From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 11/11] http-fetch: Use temporary files for pack-*.idx until verified
Date: Mon, 19 Apr 2010 07:23:10 -0700
Message-ID: <1271686990-16363-7-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:24:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rtj-0001ST-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003Ab0DSOXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:23:47 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48685 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab0DSOXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:23:45 -0400
Received: by mail-bw0-f225.google.com with SMTP id 25so5648036bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:23:44 -0700 (PDT)
Received: by 10.204.144.153 with SMTP id z25mr291189bku.198.1271687024256;
        Mon, 19 Apr 2010 07:23:44 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 15sm3160924bwz.4.2010.04.19.07.23.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145302>

Verify that a downloaded pack-*.idx file is consistent and valid
as an index file before we rename it into its final destination.
This prevents a corrupt index file from later being treated as a
usable file, confusing readers.

Check that we do not have the pack index file before invoking
fetch_pack_index(); that way, we can do without the has_pack_index()
check in fetch_pack_index().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Added paragraph describing the move of has_pack_index() to the
 commit message.
 
 No code change from v3.

 http.c                |   56 ++++++++++++++++++++++++++++++++++--------------
 t/t5550-http-fetch.sh |   15 +++++++++++++
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/http.c b/http.c
index 2ebd679..0813c9e 100644
--- a/http.c
+++ b/http.c
@@ -897,18 +897,11 @@ int http_fetch_ref(const char *base, struct ref *ref)
 }
 
 /* Helpers for fetching packs */
-static int fetch_pack_index(unsigned char *sha1, const char *base_url)
+static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 {
-	int ret = 0;
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
 		fprintf(stderr, "Getting index for pack %s\n", sha1_to_hex(sha1));
 
@@ -916,26 +909,55 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	strbuf_addf(&buf, "objects/pack/pack-%s.idx", sha1_to_hex(sha1));
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
 	free(url);
-	return ret;
+	return tmp;
 }
 
 static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url)
 {
 	struct packed_git *new_pack;
+	char *tmp_idx = NULL;
+	int ret;
+
+	if (has_pack_index(sha1)) {
+		new_pack = parse_pack_index(sha1, NULL);
+		if (!new_pack)
+			return -1; /* parse_pack_index() already issued error message */
+		goto add_pack;
+	}
 
-	if (fetch_pack_index(sha1, base_url))
+	tmp_idx = fetch_pack_index(sha1, base_url);
+	if (!tmp_idx)
 		return -1;
 
-	new_pack = parse_pack_index(sha1, sha1_pack_index_name(sha1));
-	if (!new_pack)
+	new_pack = parse_pack_index(sha1, tmp_idx);
+	if (!new_pack) {
+		unlink(tmp_idx);
+		free(tmp_idx);
+
 		return -1; /* parse_pack_index() already issued error message */
+	}
+
+	ret = verify_pack_index(new_pack);
+	if (!ret) {
+		close_pack_index(new_pack);
+		ret = move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
+	}
+	free(tmp_idx);
+	if (ret)
+		return -1;
+
+add_pack:
 	new_pack->next = *packs_head;
 	*packs_head = new_pack;
 	return 0;
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
1.7.1.rc1.279.g22727
