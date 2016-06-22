Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0186F20189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbcFVVKH (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:10:07 -0400
Received: from kitenet.net ([66.228.36.95]:59288 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbcFVVKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:10:05 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=MRpmkmN6;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466629760; bh=FaXm1xjeuAbTv/tEAwEu7wzeVJoRvGb+Lu1PpkYnNwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRpmkmN6mITNnG+ep2lyMlCTvYpRSN+dVPekf99TV/B37X7udfc8uJ1KyBPYaox9t
	 VKIWLfdobVQ3eZu6+e3JsxZBAdPxt8vfcPW+Lm3oTm5tljYWqtlaDw/KtJ8vSb7ieO
	 yLE4TgwElSVaYEWVBhJxzZHzPkjEapJ+FcOCHxTw=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v4 7/8] use smudgeToFile filter in git am
Date:	Wed, 22 Jun 2016 17:09:17 -0400
Message-Id: <1466629758-8035-8-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
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
 builtin/apply.c       | 16 ++++++++++++++++
 convert.c             | 19 +++++++++++++++++--
 entry.c               | 15 +++------------
 t/t0021-conversion.sh | 13 +++++++++++++
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b24c6ba..b027ab7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4250,6 +4250,22 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return -1;
 
+	if (can_smudge_to_file(path)) {
+		close(fd);
+		fd = convert_to_working_tree_filter_to_file(path, path, buf, size);
+		if (fd < 0) {
+			/* smudgeToFile filter failed; continue
+			 * with regular file creation. */
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
index 378a3bd..4fe89e0 100644
--- a/convert.c
+++ b/convert.c
@@ -1048,13 +1048,28 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	return convert_to_working_tree_internal(path, NULL, src, len, dst, 0);
 }
 
+/* Returns fd open to read the worktree file on success.
+ * On failure, the worktree file will not exist. */
 int convert_to_working_tree_filter_to_file(const char *path, const char *destpath, const char *src, size_t len)
 {
 	struct strbuf output = STRBUF_INIT;
-	int ret = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
+	int ok = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
 	/* The smudgeToFile filter stdout is not used. */
 	strbuf_release(&output);
-	return ret;
+	if (ok) {
+		/* Open the file to make sure that it's present
+		 * (and readable) after the command populated it. */
+		int fd = open(path, O_RDONLY);
+		if (fd < 0)
+			unlink(path);
+		return fd;
+	}
+	else {
+		/* The command could have created the file before failing,
+		 * so delete it. */
+		unlink(path);
+		return -1;
+	}
 }
 
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
diff --git a/entry.c b/entry.c
index 8322127..2f7c4fd 100644
--- a/entry.c
+++ b/entry.c
@@ -190,13 +190,10 @@ static int write_entry(struct cache_entry *ce,
 
 		if (smudge_to_file) {
 			close(fd);
-			if (! convert_to_working_tree_filter_to_file(ce->name, path, new, size)) {
+			fd = convert_to_working_tree_filter_to_file(ce->name, path, new, size);
+			if (fd < 0) {
 				smudge_to_file = 0;
-				/* The failing smudgeToFile filter may have
-				 * deleted or replaced the file; delete
-				 * the file and re-open for recovery write.
-				 */
-				unlink(path);
+				/* re-open for recovery write */
 				fd = open_output_fd(path, ce, to_tempfile);
 				if (fd < 0) {
 					free(new);
@@ -205,12 +202,6 @@ static int write_entry(struct cache_entry *ce,
 			}
 			else {
 				free(new);
-				/* The smudgeToFile filter may have replaced
-				 * or deleted the file; reopen it to make sure
-				 * that the file exists. */
-				fd = open(path, O_RDONLY);
-				if (fd < 0)
-					return error_errno("unable to create file %s", path);
 				if (!to_tempfile)
 					fstat_done = fstat_output(fd, state, &st);
 				close(fd);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index c0b4709..fd07bd6 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -334,6 +334,19 @@ test_expect_success 'recovery from failure of smudgeToFile filter that deletes t
 	cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used by git am' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	git commit fstest.t -m "added fstest.t" &&
+	git format-patch HEAD^ --stdout > fstest.patch &&
+	git reset --hard HEAD^ &&
+	git am < fstest.patch &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran &&
+	cmp test fstest.t
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
-- 
2.9.0.587.ga3bedf2

