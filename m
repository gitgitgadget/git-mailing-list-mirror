From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] clean: make is_git_repository a public function
Date: Fri, 22 Jan 2016 17:27:33 -0500
Message-ID: <20160122222733.GA15560@sigill.intra.peff.net>
References: <20160122222650.GA14772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:27:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkBA-0008Ey-GQ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbcAVW1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:27:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:58955 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753876AbcAVW1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:27:36 -0500
Received: (qmail 17660 invoked by uid 102); 22 Jan 2016 22:27:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:27:36 -0500
Received: (qmail 6583 invoked by uid 107); 22 Jan 2016 22:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:27:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:27:33 -0500
Content-Disposition: inline
In-Reply-To: <20160122222650.GA14772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284595>

We have always had is_git_directory(), for looking at a
specific directory to see if it contains a git repo. In
0179ca7 (clean: improve performance when removing lots of
directories, 2015-06-15), we added is_git_repository() which
checks for a non-bare repository by looking at its ".git"
entry.

However, the fix in 0179ca7 needs to be applied other
places, too. Let's make this new helper globally available.
We need to give it a better name, though, to avoid confusion
with is_git_directory(). This patch does that, documents
both functions with a comment to reduce confusion, and
removes the clean-specific references in the comments.

Based-on-a-patch-by: Andreas Krey <a.krey@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clean.c | 26 +-------------------------
 cache.h         | 20 +++++++++++++++++++-
 setup.c         | 17 +++++++++++++++++
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d7acb94..919157b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -147,30 +147,6 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-/*
- * Return 1 if the given path is the root of a git repository or
- * submodule else 0. Will not return 1 for bare repositories with the
- * exception of creating a bare repository in "foo/.git" and calling
- * is_git_repository("foo").
- */
-static int is_git_repository(struct strbuf *path)
-{
-	int ret = 0;
-	int gitfile_error;
-	size_t orig_path_len = path->len;
-	assert(orig_path_len != 0);
-	strbuf_complete(path, '/');
-	strbuf_addstr(path, ".git");
-	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
-		ret = 1;
-	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
-	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
-		ret = 1;  /* This could be a real .git file, take the
-			   * safe option and avoid cleaning */
-	strbuf_setlen(path, orig_path_len);
-	return ret;
-}
-
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -182,7 +158,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	*dir_gone = 1;
 
-	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_git_repository(path)) {
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_nonbare_repository_dir(path)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
diff --git a/cache.h b/cache.h
index dfc459c..553b04b 100644
--- a/cache.h
+++ b/cache.h
@@ -458,7 +458,6 @@ extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
-extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
@@ -469,6 +468,25 @@ extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 
+/*
+ * Return true if the given path is a git directory; note that this _just_
+ * looks at the directory itself. If you want to know whether "foo/.git"
+ * is a repository, you must feed that path, not just "foo".
+ */
+extern int is_git_directory(const char *path);
+
+/*
+ * Return 1 if the given path is the root of a git repository or
+ * submodule, else 0. Will not return 1 for bare repositories with the
+ * exception of creating a bare repository in "foo/.git" and calling
+ * is_git_repository("foo").
+ *
+ * If we run into read errors, we err on the side of saying "yes, it is",
+ * as we usually consider sub-repos precious, and would prefer to err on the
+ * side of not disrupting or deleting them.
+ */
+extern int is_nonbare_repository_dir(struct strbuf *path);
+
 #define READ_GITFILE_ERR_STAT_FAILED 1
 #define READ_GITFILE_ERR_NOT_A_FILE 2
 #define READ_GITFILE_ERR_OPEN_FAILED 3
diff --git a/setup.c b/setup.c
index d343725..2c4b22c 100644
--- a/setup.c
+++ b/setup.c
@@ -312,6 +312,23 @@ done:
 	return ret;
 }
 
+int is_nonbare_repository_dir(struct strbuf *path)
+{
+	int ret = 0;
+	int gitfile_error;
+	size_t orig_path_len = path->len;
+	assert(orig_path_len != 0);
+	strbuf_complete(path, '/');
+	strbuf_addstr(path, ".git");
+	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
+		ret = 1;
+	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
+	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
+		ret = 1;
+	strbuf_setlen(path, orig_path_len);
+	return ret;
+}
+
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0)
-- 
2.7.0.384.gae54cb4
