Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45BC1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbcGKWrO (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:47:14 -0400
Received: from kitenet.net ([66.228.36.95]:32768 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbcGKWrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:47:13 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=P+WpFgpS;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277198; bh=tAWpo3wY2ayI3N2P5PIoaKI4XKz6M0EPI7WSh1kSoZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+WpFgpSST+oHI+yvWOFavctP60LP4dRf0CJA1N75Wk/pQIHue3j4sxVPNsjTAuj6
	 IzUxRBE2Ilz3E0UF3r6iL2lCVMtITzMvvTqYjr9xEXi8mGgInDOWD1bi7bdmt2NY1z
	 ZlAIY9kjZhF+1jmpxhc1YP+tkocCMOsmT/DbiGRI=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 4/8] use smudgeToFile in git checkout etc
Date:	Mon, 11 Jul 2016 18:45:08 -0400
Message-Id: <1468277112-9909-5-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This makes git checkout, git reset, etc use smudgeToFile.

Includes test cases.

(There's a call to convert_to_working_tree in merge-recursive.c
that could also be made to use smudgeToFile as well.)

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 entry.c               | 40 ++++++++++++++++++++++++++++++++--------
 t/t0021-conversion.sh | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/entry.c b/entry.c
index 519e042..81d12a1 100644
--- a/entry.c
+++ b/entry.c
@@ -146,6 +146,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	int regular_file, smudge_to_file;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
@@ -175,8 +176,13 @@ static int write_entry(struct cache_entry *ce,
 
 		/*
 		 * Convert from git internal format to working tree format
+		 * unless the smudgeToFile filter can write to the
+		 * file directly.
 		 */
-		if (ce_mode_s_ifmt == S_IFREG &&
+		regular_file = ce_mode_s_ifmt == S_IFREG;
+		smudge_to_file = regular_file
+			&& can_smudge_to_file(ce->name);
+		if (regular_file && !smudge_to_file &&
 		    convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
 			new = strbuf_detach(&buf, &newsize);
@@ -189,13 +195,31 @@ static int write_entry(struct cache_entry *ce,
 			return error_errno("unable to create file %s", path);
 		}
 
-		wrote = write_in_full(fd, new, size);
-		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
-		close(fd);
-		free(new);
-		if (wrote != size)
-			return error("unable to write file %s", path);
+		if (!smudge_to_file) {
+			wrote = write_in_full(fd, new, size);
+			if (!to_tempfile)
+				fstat_done = fstat_output(fd, state, &st);
+			close(fd);
+			free(new);
+			if (wrote != size)
+				return error("unable to write file %s", path);
+		}
+		else {
+			close(fd);
+			convert_to_working_tree_filter_to_file(ce->name, path, new, size);
+			free(new);
+			/*
+			 * The smudgeToFile filter may have replaced the
+			 * file; open it to make sure that the file
+			 * exists.
+			 */
+			fd = open(path, O_RDONLY);
+			if (fd < 0)
+				return error_errno("unable to create file %s", path);
+			if (!to_tempfile)
+				fstat_done = fstat_output(fd, state, &st);
+			close(fd);
+		}
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bd84b80..ea18b17 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -14,12 +14,20 @@ chmod +x rot13.sh
 
 cat <<EOF >rot13-from-file.sh
 #!$SHELL_PATH
-fsfile="\$1"
+srcfile="\$1"
 touch rot13-from-file.ran
-cat "\$fsfile" | ./rot13.sh
+cat "\$srcfile" | ./rot13.sh
 EOF
 chmod +x rot13-from-file.sh
 
+cat <<EOF >rot13-to-file.sh
+#!$SHELL_PATH
+destfile="\$1"
+touch rot13-to-file.ran
+./rot13.sh >"\$destfile"
+EOF
+chmod +x rot13-to-file.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -291,6 +299,17 @@ test_expect_success 'cleanFromFile filter is used when adding a file' '
 	test_cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used when checking out a file' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test_cmp test fstest.t &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
@@ -304,4 +323,15 @@ test_expect_success 'cleanFromFile filter is not used when clean filter is not c
 	test_cmp test actual
 '
 
+test_expect_success 'smudgeToFile filter is not used when smudge filter is not configured' '
+	test_config filter.nosmudge.clean ./rot13.sh &&
+	test_config filter.nosmudge.smudgeToFile ./rot13-to-file.sh &&
+
+	echo "*.no filter=nosmudge" >.gitattributes &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test ! -e rot13-to-file.ran
+'
+
 test_done
-- 
2.8.1

