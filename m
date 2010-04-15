From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 5/6] http-fetch: Use index-pack rather than verify-pack to check packs
Date: Thu, 15 Apr 2010 14:25:03 -0700
Message-ID: <1271366704-25262-1-git-send-email-spearce@spearce.org>
References: <201004152134.10555.j6t@kdbg.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 23:25:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2WYy-0002gX-DI
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 23:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab0DOVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 17:25:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63259 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107Ab0DOVZL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 17:25:11 -0400
Received: by wwb24 with SMTP id 24so794563wwb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 14:25:09 -0700 (PDT)
Received: by 10.216.155.213 with SMTP id j63mr724762wek.47.1271366709298;
        Thu, 15 Apr 2010 14:25:09 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x14sm14797905wbs.12.2010.04.15.14.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 14:25:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <201004152134.10555.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145027>

To ensure we don't leave a corrupt pack file positioned as though
it were a valid pack file, run index-pack on the temporary pack
before we rename it to its final name.  If index-pack crashes out
when it discovers file corruption (e.g. GitHub's error HTML at the
end of the file), simply delete the temporary files to cleanup.

By waiting until the pack has been validated before we move it
to its final name, we eliminate a race condition where another
concurrent reader might try to access the pack at the same time
that we are still trying to verify its not corrupt.

Switching from verify-pack to index-pack is a change in behavior,
but it should turn out better for users.  The index-pack algorithm
tries to minimize disk seeks, as well as the number of times any
given object is inflated, by organizing its work along delta chains.
The verify-pack logic does not attempt to do this, thrashing the
delta base cache and the filesystem cache.

By recreating the index file locally, we also can automatically
upgrade from a v1 pack table of contents to v2.  This makes the
CRC32 data available for use during later repacks, even if the
server didn't have them on hand.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h               |    1 +
 http.c                |   42 ++++++++++++++++++++++++++++++++++--------
 http.h                |    1 -
 sha1_file.c           |   11 +++++++++--
 t/t5550-http-fetch.sh |   15 +++++++++++++++
 5 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 5eb0573..4150603 100644
--- a/cache.h
+++ b/cache.h
@@ -916,6 +916,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
+extern void close_pack_index(struct packed_git *);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
diff --git a/http.c b/http.c
index 64e0c18..aa3e380 100644
--- a/http.c
+++ b/http.c
@@ -1,6 +1,7 @@
 #include "http.h"
 #include "pack.h"
 #include "sideband.h"
+#include "run-command.h"
 
 int data_received;
 int active_requests;
@@ -1000,11 +1001,13 @@ void release_http_pack_request(struct http_pack_request *preq)
 
 int finish_http_pack_request(struct http_pack_request *preq)
 {
-	int ret;
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
+	char *tmp_idx;
+	struct child_process ip;
+	const char *ip_argv[8];
 
-	p->pack_size = ftell(preq->packfile);
+	close_pack_index(p);
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 	preq->slot->local = NULL;
@@ -1014,13 +1017,37 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	ret = move_temp_to_file(preq->tmpfile, preq->filename);
-	if (ret)
-		return ret;
-	if (verify_pack(p))
+	tmp_idx = xstrdup(preq->tmpfile);
+	strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
+	       ".idx.temp");
+
+	ip_argv[0] = "index-pack";
+	ip_argv[1] = "-o";
+	ip_argv[2] = tmp_idx;
+	ip_argv[3] = preq->tmpfile;
+	ip_argv[4] = NULL;
+
+	memset(&ip, 0, sizeof(ip));
+	ip.argv = ip_argv;
+	ip.git_cmd = 1;
+	ip.no_stdin = 1;
+	ip.no_stdout = 1;
+
+	if (run_command(&ip)) {
+		unlink(preq->tmpfile);
+		unlink(tmp_idx);
+		free(tmp_idx);
 		return -1;
-	install_packed_git(p);
+	}
 
+	if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1))
+	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
+		free(tmp_idx);
+		return -1;
+	}
+
+	install_packed_git(p);
+	free(tmp_idx);
 	return 0;
 }
 
@@ -1043,7 +1070,6 @@ struct http_pack_request *new_http_pack_request(
 	preq->url = strbuf_detach(&buf, NULL);
 
 	filename = sha1_pack_name(target->sha1);
-	snprintf(preq->filename, sizeof(preq->filename), "%s", filename);
 	snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp", filename);
 	preq->packfile = fopen(preq->tmpfile, "a");
 	if (!preq->packfile) {
diff --git a/http.h b/http.h
index 5c9441c..e4a8126 100644
--- a/http.h
+++ b/http.h
@@ -152,7 +152,6 @@ struct http_pack_request
 	struct packed_git *target;
 	struct packed_git **lst;
 	FILE *packfile;
-	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	struct curl_slist *range_header;
 	struct active_request_slot *slot;
diff --git a/sha1_file.c b/sha1_file.c
index ff65328..820063e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -599,6 +599,14 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
+void close_pack_index(struct packed_git *p)
+{
+	if (p->index_data) {
+		munmap((void *)p->index_data, p->index_size);
+		p->index_data = NULL;
+	}
+}
+
 /*
  * This is used by git-repack in case a newly created pack happens to
  * contain the same set of objects as an existing one.  In that case
@@ -620,8 +628,7 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_windows(p);
 			if (p->pack_fd != -1)
 				close(p->pack_fd);
-			if (p->index_data)
-				munmap((void *)p->index_data, p->index_size);
+			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			free(p);
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 78c31c9..1a4dfc9 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -62,6 +62,21 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'fetch notices corrupt pack' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
+	 p=`ls objects/pack/pack-*.pack` &&
+	 chmod u+w $p &&
+	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
+	) &&
+	mkdir repo_bad1.git &&
+	(cd repo_bad1.git &&
+	 git --bare init &&
+	 test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad1.git &&
+	 test 0 = `ls objects/pack/pack-*.pack | wc -l`
+	)
+'
+
 test_expect_success 'did not use upload-pack service' '
 	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
 	: >exp
-- 
1.7.1.rc1.269.ga27c7
