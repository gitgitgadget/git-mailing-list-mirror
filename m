From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] commit: allow partial commits with relative paths
Date: Sat, 30 Jul 2011 19:13:47 +0200
Message-ID: <20110730171347.GA10432@toss.lan>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
 <20110729133551.GA8707@toss.lan>
 <4E343534.8000604@drmicha.warpmail.net>
 <20110730170045.GA9900@toss.lan>
 <4E34399C.2080109@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jul 30 19:14:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnD70-0003mu-FW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 19:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab1G3RN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 13:13:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36205 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752559Ab1G3RNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 13:13:53 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 3974E1001C;
	Sat, 30 Jul 2011 19:13:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E34399C.2080109@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178216>

In order to do partial commits, git-commit overlays a tree on the
cache and checks pathspecs against the result. Currently, the
overlaying is done using "prefix" which prevents relative pathspecs
with ".." and absolute pathspec from matching when they refer to
files not under "prefix" and absent from the index, but still in
the tree (i.e.  files staged for removal).

The point of providing a prefix at all is performance optimization.
If we say there is no common prefix for the files of interest, then
we have to read the entire tree into the index.

But even if we cannot use the working directory as a prefix, we can
still figure out if there is a common prefix for all given paths,
and use that instead. The pathspec_prefix() routine from ls-files.c
does exactly that.

Any use of global variables is removed from pathspec_prefix() so
that it can be called from commit.c.

Reported-by: Reuben Thomas <rrt@sc3d.org>
Analyzed-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Jul 30, 2011 at 07:04:28PM +0200, Michael J Gruber wrote:
> 
> That's the kind of explanation that I meant. Thanks.

I do tend to be too brief. Sorry about that.

Only the commit message changed in this v2.

 builtin/commit.c   |    6 ++++--
 builtin/ls-files.c |   38 ++------------------------------------
 cache.h            |    1 +
 setup.c            |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a16d00b..c2db12a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -256,8 +256,10 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		;
 	m = xcalloc(1, i);
 
-	if (with_tree)
-		overlay_tree_on_cache(with_tree, prefix);
+	if (with_tree) {
+		const char *max_prefix = pathspec_prefix(prefix, pattern);
+		overlay_tree_on_cache(with_tree, max_prefix);
+	}
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 72b986f..fef5642 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -276,41 +276,6 @@ static void prune_cache(const char *prefix)
 	active_nr = last;
 }
 
-static const char *pathspec_prefix(const char *prefix)
-{
-	const char **p, *n, *prev;
-	unsigned long max;
-
-	if (!pathspec) {
-		max_prefix_len = prefix ? strlen(prefix) : 0;
-		return prefix;
-	}
-
-	prev = NULL;
-	max = PATH_MAX;
-	for (p = pathspec; (n = *p) != NULL; p++) {
-		int i, len = 0;
-		for (i = 0; i < max; i++) {
-			char c = n[i];
-			if (prev && prev[i] != c)
-				break;
-			if (!c || c == '*' || c == '?')
-				break;
-			if (c == '/')
-				len = i+1;
-		}
-		prev = n;
-		if (len < max) {
-			max = len;
-			if (!max)
-				break;
-		}
-	}
-
-	max_prefix_len = max;
-	return max ? xmemdupz(prev, max) : NULL;
-}
-
 static void strip_trailing_slash_from_submodules(void)
 {
 	const char **p;
@@ -581,7 +546,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		strip_trailing_slash_from_submodules();
 
 	/* Find common prefix for all pathspec's */
-	max_prefix = pathspec_prefix(prefix);
+	max_prefix = pathspec_prefix(prefix, pathspec);
+	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
diff --git a/cache.h b/cache.h
index 86518fb..dd3edaa 100644
--- a/cache.h
+++ b/cache.h
@@ -441,6 +441,7 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
+extern const char *pathspec_prefix(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/setup.c b/setup.c
index 5ea5502..2c51a9a 100644
--- a/setup.c
+++ b/setup.c
@@ -264,6 +264,38 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	return pathspec;
 }
 
+const char *pathspec_prefix(const char *prefix, const char **pathspec)
+{
+	const char **p, *n, *prev;
+	unsigned long max;
+
+	if (!pathspec)
+		return prefix ? xmemdupz(prefix, strlen(prefix)) : NULL;
+
+	prev = NULL;
+	max = PATH_MAX;
+	for (p = pathspec; (n = *p) != NULL; p++) {
+		int i, len = 0;
+		for (i = 0; i < max; i++) {
+			char c = n[i];
+			if (prev && prev[i] != c)
+				break;
+			if (!c || c == '*' || c == '?')
+				break;
+			if (c == '/')
+				len = i+1;
+		}
+		prev = n;
+		if (len < max) {
+			max = len;
+			if (!max)
+				break;
+		}
+	}
+
+	return max ? xmemdupz(prev, max) : NULL;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
-- 
1.7.3.1.105.g84915
