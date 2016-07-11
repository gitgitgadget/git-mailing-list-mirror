Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C9F1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbcGKWrT (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:47:19 -0400
Received: from kitenet.net ([66.228.36.95]:32782 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbcGKWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:47:18 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=P7RXYLHP;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277198; bh=R6DA3FWAltlIvvD5mJEp7ZgM7JFZFfGDS/9auV9Z+0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7RXYLHPbs0CXSl4ChFu0IJTC7WGua7f0VyocRm/r3ZZK/2HscKr3lMHDy0fxfD3I
	 grgLgEiaffIZ5+vMX0FWQIYDLISJD4NlDMYYt3NoONm10nDHJp/vSm1/YdyoaT8+3p
	 RnZbAzgY6m43Lhx7BxNApQ8/UPzUL5hWD45Jl5YU=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 7/8] use smudgeToFile filter in git am
Date:	Mon, 11 Jul 2016 18:45:11 -0400
Message-Id: <1468277112-9909-8-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

git am updates the work tree and so should use the smudgeToFile filter.

This includes some refactoring into convert_to_working_tree_filter_to_file
to make it check the file after running the smudgeToFile command, and clean
up from a failing command.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 apply.c               | 16 ++++++++++++++++
 convert.c             | 25 +++++++++++++++++++++++--
 entry.c               | 21 ++++-----------------
 t/t0021-conversion.sh | 13 +++++++++++++
 4 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index 4a6b2db..7db8344 100644
--- a/apply.c
+++ b/apply.c
@@ -4322,6 +4322,22 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return 1;
 
+	if (can_smudge_to_file(path)) {
+		close(fd);
+		fd = convert_to_working_tree_filter_to_file(path, path, buf, size);
+		if (fd < 0) {
+			/* smudgeToFile filter failed; continue
+			 * with regular file creation instead. */
+			fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
+			if (fd < 0)
+				return -1;
+		}
+		else {
+			close(fd);
+			return 0;
+		}
+	}
+
 	if (convert_to_working_tree(path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
diff --git a/convert.c b/convert.c
index e1b0b44..3746ad5 100644
--- a/convert.c
+++ b/convert.c
@@ -1030,13 +1030,34 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	return convert_to_working_tree_internal(path, NULL, src, len, dst, 0);
 }
 
+/*
+ * Returns fd open to read the worktree file on success.
+ * On failure, the worktree file will not exist.
+ */
 int convert_to_working_tree_filter_to_file(const char *path, const char *destpath, const char *src, size_t len)
 {
 	struct strbuf output = STRBUF_INIT;
-	int ret = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
+	int ok = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
 	/* The smudgeToFile filter stdout is not used. */
 	strbuf_release(&output);
-	return ret;
+	if (ok) {
+		/*
+		 * Open the file to make sure that it's present
+		 * (and readable) after the command populated it.
+		 */
+		int fd = open(path, O_RDONLY);
+		if (fd < 0)
+			unlink(path);
+		return fd;
+	}
+	else {
+		/*
+		 * The command could have created the file before failing,
+		 * so delete it.
+		 */
+		unlink(path);
+		return -1;
+	}
 }
 
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
diff --git a/entry.c b/entry.c
index 7811e31..40662eb 100644
--- a/entry.c
+++ b/entry.c
@@ -191,34 +191,21 @@ static int write_entry(struct cache_entry *ce,
 
 		if (smudge_to_file) {
 			close(fd);
-			if (convert_to_working_tree_filter_to_file(ce->name, path, new, size)) {
+			fd = convert_to_working_tree_filter_to_file(ce->name, path, new, size);
+			if (fd >= 0) {
 				free(new);
-				/*
-				 * The smudgeToFile filter may have replaced
-				 * or deleted the file; reopen it to make
-				 * sure that the file exists.
-				 */
-				fd = open(path, O_RDONLY);
-				if (fd < 0)
-					return error_errno("unable to create file %s", path);
 				if (!to_tempfile)
 					fstat_done = fstat_output(fd, state, &st);
 				close(fd);
 			}
 			else {
-				/*
-				 * The failing smudgeToFile filter may have
-				 * deleted or replaced the file; delete
-				 * the file and re-open for recovery write.
-				 */
-				unlink(path);
+				/* Fall through to normal write below. */
+				smudge_to_file = 0;
 				fd = open_output_fd(path, ce, to_tempfile);
 				if (fd < 0) {
 					free(new);
 					return error_errno("unable to create file %s", path);
 				}
-				/* Fall through to normal write below. */
-				smudge_to_file = 0;
 			}
 		}
 
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0efad9b..42b28aa 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -334,6 +334,19 @@ test_expect_success 'recovery from failure of smudgeToFile filter that deletes t
 	test_cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used by git am' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	git commit fstest.t -m "added fstest.t" &&
+	git format-patch HEAD^ --stdout >fstest.patch &&
+	git reset --hard HEAD^ &&
+	git am fstest.patch &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran &&
+	test_cmp test fstest.t
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
-- 
2.8.1

