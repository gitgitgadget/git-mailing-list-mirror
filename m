From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 10/11] http-fetch: Use index-pack rather than verify-pack to check packs
Date: Mon, 19 Apr 2010 07:23:09 -0700
Message-ID: <1271686990-16363-6-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:24:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ruB-0001oC-T4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab0DSOYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:24:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31783 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab0DSOYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:24:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2003958fgg.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:24:40 -0700 (PDT)
Received: by 10.223.1.19 with SMTP id 19mr64652fad.61.1271687019062;
        Mon, 19 Apr 2010 07:23:39 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 19sm483549fkr.9.2010.04.19.07.23.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145303>

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

 Moved unlink of index to after the index-pack is successful,
 per Tay Ray Chuan's request.

 Removed Junio SOB line since the logic changed.

 http.c                |   44 +++++++++++++++++++++++++++++++++++++-------
 t/t5550-http-fetch.sh |   15 +++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index 9c62632..2ebd679 100644
--- a/http.c
+++ b/http.c
@@ -1,6 +1,7 @@
 #include "http.h"
 #include "pack.h"
 #include "sideband.h"
+#include "run-command.h"
 
 int data_received;
 int active_requests;
@@ -998,11 +999,14 @@ void release_http_pack_request(struct http_pack_request *preq)
 
 int finish_http_pack_request(struct http_pack_request *preq)
 {
-	int ret;
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
+	char *tmp_idx;
+	struct child_process ip;
+	const char *ip_argv[8];
+
+	close_pack_index(p);
 
-	p->pack_size = ftell(preq->packfile);
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 	preq->slot->local = NULL;
@@ -1012,13 +1016,39 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	ret = move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1));
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
+
+	unlink(sha1_pack_index_name(p->sha1));
 
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
1.7.1.rc1.279.g22727
