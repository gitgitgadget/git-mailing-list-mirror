From: skimo@liacs.nl
Subject: [PATCH 1/6] revision: allow selection of commits that do not match a pattern
Date: Thu, 12 Jul 2007 21:05:58 +0200
Message-ID: <1184267163786-git-send-email-skimo@liacs.nl>
References: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I944P-0005YQ-Gy
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbXGLTLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbXGLTLS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:11:18 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46312 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbXGLTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:11:17 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ63MF029830;
	Thu, 12 Jul 2007 21:06:08 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 7E03C3C00B; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11842671631744-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52329>

From: Sven Verdoolaege <skimo@kotnet.org>

We do this by maintaining two lists of patterns, one for
those that should match and one for those that should not match.

A negative pattern is specified by putting a '!' in front.
For example, to show the commits of Jakub Narebski that
are not about gitweb, you'd do a

	git log --author='Narebski' --grep='!gitweb' --all-match

As an added bonus, this patch also documents --all-match.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rev-list.txt |   17 ++++++++++
 revision.c                     |   64 +++++++++++++++++++++++++++++++++------
 revision.h                     |    1 +
 3 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20dcac6..c462f5d 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -214,11 +214,19 @@ limiting may be applied.
 
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular expression).
+	A pattern starting with a '!' will show only commits that do
+	not match the remainder of the pattern.
+	To match lines starting with '!', escape the initial '!'
+	with a backslash.
 
 --grep='pattern'::
 
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
+	A pattern starting with a '!' will show only commits that do
+	not match the remainder of the pattern.
+	To match lines starting with '!', escape the initial '!'
+	with a backslash.
 
 --regexp-ignore-case::
 
@@ -229,6 +237,15 @@ limiting may be applied.
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
+--all-match::
+
+	Without this option, a commit is shown if any of the
+	(positive or negative) patterns matches, i.e., there
+	is at least one positive match or not all of the negative
+	patterns match.  With this options, a commit is only
+	shown if all of the patterns match, i.e., all positive
+	patterns match and no negative pattern matches.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index 27cce09..38061f9 100644
--- a/revision.c
+++ b/revision.c
@@ -826,34 +826,50 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+static void add_grep(struct rev_info *revs, const char *ptn,
+		    enum grep_pat_token what)
 {
-	if (!revs->grep_filter) {
+	int negated = 0;
+	struct grep_opt **filter;
+
+	if (ptn[0] == '\\' && ptn[1] == '!')
+		ptn++;
+	if (*ptn == '!') {
+		negated = 1;
+		ptn++;
+	}
+	filter = negated ? &revs->grep_neg_filter : &revs->grep_filter;
+	if (!*filter) {
 		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
 		opt->status_only = 1;
 		opt->pattern_tail = &(opt->pattern_list);
 		opt->regflags = REG_NEWLINE;
-		revs->grep_filter = opt;
+		*filter = opt;
 	}
-	append_grep_pattern(revs->grep_filter, ptn,
-			    "command line", 0, what);
+	append_grep_pattern(*filter, ptn, "command line", 0, what);
 }
 
-static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
+static void add_header_grep(struct rev_info *revs, const char *field,
+			    const char *pattern)
 {
 	char *pat;
-	const char *prefix;
+	const char *prefix, *negated;
 	int patlen, fldlen;
 
 	fldlen = strlen(field);
 	patlen = strlen(pattern);
 	pat = xmalloc(patlen + fldlen + 10);
+	negated = "";
+	if (*pattern == '!') {
+		negated = "!";
+		pattern++;
+	}
 	prefix = ".*";
 	if (*pattern == '^') {
 		prefix = "";
 		pattern++;
 	}
-	sprintf(pat, "^%s %s%s", field, prefix, pattern);
+	sprintf(pat, "%s^%s %s%s", negated, field, prefix, pattern);
 	add_grep(revs, pat, GREP_PATTERN_HEAD);
 }
 
@@ -1217,6 +1233,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->grep_filter)
 		revs->grep_filter->regflags |= regflags;
 
+	if (revs->grep_neg_filter)
+		revs->grep_neg_filter->regflags |= regflags;
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
@@ -1254,6 +1273,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		compile_grep_patterns(revs->grep_filter);
 	}
 
+	if (revs->grep_neg_filter) {
+		revs->grep_neg_filter->all_match = !all_match;
+		compile_grep_patterns(revs->grep_neg_filter);
+	}
+
 	return left;
 }
 
@@ -1352,11 +1376,31 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	return 0;
 }
 
+/*
+ * If all_match is set, then a commit matches if all the positive
+ * patterns match and not one of the negative patterns matches.
+ * If all_match is not set, then a commit matches if at least one
+ * of the positive patterns matches or not all of the negative
+ * patterns match.
+ */
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
-	if (!opt->grep_filter)
+	int pos_match, all_match;
+
+	pos_match = !opt->grep_filter ||
+		    grep_buffer(opt->grep_filter,
+			   NULL, /* we say nothing, not even filename */
+			   commit->buffer, strlen(commit->buffer));
+	if (!opt->grep_neg_filter)
+		return pos_match;
+
+	all_match = !opt->grep_neg_filter->all_match;
+	if (!all_match && opt->grep_filter && pos_match)
 		return 1;
-	return grep_buffer(opt->grep_filter,
+	if (all_match && !pos_match)
+		return 0;
+
+	return !grep_buffer(opt->grep_neg_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
 }
diff --git a/revision.h b/revision.h
index f46b4d5..9728d4c 100644
--- a/revision.h
+++ b/revision.h
@@ -84,6 +84,7 @@ struct rev_info {
 
 	/* Filter by commit log message */
 	struct grep_opt	*grep_filter;
+	struct grep_opt	*grep_neg_filter;
 
 	/* special limits */
 	int skip_count;
-- 
1.5.3.rc0.100.ge60b4
