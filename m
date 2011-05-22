From: Anthony Foiani <anthony.foiani@gmail.com>
Subject: [PATCH] Improve errors from 'git diff --no-index'.
Date: Sun, 22 May 2011 13:17:21 -0600
Message-ID: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
To: anthony.foiani@gmail.com
X-From: git-owner@vger.kernel.org Mon May 23 00:26:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOH6m-000274-DN
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 00:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab1EVW0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 18:26:44 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55910 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab1EVW0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 18:26:42 -0400
Received: by pvg12 with SMTP id 12so2348879pvg.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:date:subject:to;
        bh=5X2jZ/SlrbTifuWvkwyTrGN236qpBXpvhlpB972MiA4=;
        b=M0W+vCSIgspStYc+JBRZUFB99mBBTHmiyqz7iqRx6QIVC/U2ioA3twl+ItmxBsitml
         vo6L7FWvIyHKwYq5uhfsu/3ZKZrKpDK+o4pdyz/FQQcKGAFSqOdDoC4sYiC7mZe2nRO/
         RYWJvmyaJcHJ36nDTOC1x0XxjKsBp0GJOWxrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=i25fmpYHqpjDOx+UWkGBpDbD4h/xNZPhkmjEmMvIQvin1KfM3751/G6eB2+LUvAQTF
         bp7S/UM8hAJAoEoRfa8m7V74EazrCIRkVCohZVWXfVk5b2PjtPmFyth4LloLws6iTCnd
         pQQotpQJCf2sE/SeHVHX0CYezWm9seJXCmUzk=
Received: by 10.143.26.42 with SMTP id d42mr697216wfj.215.1306103202214;
        Sun, 22 May 2011 15:26:42 -0700 (PDT)
Received: from localhost (c-76-113-6-93.hsd1.nm.comcast.net [76.113.6.93])
        by mx.google.com with ESMTPS id w27sm3991837wfh.9.2011.05.22.15.26.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 15:26:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174203>

I accidentally tried to use "git diff" when I wasn't within a git
repository, only to be confused by getting a usage message with no
particular error output.

This patch tries to provide better explanations to the user when the diff
cannot be done.

Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
---
 diff-no-index.c |  122 ++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..3172788 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -149,21 +149,56 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
-static int path_outside_repo(const char *path)
+/**
+ * path_in_repo() - Determine whether @path is within a git directory/repo.
+ * @path: pathspec to test
+ *
+ * Returns true if @path is equal to, or lies within, the git tree
+ * returned by get_git_work_tree.
+ */
+static int path_in_repo(const char *path)
 {
-	const char *work_tree;
-	size_t len;
+	const char *tree;
+	const char *abs_path;
+	const char *abs_tree;
+	char norm_path[PATH_MAX+1];
+	char norm_tree[PATH_MAX+1];
+	size_t tree_len;
+	size_t path_len;
+
+	/* Paranoia. */
+	if (!path)
+		return 0;
 
-	if (!is_absolute_path(path))
+	/* If there's no tree, then there's no repo to be in. */
+	tree = get_git_work_tree();
+	if (!tree)
 		return 0;
-	work_tree = get_git_work_tree();
-	if (!work_tree)
-		return 1;
-	len = strlen(work_tree);
-	if (strncmp(path, work_tree, len) ||
-	    (path[len] != '\0' && path[len] != '/'))
-		return 1;
-	return 0;
+
+	/* Get the full paths and normalize them.. */
+	abs_path = real_path(path);
+	if (normalize_path_copy(norm_path, abs_path))
+		die("could not normalize path '%s'", abs_path);
+	abs_tree = real_path(tree);
+	if (normalize_path_copy(norm_tree, abs_tree))
+		die("could not normalize tree '%s'", abs_tree);
+
+	/* See if the work tree is a prefix *directory* of the given path. */
+	path_len = strlen(norm_path);
+	tree_len = strlen(norm_tree);
+
+	if (path_len < tree_len)
+		return 0; /* Can't be a subdir if it's shorter. */
+
+	if (strncmp(norm_path, norm_tree, tree_len))
+		return 0; /* Nor if the first 'tree_len' bytes don't match. */
+
+	if (norm_path[tree_len] == '\0')
+		return 1; /* The path and tree are the same. */
+	if (norm_path[tree_len] == '/')
+		return 1; /* The path is a subdir of the tree. */
+
+	return 0; /* Nope. */
 }
 
 void diff_no_index(struct rev_info *revs,
@@ -186,22 +221,55 @@ void diff_no_index(struct rev_info *revs,
 			break;
 	}
 
-	if (!no_index && !nongit) {
-		/*
-		 * Inside a git repository, without --no-index.  Only
-		 * when a path outside the repository is given,
-		 * e.g. "git diff /var/tmp/[12]", or "git diff
-		 * Makefile /var/tmp/Makefile", allow it to be used as
-		 * a colourful "diff" replacement.
-		 */
-		if ((argc != i + 2) ||
-		    (!path_outside_repo(argv[i]) &&
-		     !path_outside_repo(argv[i+1])))
-			return;
+	/* How many pathspecs were given on the command line? */
+	const int n_paths = (argc - i);
+
+	/* If --no-index wasn't specified explicitly, check to see if
+	 * we need to force it. */
+	if (!no_index) {
+
+		/* The first pathspec is the "left hand side" */
+		const char *lhs = (n_paths >= 1) ? argv[i] : NULL;
+		const int lhs_in_repo = lhs && path_in_repo(lhs);
+
+		/* And the second is the "right hand side" */
+		const char *rhs = (n_paths >= 2) ? argv[i+1] : NULL;
+		const int rhs_in_repo = rhs && path_in_repo(rhs);
+
+		int force_no_index = 0;
+
+		if (nongit) {
+			warning("'git diff' outside a repo, forcing --no-index");
+			force_no_index = 1;
+		}
+		else {
+			if (lhs_in_repo || rhs_in_repo)
+				return; /* Normal git diff, let core handle it. */
+
+			const int lhs_untracked = (lhs && !lhs_in_repo);
+			const int rhs_untracked = (rhs && !rhs_in_repo);
+
+			if (lhs_untracked && rhs_untracked)
+				warning("neither '%s' nor '%s' are tracked,"
+					" forcing --no-index", lhs, rhs );
+			else if (lhs_untracked)
+				warning("'%s' is not tracked,"
+					" forcing --no-index", lhs );
+			else if (rhs_untracked)
+				warning("'%s' is not tracked,"
+					" forcing --no-index", rhs );
+
+			force_no_index = lhs_untracked || rhs_untracked;
+		}
+
+		if (!force_no_index) /* Impossible? */
+			die("--no-index not set and not forced");
+	}
+
+	if (n_paths != 2) {
+		warning("no-index mode requires exactly two pathspecs");
+		usage("git diff --no-index <path> <path>");
 	}
-	if (argc != i + 2)
-		usagef("git diff %s <path> <path>",
-		       no_index ? "--no-index" : "[--no-index]");
 
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
-- 
1.7.4.4
