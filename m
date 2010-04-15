From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 6/6] http-fetch: Use temporary files for pack-*.idx until verified
Date: Thu, 15 Apr 2010 14:25:04 -0700
Message-ID: <1271366704-25262-2-git-send-email-spearce@spearce.org>
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
	id 1O2WYz-0002gX-3t
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 23:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab0DOVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 17:25:19 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63259 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230Ab0DOVZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 17:25:15 -0400
Received: by mail-ww0-f46.google.com with SMTP id 24so794563wwb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 14:25:14 -0700 (PDT)
Received: by 10.216.88.148 with SMTP id a20mr678389wef.124.1271366713948;
        Thu, 15 Apr 2010 14:25:13 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x1sm14782236wbx.19.2010.04.15.14.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 14:25:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <201004152134.10555.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145028>

Verify that a downloaded pack-*.idx file is consistent and valid
as an index file before we rename it into its final destination.
This prevents a corrupt index file from later being treated as a
usable file, confusing readers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h               |    2 +-
 http.c                |   62 +++++++++++++++++++++++++++++++-----------------
 pack-check.c          |   15 ++++++++---
 pack.h                |    1 +
 sha1_file.c           |    6 +++-
 t/t5550-http-fetch.sh |   15 ++++++++++++
 6 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/cache.h b/cache.h
index 4150603..0d101e4 100644
--- a/cache.h
+++ b/cache.h
@@ -905,7 +905,7 @@ struct extra_have_objects {
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1);
+extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/http.c b/http.c
index aa3e380..2d88034 100644
--- a/http.c
+++ b/http.c
@@ -897,47 +897,65 @@ int http_fetch_ref(const char *base, struct ref *ref)
 }
 
 /* Helpers for fetching packs */
-static int fetch_pack_index(unsigned char *sha1, const char *base_url)
+static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 {
-	int ret = 0;
-	char *hex = xstrdup(sha1_to_hex(sha1));
-	char *filename;
-	char *url = NULL;
+	char *url, *tmp;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (has_pack_index(sha1)) {
-		ret = 0;
-		goto cleanup;
-	}
-
 	if (http_is_verbose)
-		fprintf(stderr, "Getting index for pack %s\n", hex);
+		fprintf(stderr, "Getting index for pack %s\n", sha1_to_hex(sha1));
 
 	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hex);
+	strbuf_addf(&buf, "objects/pack/pack-%s.idx", sha1_to_hex(sha1));
 	url = strbuf_detach(&buf, NULL);
 
-	filename = sha1_pack_index_name(sha1);
-	if (http_get_file(url, filename, 0) != HTTP_OK)
-		ret = error("Unable to get pack index %s\n", url);
+	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(sha1));
+	tmp = strbuf_detach(&buf, NULL);
+
+	if (http_get_file(url, tmp, 0) != HTTP_OK) {
+		error("Unable to get pack index %s\n", url);
+		free(tmp);
+		tmp = NULL;
+	}
 
-cleanup:
-	free(hex);
 	free(url);
-	return ret;
+	return tmp;
 }
 
 static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url)
 {
 	struct packed_git *new_pack;
+	char *tmp_idx = NULL;
 
-	if (fetch_pack_index(sha1, base_url))
-		return -1;
+	if (!has_pack_index(sha1)) {
+		tmp_idx = fetch_pack_index(sha1, base_url);
+		if (!tmp_idx)
+			return -1;
+	}
 
-	new_pack = parse_pack_index(sha1);
-	if (!new_pack)
+	new_pack = parse_pack_index(sha1, tmp_idx);
+	if (!new_pack) {
+		if (tmp_idx) {
+			unlink(tmp_idx);
+			free(tmp_idx);
+		}
 		return -1; /* parse_pack_index() already issued error message */
+	}
+
+	if (tmp_idx) {
+		int ret;
+
+		ret = verify_pack_index(new_pack);
+		if (!ret) {
+			close_pack_index(new_pack);
+			ret = move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
+		}
+		free(tmp_idx);
+		if (ret)
+			return -1;
+	}
+
 	new_pack->next = *packs_head;
 	*packs_head = new_pack;
 	return 0;
diff --git a/pack-check.c b/pack-check.c
index 166ca70..9baba12 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -133,14 +133,13 @@ static int verify_packfile(struct packed_git *p,
 	return err;
 }
 
-int verify_pack(struct packed_git *p)
+int verify_pack_index(struct packed_git *p)
 {
 	off_t index_size;
 	const unsigned char *index_base;
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
 	int err = 0;
-	struct pack_window *w_curs = NULL;
 
 	if (open_pack_index(p))
 		return error("packfile %s index not opened", p->pack_name);
@@ -154,9 +153,17 @@ int verify_pack(struct packed_git *p)
 	if (hashcmp(sha1, index_base + index_size - 20))
 		err = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
+	return err;
+}
+
+int verify_pack(struct packed_git *p)
+{
+	int err = 0;
+	struct pack_window *w_curs = NULL;
 
-	/* Verify pack file */
-	err |= verify_packfile(p, &w_curs);
+	err |= verify_pack_index(p);
+	if (!err)
+		err |= verify_packfile(p, &w_curs);
 	unuse_pack(&w_curs);
 
 	return err;
diff --git a/pack.h b/pack.h
index d268c01..bb27576 100644
--- a/pack.h
+++ b/pack.h
@@ -57,6 +57,7 @@ struct pack_idx_entry {
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
+extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
diff --git a/sha1_file.c b/sha1_file.c
index 820063e..232e14d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -838,12 +838,14 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	return p;
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1)
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
-	const char *idx_path = sha1_pack_index_name(sha1);
 	const char *path = sha1_pack_name(sha1);
 	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
 
+	if (!idx_path)
+		idx_path = sha1_pack_index_name(sha1);
+
 	strcpy(p->pack_name, path);
 	hashcpy(p->sha1, sha1);
 	if (check_packed_git_idx(idx_path, p)) {
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 1a4dfc9..fc675b5 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -77,6 +77,21 @@ test_expect_success 'fetch notices corrupt pack' '
 	)
 '
 
+test_expect_success 'fetch notices corrupt idx' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
+	 p=`ls objects/pack/pack-*.idx` &&
+	 chmod u+w $p &&
+	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
+	) &&
+	mkdir repo_bad2.git &&
+	(cd repo_bad2.git &&
+	 git --bare init &&
+	 test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad2.git &&
+	 test 0 = `ls objects/pack | wc -l`
+	)
+'
+
 test_expect_success 'did not use upload-pack service' '
 	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
 	: >exp
-- 
1.7.1.rc1.269.ga27c7
