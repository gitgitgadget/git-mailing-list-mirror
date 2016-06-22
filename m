Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9015F20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcFVUWW (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:22:22 -0400
Received: from kitenet.net ([66.228.36.95]:57494 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbcFVUWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:22:21 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=EeFTSobp;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466626900; bh=dVMnkdD6PUhBXnKXSgxdfqdzolNDmZA6qNGBd2Qfet8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeFTSobpJdTIjZ7tw+I4adrTEZ9w7RizzAVU3xcHfJo5YTJ81o0zextnyB7HbrsF6
	 VST0s7n/T0rLnRbTWxvlvTPidkUPIX2e4jxnfR2czAFDnB9tKNZCddk7XEMp5WesYY
	 wF64WhTOlcXx9OqjTIdLUIKuIAuIYWgURWfsoApc=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v3 4/8] use smudgeToFile in git checkout etc
Date:	Wed, 22 Jun 2016 16:21:29 -0400
Message-Id: <20160622202133.23565-5-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.8.gf959b2a
In-Reply-To: <20160622202133.23565-1-joeyh@joeyh.name>
References: <20160622202133.23565-1-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
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
 entry.c               | 37 +++++++++++++++++++++++++++++--------
 t/t0021-conversion.sh | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/entry.c b/entry.c
index 519e042..97975e5 100644
--- a/entry.c
+++ b/entry.c
@@ -175,8 +175,13 @@ static int write_entry(struct cache_entry *ce,
 
 		/*
 		 * Convert from git internal format to working tree format
+		 * unless the smudgeToFile filter can write to the
+		 * file directly.
 		 */
-		if (ce_mode_s_ifmt == S_IFREG &&
+		int regular_file = ce_mode_s_ifmt == S_IFREG;
+		int smudge_to_file = regular_file
+			&& can_smudge_to_file(ce->name);
+		if (regular_file && ! smudge_to_file &&
 		    convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
 			new = strbuf_detach(&buf, &newsize);
@@ -189,13 +194,29 @@ static int write_entry(struct cache_entry *ce,
 			return error_errno("unable to create file %s", path);
 		}
 
-		wrote = write_in_full(fd, new, size);
-		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
-		close(fd);
-		free(new);
-		if (wrote != size)
-			return error("unable to write file %s", path);
+		if (! smudge_to_file) {
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
+			/* The smudgeToFile filter may have replaced the
+			 * file; open it to make sure that the file
+			 * exists. */
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
index 407d5d6..cba03fd 100755
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
+./rot13.sh > "\$destfile"
+EOF
+chmod +x rot13-to-file.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -291,6 +299,17 @@ test_expect_success 'cleanFromFile filter is used when adding a file' '
 	cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used when checking out a file' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	cmp test fstest.t &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
@@ -299,9 +318,18 @@ test_expect_success 'cleanFromFile filter is not used when clean filter is not c
 
 	cat test >test.no &&
 	git add test.no &&
-	test ! -e rot13-from-file.ran &&
-	git cat-file blob :test.no >actual &&
-	cmp test actual
+	test ! -e rot13-from-file.ran
+'
+
+test_expect_success 'smudgeToFile filter is not used when smudge filter is not configured' '
+	test_config filter.nosmudge.clean ./rot13.sh &&
+	test_config filter.nosmudge.smudgeToFile ./rot13-to-file.sh &&
+
+	echo "*.no filter=nosmudge" >.gitattributes &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test ! -e rot13-to-file.ran
 '
 
 test_done
-- 
2.9.0.8.g973eabb.dirty

