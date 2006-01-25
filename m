From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] diff-tree -c: show a merge commit a bit more sensibly.
Date: Tue, 24 Jan 2006 18:08:53 -0800
Message-ID: <7vu0bt2h56.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 03:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a5z-00023H-77
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWAYCI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWAYCI5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:08:57 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42220 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750883AbWAYCI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:08:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020744.DIHG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:07:44 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15114>

A new option '-c' to diff-tree changes the way a merge commit is
displayed when generating a patch output.  It shows a "combined
diff" (hence the option letter 'c'), which looks like this:

    $ git-diff-tree --pretty -c -p fec9ebf1 | head -n 18
    diff-tree fec9ebf... (from parents)
    Merge: 0620db3... 8a263ae...
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Sun Jan 15 22:25:35 2006 -0800

	Merge fixes up to GIT 1.1.3

    diff --combined describe.c
    @@@ +98,7 @@@
	    return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
       }

    -  static void describe(char *arg)
     - static void describe(struct commit *cmit, int last_one)
    ++ static void describe(char *arg, int last_one)
       {
     +      unsigned char sha1[20];
     +      struct commit *cmit;

There are a few things to note about this feature:

 - The '-c' option implies '-p'.  It also implies '-m' halfway
   in the sense that "interesting" merges are shown, but not all
   merges.

 - When a blob matches one of the parents, we do not show a diff
   for that path at all.  For a merge commit, this option shows
   paths with real file-level merge (aka "interesting things").

 - As a concequence of the above, an "uninteresting" merge is
   not shown at all.  You can use '-m' in addition to '-c' to
   show the commit log for such a merge, but there will be no
   combined diff output.

 - Unlike "gitk", the output is monochrome.

A '-' character in the nth column means the line is from the nth
parent and does not appear in the merge result (i.e. removed
from that parent's version).

A '+' character in the nth column means the line appears in the
merge result, and the nth parent does not have that line
(i.e. added by the merge itself or inherited from another
parent).

The above example output shows that the function signature was
changed from either parents (hence two "-" lines and a "++"
line), and "unsigned char sha1[20]", prefixed by a " +", was
inherited from the first parent.

The code as sent to the list was buggy in few corner cases,
which I have fixed since then.

It does not bother to keep track of and show the line numbers
from parent commits, which it probably should.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a replacement for the previous one, and is in the
   "pu" branch.

 Makefile       |    2 
 combine-diff.c |  469 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff-tree.c    |   36 ++++
 diff.h         |    2 
 4 files changed, 502 insertions(+), 7 deletions(-)
 create mode 100644 combine-diff.c

8085b27b67d0c4ccec206699f4292e6aed94f36b
diff --git a/Makefile b/Makefile
index 3046056..552b20f 100644
--- a/Makefile
+++ b/Makefile
@@ -182,7 +182,7 @@ LIB_H = \
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
-	diffcore-pickaxe.o diffcore-rename.o tree-diff.o
+	diffcore-pickaxe.o diffcore-rename.o tree-diff.o combine-diff.o
 
 LIB_OBJS = \
 	blob.o commit.o connect.o count-delta.o csum-file.o \
diff --git a/combine-diff.c b/combine-diff.c
new file mode 100644
index 0000000..6690023
--- /dev/null
+++ b/combine-diff.c
@@ -0,0 +1,469 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "quote.h"
+
+struct path_list {
+	struct path_list *next;
+	int len;
+	char *path;
+	unsigned char sha1[20];
+	unsigned char parent_sha1[FLEX_ARRAY][20];
+};
+
+static int uninteresting(struct diff_filepair *p)
+{
+	if (diff_unmodified_pair(p))
+		return 1;
+	if (!S_ISREG(p->one->mode) || !S_ISREG(p->two->mode))
+		return 1;
+	return 0;
+}
+
+static struct path_list *intersect_paths(struct path_list *curr,
+					 int n, int num_parent)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct path_list *p;
+	int i;
+
+	if (!n) {
+		struct path_list *list = NULL, *tail = NULL;
+		for (i = 0; i < q->nr; i++) {
+			int len;
+			const char *path;
+			if (uninteresting(q->queue[i]))
+				continue;
+			path = q->queue[i]->two->path;
+			len = strlen(path);
+
+			p = xmalloc(sizeof(*p) + len + 1 + num_parent * 20);
+			p->path = (char*) &(p->parent_sha1[num_parent][0]);
+			memcpy(p->path, path, len);
+			p->path[len] = 0;
+			p->len = len;
+			p->next = NULL;
+			memcpy(p->sha1, q->queue[i]->two->sha1, 20);
+			memcpy(p->parent_sha1[n], q->queue[i]->one->sha1, 20);
+			if (!tail)
+				list = tail = p;
+			else {
+				tail->next = p;
+				p = tail;
+			}
+		}
+		return list;
+	}
+
+	for (p = curr; p; p = p->next) {
+		int found = 0;
+		if (!p->len)
+			continue;
+		for (i = 0; i < q->nr; i++) {
+			const char *path;
+			int len;
+
+			if (uninteresting(q->queue[i]))
+				continue;
+			path = q->queue[i]->two->path;
+			len = strlen(path);
+			if (len == p->len && !memcmp(path, p->path, len)) {
+				found = 1;
+				memcpy(p->parent_sha1[n],
+				       q->queue[i]->one->sha1, 20);
+				break;
+			}
+		}
+		if (!found)
+			p->len = 0;
+	}
+	return curr;
+}
+
+struct lline {
+	struct lline *next;
+	int len;
+	unsigned long parent_map;
+	char line[FLEX_ARRAY];
+};
+
+struct sline {
+	struct lline *lost_head, **lost_tail;
+	char *bol;
+	int len;
+	unsigned long flag;
+};
+
+static char *grab_blob(const unsigned char *sha1, unsigned long *size)
+{
+	char *blob;
+	char type[20];
+	if (!memcmp(sha1, null_sha1, 20)) {
+		/* deleted blob */
+		*size = 0;
+		return xcalloc(1, 1);
+	}
+	blob = read_sha1_file(sha1, type, size);
+	if (strcmp(type, "blob"))
+		die("object '%s' is not a blob!", sha1_to_hex(sha1));
+	return blob;
+}
+
+#define TMPPATHLEN 50
+#define MAXLINELEN 10240
+
+static void write_to_temp_file(char *tmpfile, void *blob, unsigned long size)
+{
+	int fd = git_mkstemp(tmpfile, TMPPATHLEN, ".diff_XXXXXX");
+	if (fd < 0)
+		die("unable to create temp-file");
+	if (write(fd, blob, size) != size)
+		die("unable to write temp-file");
+	close(fd);
+}
+
+static void write_temp_blob(char *tmpfile, const unsigned char *sha1)
+{
+	unsigned long size;
+	void *blob;
+	blob = grab_blob(sha1, &size);
+	write_to_temp_file(tmpfile, blob, size);
+	free(blob);
+}
+
+static int parse_num(char **cp_p, unsigned int *num_p)
+{
+	char *cp = *cp_p;
+	unsigned int num = 0;
+	int read_some;
+
+	while ('0' <= *cp && *cp <= '9')
+		num = num * 10 + *cp++ - '0';
+	if (!(read_some = cp - *cp_p))
+		return -1;
+	*cp_p = cp;
+	*num_p = num;
+	return 0;
+}
+
+static int parse_hunk_header(char *line, int len,
+			     unsigned int *ob, unsigned int *on,
+			     unsigned int *nb, unsigned int *nn)
+{
+	char *cp;
+	cp = line + 4;
+	if (parse_num(&cp, ob)) {
+	bad_line:
+		return error("malformed diff output: %s", line);
+	}
+	if (*cp == ',') {
+		cp++;
+		if (parse_num(&cp, on))
+			goto bad_line;
+	}
+	else
+		*on = 1;
+	if (*cp++ != ' ' || *cp++ != '+')
+		goto bad_line;
+	if (parse_num(&cp, nb))
+		goto bad_line;
+	if (*cp == ',') {
+		cp++;
+		if (parse_num(&cp, nn))
+			goto bad_line;
+	}
+	else
+		*nn = 1;
+	return -!!memcmp(cp, " @@", 3);
+}
+
+static void append_lost(struct sline *sline, int n, const char *line)
+{
+	struct lline *lline;
+	int len = strlen(line);
+	unsigned long this_mask = (1UL<<n);
+	if (line[len-1] == '\n')
+		len--;
+
+	/* Check to see if we can squash things */
+	if (sline->lost_head) {
+		struct lline *last_one = NULL;
+		/* We cannot squash it with earlier one */
+		for (lline = sline->lost_head;
+		     lline;
+		     lline = lline->next)
+			if (lline->parent_map & this_mask)
+				last_one = lline;
+		lline = last_one ? last_one->next : sline->lost_head;
+		while (lline) {
+			if (lline->len == len &&
+			    !memcmp(lline->line, line, len)) {
+				lline->parent_map |= this_mask;
+				return;
+			}
+			lline = lline->next;
+		}
+	}
+
+	lline = xmalloc(sizeof(*lline) + len + 1);
+	lline->len = len;
+	lline->next = NULL;
+	lline->parent_map = this_mask;
+	memcpy(lline->line, line, len);
+	lline->line[len] = 0;
+	if (sline->lost_head)
+		*(sline->lost_tail) = lline;
+	else
+		sline->lost_head = lline;
+	sline->lost_tail = &lline->next;
+}
+
+static void combine_diff(const unsigned char *parent, const char *ourtmp,
+			 struct sline *sline, int cnt, int n)
+{
+	FILE *in;
+	char parent_tmp[TMPPATHLEN];
+	char cmd[TMPPATHLEN * 2 + 1024];
+	char line[MAXLINELEN];
+	unsigned int lno, ob, on, nb, nn;
+	unsigned long pmask = ~(1UL << n);
+	struct sline *lost_bucket = NULL;
+
+	write_temp_blob(parent_tmp, parent);
+	sprintf(cmd, "diff --unified=0 -La/x -Lb/x '%s' '%s'",
+		parent_tmp, ourtmp);
+	in = popen(cmd, "r");
+	if (!in)
+		return;
+
+	lno = 1;
+	while (fgets(line, sizeof(line), in) != NULL) {
+		int len = strlen(line);
+		if (5 < len && !memcmp("@@ -", line, 4)) {
+			if (parse_hunk_header(line, len,
+					      &ob, &on, &nb, &nn))
+				break;
+			lno = nb;
+			if (!nb) {
+				/* @@ -1,2 +0,0 @@ to remove the
+				 * first two lines...
+				 */
+				nb = 1;
+			}
+			lost_bucket = &sline[nb-1]; /* sline is 0 based */
+			continue;
+		}
+		if (!lost_bucket)
+			continue;
+		switch (line[0]) {
+		case '-':
+			append_lost(lost_bucket, n, line+1);
+			break;
+		case '+':
+			sline[lno-1].flag &= pmask;
+			lno++;
+			break;
+		}
+	}
+	fclose(in);
+	unlink(parent_tmp);
+}
+
+static unsigned long context = 3;
+static char combine_marker = '@';
+
+static int interesting(struct sline *sline, unsigned long all_mask)
+{
+	return ((sline->flag & all_mask) != all_mask || sline->lost_head);
+}
+
+static void make_hunks(struct sline *sline, unsigned long cnt, int num_parent)
+{
+	unsigned long all_mask = (1UL<<num_parent) - 1;
+	unsigned long mark = (1UL<<num_parent);
+	unsigned long i;
+
+	i = 0;
+	while (i < cnt) {
+		if (interesting(&sline[i], all_mask)) {
+			unsigned long j = (context < i) ? i - context : 0;
+			while (j <= i)
+				sline[j++].flag |= mark;
+			while (++i < cnt) {
+				if (!interesting(&sline[i], all_mask))
+					break;
+				sline[i].flag |= mark;
+			}
+			j = (i + context < cnt) ? i + context : cnt;
+			while (i < j)
+				sline[i++].flag |= mark;
+			continue;
+		}
+		i++;
+	}
+}
+
+static void dump_sline(struct sline *sline, int cnt, int num_parent)
+{
+	unsigned long mark = (1UL<<num_parent);
+	int i;
+	int lno = 0;
+
+	while (1) {
+		struct sline *sl = &sline[lno];
+		int hunk_end;
+		while (lno < cnt && !(sline[lno].flag & mark))
+			lno++;
+		if (cnt <= lno)
+			break;
+		for (hunk_end = lno + 1; hunk_end < cnt; hunk_end++)
+			if (!(sline[hunk_end].flag & mark))
+				break;
+		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
+		printf(" +%d,%d ", lno+1, hunk_end-lno);
+		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
+		putchar('\n');
+		while (lno < hunk_end) {
+			struct lline *ll;
+			int j;
+			sl = &sline[lno++];
+			ll = sl->lost_head;
+			while (ll) {
+				for (j = 0; j < num_parent; j++) {
+					if (ll->parent_map & (1UL<<j))
+						putchar('-');
+					else
+						putchar(' ');
+				}
+				putchar(' ');
+				puts(ll->line);
+				ll = ll->next;
+			}
+			for (j = 0; j < num_parent; j++) {
+				if ((1UL<<j) & sl->flag)
+					putchar(' ');
+				else
+					putchar('+');
+			}
+			printf(" %.*s\n", sl->len, sl->bol);
+		}
+	}
+}
+
+static void show_combined_diff(struct path_list *elem, int num_parent)
+{
+	unsigned long size, cnt, lno;
+	char *result, *cp, *ep;
+	struct sline *sline; /* survived lines */
+	int i;
+	char ourtmp[TMPPATHLEN];
+
+	/* Read the result of merge first */
+	result = grab_blob(elem->sha1, &size);
+	write_to_temp_file(ourtmp, result, size);
+
+	for (cnt = 0, cp = result; cp - result < size; cp++) {
+		if (*cp == '\n')
+			cnt++;
+	}
+	if (result[size-1] != '\n')
+		cnt++; /* incomplete line */
+
+	sline = xcalloc(cnt, sizeof(*sline));
+	ep = result;
+	sline[0].bol = result;
+	for (lno = 0, cp = result; cp - result < size; cp++) {
+		if (*cp == '\n') {
+			sline[lno].len = cp - sline[lno].bol;
+			sline[lno].flag = (1UL<<num_parent) - 1;
+			lno++;
+			if (lno < cnt)
+				sline[lno].bol = cp + 1;
+		}
+	}
+	if (result[size-1] != '\n') {
+		sline[cnt-1].len = size - (sline[cnt-1].bol - result);
+		sline[cnt-1].flag = (1UL<<num_parent) - 1;
+	}
+
+	for (i = 0; i < num_parent; i++)
+		combine_diff(elem->parent_sha1[i], ourtmp, sline, cnt, i);
+
+	make_hunks(sline, cnt, num_parent);
+
+	dump_sline(sline, cnt, num_parent);
+	unlink(ourtmp);
+	free(result);
+
+	for (i = 0; i < cnt; i++) {
+		if (sline[i].lost_head) {
+			struct lline *ll = sline[i].lost_head;
+			while (ll) {
+				struct lline *tmp = ll;
+				ll = ll->next;
+				free(tmp);
+			}
+		}
+	}
+	free(sline);
+}
+
+int diff_tree_combined_merge(const unsigned char *sha1,
+			     const char *header, int show_empty_merge)
+{
+	struct commit *commit = lookup_commit(sha1);
+	struct diff_options diffopts;
+	struct commit_list *parents;
+	struct path_list *p, *paths = NULL;
+	int num_parent, i, num_paths;
+
+	diff_setup(&diffopts);
+	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diffopts.recursive = 1;
+
+	/* count parents */
+	for (parents = commit->parents, num_parent = 0;
+	     parents;
+	     parents = parents->next, num_parent++)
+		; /* nothing */
+
+	/* find set of paths that everybody touches */
+	for (parents = commit->parents, i = 0;
+	     parents;
+	     parents = parents->next, i++) {
+		struct commit *parent = parents->item;
+		diff_tree_sha1(parent->object.sha1, commit->object.sha1, "",
+			       &diffopts);
+		paths = intersect_paths(paths, i, num_parent);
+		diff_flush(&diffopts);
+	}
+
+	/* find out surviving paths */
+	for (num_paths = 0, p = paths; p; p = p->next) {
+		if (p->len)
+			num_paths++;
+	}
+	if (num_paths || show_empty_merge) {
+		puts(header);
+		for (p = paths; p; p = p->next) {
+			if (!p->len)
+				continue;
+			printf("diff --combined ");
+			if (quote_c_style(p->path, NULL, NULL, 0))
+				quote_c_style(p->path, NULL, stdout, 0);
+			else
+				printf("%s", p->path);
+			putchar('\n');
+			show_combined_diff(p, num_parent);
+		}
+	}
+
+	/* Clean things up */
+	while (paths) {
+		struct path_list *tmp = paths;
+		paths = paths->next;
+		free(tmp);
+	}
+	return 0;
+}
diff --git a/diff-tree.c b/diff-tree.c
index efa2b94..0c68936 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -6,6 +6,8 @@ static int show_root_diff = 0;
 static int no_commit_id = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
+static int show_empty_combined = 0;
+static int combine_merges = 0;
 static int read_stdin = 0;
 
 static const char *header = NULL;
@@ -79,9 +81,13 @@ static const char *generate_header(const
 	offset = sprintf(this_header, "%s%s ",
 			 header_prefix,
 			 diff_unique_abbrev(commit_sha1, abbrev));
-	offset += sprintf(this_header + offset, "(from %s)\n",
-			 parent_sha1 ?
-			 diff_unique_abbrev(parent_sha1, abbrev) : "root");
+	if (commit_sha1 != parent_sha1)
+		offset += sprintf(this_header + offset, "(from %s)\n",
+				  parent_sha1
+				  ? diff_unique_abbrev(parent_sha1, abbrev)
+				  : "root");
+	else
+		offset += sprintf(this_header + offset, "(from parents)\n");
 	offset += pretty_print_commit(commit_format, msg, len,
 				      this_header + offset,
 				      sizeof(this_header) - offset);
@@ -108,8 +114,16 @@ static int diff_tree_commit(const unsign
 	}
 
 	/* More than one parent? */
-	if (ignore_merges && commit->parents && commit->parents->next)
-		return 0;
+	if (commit->parents && commit->parents->next) {
+		if (ignore_merges)
+			return 0;
+		else if (combine_merges) {
+			header = generate_header(sha1, sha1,
+						 commit->buffer);
+			return diff_tree_combined_merge(sha1, header,
+							show_empty_combined);
+		}
+	}
 
 	for (parents = commit->parents; parents; parents = parents->next) {
 		struct commit *parent = parents->item;
@@ -154,7 +168,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"git-diff-tree [--stdin] [-m] [-c] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
@@ -217,6 +231,10 @@ int main(int argc, const char **argv)
 			ignore_merges = 0;
 			continue;
 		}
+		if (!strcmp(arg, "-c")) {
+			combine_merges = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-v")) {
 			verbose_header = 1;
 			header_prefix = "diff-tree ";
@@ -245,6 +263,12 @@ int main(int argc, const char **argv)
 	if (diff_options.output_format == DIFF_FORMAT_PATCH)
 		diff_options.recursive = 1;
 
+	if (combine_merges) {
+		diff_options.output_format = DIFF_FORMAT_PATCH;
+		show_empty_combined = !ignore_merges;
+		ignore_merges = 0;
+	}
+
 	diff_tree_setup_paths(get_pathspec(prefix, argv));
 	diff_setup_done(&diff_options);
 
diff --git a/diff.h b/diff.h
index 5696f2a..081234c 100644
--- a/diff.h
+++ b/diff.h
@@ -56,6 +56,8 @@ extern int diff_tree(struct tree_desc *t
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 
+extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int);
+
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
-- 
1.1.4.g869a
