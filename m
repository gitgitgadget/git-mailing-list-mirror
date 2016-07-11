Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC2D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbcGKWrW (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:47:22 -0400
Received: from kitenet.net ([66.228.36.95]:32788 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbcGKWrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:47:19 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=e1tj3LJk;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277198; bh=4aNAzyRt9bz6y9MPC2VC5pj9+5O3Gb5fUsDopvg0K64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1tj3LJkIi1ro6kUH77lZhTIqJt1N6KgyzFzcDDEdrFFz4x49MywJnSCKy9xtgY4h
	 gc/cr1oZKUTrgmSXwMT8HD5yRltK8eWXnXOYn816pWnnRSkFlcwB+VWR4hhVcYahcV
	 KM71p6oYWBbs2BULmxjndGZX1lRSx34zt8DePh2Y=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 6/8] better recovery from failure of smudgeToFile filter
Date:	Mon, 11 Jul 2016 18:45:10 -0400
Message-Id: <1468277112-9909-7-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If the smudgeToFile filter fails, it can leave the worktree file with the
wrong content, or even deleted. Recover from this by falling back to
running the smudge filter.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 entry.c               | 66 ++++++++++++++++++++++++++++++++++-----------------
 t/t0021-conversion.sh | 24 +++++++++++++++++++
 2 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/entry.c b/entry.c
index 81d12a1..7811e31 100644
--- a/entry.c
+++ b/entry.c
@@ -182,12 +182,6 @@ static int write_entry(struct cache_entry *ce,
 		regular_file = ce_mode_s_ifmt == S_IFREG;
 		smudge_to_file = regular_file
 			&& can_smudge_to_file(ce->name);
-		if (regular_file && !smudge_to_file &&
-		    convert_to_working_tree(ce->name, new, size, &buf)) {
-			free(new);
-			new = strbuf_detach(&buf, &newsize);
-			size = newsize;
-		}
 
 		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
@@ -195,7 +189,51 @@ static int write_entry(struct cache_entry *ce,
 			return error_errno("unable to create file %s", path);
 		}
 
+		if (smudge_to_file) {
+			close(fd);
+			if (convert_to_working_tree_filter_to_file(ce->name, path, new, size)) {
+				free(new);
+				/*
+				 * The smudgeToFile filter may have replaced
+				 * or deleted the file; reopen it to make
+				 * sure that the file exists.
+				 */
+				fd = open(path, O_RDONLY);
+				if (fd < 0)
+					return error_errno("unable to create file %s", path);
+				if (!to_tempfile)
+					fstat_done = fstat_output(fd, state, &st);
+				close(fd);
+			}
+			else {
+				/*
+				 * The failing smudgeToFile filter may have
+				 * deleted or replaced the file; delete
+				 * the file and re-open for recovery write.
+				 */
+				unlink(path);
+				fd = open_output_fd(path, ce, to_tempfile);
+				if (fd < 0) {
+					free(new);
+					return error_errno("unable to create file %s", path);
+				}
+				/* Fall through to normal write below. */
+				smudge_to_file = 0;
+			}
+		}
+
+		/*
+		 * Not an else of above if (smudge_to_file) because the
+		 * smudgeToFile filter may fail and in that case this is
+		 * run to recover.
+		 */
 		if (!smudge_to_file) {
+			if (regular_file &&
+			    convert_to_working_tree(ce->name, new, size, &buf)) {
+				free(new);
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
 			wrote = write_in_full(fd, new, size);
 			if (!to_tempfile)
 				fstat_done = fstat_output(fd, state, &st);
@@ -204,22 +242,6 @@ static int write_entry(struct cache_entry *ce,
 			if (wrote != size)
 				return error("unable to write file %s", path);
 		}
-		else {
-			close(fd);
-			convert_to_working_tree_filter_to_file(ce->name, path, new, size);
-			free(new);
-			/*
-			 * The smudgeToFile filter may have replaced the
-			 * file; open it to make sure that the file
-			 * exists.
-			 */
-			fd = open(path, O_RDONLY);
-			if (fd < 0)
-				return error_errno("unable to create file %s", path);
-			if (!to_tempfile)
-				fstat_done = fstat_output(fd, state, &st);
-			close(fd);
-		}
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index ea18b17..0efad9b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -28,6 +28,14 @@ touch rot13-to-file.ran
 EOF
 chmod +x rot13-to-file.sh
 
+cat <<EOF >delete-file-and-fail.sh
+#!$SHELL_PATH
+destfile="\$1"
+rm -f "\$destfile"
+exit 1
+EOF
+chmod +x delete-file-and-fail.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -310,6 +318,22 @@ test_expect_success 'smudgeToFile filter is used when checking out a file' '
 	rm -f rot13-to-file.ran
 '
 
+test_expect_success 'recovery from failure of smudgeToFile filter, using smudge filter' '
+	test_config filter.rot13.smudgeToFile false &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test_cmp test fstest.t
+'
+
+test_expect_success 'recovery from failure of smudgeToFile filter that deletes the worktree file' '
+	test_config filter.rot13.smudgeToFile ./delete-file-and-fail.sh &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test_cmp test fstest.t
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
-- 
2.8.1

