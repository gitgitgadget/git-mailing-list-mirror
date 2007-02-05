From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-blame: no rev means start from the working tree file.
Date: Sun, 04 Feb 2007 19:00:45 -0800
Message-ID: <7vsldlpaua.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
	<7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
	<20070204185144.GB24368@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org>
	<20070204205858.GE12943@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 04:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDu65-0001Jo-UF
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 04:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbXBEDAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 22:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbXBEDAs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 22:00:48 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:39910 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752673AbXBEDAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 22:00:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205030045.JRDL1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 22:00:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kf0l1W0051kojtg0000000; Sun, 04 Feb 2007 22:00:46 -0500
In-Reply-To: <20070204205858.GE12943@thunk.org> (Theodore Tso's message of
	"Sun, 4 Feb 2007 15:58:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38722>

Warning: this changes the semantics.

This makes "git blame" without any positive rev to start digging
from the working tree copy, which is made into a fake commit
whose sole parent is the HEAD.

It also adds --contents <file> option to pretend as if the
working tree copy has the contents of the named file.  You can
use '-' to make the command read from the standard input.

If you want the command to start annotating from the HEAD
commit, you need to explicitly give HEAD parameter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Theodore Tso <tytso@mit.edu> writes:

 > On Sun, Feb 04, 2007 at 11:12:34AM -0800, Linus Torvalds wrote:
 >> 
 >> On Sun, 4 Feb 2007, Jeff King wrote:
 >> > 
 >> > Just a thought, but it might be useful to blame the contents of an
 >> > arbitrary file (but starting the history at a given pathname). Something
 >> > like "git blame --contents /tmp/foo.c file.c", with contents defaulting
 >> > to "file.c". There's much discussion of editor interfaces, and this
 >> > leaves the possibility of git-blaming the contents of the editor buffer
 >> > (after writing it out to a temp file) without having to save changes to
 >> > the working tree file.
 >> 
 >> I agree, that probably would make most sense. If we do this at all. On the 
 >> other hand, I suspect that most editors would probably want to pipe the 
 >> contents to the program, not write it to a temp-file.
 >
 > ... and use it with --incremental, as well.  In emacs you can have the
 > annotation take place as it is being written out relatively easily, by
 > arranging to have a callback function get called each time more
 > information is handed back to emacs via a pipe.

 * By popular request, this is the second round of the patch.
   I've splitted out a small change to make ident.c::get_ident()
   available to this one into a separate commit, which this
   patch depends on.

 builtin-blame.c |  209 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 diff-lib.c      |   44 +++++++++++-
 diff.h          |    1 +
 3 files changed, 228 insertions(+), 26 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 1c21204..897323a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -15,9 +15,10 @@
 #include "revision.h"
 #include "quote.h"
 #include "xdiff-interface.h"
+#include "cache-tree.h"
 
 static char blame_usage[] =
-"git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
+"git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
 "  -l, --long          Show long commit SHA1 (Default: off)\n"
@@ -29,6 +30,7 @@ static char blame_usage[] =
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
 "  --incremental       Show blame entries as we find them, incrementally\n"
+"  --contents file     Use <file>'s contents as the final image\n"
 "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
 
 static int longest_file;
@@ -333,9 +335,13 @@ static struct origin *find_origin(struct scoreboard *sb,
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
-	diff_tree_sha1(parent->tree->object.sha1,
-		       origin->commit->tree->object.sha1,
-		       "", &diff_opts);
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	/* It is either one entry that says "modified", or "created",
@@ -402,9 +408,13 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
-	diff_tree_sha1(parent->tree->object.sha1,
-		       origin->commit->tree->object.sha1,
-		       "", &diff_opts);
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
@@ -1047,9 +1057,12 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	    (!porigin || strcmp(target->path, porigin->path)))
 		diff_opts.find_copies_harder = 1;
 
-	diff_tree_sha1(parent->tree->object.sha1,
-		       target->commit->tree->object.sha1,
-		       "", &diff_opts);
+	if (is_null_sha1(target->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       target->commit->tree->object.sha1,
+			       "", &diff_opts);
 
 	if (!diff_opts.find_copies_harder)
 		diffcore_std(&diff_opts);
@@ -1336,9 +1349,9 @@ static void get_commit_info(struct commit *commit,
 	tmp += 2;
 	endp = strchr(tmp, '\n');
 	if (!endp)
-		goto error_out;
+		endp = tmp + strlen(tmp);
 	len = endp - tmp;
-	if (len >= sizeof(summary_buf))
+	if (len >= sizeof(summary_buf) || len == 0)
 		goto error_out;
 	memcpy(summary_buf, tmp, len);
 	summary_buf[len] = 0;
@@ -1910,6 +1923,137 @@ static int git_blame_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static struct commit *fake_working_tree_commit(const char *path, const char *contents_from)
+{
+	struct commit *commit;
+	struct origin *origin;
+	unsigned char head_sha1[20];
+	char *buf;
+	const char *ident;
+	int fd;
+	time_t now;
+	unsigned long fin_size;
+	int size, len;
+	struct cache_entry *ce;
+	unsigned mode;
+
+	if (get_sha1("HEAD", head_sha1))
+		die("No such ref: HEAD");
+
+	time(&now);
+	commit = xcalloc(1, sizeof(*commit));
+	commit->parents = xcalloc(1, sizeof(*commit->parents));
+	commit->parents->item = lookup_commit_reference(head_sha1);
+	commit->object.parsed = 1;
+	commit->date = now;
+	commit->object.type = OBJ_COMMIT;
+
+	origin = make_origin(commit, path);
+
+	if (!contents_from || strcmp("-", contents_from)) {
+		struct stat st;
+		const char *read_from;
+
+		if (contents_from) {
+			if (stat(contents_from, &st) < 0)
+				die("Cannot stat %s", contents_from);
+			read_from = contents_from;
+		}
+		else {
+			if (lstat(path, &st) < 0)
+				die("Cannot lstat %s", path);
+			read_from = path;
+		}
+		fin_size = st.st_size;
+		buf = xmalloc(fin_size+1);
+		mode = canon_mode(st.st_mode);
+		switch (st.st_mode & S_IFMT) {
+		case S_IFREG:
+			fd = open(read_from, O_RDONLY);
+			if (fd < 0)
+				die("cannot open %s", read_from);
+			if (read_in_full(fd, buf, fin_size) != fin_size)
+				die("cannot read %s", read_from);
+			break;
+		case S_IFLNK:
+			if (readlink(read_from, buf, fin_size+1) != fin_size)
+				die("cannot readlink %s", read_from);
+			break;
+		default:
+			die("unsupported file type %s", read_from);
+		}
+	}
+	else {
+		/* Reading from stdin */
+		contents_from = "standard input";
+		buf = NULL;
+		fin_size = 0;
+		mode = 0;
+		while (1) {
+			ssize_t cnt = 8192;
+			buf = xrealloc(buf, fin_size + cnt);
+			cnt = xread(0, buf + fin_size, cnt);
+			if (cnt < 0)
+				die("read error %s from stdin",
+				    strerror(errno));
+			if (!cnt)
+				break;
+			fin_size += cnt;
+		}
+		buf = xrealloc(buf, fin_size + 1);
+	}
+	buf[fin_size] = 0;
+	origin->file.ptr = buf;
+	origin->file.size = fin_size;
+	write_sha1_file(buf, fin_size, blob_type, origin->blob_sha1);
+	commit->util = origin;
+
+	/*
+	 * Read the current index, replace the path entry with
+	 * origin->blob_sha1 without mucking with its mode or type
+	 * bits; we are not going to write this index out -- we just
+	 * want to run "diff-index --cached".
+	 */
+	discard_cache();
+	read_cache();
+
+	len = strlen(path);
+	if (!mode) {
+		int pos = cache_name_pos(path, len);
+		if (0 <= pos)
+			mode = ntohl(active_cache[pos]->ce_mode);
+		else
+			/* Let's not bother reading from HEAD tree */
+			mode = S_IFREG | 0644;
+	}
+	size = cache_entry_size(len);
+	ce = xcalloc(1, size);
+	hashcpy(ce->sha1, origin->blob_sha1);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_mode = create_ce_mode(mode);
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+
+	/*
+	 * We are not going to write this out, so this does not matter
+	 * right now, but someday we might optimize diff-index --cached
+	 * with cache-tree information.
+	 */
+	cache_tree_invalidate_path(active_cache_tree, path);
+
+	commit->buffer = xmalloc(400);
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	sprintf(commit->buffer,
+		"tree 0000000000000000000000000000000000000000\n"
+		"parent %s\n"
+		"author %s\n"
+		"committer %s\n\n"
+		"Version of %s from %s\n",
+		sha1_to_hex(head_sha1),
+		ident, ident, path, contents_from ? contents_from : path);
+	return commit;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1924,6 +2068,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *final_commit_name = NULL;
 	char type[10];
 	const char *bottomtop = NULL;
+	const char *contents_from = NULL;
 
 	git_config(git_blame_config);
 	save_commit_buffer = 0;
@@ -1968,6 +2113,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				die("More than one '-L n,m' option given");
 			bottomtop = arg;
 		}
+		else if (!strcmp("--contents", arg)) {
+			if (++i >= argc)
+				usage(blame_usage);
+			contents_from = argv[i];
+		}
 		else if (!strcmp("--incremental", arg))
 			incremental = 1;
 		else if (!strcmp("--score-debug", arg))
@@ -2087,7 +2237,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argv[unk] = NULL;
 
 	init_revisions(&revs, NULL);
-	setup_revisions(unk, argv, &revs, "HEAD");
+	setup_revisions(unk, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
 	/*
@@ -2114,16 +2264,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!sb.final) {
 		/*
 		 * "--not A B -- path" without anything positive;
-		 * default to HEAD.
+		 * do not default to HEAD, but use the working tree
+		 * or "--contents".
 		 */
-		unsigned char head_sha1[20];
-
-		final_commit_name = "HEAD";
-		if (get_sha1(final_commit_name, head_sha1))
-			die("No such ref: HEAD");
-		sb.final = lookup_commit_reference(head_sha1);
-		add_pending_object(&revs, &(sb.final->object), "HEAD");
+		sb.final = fake_working_tree_commit(path, contents_from);
+		add_pending_object(&revs, &(sb.final->object), ":");
 	}
+	else if (contents_from)
+		die("Cannot use --contents with final commit object name");
 
 	/*
 	 * If we have bottom, this will mark the ancestors of the
@@ -2132,11 +2280,22 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	 */
 	prepare_revision_walk(&revs);
 
-	o = get_origin(&sb, sb.final, path);
-	if (fill_blob_sha1(o))
-		die("no such path %s in %s", path, final_commit_name);
+	if (is_null_sha1(sb.final->object.sha1)) {
+		char *buf;
+		o = sb.final->util;
+		buf = xmalloc(o->file.size + 1);
+		memcpy(buf, o->file.ptr, o->file.size + 1);
+		sb.final_buf = buf;
+		sb.final_buf_size = o->file.size;
+	}
+	else {
+		o = get_origin(&sb, sb.final, path);
+		if (fill_blob_sha1(o))
+			die("no such path %s in %s", path, final_commit_name);
 
-	sb.final_buf = read_sha1_file(o->blob_sha1, type, &sb.final_buf_size);
+		sb.final_buf = read_sha1_file(o->blob_sha1, type,
+					      &sb.final_buf_size);
+	}
 	num_read_blob++;
 	lno = prepare_lines(&sb);
 
diff --git a/diff-lib.c b/diff-lib.c
index 2c9be60..91cd877 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
+#include "cache-tree.h"
 
 /*
  * diff-files
@@ -271,7 +272,7 @@ static int diff_cache(struct rev_info *revs,
 				break;
 			}
 			/* Show difference between old and new */
-			show_modified(revs,ac[1], ce, 1,
+			show_modified(revs, ac[1], ce, 1,
 				      cached, match_missing);
 			break;
 		case 1:
@@ -372,3 +373,44 @@ int run_diff_index(struct rev_info *revs, int cached)
 	diff_flush(&revs->diffopt);
 	return ret;
 }
+
+int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
+{
+	struct tree *tree;
+	struct rev_info revs;
+	int i;
+	struct cache_entry **dst;
+	struct cache_entry *last = NULL;
+
+	/*
+	 * This is used by git-blame to run diff-cache internally;
+	 * it potentially needs to repeatedly run this, so we will
+	 * start by removing the higher order entries the last round
+	 * left behind.
+	 */
+	dst = active_cache;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce)) {
+			if (last && !strcmp(ce->name, last->name))
+				continue;
+			cache_tree_invalidate_path(active_cache_tree,
+						   ce->name);
+			last = ce;
+			ce->ce_mode = 0;
+			ce->ce_flags &= ~htons(CE_STAGEMASK);
+		}
+		*dst++ = ce;
+	}
+	active_nr = dst - active_cache;
+
+	init_revisions(&revs, NULL);
+	revs.prune_data = opt->paths;
+	tree = parse_tree_indirect(tree_sha1);
+	if (!tree)
+		die("bad tree object %s", sha1_to_hex(tree_sha1));
+	if (read_tree(tree, 1, opt->paths))
+		return error("unable to read tree %s", sha1_to_hex(tree_sha1));
+	return diff_cache(&revs, active_cache, active_nr, revs.prune_data,
+			  1, 0);
+}
diff --git a/diff.h b/diff.h
index 7a347cf..eece65d 100644
--- a/diff.h
+++ b/diff.h
@@ -222,6 +222,7 @@ extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
+extern int do_diff_cache(const unsigned char *, struct diff_options *);
 extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
 #endif /* DIFF_H */
-- 
1.5.0.rc3.40.g1f7d
