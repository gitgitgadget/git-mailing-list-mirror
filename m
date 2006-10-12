From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 01:52:52 -0700
Message-ID: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 12 10:53:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXwJQ-0003vx-2E
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 10:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWJLIw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 04:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422848AbWJLIw4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 04:52:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62888 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1422846AbWJLIwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 04:52:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012085253.DSFG6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 04:52:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZLsi1V0031kojtg0000000
	Thu, 12 Oct 2006 04:52:43 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28774>

Currently it does what git-blame does, but only faster.

More importantly, its internal structure is designed to support
content movement (aka cut-and-paste) more easily by allowing
more than one paths to be taken from the same commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

I really hate to do this immediately after writing obituary for
annotate, but I had a solid 24-hour to work on git, which is a
rare opportunity for me these days, so here it is.

For 160+ *.c files in git.git repository, running git-blame and
git-pickaxe with "-n -f" options for all of them takes the
following:

 *** blame ***
 141.43user 1.41system 2:22.94elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+438667minor)pagefaults 0swaps
 *** pickaxe ***
 78.99user 2.22system 1:21.22elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
 0inputs+0outputs (0major+397307minor)pagefaults 0swaps

I have given only cursory check to its output (some files are
blamed slightly differently from how git-blame does), but it
appears that there is no major breakage.  You can see for
example try annotating builtin-apply.c starting from v1.4.0;
there are two differences, which pickaxe assigns blame to older
commits and both of them seem to be sensible.  This exercise
also revealed some mistakes I made earlier (number of same
patches were cherry-picked in separate branches and then later
merged: "gitk master --not e4c9327a 15b4d577 -- pack-objects.c"
would show an example of such a breakage.

 Documentation/git-pickaxe.txt |  104 +++++
 Documentation/git.txt         |    3 +
 Makefile                      |    1 +
 builtin-pickaxe.c             |  952 +++++++++++++++++++++++++++++++++++++++++
 builtin.h                     |    1 +
 git.c                         |    1 +
 t/t8003-pickaxe.sh            |    9 +
 7 files changed, 1071 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-pickaxe.txt b/Documentation/git-pickaxe.txt
new file mode 100644
index 0000000..7f30cdf
--- /dev/null
+++ b/Documentation/git-pickaxe.txt
@@ -0,0 +1,104 @@
+git-pickaxe(1)
+==============
+
+NAME
+----
+git-pickaxe - Show what revision and author last modified each line of a file
+
+SYNOPSIS
+--------
+'git-pickaxe' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] <file> [<rev>]
+
+DESCRIPTION
+-----------
+
+Annotates each line in the given file with information from the revision which
+last modified the line. Optionally, start annotating from the given revision.
+
+Also it can limit the range of lines annotated.
+
+This report doesn't tell you anything about lines which have been deleted or
+replaced; you need to use a tool such as gitlink:git-diff[1] or the "pickaxe"
+interface briefly mentioned in the following paragraph.
+
+Apart from supporting file annotation, git also supports searching the
+development history for when a code snippet occured in a change. This makes it
+possible to track when a code snippet was added to a file, moved or copied
+between files, and eventually deleted or replaced. It works by searching for
+a text string in the diff. A small example:
+
+-----------------------------------------------------------------------------
+$ git log --pretty=oneline -S'blame_usage'
+5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
+ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
+-----------------------------------------------------------------------------
+
+OPTIONS
+-------
+-c, --compatibility::
+	Use the same output mode as gitlink:git-annotate[1] (Default: off).
+
+-L n,m::
+	Annotate only the specified line range (lines count from 1).
+
+-l, --long::
+	Show long rev (Default: off).
+
+-t, --time::
+	Show raw timestamp (Default: off).
+
+-S, --rev-file <revs-file>::
+	Use revs from revs-file instead of calling gitlink:git-rev-list[1].
+
+-f, --show-name::
+	Show filename in the original commit.  By default
+	filename is shown if there is any line that came from a
+	file with different name, due to rename detection.
+
+-n, --show-number::
+	Show line number in the original commit (Default: off).
+
+-p, --porcelain::
+	Show in a format designed for machine consumption.
+
+-h, --help::
+	Show help message.
+
+
+THE PORCELAIN FORMAT
+--------------------
+
+In this format, each line is output after a header; the
+header at the minumum has the first line which has:
+
+- 40-byte SHA-1 of the commit the line is attributed to;
+- the line number of the line in the original file;
+- the line number of the line in the final file;
+- on a line that starts a group of line from a different
+  commit than the previous one, the number of lines in this
+  group.  On subsequent lines this field is absent.
+
+This header line is followed by the following information
+at least once for each commit:
+
+- author name ("author"), email ("author-mail"), time
+  ("author-time"), and timezone ("author-tz"); similarly
+  for committer.
+- filename in the commit the line is attributed to.
+- the first line of the commit log message ("summary").
+
+The contents of the actual line is output after the above
+header, prefixed by a TAB. This is to allow adding more
+header elements later.
+
+SEE ALSO
+--------
+gitlink:git-blame[1]
+
+AUTHOR
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3af6fc6..7074e32 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -430,6 +430,9 @@ gitlink:git-annotate[1]::
 gitlink:git-blame[1]::
 	Blame file lines on commits.
 
+gitlink:git-pickaxe[1]::
+	Find out where each line in a file came from.
+
 gitlink:git-check-ref-format[1]::
 	Make sure ref name is well formed.
 
diff --git a/Makefile b/Makefile
index 2c7c338..bd99550 100644
--- a/Makefile
+++ b/Makefile
@@ -288,6 +288,7 @@ BUILTIN_OBJS = \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
+	builtin-pickaxe.o \
 	builtin-prune.o \
 	builtin-prune-packed.o \
 	builtin-push.o \
diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
new file mode 100644
index 0000000..0e26308
--- /dev/null
+++ b/builtin-pickaxe.c
@@ -0,0 +1,952 @@
+/*
+ * Pickaxe
+ *
+ * Copyright (c) 2006, Junio C Hamano
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "blob.h"
+#include "commit.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "xdiff-interface.h"
+
+#include <time.h>
+#include <sys/time.h>
+
+static char pickaxe_usage[] =
+"git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] file [commit]\n"
+"  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
+"  -l, --long          Show long commit SHA1 (Default: off)\n"
+"  -t, --time          Show raw timestamp (Default: off)\n"
+"  -f, --show-name     Show original filename (Default: auto)\n"
+"  -n, --show-number   Show original linenumber (Default: off)\n"
+"  -p, --porcelain     Show in a format designed for machine consumption\n"
+"  -L n,m              Process only line range n,m, counting from 1\n"
+"  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
+
+static int longest_file;
+static int longest_author;
+static int max_orig_digits;
+static int max_digits;
+
+#define DEBUG 0
+/*
+ * One blob in a commit
+ */
+struct origin {
+	struct commit *commit;
+	unsigned char blob_sha1[20];
+	char metainfo_given;
+	char path[FLEX_ARRAY];
+};
+
+struct blame_entry {
+	/* the first line of this group in the final image;
+	 * internally all line numbers are 0 based.
+	 */
+	int lno;
+
+	/* how many lines this group has */
+	int num_lines;
+
+	/* the commit that introduced this group into the final image */
+	struct origin *suspect;
+
+	/* true if the suspect is truly guilty; false while we have not
+	 * checked if the group came from one of its parents.
+	 */
+	char guilty;
+
+	/* the line number of the first line of this group in the
+	 * suspect's file; internally all line numbers are 0 based.
+	 */
+	int s_lno;
+};
+
+struct scoreboard {
+	/* the final commit (i.e. where we started digging from) */
+	struct commit *final;
+
+	const char *path;
+
+	/* the contents in the final; pointed into by buf pointers of
+	 * blame_entries
+	 */
+	const char *final_buf;
+	unsigned long final_buf_size;
+
+	/* list of blames */
+	struct blame_entry **entries;
+	int num_entries;
+};
+
+static int blame_entry_sort(const void *a_, const void *b_)
+{
+	int a = (*(struct blame_entry **)a_)->lno;
+	int b = (*(struct blame_entry **)b_)->lno;
+	return a - b;
+}
+
+static void coalesce(struct scoreboard *sb)
+{
+	int i, o, num;
+	struct blame_entry **ent;
+
+	qsort(sb->entries, sb->num_entries, sizeof(struct blame_entry *),
+	      blame_entry_sort);
+	ent = sb->entries;
+	num = sb->num_entries;
+
+	/*
+	 * Look at i, and see if it is adjacent to the last one at (o-1);
+	 * if so, extend the last one into a larger group and drop the
+	 * current one at i.  Copy the entry to remove gaps made by the
+	 * coalescing process as we go.
+	 */
+	for (o = 0, i = 0; i < num; i++) {
+		if (o &&
+		    ent[o-1]->suspect == ent[i]->suspect &&
+		    ent[o-1]->s_lno + ent[o-1]->num_lines == ent[i]->s_lno) {
+			ent[o-1]->num_lines += ent[i]->num_lines;
+			free(ent[i]);
+			continue;
+		}
+		if (o != i)
+			ent[o] = ent[i];
+		o++;
+	}
+	sb->num_entries = o;
+}
+
+static void free_origin(struct origin *o)
+{
+	free(o);
+}
+
+static struct origin *find_origin(struct scoreboard *sb,
+				  struct commit *commit,
+				  const char *path)
+{
+	int i, num;
+	struct blame_entry **ent;
+	struct origin *o;
+	unsigned mode;
+	char type[10];
+
+	ent = sb->entries;
+	num = sb->num_entries;
+	for (i = 0; i < num; i++) {
+		if (ent[i]->suspect->commit == commit &&
+		    !strcmp(ent[i]->suspect->path, path))
+			return ent[i]->suspect;
+	}
+
+	o = xcalloc(1, sizeof(*o) + strlen(path) + 1);
+	o->commit = commit;
+	strcpy(o->path, path);
+	if (get_tree_entry(commit->object.sha1, path, o->blob_sha1, &mode))
+		goto err_out;
+	if (sha1_object_info(o->blob_sha1, type, NULL) ||
+	    strcmp(type, blob_type))
+		goto err_out;
+	return o;
+ err_out:
+	free_origin(o);
+	return NULL;
+}
+
+static struct origin *find_rename(struct scoreboard *sb,
+				  struct commit *parent,
+				  struct origin *origin)
+{
+	struct origin *porigin = NULL;
+	struct diff_options diff_opts;
+	int i;
+	const char *paths[1];
+
+	diff_setup(&diff_opts);
+	diff_opts.recursive = 1;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup");
+	diff_tree_sha1(origin->commit->tree->object.sha1,
+		       parent->tree->object.sha1,
+		       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		if (p->status == 'R' && !strcmp(p->one->path, origin->path)) {
+			porigin = find_origin(sb, parent, p->two->path);
+			break;
+		}
+	}
+	diff_flush(&diff_opts);
+	return porigin;
+}
+
+struct chunk {
+	/* line number in postimage; up to but not including this
+	 * line is the same as preimage
+	 */
+	int same;
+
+	/* preimage line number after this chunk */
+	int p_next;
+
+	/* postimage line number after this chunk */
+	int t_next;
+};
+
+struct patch {
+	struct chunk *chunks;
+	int num;
+};
+
+struct blame_diff_state {
+	struct xdiff_emit_state xm;
+	struct patch *ret;
+};
+
+static void process_u0_diff(void *state_, char *line, unsigned long len)
+{
+	struct blame_diff_state *state = state_;
+	struct chunk *chunk;
+	int off1, off2, len1, len2;
+
+if(DEBUG) fprintf(stderr, "%.*s", (int) len, line);
+
+	if (len < 4 || line[0] != '@' || line[1] != '@')
+		return;
+
+	state->ret->num++;
+	state->ret->chunks = xrealloc(state->ret->chunks,
+				      sizeof(struct chunk) * state->ret->num);
+	chunk = &state->ret->chunks[state->ret->num - 1];
+
+	if (parse_hunk_header(line, len,
+			      &off1, &len1,
+			      &off2, &len2)) {
+		state->ret->num--;
+		return;
+	}
+
+	/* Line numbers in patch output are one based. */
+	off1--;
+	off2--;
+
+	chunk->same = len2 ? off2 : (off2 + 1);
+
+	chunk->p_next = off1 + (len1 ? len1 : 1);
+	chunk->t_next = chunk->same + len2;
+}
+
+static struct patch *get_patch(struct origin *parent,
+			       struct origin *origin)
+{
+	struct blame_diff_state state;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	mmfile_t file_p, file_o;
+	xdemitcb_t ecb;
+	char type[10];
+
+if(DEBUG) fprintf(stderr, "get patch %.8s %.8s\n",
+		sha1_to_hex(parent->commit->object.sha1),
+		sha1_to_hex(origin->commit->object.sha1));
+
+	file_p.ptr = read_sha1_file(parent->blob_sha1, type,
+				    (unsigned long *) &file_p.size);
+	file_o.ptr = read_sha1_file(origin->blob_sha1, type,
+				    (unsigned long *) &file_o.size);
+	if (!file_p.ptr || !file_o.ptr)
+		return NULL;
+
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = 0;
+	xecfg.flags = 0;
+	ecb.outf = xdiff_outf;
+	ecb.priv = &state;
+	memset(&state, 0, sizeof(state));
+	state.xm.consume = process_u0_diff;
+	state.ret = xmalloc(sizeof(struct patch));
+	state.ret->chunks = NULL;
+	state.ret->num = 0;
+
+	xdl_diff(&file_p, &file_o, &xpp, &xecfg, &ecb);
+	return state.ret;
+}
+
+static void free_patch(struct patch *p)
+{
+	free(p->chunks);
+	free(p);
+}
+
+static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
+{
+	sb->entries = xrealloc(sb->entries,
+			       sizeof(struct blame_entry *) *
+			       (sb->num_entries + 1));
+	sb->entries[sb->num_entries++] = e;
+}
+
+static void blame_overlap(struct scoreboard *sb, struct blame_entry *e,
+			  int tlno, int plno, int same,
+			  struct origin *parent)
+{
+	/* it is known that lines between tlno to same
+	 * came from parent, and e has an overlap with that range.
+	 * it also is known that parent's line plno corresponds to
+	 * e's line tlno.
+	 *
+	 *                <---- e ----->
+	 *                   <------>
+	 *                   <------------>
+	 *             <------------>
+	 *             <------------------>
+	 *
+	 * Potentially we need to split e into three parts; before
+	 * this chunk, the chunk to be blamed for parent, and after
+	 * that portion.
+	 *
+	 * When the function splits the blame_entry, it pushes the part
+	 * that needs to be re-processed at the end of the queue.
+	 */
+	int chunk_end_lno;
+	struct blame_entry split[3], *new_entry;
+	memset(split, 0, sizeof(split));
+
+	split[1].suspect = parent;
+	if (e->s_lno < tlno) {
+		/* there is a pre-chunk part not blamed on parent */
+		split[0].suspect = e->suspect;
+		split[0].lno = e->lno;
+		split[0].s_lno = e->s_lno;
+		split[0].num_lines = tlno - e->s_lno;
+		split[1].lno = e->lno + tlno - e->s_lno;
+		split[1].s_lno = plno;
+	}
+	else {
+		split[1].lno = e->lno;
+		split[1].s_lno = plno + (e->s_lno - tlno);
+	}
+
+	if (same < e->s_lno + e->num_lines) {
+		/* there is a post-chunk part not blamed on parent */
+		split[2].suspect = e->suspect;
+		split[2].lno = e->lno + (same - e->s_lno);
+		split[2].s_lno = e->s_lno + (same - e->s_lno);
+		split[2].num_lines = e->s_lno + e->num_lines - same;
+		chunk_end_lno = split[2].lno;
+	}
+	else
+		chunk_end_lno = e->lno + e->num_lines;
+	split[1].num_lines = chunk_end_lno - split[1].lno;
+
+	if (split[0].suspect && split[2].suspect) {
+		/* we need to split e into two and add another for parent */
+		memcpy(e, &(split[0]), sizeof(struct blame_entry));
+
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+	}
+	else if (!split[0].suspect && !split[2].suspect)
+		/* parent covers the entire area */
+		memcpy(e, &(split[1]), sizeof(struct blame_entry));
+	else if (split[0].suspect) {
+		memcpy(e, &(split[0]), sizeof(struct blame_entry));
+
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+	}
+	else {
+		new_entry = xmalloc(sizeof(*new_entry));
+		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
+		add_blame_entry(sb, new_entry);
+
+		memcpy(e, &(split[2]), sizeof(struct blame_entry));
+	}
+}
+
+static void blame_chunk(struct scoreboard *sb,
+			int tlno, int plno, int same,
+			struct origin *target, struct origin *parent)
+{
+	int i;
+	for (i = 0; i < sb->num_entries; i++) {
+		struct blame_entry *e = sb->entries[i];
+		if (e->guilty || e->suspect != target)
+			continue;
+		if (same <= e->s_lno)
+			continue;
+		if (tlno < e->s_lno + e->num_lines)
+			blame_overlap(sb, e, tlno, plno, same, parent);
+	}
+}
+
+static int pass_blame_to_parent(struct scoreboard *sb,
+				struct origin *target,
+				struct origin *parent)
+{
+	int i;
+	struct patch *patch;
+	int plno, tlno, last_in_target = -1;
+
+	for (i = 0; i < sb->num_entries; i++) {
+		struct blame_entry *e = sb->entries[i];
+		if (e->guilty || e->suspect != target)
+			continue;
+		if (last_in_target < e->s_lno + e->num_lines)
+			last_in_target = e->s_lno + e->num_lines;
+	}
+	patch = get_patch(parent, target);
+	plno = tlno = 0;
+	for (i = 0; i < patch->num; i++) {
+		struct chunk *chunk = &patch->chunks[i];
+
+if(DEBUG)	fprintf(stderr,
+			"plno = %d, tlno = %d, "
+			"same as parent up to %d, resync %d and %d\n",
+			plno, tlno,
+			chunk->same, chunk->p_next, chunk->t_next);
+		blame_chunk(sb, tlno, plno, chunk->same, target, parent);
+		plno = chunk->p_next;
+		tlno = chunk->t_next;
+	}
+	/* rest (i.e. anything above tlno) are the same as parent */
+	blame_chunk(sb, tlno, plno, last_in_target, target, parent);
+
+	free_patch(patch);
+	return 0;
+}
+
+#define MAXPARENT 16
+static void pass_blame(struct scoreboard *sb, struct origin *origin)
+{
+	int i, parent_ix;
+	struct commit *commit = origin->commit;
+	struct commit_list *parent;
+	struct origin *parent_origin[MAXPARENT], *porigin;
+
+	if (parse_commit(commit))
+		exit(1);
+
+	memset(parent_origin, 0, sizeof(parent_origin));
+	for (parent_ix = 0, parent = commit->parents;
+	     parent_ix < MAXPARENT && parent;
+	     parent = parent->next, parent_ix++) {
+		if (parse_commit(parent->item))
+			continue;
+		porigin = find_origin(sb, parent->item, origin->path);
+		if (!porigin)
+			porigin = find_rename(sb, parent->item, origin);
+		if (!porigin)
+			continue;
+		if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
+			for (i = 0; i < sb->num_entries; i++) {
+				if (sb->entries[i]->suspect == origin)
+					sb->entries[i]->suspect = porigin;
+			}
+			/* now everything blamed for origin is blamed for
+			 * porigin, we do not need to keep it anymore.
+			 * Do not free porigin (or the ones we got from
+			 * earlier round); they may still be used elsewhere.
+			 */
+			free_origin(origin);
+			return;
+		}
+		parent_origin[parent_ix] = porigin;
+	}
+
+	for (parent_ix = 0, parent = commit->parents;
+	     parent_ix < MAXPARENT && parent;
+	     parent = parent->next, parent_ix++) {
+		struct origin *porigin = parent_origin[parent_ix];
+		if (!porigin)
+			continue;
+		if (pass_blame_to_parent(sb, origin, porigin))
+			break;
+	}
+
+	/* NEEDSWORK:
+	 * Optionally run "ciff" to find copies from parents' files here
+	 */
+
+	/* Take responsibility for the remaining entries */
+	for (i = 0; i < sb->num_entries; i++)
+		if (!sb->entries[i]->guilty &&
+		    sb->entries[i]->suspect == origin)
+			sb->entries[i]->guilty = 1;
+}
+
+static void assign_blame(struct scoreboard *sb)
+{
+	while (1) {
+		int i;
+		struct origin *suspect = NULL;
+
+		/* find one suspect to break down */
+		for (i = 0; !suspect && i < sb->num_entries; i++) {
+			if (!sb->entries[i]->guilty)
+				suspect = sb->entries[i]->suspect;
+		}
+		if (!suspect)
+			return; /* all done */
+
+		pass_blame(sb, suspect);
+	}
+}
+
+static const char *format_time(unsigned long time, const char *tz_str,
+			       int show_raw_time)
+{
+	static char time_buf[128];
+	time_t t = time;
+	int minutes, tz;
+	struct tm *tm;
+
+	if (show_raw_time) {
+		sprintf(time_buf, "%lu %s", time, tz_str);
+		return time_buf;
+	}
+
+	tz = atoi(tz_str);
+	minutes = tz < 0 ? -tz : tz;
+	minutes = (minutes / 100)*60 + (minutes % 100);
+	minutes = tz < 0 ? -minutes : minutes;
+	t = time + minutes * 60;
+	tm = gmtime(&t);
+
+	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", tm);
+	strcat(time_buf, tz_str);
+	return time_buf;
+}
+
+struct commit_info
+{
+	char *author;
+	char *author_mail;
+	unsigned long author_time;
+	char *author_tz;
+
+	/* filled only when asked for details */
+	char *committer;
+	char *committer_mail;
+	unsigned long committer_time;
+	char *committer_tz;
+
+	char *summary;
+};
+
+static void get_ac_line(const char *inbuf, const char *what,
+			int bufsz, char *person, char **mail,
+			unsigned long *time, char **tz)
+{
+	int len;
+	char *tmp, *endp;
+
+	tmp = strstr(inbuf, what);
+	if (!tmp)
+		goto error_out;
+	tmp += strlen(what);
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		len = strlen(tmp);
+	else
+		len = endp - tmp;
+	if (bufsz <= len) {
+	error_out:
+		/* Ugh */
+		person = *mail = *tz = "(unknown)";
+		*time = 0;
+		return;
+	}
+	memcpy(person, tmp, len);
+
+	tmp = person;
+	tmp += len;
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	*tz = tmp+1;
+
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	*time = strtoul(tmp, NULL, 10);
+
+	*tmp = 0;
+	while (*tmp != ' ')
+		tmp--;
+	*mail = tmp + 1;
+	*tmp = 0;
+}
+
+static void get_commit_info(struct commit *commit,
+			    struct commit_info *ret,
+			    int detailed)
+{
+	int len;
+	char *tmp, *endp;
+	static char author_buf[1024];
+	static char committer_buf[1024];
+	static char summary_buf[1024];
+
+	ret->author = author_buf;
+	get_ac_line(commit->buffer, "\nauthor ",
+		    sizeof(author_buf), author_buf, &ret->author_mail,
+		    &ret->author_time, &ret->author_tz);
+
+	if (!detailed)
+		return;
+
+	ret->committer = committer_buf;
+	get_ac_line(commit->buffer, "\ncommitter ",
+		    sizeof(committer_buf), committer_buf, &ret->committer_mail,
+		    &ret->committer_time, &ret->committer_tz);
+
+	ret->summary = summary_buf;
+	tmp = strstr(commit->buffer, "\n\n");
+	if (!tmp) {
+	error_out:
+		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
+		return;
+	}
+	tmp += 2;
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		goto error_out;
+	len = endp - tmp;
+	if (len >= sizeof(summary_buf))
+		goto error_out;
+	memcpy(summary_buf, tmp, len);
+	summary_buf[len] = 0;
+}
+
+static const char *nth_line(const char *buf, unsigned long len, int lno)
+{
+	while (lno) {
+		if (*buf == '\n')
+			lno--;
+		buf++;
+		if (!--len)
+			die("internal error: buffer ran out");
+	}
+	return buf;
+}
+
+#define OUTPUT_ANNOTATE_COMPAT	001
+#define OUTPUT_LONG_OBJECT_NAME	002
+#define OUTPUT_RAW_TIMESTAMP	004
+#define OUTPUT_PORCELAIN	010
+#define OUTPUT_SHOW_NAME	020
+#define OUTPUT_SHOW_NUMBER	040
+
+static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	char hex[41];
+
+	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+	printf("%s%c%d %d %d\n",
+	       hex,
+	       ent->guilty ? ' ' : '*', // purely for debugging
+	       ent->s_lno + 1,
+	       ent->lno + 1,
+	       ent->num_lines);
+	if (!ent->suspect->metainfo_given) {
+		struct commit_info ci;
+		suspect->metainfo_given = 1;
+		get_commit_info(suspect->commit, &ci, 1);
+		printf("author %s\n", ci.author);
+		printf("author-mail %s\n", ci.author_mail);
+		printf("author-time %lu\n", ci.author_time);
+		printf("author-tz %s\n", ci.author_tz);
+		printf("committer %s\n", ci.committer);
+		printf("committer-mail %s\n", ci.committer_mail);
+		printf("committer-time %lu\n", ci.committer_time);
+		printf("committer-tz %s\n", ci.committer_tz);
+		printf("filename %s\n", suspect->path);
+		printf("summary %s\n", ci.summary);
+	}
+	cp = nth_line(sb->final_buf, sb->final_buf_size, ent->lno);
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		char ch;
+		if (cnt)
+			printf("%s %d %d\n", hex,
+			       ent->s_lno + 1 + cnt,
+			       ent->lno + 1 + cnt);
+		putchar('\t');
+		do {
+			ch = *cp++;
+			putchar(ch);
+		} while (ch != '\n' &&
+			 cp < sb->final_buf + sb->final_buf_size);
+	}
+}
+
+static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	struct commit_info ci;
+	char hex[41];
+	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+
+	get_commit_info(suspect->commit, &ci, 1);
+	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+
+	cp = nth_line(sb->final_buf, sb->final_buf_size, ent->lno);
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		char ch;
+
+		printf("%.*s", (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8, hex);
+		if (opt & OUTPUT_ANNOTATE_COMPAT)
+			printf("\t(%10s\t%10s\t%d)", ci.author,
+			       format_time(ci.author_time, ci.author_tz,
+					   show_raw_time),
+			       ent->lno + 1 + cnt);
+		else {
+			if (opt & OUTPUT_SHOW_NAME)
+				printf(" %-*.*s", longest_file, longest_file,
+				       suspect->path);
+			if (opt & OUTPUT_SHOW_NUMBER)
+				printf(" %*d", max_orig_digits,
+				       ent->s_lno + 1 + cnt);
+			printf(" (%-*.*s %10s %*d) ",
+			       longest_author, longest_author, ci.author,
+			       format_time(ci.author_time, ci.author_tz,
+					   show_raw_time),
+			       max_digits, ent->lno + 1 + cnt);
+		}
+		do {
+			ch = *cp++;
+			putchar(ch);
+		} while (ch != '\n' &&
+			 cp < sb->final_buf + sb->final_buf_size);
+	}
+}
+
+static void output(struct scoreboard *sb, int option)
+{
+	int i, num;
+	struct blame_entry **ent;
+	ent = sb->entries;
+	num = sb->num_entries;
+	for (i = 0; i < num; i++) {
+		if (option & OUTPUT_PORCELAIN)
+			emit_porcelain(sb, ent[i]);
+		else
+			emit_other(sb, ent[i], option);
+	}
+}
+
+static int count_lines(const char *buf, unsigned long len)
+{
+	int num = 0;
+	if (len && buf[len-1] != '\n')
+		num++; /* incomplete line at the end */
+	while (len--) {
+		if (*buf++ == '\n')
+			num++;
+	}
+	return num;
+}
+
+static int read_ancestry(const char *graft_file)
+{
+	FILE *fp = fopen(graft_file, "r");
+	char buf[1024];
+	if (!fp)
+		return -1;
+	while (fgets(buf, sizeof(buf), fp)) {
+		/* The format is just "Commit Parent1 Parent2 ...\n" */
+		int len = strlen(buf);
+		struct commit_graft *graft = read_graft_line(buf, len);
+		register_commit_graft(graft, 0);
+	}
+	fclose(fp);
+	return 0;
+}
+
+static int lineno_width(int lines)
+{
+        int i, width;
+
+        for (width = 1, i = 10; i <= lines + 1; width++)
+                i *= 10;
+        return width;
+}
+
+static void find_alignment(struct scoreboard *sb, int *option)
+{
+	int i;
+	int longest_src_lines = 0;
+	int longest_dst_lines = 0;
+
+	for (i = 0; i < sb->num_entries; i++) {
+		struct blame_entry *e = sb->entries[i];
+		struct origin *suspect = e->suspect;
+		struct commit_info ci;
+		int num;
+
+		if (!suspect->metainfo_given) {
+			suspect->metainfo_given = 1;
+			get_commit_info(suspect->commit, &ci, 1);
+			if (strcmp(suspect->path, sb->path))
+				*option |= OUTPUT_SHOW_NAME;
+			num = strlen(suspect->path);
+			if (longest_file < num)
+				longest_file = num;
+			num = strlen(ci.author);
+			if (longest_author < num)
+				longest_author = num;
+		}
+		num = e->s_lno + e->num_lines;
+		if (longest_src_lines < num)
+			longest_src_lines = num;
+		num = e->lno + e->num_lines;
+		if (longest_dst_lines < num)
+			longest_dst_lines = num;
+	}
+	max_orig_digits = lineno_width(longest_src_lines);
+	max_digits = lineno_width(longest_dst_lines);
+}
+
+int cmd_pickaxe(int argc, const char **argv, const char *prefix)
+{
+	const char *path = argv[1];
+	unsigned char sha1[20];
+	struct scoreboard sb;
+	struct origin *o;
+	struct blame_entry *ent;
+	int i, seen_dashdash;
+	long bottom, top, lno;
+	int output_option = 0;
+	const char *revs_file = NULL;
+	const char *final_commit_name = "HEAD";
+	char type[10];
+
+	bottom = top = 0;
+	seen_dashdash = 0;
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (*arg != '-')
+			break;
+		else if (!strcmp("-c", arg))
+			output_option |= OUTPUT_ANNOTATE_COMPAT;
+		else if (!strcmp("-t", arg))
+			output_option |= OUTPUT_RAW_TIMESTAMP;
+		else if (!strcmp("-l", arg))
+			output_option |= OUTPUT_LONG_OBJECT_NAME;
+		else if (!strcmp("-S", arg) && ++i < argc)
+			revs_file = argv[i];
+		else if (!strcmp("-L", arg) && ++i < argc) {
+			char *term;
+			arg = argv[i];
+			if (bottom || top)
+				die("More than one '-L n,m' option given");
+			bottom = strtol(arg, &term, 10);
+			if (*term == ',') {
+				top = strtol(term + 1, &term, 10);
+				if (*term)
+					usage(pickaxe_usage);
+			}
+			if (bottom && top && top < bottom) {
+				unsigned long tmp;
+				tmp = top; top = bottom; bottom = tmp;
+			}
+		}
+		else if (!strcmp("-f", arg) ||
+			 !strcmp("--show-name", arg))
+			output_option |= OUTPUT_SHOW_NAME;
+		else if (!strcmp("-n", arg) ||
+			 !strcmp("--show-number", arg))
+			output_option |= OUTPUT_SHOW_NUMBER;
+		else if (!strcmp("--porcelain", arg))
+			output_option |= OUTPUT_PORCELAIN;
+		else if (!strcmp("--", arg)) {
+			seen_dashdash = 1;
+			i++;
+			break;
+		}
+		else
+			usage(pickaxe_usage);
+	}
+
+	/* argv[i] is filename, argv[i+1] if exists is the commit */
+	if (i >= argc)
+		usage(pickaxe_usage);
+	path = argv[i++];
+	if (!seen_dashdash) {
+		struct stat st;
+		if (lstat(path, &st))
+			die("cannot stat path %s: %s", path, strerror(errno));
+	}
+
+	if (i == argc - 1)
+		final_commit_name = argv[i];
+	else if (i != argc)
+		usage(pickaxe_usage);
+
+	memset(&sb, 0, sizeof(sb));
+	if (get_sha1(final_commit_name, sha1) ||
+	    !(sb.final = lookup_commit_reference(sha1)))
+		die("no such commit %s", final_commit_name);
+	o = find_origin(&sb, sb.final, path);
+	if (!o)
+		die("no such path %s in %s", path, final_commit_name);
+
+	sb.final_buf = read_sha1_file(o->blob_sha1, type, &sb.final_buf_size);
+	lno = count_lines(sb.final_buf, sb.final_buf_size);
+
+	if (bottom < 1)
+		bottom = 1;
+	if (top < 1)
+		top = lno;
+	bottom--;
+	if (lno < top)
+		die("file %s has only %lu lines", path, lno);
+
+	ent = xcalloc(1, sizeof(*ent));
+	ent->lno = bottom;
+	ent->num_lines = top - bottom;
+	ent->suspect = o;
+	ent->s_lno = bottom;
+
+	sb.entries = xcalloc(10, sizeof(struct blame_entry *));
+	sb.entries[0] = ent;
+	sb.num_entries = 1;
+	sb.path = path;
+
+	if (revs_file && read_ancestry(revs_file))
+		die("reading graft file %s failed: %s",
+		    revs_file, strerror(errno));
+
+	assign_blame(&sb);
+
+	coalesce(&sb);
+
+	if (!(output_option & OUTPUT_PORCELAIN))
+		find_alignment(&sb, &output_option);
+
+	output(&sb, output_option);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index f9fa9ff..7451ce6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -39,6 +39,7 @@ extern int cmd_mailsplit(int argc, const
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index e089b53..6164380 100644
--- a/git.c
+++ b/git.c
@@ -245,6 +245,7 @@ static void handle_internal_command(int 
 		{ "mv", cmd_mv, RUN_SETUP },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "pickaxe", cmd_pickaxe, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
diff --git a/t/t8003-pickaxe.sh b/t/t8003-pickaxe.sh
new file mode 100755
index 0000000..d09d1c9
--- /dev/null
+++ b/t/t8003-pickaxe.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+test_description='git-pickaxe'
+. ./test-lib.sh
+
+PROG='git pickaxe -c'
+. ../annotate-tests.sh
+
+test_done
-- 
1.4.3.rc2.gdce3
