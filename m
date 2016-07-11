Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3DA1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbcGKWq7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:46:59 -0400
Received: from kitenet.net ([66.228.36.95]:60948 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbcGKWq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:46:58 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=O21fZnmu;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277197; bh=ID7Cvl2BMx/TZGvnWWIJ3y9tfZmZmZ0hcgqOsxLVm9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O21fZnmuEK0afkVNZdA2KL+bhF+skap1V8rdhqtR0vzDPg7cri/BlGPK8eY5G/xi6
	 7f7vYgrq3QCN/0Q7cXsHSm0k8sgA2DLnriNR0Ga/gtk6OjqDr2JNHEMDoEt6MMyVto
	 4wAJLa+dzSUA8Y+8bwZ760DVTucDOLRoEINUvJ0Y=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 3/8] use cleanFromFile in git add
Date:	Mon, 11 Jul 2016 18:45:07 -0400
Message-Id: <1468277112-9909-4-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Includes test cases.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 sha1_file.c           | 42 ++++++++++++++++++++++++++++++++++++------
 t/t0021-conversion.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2fc22b0..549a20f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3335,6 +3335,29 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 	return ret;
 }
 
+static int index_from_file_convert_blob(unsigned char *sha1,
+				      const char *path, unsigned flags)
+{
+	int ret;
+	const int write_object = flags & HASH_WRITE_OBJECT;
+	struct strbuf sbuf = STRBUF_INIT;
+
+	assert(path);
+	assert(can_clean_from_file(path));
+
+	convert_to_git_filter_from_file(path, &sbuf,
+				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
+
+	if (write_object)
+		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+				      sha1);
+	else
+		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+				     sha1);
+	strbuf_release(&sbuf);
+	return ret;
+}
+
 static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
@@ -3427,12 +3450,19 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
-		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return error_errno("open(\"%s\")", path);
-		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
-			return error("%s: failed to insert into database",
-				     path);
+		if (can_clean_from_file(path)) {
+			if (index_from_file_convert_blob(sha1, path, flags) < 0)
+				return error("%s: failed to insert into database",
+					     path);
+		}
+		else {
+			fd = open(path, O_RDONLY);
+			if (fd < 0)
+				return error_errno("open(\"%s\")", path);
+			if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
+				return error("%s: failed to insert into database",
+					     path);
+		}
 		break;
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7bac2bc..bd84b80 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -12,6 +12,14 @@ tr \
 EOF
 chmod +x rot13.sh
 
+cat <<EOF >rot13-from-file.sh
+#!$SHELL_PATH
+fsfile="\$1"
+touch rot13-from-file.ran
+cat "\$fsfile" | ./rot13.sh
+EOF
+chmod +x rot13-from-file.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -268,4 +276,32 @@ test_expect_success 'disable filter with empty override' '
 	test_must_be_empty err
 '
 
+test_expect_success 'cleanFromFile filter is used when adding a file' '
+	test_config filter.rot13.cleanFromFile ./rot13-from-file.sh &&
+
+	echo "*.t filter=rot13" >.gitattributes &&
+
+	cat test >fstest.t &&
+	git add fstest.t &&
+	test -e rot13-from-file.ran &&
+	rm -f rot13-from-file.ran &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test_cmp test fstest.t
+'
+
+test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
+	test_config filter.noclean.smudge ./rot13.sh &&
+	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
+
+	echo "*.no filter=noclean" >.gitattributes &&
+
+	cat test >test.no &&
+	git add test.no &&
+	test ! -e rot13-from-file.ran &&
+	git cat-file blob :test.no >actual &&
+	test_cmp test actual
+'
+
 test_done
-- 
2.8.1

