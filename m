From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff-tree --cc: denser combined diff output for a merge commit.
Date: Tue, 24 Jan 2006 18:08:56 -0800
Message-ID: <7voe212h53.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 03:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1a60-00023H-ES
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 03:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWAYCJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 21:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAYCJA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 21:09:00 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5531 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750951AbWAYCI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 21:08:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125020640.CYXN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 21:06:40 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15115>

Building on the previous '-c' (combined) option, '--cc' option
squelches the output further by omitting hunks that consist of
difference with solely one parent.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I am not particularly happy about the option name, but I
   wanted to avoid --dense, because it would make it hard to use
   in the context of 'whatchanged' (rev-list wants that flag).

   Even without '-m' flag, the command outputs the commit log if
   the removal of not so interesting hunks results in an empty
   patch, along with 'diff --combined' header.  This might be
   considered a feature to remind the user that there were some
   file-level merges, just like diff-files shows empty diffs on
   cache-dirty paths.

 combine-diff.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 diff-tree.c    |   10 ++++++--
 diff.h         |    2 +-
 3 files changed, 73 insertions(+), 8 deletions(-)

ceba1d2a70929c0c89c4dcddb1e1b4dd38d8494c
diff --git a/combine-diff.c b/combine-diff.c
index 6690023..062ed8a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -278,7 +278,25 @@ static int interesting(struct sline *sli
 	return ((sline->flag & all_mask) != all_mask || sline->lost_head);
 }
 
-static void make_hunks(struct sline *sline, unsigned long cnt, int num_parent)
+static unsigned long line_diff_parents(struct sline *sline, unsigned long all_mask)
+{
+	/*
+	 * Look at the line and see from which parents we have difference.
+	 * Lower bits of sline->flag records if the parent had this line,
+	 * so XOR with all_mask gives us on-bits for parents we have
+	 * differences with.
+	 */
+	unsigned long parents = (sline->flag ^ all_mask);
+	if (sline->lost_head) {
+		struct lline *ll;
+		for (ll = sline->lost_head; ll; ll = ll->next)
+			parents |= ll->parent_map;
+	}
+	return parents & all_mask;
+}
+
+static void make_hunks(struct sline *sline, unsigned long cnt,
+		       int num_parent, int dense)
 {
 	unsigned long all_mask = (1UL<<num_parent) - 1;
 	unsigned long mark = (1UL<<num_parent);
@@ -302,6 +320,45 @@ static void make_hunks(struct sline *sli
 		}
 		i++;
 	}
+	if (!dense)
+		return;
+
+	/* Look at each hunk, and if it contains changes from only
+	 * one parent, mark that uninteresting.
+	 */
+	i = 0;
+	while (i < cnt) {
+		int j, hunk_end, diffs;
+		unsigned long parents;
+		while (i < cnt && !(sline[i].flag & mark))
+			i++;
+		if (cnt <= i)
+			break; /* No more interesting hunks */
+		for (hunk_end = i + 1; hunk_end < cnt; hunk_end++)
+			if (!(sline[hunk_end].flag & mark))
+				break;
+		/* [i..hunk_end) are interesting.  Now is it from
+		 * only one parent?
+		 * If lost lines are only from one parent and
+		 * remaining lines existed in parents other than
+		 * that parent, then the hunk is not that interesting.
+		 */
+		parents = 0;
+		diffs = 0;
+		for (j = i; j < hunk_end; j++)
+			parents |= line_diff_parents(sline + j, all_mask);
+		/* Now, how many bits from [0..num_parent) are on? */
+		for (j = 0; j < num_parent; j++) {
+			if (parents & (1UL<<j))
+				diffs++;
+		}
+		if (diffs < 2) {
+			/* This hunk is not that interesting after all */
+			for (j = i; j < hunk_end; j++)
+				sline[j].flag &= ~mark;
+		}
+		i = hunk_end;
+	}
 }
 
 static void dump_sline(struct sline *sline, int cnt, int num_parent)
@@ -351,7 +408,8 @@ static void dump_sline(struct sline *sli
 	}
 }
 
-static void show_combined_diff(struct path_list *elem, int num_parent)
+static void show_combined_diff(struct path_list *elem, int num_parent,
+			       int dense)
 {
 	unsigned long size, cnt, lno;
 	char *result, *cp, *ep;
@@ -390,7 +448,7 @@ static void show_combined_diff(struct pa
 	for (i = 0; i < num_parent; i++)
 		combine_diff(elem->parent_sha1[i], ourtmp, sline, cnt, i);
 
-	make_hunks(sline, cnt, num_parent);
+	make_hunks(sline, cnt, num_parent, dense);
 
 	dump_sline(sline, cnt, num_parent);
 	unlink(ourtmp);
@@ -410,7 +468,8 @@ static void show_combined_diff(struct pa
 }
 
 int diff_tree_combined_merge(const unsigned char *sha1,
-			     const char *header, int show_empty_merge)
+			     const char *header,
+			     int show_empty_merge, int dense)
 {
 	struct commit *commit = lookup_commit(sha1);
 	struct diff_options diffopts;
@@ -455,7 +514,7 @@ int diff_tree_combined_merge(const unsig
 			else
 				printf("%s", p->path);
 			putchar('\n');
-			show_combined_diff(p, num_parent);
+			show_combined_diff(p, num_parent, dense);
 		}
 	}
 
diff --git a/diff-tree.c b/diff-tree.c
index 0c68936..99c580c 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -8,6 +8,7 @@ static int verbose_header = 0;
 static int ignore_merges = 1;
 static int show_empty_combined = 0;
 static int combine_merges = 0;
+static int dense_combined_merges = 0;
 static int read_stdin = 0;
 
 static const char *header = NULL;
@@ -121,7 +122,8 @@ static int diff_tree_commit(const unsign
 			header = generate_header(sha1, sha1,
 						 commit->buffer);
 			return diff_tree_combined_merge(sha1, header,
-							show_empty_combined);
+							show_empty_combined,
+							dense_combined_merges);
 		}
 	}
 
@@ -168,7 +170,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-c] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
@@ -235,6 +237,10 @@ int main(int argc, const char **argv)
 			combine_merges = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--cc")) {
+			dense_combined_merges = combine_merges = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-v")) {
 			verbose_header = 1;
 			header_prefix = "diff-tree ";
diff --git a/diff.h b/diff.h
index 081234c..ab0d47b 100644
--- a/diff.h
+++ b/diff.h
@@ -56,7 +56,7 @@ extern int diff_tree(struct tree_desc *t
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 
-extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int);
+extern int diff_tree_combined_merge(const unsigned char *sha1, const char *, int, int);
 
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
-- 
1.1.4.g869a
