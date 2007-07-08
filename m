From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH v3] revision: allow selection of commits that do not match a
 pattern
Date: Sun, 08 Jul 2007 12:57:20 +0200
Message-ID: <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site>
 <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site>
 <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071957370.4093@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 12:57:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7USE-0006ma-3k
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 12:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXGHK5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 06:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXGHK5X
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 06:57:23 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:62659 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbXGHK5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 06:57:22 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKU00844X3KY3@smtp15.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 12:57:21 +0200 (CEST)
Received: (qmail 18937 invoked by uid 500); Sun, 08 Jul 2007 10:57:20 +0000
In-reply-to: <Pine.LNX.4.64.0707071957370.4093@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51874>

We do this by maintaining two lists of patterns, one for
those that should match and one for those that should not match.

A negative pattern is specified by putting a '!' in front.
For example, to show the commits of Jakub Narebski that
are not about gitweb, you'd do a

	git log --author='Narebski' --grep='!gitweb' --all-match

As an added bonus, this patch also documents --all-match.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
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
index 5184716..0035d40 100644
--- a/revision.c
+++ b/revision.c
@@ -821,34 +821,50 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
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
 
@@ -1212,6 +1228,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->grep_filter)
 		revs->grep_filter->regflags |= regflags;
 
+	if (revs->grep_neg_filter)
+		revs->grep_neg_filter->regflags |= regflags;
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
@@ -1249,6 +1268,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		compile_grep_patterns(revs->grep_filter);
 	}
 
+	if (revs->grep_neg_filter) {
+		revs->grep_neg_filter->all_match = !all_match;
+		compile_grep_patterns(revs->grep_neg_filter);
+	}
+
 	return left;
 }
 
@@ -1327,11 +1351,31 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
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
1.5.3.rc0.65.ge75d-dirty
