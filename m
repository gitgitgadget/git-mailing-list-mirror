X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-format.txt: Combined diff format documentation supplement
Date: Thu, 26 Oct 2006 00:05:04 -0700
Message-ID: <7v1wovsgkf.fsf@assigned-by-dhcp.cox.net>
References: <ehoo2k$1g6$1@sea.gmane.org>
	<7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
	<200610260544.50614.jnareb@gmail.com>
	<7vac3jk3g7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 07:05:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30141>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GczIi-0004hQ-OB for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751724AbWJZHFH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 03:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWJZHFH
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:05:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49870 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1751724AbWJZHFF
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:05:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026070505.LBFC16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 03:05:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ev4n1V00Q1kojtg0000000 Thu, 26 Oct 2006
 03:04:48 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

By the way, this is only minimally tested, but this patch fills
the blanks in your documentation.

The combine_diff_path structure _does_ keep track of the
original path in each parent, so renames _could_ be shown (we do
not keep the score, though), but the question is how.  "rename to"
would obviously be "the path in the merge result", but "rename from"
needs to be shown for all parents when we have rename from any
of the parents.  "rename from" line as in the usual one parent diff
does not have any place to say "which parent" (because there is
no need), so showing the usual "rename from" for only parents
that the result has rename from makes the output useless -- we
cannot tell "from which parent" from such an output.  I feel
that an evil merge is rare enough that worrying about showing
rename line is probably not worth the effort.

-- >8 --
[PATCH] combine-diff: a few more finishing touches.

"new file" and "deleted file" were already reported in the
original code, but the logic was not as transparent as it could
have.  This uses a few variables and more comments to clarify
the flow.  The rule is: (1) if a path exists in the merge result
when no parent had it, we report "new" (otherwise it came from
the parents, as opposed to have added by the evil merge). (2) if
the path does not exist in the merge result, it is "deleted".

Since we can say "new" and "deleted", there is no reason not to
follow the /dev/null convention.  This fixes it.

Appending function name after @@@ ... @@@ is trivial, so
implement it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 combine-diff.c |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 46d9121..01a8437 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -489,6 +489,12 @@ static void show_parent_lno(struct sline
 	printf(" -%lu,%lu", l0, l1-l0);
 }
 
+static int hunk_comment_line(const char *bol)
+{
+	int ch = *bol & 0xff;
+	return (isalpha(ch) || ch == '_' || ch == '$');
+}
+
 static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 		       int use_color)
 {
@@ -508,8 +514,13 @@ static void dump_sline(struct sline *sli
 		struct sline *sl = &sline[lno];
 		unsigned long hunk_end;
 		unsigned long rlines;
-		while (lno <= cnt && !(sline[lno].flag & mark))
+		const char *hunk_comment = NULL;
+
+		while (lno <= cnt && !(sline[lno].flag & mark)) {
+			if (hunk_comment_line(sline[lno].bol))
+				hunk_comment = sline[lno].bol;
 			lno++;
+		}
 		if (cnt < lno)
 			break;
 		else {
@@ -526,6 +537,22 @@ static void dump_sline(struct sline *sli
 			show_parent_lno(sline, lno, hunk_end, i);
 		printf(" +%lu,%lu ", lno+1, rlines);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
+
+		if (hunk_comment) {
+			int comment_end = 0;
+			for (i = 0; i < 40; i++) {
+				int ch = hunk_comment[i] & 0xff;
+				if (!ch || ch == '\n')
+					break;
+				if (!isspace(ch))
+				    comment_end = i;
+			}
+			if (comment_end)
+				putchar(' ');
+			for (i = 0; i < comment_end; i++)
+				putchar(hunk_comment[i]);
+		}
+
 		printf("%s\n", c_reset);
 		while (lno < hunk_end) {
 			struct lline *ll;
@@ -707,6 +734,8 @@ static void show_patch_diff(struct combi
 		int use_color = opt->color_diff;
 		const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
 		const char *c_reset = diff_get_color(use_color, DIFF_RESET);
+		int added = 0;
+		int deleted = 0;
 
 		if (rev->loginfo)
 			show_log(rev, opt->msg_sep);
@@ -722,7 +751,10 @@ static void show_patch_diff(struct combi
 		printf("..%s%s\n", abb, c_reset);
 
 		if (mode_differs) {
-			int added = !!elem->mode;
+			deleted = !elem->mode;
+
+			/* We say it was added if nobody had it */
+			added = !deleted;
 			for (i = 0; added && i < num_parent; i++)
 				if (elem->parent[i].status !=
 				    DIFF_STATUS_ADDED)
@@ -731,7 +763,7 @@ static void show_patch_diff(struct combi
 				printf("%snew file mode %06o",
 				       c_meta, elem->mode);
 			else {
-				if (!elem->mode)
+				if (deleted)
 					printf("%sdeleted file ", c_meta);
 				printf("mode ");
 				for (i = 0; i < num_parent; i++) {
@@ -743,8 +775,14 @@ static void show_patch_diff(struct combi
 			}
 			printf("%s\n", c_reset);
 		}
-		dump_quoted_path("--- a/", elem->path, c_meta, c_reset);
-		dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
+		if (added)
+			dump_quoted_path("--- /dev/", "null", c_meta, c_reset);
+		else
+			dump_quoted_path("--- a/", elem->path, c_meta, c_reset);
+		if (deleted)
+			dump_quoted_path("+++ /dev/", "null", c_meta, c_reset);
+		else
+			dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
 		dump_sline(sline, cnt, num_parent, opt->color_diff);
 	}
 	free(result);
