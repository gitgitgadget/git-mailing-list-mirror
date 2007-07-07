From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] revision: allow selection of commits that do not match a
 pattern
Date: Sat, 07 Jul 2007 20:42:24 +0200
Message-ID: <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site>
 <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 20:42:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7FEk-000185-BC
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXGGSm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXGGSm1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 14:42:27 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:34943 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557AbXGGSm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 14:42:26 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKT006MTNYOSZ@smtp16.wxs.nl> for git@vger.kernel.org; Sat,
 07 Jul 2007 20:42:24 +0200 (CEST)
Received: (qmail 29216 invoked by uid 500); Sat, 07 Jul 2007 18:42:24 +0000
In-reply-to: <Pine.LNX.4.64.0707071831300.4093@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51833>

We do this by maintaining two lists of patterns, one for
those that should match and one for those that should not match.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/git-rev-list.txt |    8 +++++
 revision.c                     |   59 +++++++++++++++++++++++++++++++--------
 revision.h                     |    1 +
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20dcac6..a27e4dd 100644
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
 
diff --git a/revision.c b/revision.c
index 5184716..4b00ada 100644
--- a/revision.c
+++ b/revision.c
@@ -821,40 +821,65 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+static void add_grep_to_filter(struct grep_opt **filter, const char *ptn,
+				enum grep_pat_token what)
 {
-	if (!revs->grep_filter) {
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
+static void add_grep(struct rev_info *revs, const char *ptn,
+		    enum grep_pat_token what, int negated)
+{
+	if (negated)
+		add_grep_to_filter(&revs->grep_neg_filter, ptn, what);
+	else
+		add_grep_to_filter(&revs->grep_filter, ptn, what);
+}
+
+static void add_header_grep(struct rev_info *revs, const char *field,
+			    const char *pattern)
 {
 	char *pat;
 	const char *prefix;
 	int patlen, fldlen;
+	int negated = 0;
 
 	fldlen = strlen(field);
 	patlen = strlen(pattern);
 	pat = xmalloc(patlen + fldlen + 10);
 	prefix = ".*";
+	if (*pattern == '!') {
+		negated = 1;
+		pattern++;
+	}
+	if (pattern[0] == '\\' && pattern[1] == '!')
+		pattern++;
 	if (*pattern == '^') {
 		prefix = "";
 		pattern++;
 	}
 	sprintf(pat, "^%s %s%s", field, prefix, pattern);
-	add_grep(revs, pat, GREP_PATTERN_HEAD);
+	add_grep(revs, pat, GREP_PATTERN_HEAD, negated);
 }
 
 static void add_message_grep(struct rev_info *revs, const char *pattern)
 {
-	add_grep(revs, pattern, GREP_PATTERN_BODY);
+	int negated = 0;
+
+	if (*pattern == '!') {
+		negated = 1;
+		pattern++;
+	}
+	if (pattern[0] == '\\' && pattern[1] == '!')
+		pattern++;
+	add_grep(revs, pattern, GREP_PATTERN_BODY, negated);
 }
 
 static void add_ignore_packed(struct rev_info *revs, const char *name)
@@ -1212,6 +1237,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->grep_filter)
 		revs->grep_filter->regflags |= regflags;
 
+	if (revs->grep_neg_filter)
+		revs->grep_neg_filter->regflags |= regflags;
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
@@ -1249,6 +1277,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		compile_grep_patterns(revs->grep_filter);
 	}
 
+	if (revs->grep_neg_filter) {
+		compile_grep_patterns(revs->grep_neg_filter);
+	}
+
 	return left;
 }
 
@@ -1329,11 +1361,14 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
-	if (!opt->grep_filter)
-		return 1;
-	return grep_buffer(opt->grep_filter,
+	return (!opt->grep_filter ||
+		grep_buffer(opt->grep_filter,
+			   NULL, /* we say nothing, not even filename */
+			   commit->buffer, strlen(commit->buffer))) &&
+	       (!opt->grep_neg_filter ||
+		!grep_buffer(opt->grep_neg_filter,
 			   NULL, /* we say nothing, not even filename */
-			   commit->buffer, strlen(commit->buffer));
+			   commit->buffer, strlen(commit->buffer)));
 }
 
 static struct commit *get_revision_1(struct rev_info *revs)
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
1.5.3.rc0.41.ge7772
