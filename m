From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 05/22] teach diff-files.c about cache iterators
Date: Mon, 12 Sep 2005 10:55:54 -0400
Message-ID: <20050912145554.28120.4307.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:02:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpln-0001hk-UO
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVILO5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVILO4x
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:53 -0400
Received: from citi.umich.edu ([141.211.133.111]:52240 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751292AbVILOzy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:54 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 4E5A91BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:54 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8398>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 diff-files.c |   79 ++++++++++++++++++++++++++++++----------------------------
 1 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -11,6 +11,7 @@ static const char diff_files_usage[] =
 "[<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
+static const unsigned char null_sha1[20] = { 0, };
 static int diff_output_format = DIFF_FORMAT_RAW;
 static int diff_line_termination = '\n';
 static int detect_rename = 0;
@@ -22,6 +23,7 @@ static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static const char *diff_filter = NULL;
+static const char **pathspec;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -41,12 +43,47 @@ static void show_modified(int oldmode, i
 	diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
 }
 
+static int diff_one_file(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	struct stat st;
+	unsigned int oldmode;
+	int changed;
+
+	if (!ce_path_match(ce, pathspec))
+		goto out;
+
+	if (ce_stage(ce)) {
+		show_unmerge(ce->name);
+		next_name(cc, ce);
+		return 0;
+	}
+
+	if (lstat(ce->name, &st) < 0) {
+		if (errno != ENOENT && errno != ENOTDIR) {
+			perror(ce->name);
+			goto out;
+		}
+		if (silent)
+			goto out;
+		show_file('-', ce);
+		goto out;
+	}
+	changed = ce_match_stat(ce, &st);
+	if (!changed && !find_copies_harder)
+		goto out;
+	oldmode = ntohl(ce->ce_mode);
+	show_modified(oldmode, DIFF_FILE_CANON_MODE(st.st_mode),
+		      ce->sha1, (changed ? null_sha1 : ce->sha1),
+		      ce->name);
+out:
+	next_cc(cc);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
-	static const unsigned char null_sha1[20] = { 0, };
-	const char **pathspec;
 	const char *prefix = setup_git_directory();
-	int entries, i;
+	int entries;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-p") || !strcmp(argv[1], "-u"))
@@ -112,42 +149,8 @@ int main(int argc, char **argv)
 
 	diff_setup(diff_setup_opt);
 
-	for (i = 0; i < entries; i++) {
-		struct stat st;
-		unsigned int oldmode;
-		struct cache_entry *ce = active_cache[i];
-		int changed;
-
-		if (!ce_path_match(ce, pathspec))
-			continue;
-
-		if (ce_stage(ce)) {
-			show_unmerge(ce->name);
-			while (i < entries &&
-			       !strcmp(ce->name, active_cache[i]->name))
-				i++;
-			i--; /* compensate for loop control increments */
-			continue;
-		}
+	walk_cache(diff_one_file);
 
-		if (lstat(ce->name, &st) < 0) {
-			if (errno != ENOENT && errno != ENOTDIR) {
-				perror(ce->name);
-				continue;
-			}
-			if (silent)
-				continue;
-			show_file('-', ce);
-			continue;
-		}
-		changed = ce_match_stat(ce, &st);
-		if (!changed && !find_copies_harder)
-			continue;
-		oldmode = ntohl(ce->ce_mode);
-		show_modified(oldmode, DIFF_FILE_CANON_MODE(st.st_mode),
-			      ce->sha1, (changed ? null_sha1 : ce->sha1),
-			      ce->name);
-	}
 	diffcore_std(pathspec, 
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
