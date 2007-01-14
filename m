From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Allow the user to control the verbosity of merge-recursive.
Date: Sun, 14 Jan 2007 00:28:48 -0500
Message-ID: <20070114052848.GB19113@spearce.org>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 06:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5xvp-0006Ma-Do
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 06:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXANF2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 00:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXANF2z
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 00:28:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46630 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXANF2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 00:28:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5xvF-0004jR-Mi; Sun, 14 Jan 2007 00:28:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A86A20FBAE; Sun, 14 Jan 2007 00:28:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36794>

Junio C Hamano <junkio@cox.net> writes:
> I think the output from merge-recursive can be categorized into 5
> verbosity levels:
>
> 1. "CONFLICT", "Rename", "Adding here instead due to D/F conflict"
> (outermost)
>
> 2. "Auto-merged successfully" (outermost)
>
> 3. The first "Merging X with Y".
>
> 4. outermost "Merging:\ntitle1\ntitle2".
>
> 5. outermost "found N common ancestors\nancestor1\nancestor2\n..."
> and anything from inner merge.
>
> I would prefer the default verbosity level to be 2 (that is, show
> both 1 and 2).

and this change makes it so.  I think level 3 is probably pointless
as its only one line of output above level 2, but I can see how some
users may want to view it but not view the slightly more verbose
output of level 4.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    7 +++
 merge-recursive.c        |  100 ++++++++++++++++++++++++++++-----------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f7dba89..faa17ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -321,6 +321,13 @@ merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
 
+merge.verbosity::
+	Controls the amount of output shown by the recursive merge
+	strategy.  Level 0 outputs nothing except a final error
+	message if conflicts were detected. Level 1 outputs only
+	conflicts, 2 outputs conflicts and file changes.  Level 5 and
+	above outputs debugging information.  The default is level 2.
+
 pack.window::
 	The size of the window used by gitlink:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/merge-recursive.c b/merge-recursive.c
index 8738f09..05f9311 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -71,17 +71,25 @@ static struct path_list current_file_set = {NULL, 0, 0, 1};
 static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
+static int verbosity = 2;
 
-static void output(const char *fmt, ...)
+static int show (int v)
+{
+	return (!call_depth && verbosity >= v) || verbosity >= 5;
+}
+
+static void output(int v, const char *fmt, ...)
 {
 	va_list args;
-	int i;
-	for (i = call_depth; i--;)
-		fputs("  ", stdout);
 	va_start(args, fmt);
-	vfprintf(stdout, fmt, args);
+	if (show(v)) {
+		int i;
+		for (i = call_depth; i--;)
+			fputs("  ", stdout);
+		vfprintf(stdout, fmt, args);
+		fputc('\n', stdout);
+	}
 	va_end(args);
-	fputc('\n', stdout);
 }
 
 static void output_commit_title(struct commit *commit)
@@ -640,13 +648,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *dst_name2 = ren2_dst;
 	if (path_list_has_path(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
-		output("%s is a directory in %s adding as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
 	if (path_list_has_path(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
-		output("%s is a directory in %s adding as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
@@ -660,7 +668,7 @@ static void conflict_rename_dir(struct rename *ren1,
 				const char *branch1)
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
-	output("Renaming %s to %s instead", ren1->pair->one->path, new_path);
+	output(1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path, 0);
 	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
@@ -673,7 +681,7 @@ static void conflict_rename_rename_2(struct rename *ren1,
 {
 	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
-	output("Renaming %s to %s and %s to %s instead",
+	output(1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path, 0);
@@ -766,7 +774,7 @@ static int process_renames(struct path_list *a_renames,
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
 				clean_merge = 0;
-				output("CONFLICT (rename/rename): "
+				output(1, "CONFLICT (rename/rename): "
 				       "Rename %s->%s in branch %s "
 				       "rename %s->%s in %s",
 				       src, ren1_dst, branch1,
@@ -781,13 +789,13 @@ static int process_renames(struct path_list *a_renames,
 						 branch1,
 						 branch2);
 				if (mfi.merge || !mfi.clean)
-					output("Renaming %s->%s", src, ren1_dst);
+					output(2, "Renaming %s->%s", src, ren1_dst);
 
 				if (mfi.merge)
-					output("Auto-merging %s", ren1_dst);
+					output(2, "Auto-merging %s", ren1_dst);
 
 				if (!mfi.clean) {
-					output("CONFLICT (content): merge conflict in %s",
+					output(1, "CONFLICT (content): merge conflict in %s",
 					       ren1_dst);
 					clean_merge = 0;
 
@@ -818,14 +826,14 @@ static int process_renames(struct path_list *a_renames,
 
 			if (path_list_has_path(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
-				output("CONFLICT (rename/directory): Rename %s->%s in %s "
+				output(1, "CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				conflict_rename_dir(ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output("CONFLICT (rename/delete): Rename %s->%s in %s "
+				output(1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
@@ -834,18 +842,18 @@ static int process_renames(struct path_list *a_renames,
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-				output("CONFLICT (rename/add): Rename %s->%s in %s. "
+				output(1, "CONFLICT (rename/add): Rename %s->%s in %s. "
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
-				output("Adding as %s instead", new_path);
+				output(1, "Adding as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
-				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
+				output(1, "CONFLICT (rename/rename): Rename %s->%s in %s. "
 				       "Rename %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
@@ -870,11 +878,11 @@ static int process_renames(struct path_list *a_renames,
 						a_branch, b_branch);
 
 				if (mfi.merge || !mfi.clean)
-					output("Renaming %s => %s", ren1_src, ren1_dst);
+					output(2, "Renaming %s => %s", ren1_src, ren1_dst);
 				if (mfi.merge)
-					output("Auto-merging %s", ren1_dst);
+					output(2, "Auto-merging %s", ren1_dst);
 				if (!mfi.clean) {
-					output("CONFLICT (rename/modify): Merge conflict in %s",
+					output(1, "CONFLICT (rename/modify): Merge conflict in %s",
 					       ren1_dst);
 					clean_merge = 0;
 
@@ -922,20 +930,20 @@ static int process_entry(const char *path, struct stage_data *entry,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output("Removing %s", path);
+				output(2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(1, path, !a_sha);
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
 			if (!a_sha) {
-				output("CONFLICT (delete/modify): %s deleted in %s "
+				output(1, "CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch1,
 				       branch2, branch2, path);
 				update_file(0, b_sha, b_mode, path);
 			} else {
-				output("CONFLICT (delete/modify): %s deleted in %s "
+				output(1, "CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch2,
 				       branch1, branch1, path);
@@ -968,13 +976,13 @@ static int process_entry(const char *path, struct stage_data *entry,
 		if (path_list_has_path(&current_directory_set, path)) {
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
-			output("CONFLICT (%s): There is a directory with name %s in %s. "
+			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			remove_file(0, path, 0);
 			update_file(0, sha, mode, new_path);
 		} else {
-			output("Adding %s", path);
+			output(2, "Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
@@ -988,7 +996,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			reason = "add/add";
 			o_sha = (unsigned char *)null_sha1;
 		}
-		output("Auto-merging %s", path);
+		output(2, "Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
 		hashcpy(o.sha1, o_sha);
 		o.mode = o_mode;
@@ -1004,7 +1012,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			update_file(1, mfi.sha, mfi.mode, path);
 		else {
 			clean_merge = 0;
-			output("CONFLICT (%s): Merge conflict in %s",
+			output(1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
 
 			if (index_only)
@@ -1028,7 +1036,7 @@ static int merge_trees(struct tree *head,
 {
 	int code, clean;
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output("Already uptodate!");
+		output(0, "Already uptodate!");
 		*result = head;
 		return 1;
 	}
@@ -1103,18 +1111,22 @@ static int merge(struct commit *h1,
 	struct tree *mrtree;
 	int clean;
 
-	output("Merging:");
-	output_commit_title(h1);
-	output_commit_title(h2);
+	if (show(4)) {
+		output(4, "Merging:");
+		output_commit_title(h1);
+		output_commit_title(h2);
+	}
 
 	if (!ca) {
 		ca = get_merge_bases(h1, h2, 1);
 		ca = reverse_commit_list(ca);
 	}
 
-	output("found %u common ancestor(s):", commit_list_count(ca));
-	for (iter = ca; iter; iter = iter->next)
-		output_commit_title(iter->item);
+	if (show(5)) {
+		output(5, "found %u common ancestor(s):", commit_list_count(ca));
+		for (iter = ca; iter; iter = iter->next)
+			output_commit_title(iter->item);
+	}
 
 	merged_common_ancestors = pop_commit(&ca);
 	if (merged_common_ancestors == NULL) {
@@ -1196,6 +1208,15 @@ static struct commit *get_ref(const char *ref)
 	return (struct commit *)object;
 }
 
+static int merge_config(const char *var, const char *value)
+{
+	if (!strcasecmp(var, "merge.verbosity")) {
+		verbosity = git_config_int(var, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int main(int argc, char *argv[])
 {
 	static const char *bases[20];
@@ -1207,7 +1228,9 @@ int main(int argc, char *argv[])
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd;
 
-	git_config(git_default_config); /* core.filemode */
+	git_config(merge_config);
+	if (getenv("GIT_MERGE_VERBOSITY"))
+		verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
 
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
@@ -1229,7 +1252,8 @@ int main(int argc, char *argv[])
 
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
-	printf("Merging %s with %s\n", branch1, branch2);
+	if (show(3))
+		printf("Merging %s with %s\n", branch1, branch2);
 
 	index_fd = hold_lock_file_for_update(lock, get_index_file(), 1);
 
-- 
1.5.0.rc1.g4494
