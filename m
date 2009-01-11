From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 19:36:42 +0100
Message-ID: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 19:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM5CQ-0006Q7-CO
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 19:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZAKSgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 13:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbZAKSgs
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 13:36:48 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:43696 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZAKSgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 13:36:47 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00HU5L19W190@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 19:36:45 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.153])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDB00HMHL16T060@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 19:36:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105195>

Commit c40641b77b0274186fd1b327d5dc3246f814aaaf, 'Optimize
symlink/directory detection' by Linus Torvalds, removed the 'char
*symcache' parameter to the has_symlink_leading_path() function.  This
made all variables currently named 'symcache' inside diff-lib.c
unnecessary.

This also let us throw away the 'struct oneway_unpack_data', and
instead directly use the 'struct rev_info *revs' member, which
was the only member left after removal of the 'symcache[] array'
member.  The 'struct oneway_unpack_data' was introduced by the
following commit:

  948dd346  "diff-files: careful when inspecting work tree items"

Impact: cleanup
        PATH_MAX bytes less memory stack usage in some cases

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 ae96c64... e6d1d2b... M	diff-lib.c
 diff-lib.c |   40 +++++++++++-----------------------------
 1 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64ca209f4df9008198e8a04b160bed618c7..e6d1d2b34147a13aadb5019e0c8336ef5f56ee39 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -61,14 +61,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	int silent_on_removed = option & DIFF_SILENT_ON_REMOVED;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
-	char symcache[PATH_MAX];
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
-	symcache[0] = '\0';
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, newmode;
@@ -198,11 +196,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
  * diff-index
  */
 
-struct oneway_unpack_data {
-	struct rev_info *revs;
-	char symcache[PATH_MAX];
-};
-
 /* A file entry went away or appeared */
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
@@ -216,8 +209,7 @@ static void diff_index_show_file(struct rev_info *revs,
 static int get_stat_data(struct cache_entry *ce,
 			 const unsigned char **sha1p,
 			 unsigned int *modep,
-			 int cached, int match_missing,
-			 struct oneway_unpack_data *cbdata)
+			 int cached, int match_missing)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -248,25 +240,24 @@ static int get_stat_data(struct cache_entry *ce,
 	return 0;
 }
 
-static void show_new_file(struct oneway_unpack_data *cbdata,
+static void show_new_file(struct rev_info *revs,
 			  struct cache_entry *new,
 			  int cached, int match_missing)
 {
 	const unsigned char *sha1;
 	unsigned int mode;
-	struct rev_info *revs = cbdata->revs;
 
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working copy.
 	 */
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing, cbdata) < 0)
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
 		return;
 
 	diff_index_show_file(revs, "+", new, sha1, mode);
 }
 
-static int show_modified(struct oneway_unpack_data *cbdata,
+static int show_modified(struct rev_info *revs,
 			 struct cache_entry *old,
 			 struct cache_entry *new,
 			 int report_missing,
@@ -274,9 +265,8 @@ static int show_modified(struct oneway_unpack_data *cbdata,
 {
 	unsigned int mode, oldmode;
 	const unsigned char *sha1;
-	struct rev_info *revs = cbdata->revs;
 
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing, cbdata) < 0) {
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
 					     old->sha1, old->ce_mode);
@@ -344,8 +334,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct cache_entry *idx,
 	struct cache_entry *tree)
 {
-	struct oneway_unpack_data *cbdata = o->unpack_data;
-	struct rev_info *revs = cbdata->revs;
+	struct rev_info *revs = o->unpack_data;;
 	int match_missing, cached;
 
 	/*
@@ -368,7 +357,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something added to the tree?
 	 */
 	if (!tree) {
-		show_new_file(cbdata, idx, cached, match_missing);
+		show_new_file(revs, idx, cached, match_missing);
 		return;
 	}
 
@@ -381,7 +370,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	}
 
 	/* Show difference between old and new */
-	show_modified(cbdata, tree, idx, 1, cached, match_missing);
+	show_modified(revs, tree, idx, 1, cached, match_missing);
 }
 
 static inline void skip_same_name(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -418,8 +407,7 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 {
 	struct cache_entry *idx = src[0];
 	struct cache_entry *tree = src[1];
-	struct oneway_unpack_data *cbdata = o->unpack_data;
-	struct rev_info *revs = cbdata->revs;
+	struct rev_info *revs = o->unpack_data;
 
 	if (idx && ce_stage(idx))
 		skip_same_name(idx, o);
@@ -446,7 +434,6 @@ int run_diff_index(struct rev_info *revs, int cached)
 	const char *tree_name;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	struct oneway_unpack_data unpack_cb;
 
 	mark_merge_entries();
 
@@ -456,14 +443,12 @@ int run_diff_index(struct rev_info *revs, int cached)
 	if (!tree)
 		return error("bad tree object %s", tree_name);
 
-	unpack_cb.revs = revs;
-	unpack_cb.symcache[0] = '\0';
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
-	opts.unpack_data = &unpack_cb;
+	opts.unpack_data = revs;
 	opts.src_index = &the_index;
 	opts.dst_index = NULL;
 
@@ -486,7 +471,6 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	struct cache_entry *last = NULL;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	struct oneway_unpack_data unpack_cb;
 
 	/*
 	 * This is used by git-blame to run diff-cache internally;
@@ -515,14 +499,12 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
 
-	unpack_cb.revs = &revs;
-	unpack_cb.symcache[0] = '\0';
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
-	opts.unpack_data = &unpack_cb;
+	opts.unpack_data = &revs;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-- 
1.6.1.rc1.49.g7f705
