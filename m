From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sat, 19 Jan 2008 17:22:29 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGOuM-0000ij-6V
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYATBWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 20:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYATBWy
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:22:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57792 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751714AbYATBWx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 20:22:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1Mlsf013437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 17:22:48 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1MkfV029572;
	Sat, 19 Jan 2008 17:22:46 -0800
In-Reply-To: <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-7.118 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_42,J_CHICKENPOX_45,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71147>



On Sat, 19 Jan 2008, Linus Torvalds wrote:
> 
> and the reason is that 
>  - "run_diff_files()" doesn't honor ce_uptodate
>  - ..but even if it did, wt_status_print_changed() does a wt_read_cache() 
>    which will invalidate and re-read the index!
> 
> The first problem is trivially fixed (appended), the second one is not as 
> trivial.

Ok, I have worked on that not-as-trivial thing here, and indeed, it was 
quite painful and needed major cleanups elsewhere.

The reason why wt-status.c ended up invalidating and re-reading the cache 
multiple times was that it uses "run_diff_index()", which in turn uses 
"read_tree()" to populate the index with *both* the old index and the tree 
we want to compare against.

So this patch re-writes run_diff_index() to not use read_tree(), but 
instead use "unpack_trees()" to diff the index to a tree. That, in turn, 
means that we don't need to modify the index itself, which then means that 
we don't need to invalidate it and re-read it!

This, together with the lstat() optimizations, means that "git commit" on 
the kernel tree really only needs to lstat() the index entries once. That 
noticeably cuts down on the cached timings.

Best time before:

	[torvalds@woody linux]$ time git commit > /dev/null
	real    0m0.399s
	user    0m0.232s
	sys     0m0.164s

Best time after:

	[torvalds@woody linux]$ time git commit > /dev/null
	real    0m0.254s
	user    0m0.140s
	sys     0m0.112s

so it's a noticeable improvement in addition to being a nice conceptual 
cleanup (it's really not that pretty that "run_diff_index()" dirties the 
index!)

Doing an "strace -c" on it also shows that as it cuts the number of 
lstat() calls by two thirds, it goes from being lstat()-limited to being 
limited by getdents() (which is the readdir system call):

Before:
	% time     seconds  usecs/call     calls    errors syscall
	------ ----------- ----------- --------- --------- ----------------
	 60.69    0.000704           0     69230        31 lstat
	 23.62    0.000274           0      5522           getdents
	  8.36    0.000097           0      5508      2638 open
	  2.59    0.000030           0      2869           close
	  2.50    0.000029           0       274           write
	  1.47    0.000017           0      2844           fstat

After:
	% time     seconds  usecs/call     calls    errors syscall
	------ ----------- ----------- --------- --------- ----------------
	 45.17    0.000276           0      5522           getdents
	 26.51    0.000162           0     23112        31 lstat
	 19.80    0.000121           0      5503      2638 open
	  4.91    0.000030           0      2864           close
	  1.48    0.000020           0       274           write
	  1.34    0.000018           0      2844           fstat
	...

It passes the test-suite for me, but this is another of one of those 
really core functions, and certainly pretty subtle, so..

NOTE! The Linux lstat() system call is really quite cheap when everything 
is cached, so the fact that this is quite noticeable on Linux is likely to 
mean that it is *much* more noticeable on other operating systems. I bet 
you'll see a much bigger performance improvement from this on Windows in 
particular.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This patch also includes the already sent-out trivial fix to 
run_diff_files to take advantage of ce_uptodate().


 diff-lib.c     |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 unpack-trees.h |    1 +
 wt-status.c    |    4 ---
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4a05b02..23d0fa6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "cache-tree.h"
 #include "path-list.h"
+#include "unpack-trees.h"
 
 /*
  * diff-files
@@ -435,6 +436,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
+		if (ce_uptodate(ce))
+			continue;
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT && errno != ENOTDIR) {
 				perror(ce->name);
@@ -665,12 +668,54 @@ static void mark_merge_entries(void)
 	}
 }
 
+static int oneway_diff(struct cache_entry **src,
+	struct unpack_trees_options *o,
+	int remove)
+{
+	struct cache_entry *idx = src[0];
+	struct cache_entry *tree = src[1];
+	struct rev_info *revs = o->unpack_data;
+
+	/*
+	 * Unpack-trees generates a DF/conflict entry if
+	 * there was a directory in the index and a tree
+	 * in the tree. From a diff standpoint, that's a
+	 * delete of the tree and a create of the file.
+	 */
+	if (tree == o->df_conflict_entry)
+		tree = NULL;
+
+	/*
+	 * Something added to the tree?
+	 */
+	if (!tree) {
+		if (ce_path_match(idx, revs->prune_data))
+			show_new_file(revs, idx, o->index_only, 0);
+		return 1;
+	}
+
+	/*
+	 * Something removed from the tree?
+	 */
+	if (!idx) {
+		if (ce_path_match(tree, revs->prune_data))
+			diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
+		return 0;
+	}
+
+	/* Show difference between old and new */
+	if (ce_path_match(idx, revs->prune_data))
+		show_modified(revs, tree, idx, 1, o->index_only, 0);
+	return 1;
+}
+
 int run_diff_index(struct rev_info *revs, int cached)
 {
-	int ret;
 	struct object *ent;
 	struct tree *tree;
 	const char *tree_name;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
 	int match_missing = 0;
 
 	/*
@@ -687,13 +732,20 @@ int run_diff_index(struct rev_info *revs, int cached)
 	tree = parse_tree_indirect(ent->sha1);
 	if (!tree)
 		return error("bad tree object %s", tree_name);
-	if (read_tree(tree, 1, revs->prune_data))
-		return error("unable to read tree object %s", tree_name);
-	ret = diff_cache(revs, active_cache, active_nr, revs->prune_data,
-			 cached, match_missing);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.index_only = cached;
+	opts.merge = 1;
+	opts.fn = oneway_diff;
+	opts.unpack_data = revs;
+
+	init_tree_desc(&t, tree->buffer, tree->size);
+	unpack_trees(1, &t, &opts);
+	
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return ret;
+	return 0;
 }
 
 int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
diff --git a/unpack-trees.h b/unpack-trees.h
index 5517faa..197a004 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -25,6 +25,7 @@ struct unpack_trees_options {
 	int merge_size;
 
 	struct cache_entry *df_conflict_entry;
+	void *unpack_data;
 };
 
 extern int unpack_trees(unsigned n, struct tree_desc *t,
diff --git a/wt-status.c b/wt-status.c
index c0c2472..a18ed11 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -229,7 +229,6 @@ static void wt_status_print_initial(struct wt_status *s)
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
-	wt_read_cache(s);
 	if (active_nr) {
 		s->commitable = 1;
 		wt_status_print_cached_header(s);
@@ -256,7 +255,6 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
-	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 }
 
@@ -268,7 +266,6 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
-	wt_read_cache(s);
 	run_diff_files(&rev, 0);
 }
 
@@ -335,7 +332,6 @@ static void wt_status_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
-	wt_read_cache(s);
 	run_diff_index(&rev, 1);
 
 	fflush(stdout);
