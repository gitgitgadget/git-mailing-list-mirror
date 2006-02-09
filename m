From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: move formatting logic to show_combined_diff()
Date: Thu, 09 Feb 2006 15:49:16 -0800
Message-ID: <7vbqxg6qkj.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:49:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LXN-0000sp-33
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWBIXtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWBIXtS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:49:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24509 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750838AbWBIXtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 18:49:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209234610.LHTN17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 18:46:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Feb 2006 12:27:58 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15842>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 9 Feb 2006, Junio C Hamano wrote:
>>
>> I was wondering if we could teach not diff_tree_combined_merge
>> but show_combined_diff to do this, so that diff-files -c would
>> benefit from the raw output as wel.
>
> I wanted to do it that way, but it seemed less intrusive this way.
>
> I agree that it is the correct thing to do, though.

This comes on top of the earlier "use diffcore_std()" patch.

-- >8 --
This way, diff-files can make use of it.  Also implement the
full suite of what diff_flush_raw() supports just for
consistency.  With this, 'diff-tree -c -r --name-status' would
show what is expected.

There is no way to get the historical output (useful for
debugging and low-level Plumbing work) anymore, so tentatively
it makes '-m' to mean "do not combine and show individual diffs
with parents".

diff-files matches diff-tree to produce raw output for -c.  For
textual combined diff, use -p -c.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 combine-diff.c |   85 ++++++++++++++++++++++++++++++++++++++------------------
 diff-files.c   |    6 ++--
 diff-tree.c    |    2 +
 diff.h         |    3 +-
 4 files changed, 64 insertions(+), 32 deletions(-)

0a798076b8d1a4a31bf2b24c564e2a99fd1c43a1
diff --git a/combine-diff.c b/combine-diff.c
index 6d78305..9aa099b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -618,8 +618,8 @@ static void reuse_combine_diff(struct sl
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
-int show_combined_diff(struct combine_diff_path *elem, int num_parent,
-		       int dense, const char *header)
+static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
+			   int dense, const char *header)
 {
 	unsigned long size, cnt, lno;
 	char *result, *cp, *ep;
@@ -791,32 +791,69 @@ static void show_raw_diff(struct combine
 
 	if (header)
 		puts(header);
-	offset = strlen(COLONS) - num_parent;
-	if (offset < 0)
-		offset = 0;
-	prefix = COLONS + offset;
 
-	/* Show the modes */
 	for (i = 0; i < num_parent; i++) {
-		int mode = p->parent[i].mode;
-		if (mode)
+		if (p->parent[i].mode)
 			mod_type = 'M';
-		printf("%s%06o", prefix, mode);
-		prefix = " ";
 	}
-	printf("%s%06o", prefix, p->mode);
 	if (!p->mode)
 		mod_type = 'D';
 
-	/* Show sha1's */
-	for (i = 0; i < num_parent; i++) {
-		printf("%s%s", prefix, diff_unique_abbrev(p->parent[i].sha1, opt->abbrev));
-		prefix = " ";
+	if (opt->output_format == DIFF_FORMAT_RAW) {
+		offset = strlen(COLONS) - num_parent;
+		if (offset < 0)
+			offset = 0;
+		prefix = COLONS + offset;
+
+		/* Show the modes */
+		for (i = 0; i < num_parent; i++) {
+			printf("%s%06o", prefix, p->parent[i].mode);
+			prefix = " ";
+		}
+		printf("%s%06o", prefix, p->mode);
+
+		/* Show sha1's */
+		for (i = 0; i < num_parent; i++)
+			printf(" %s", diff_unique_abbrev(p->parent[i].sha1,
+							 opt->abbrev));
+		printf(" %s ", diff_unique_abbrev(p->sha1, opt->abbrev));
+	}
+
+	if (opt->output_format == DIFF_FORMAT_RAW ||
+	    opt->output_format == DIFF_FORMAT_NAME_STATUS)
+		printf("%c%c", mod_type, inter_name_termination);
+
+	if (line_termination) {
+		if (quote_c_style(p->path, NULL, NULL, 0))
+			quote_c_style(p->path, NULL, stdout, 0);
+		else
+			printf("%s", p->path);
+		putchar(line_termination);
 	}
-	printf("%s%s", prefix, diff_unique_abbrev(p->sha1, opt->abbrev));
+	else {
+		printf("%s%c", p->path, line_termination);
+	}
+}
 
-	/* Modification type, terminations, filename */
-	printf(" %c%c%s%c", mod_type, inter_name_termination, p->path, line_termination);
+int show_combined_diff(struct combine_diff_path *p,
+		       int num_parent,
+		       int dense,
+		       const char *header,
+		       struct diff_options *opt)
+{
+	if (!p->len)
+		return 0;
+	switch (opt->output_format) {
+	case DIFF_FORMAT_RAW:
+	case DIFF_FORMAT_NAME_STATUS:
+	case DIFF_FORMAT_NAME:
+		show_raw_diff(p, num_parent, header, opt);
+		return 1;
+
+	default:
+	case DIFF_FORMAT_PATCH:
+		return show_patch_diff(p, num_parent, dense, header);
+	}
 }
 
 const char *diff_tree_combined_merge(const unsigned char *sha1,
@@ -858,14 +895,8 @@ const char *diff_tree_combined_merge(con
 	}
 	if (num_paths) {
 		for (p = paths; p; p = p->next) {
-			if (!p->len)
-				continue;
-			if (opt->output_format == DIFF_FORMAT_RAW) {
-				show_raw_diff(p, num_parent, header, opt);
-				header = NULL;
-				continue;
-			}
-			if (show_combined_diff(p, num_parent, dense, header))
+			if (show_combined_diff(p, num_parent, dense,
+					       header, opt))
 				header = NULL;
 		}
 	}
diff --git a/diff-files.c b/diff-files.c
index d24d11c..7db5ce6 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -88,9 +88,8 @@ int main(int argc, const char **argv)
 		}
 		argv++; argc--;
 	}
-	if (combine_merges) {
+	if (dense_combined_merges)
 		diff_options.output_format = DIFF_FORMAT_PATCH;
-	}
 
 	/* Find the directory, and set up the pathspec */
 	pathspec = get_pathspec(prefix, argv + 1);
@@ -166,7 +165,8 @@ int main(int argc, const char **argv)
 			if (combine_merges && num_compare_stages == 2) {
 				show_combined_diff(&combine.p, 2,
 						   dense_combined_merges,
-						   NULL);
+						   NULL,
+						   &diff_options);
 				free(combine.p.path);
 				continue;
 			}
diff --git a/diff-tree.c b/diff-tree.c
index df6fd97..b170b03 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -248,7 +248,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-m")) {
-			ignore_merges = 0;
+			combine_merges = ignore_merges = 0;
 			continue;
 		}
 		if (!strcmp(arg, "-c")) {
diff --git a/diff.h b/diff.h
index 9088519..946a406 100644
--- a/diff.h
+++ b/diff.h
@@ -75,7 +75,8 @@ struct combine_diff_path {
 	 sizeof(struct combine_diff_parent) * (n) + (l) + 1)
 
 extern int show_combined_diff(struct combine_diff_path *elem, int num_parent,
-			      int dense, const char *header);
+			      int dense, const char *header,
+			      struct diff_options *);
 
 extern const char *diff_tree_combined_merge(const unsigned char *sha1, const char *, int, struct diff_options *opt);
 
-- 
1.1.6.gce16
