From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] tree-diff: do not assume we use only one pathspec
Date: Mon, 10 Apr 2006 16:43:39 -0700
Message-ID: <7virph809g.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vodz980az.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 11 01:43:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT62q-0000yW-Cx
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWDJXnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDJXnm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:43:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63374 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932194AbWDJXnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 19:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410234340.TTWX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 19:43:40 -0400
To: git@vger.kernel.org
In-Reply-To: <7vodz980az.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Apr 2006 16:42:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18596>

The way tree-diff was set up assumed we would use only one set
of pathspec during the entire life of the program.  Move the
pathspec related static variables out to diff_options structure
so that we can filter commits with one set of paths while show
the actual diffs using different set of paths.

I suspect this breaks blame.c, and makes "git log paths..." to
default to the --full-diff, the latter of which is dealt with
the next commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diff-tree.c |    2 +-
 diff.h      |    6 +++++-
 revision.c  |    2 +-
 tree-diff.c |   46 +++++++++++++++++++++++++---------------------
 4 files changed, 32 insertions(+), 24 deletions(-)

be7b412689f723a1008b40712d9f0b96773ad81a
diff --git a/diff-tree.c b/diff-tree.c
index 2a088d1..2b79dd0 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -120,7 +120,7 @@ int main(int argc, const char **argv)
 	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
 		opt->diffopt.recursive = 1;
 
-	diff_tree_setup_paths(get_pathspec(prefix, argv));
+	diff_tree_setup_paths(get_pathspec(prefix, argv), opt);
 	diff_setup_done(&opt->diffopt);
 
 	switch (nr_sha1) {
diff --git a/diff.h b/diff.h
index a02ef28..cc7cc62 100644
--- a/diff.h
+++ b/diff.h
@@ -38,11 +38,15 @@ struct diff_options {
 	int setup;
 	int abbrev;
 
+	int nr_paths;
+	const char **paths;
+	int *pathlens;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 };
 
-extern void diff_tree_setup_paths(const char **paths);
+extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
+extern void diff_tree_release_paths(struct diff_options *);
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
diff --git a/revision.c b/revision.c
index fe26562..634f9a5 100644
--- a/revision.c
+++ b/revision.c
@@ -707,7 +707,7 @@ int setup_revisions(int argc, const char
 		revs->limited = 1;
 
 	if (revs->prune_data) {
-		diff_tree_setup_paths(revs->prune_data);
+		diff_tree_setup_paths(revs->prune_data, &diff_opt);
 		revs->prune_fn = try_to_simplify_commit;
 	}
 
diff --git a/tree-diff.c b/tree-diff.c
index 701fbba..1cdf8aa 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,11 +5,6 @@ #include "cache.h"
 #include "diff.h"
 #include "tree.h"
 
-// What paths are we interested in?
-static int nr_paths = 0;
-static const char **paths = NULL;
-static int *pathlens = NULL;
-
 static char *malloc_base(const char *base, const char *path, int pathlen)
 {
 	int baselen = strlen(base);
@@ -72,14 +67,14 @@ static int compare_tree_entry(struct tre
 	return 0;
 }
 
-static int interesting(struct tree_desc *desc, const char *base)
+static int interesting(struct tree_desc *desc, const char *base, struct diff_options *opt)
 {
 	const char *path;
 	unsigned mode;
 	int i;
 	int baselen, pathlen;
 
-	if (!nr_paths)
+	if (!opt->nr_paths)
 		return 1;
 
 	(void)tree_entry_extract(desc, &path, &mode);
@@ -87,9 +82,9 @@ static int interesting(struct tree_desc 
 	pathlen = strlen(path);
 	baselen = strlen(base);
 
-	for (i=0; i < nr_paths; i++) {
-		const char *match = paths[i];
-		int matchlen = pathlens[i];
+	for (i=0; i < opt->nr_paths; i++) {
+		const char *match = opt->paths[i];
+		int matchlen = opt->pathlens[i];
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
@@ -129,7 +124,7 @@ static int interesting(struct tree_desc 
 static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
 {
 	while (desc->size) {
-		if (interesting(desc, base))
+		if (interesting(desc, base, opt))
 			show_entry(opt, prefix, desc, base);
 		update_tree_entry(desc);
 	}
@@ -167,11 +162,11 @@ static int show_entry(struct diff_option
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	while (t1->size | t2->size) {
-		if (nr_paths && t1->size && !interesting(t1, base)) {
+		if (opt->nr_paths && t1->size && !interesting(t1, base, opt)) {
 			update_tree_entry(t1);
 			continue;
 		}
-		if (nr_paths && t2->size && !interesting(t2, base)) {
+		if (opt->nr_paths && t2->size && !interesting(t2, base, opt)) {
 			update_tree_entry(t2);
 			continue;
 		}
@@ -229,19 +224,28 @@ static int count_paths(const char **path
 	return i;
 }
 
-void diff_tree_setup_paths(const char **p)
+void diff_tree_release_paths(struct diff_options *opt)
 {
+	free(opt->pathlens);
+}
+
+void diff_tree_setup_paths(const char **p, struct diff_options *opt)
+{
+	opt->nr_paths = 0;
+	opt->pathlens = NULL;
+	opt->paths = NULL;
+
 	if (p) {
 		int i;
 
-		paths = p;
-		nr_paths = count_paths(paths);
-		if (nr_paths == 0) {
-			pathlens = NULL;
+		opt->paths = p;
+		opt->nr_paths = count_paths(p);
+		if (opt->nr_paths == 0) {
+			opt->pathlens = NULL;
 			return;
 		}
-		pathlens = xmalloc(nr_paths * sizeof(int));
-		for (i=0; i<nr_paths; i++)
-			pathlens[i] = strlen(paths[i]);
+		opt->pathlens = xmalloc(opt->nr_paths * sizeof(int));
+		for (i=0; i < opt->nr_paths; i++)
+			opt->pathlens[i] = strlen(p[i]);
 	}
 }
-- 
1.3.0.rc3.g910a
