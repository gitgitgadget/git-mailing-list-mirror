From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] revision: allow selection of commits that do not match a
 pattern
Date: Sat, 07 Jul 2007 17:30:01 +0200
Message-ID: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 17:30:09 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7CEa-0004Qm-Iz
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 17:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXGGPaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 11:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXGGPaF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 11:30:05 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:50549 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbXGGPaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 11:30:03 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKT00CBGF21DG@smtp17.wxs.nl> for git@vger.kernel.org; Sat,
 07 Jul 2007 17:30:02 +0200 (CEST)
Received: (qmail 13973 invoked by uid 500); Sat, 07 Jul 2007 15:30:01 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51818>

We do this by maintaining two lists of patterns, one for
those that should match and one for those that should not match.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/git-rev-list.txt |    7 ++++-
 revision.c                     |   57 ++++++++++++++++++++++++++++-----------
 revision.h                     |    1 +
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20dcac6..22bfd60 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -214,11 +214,15 @@ limiting may be applied.
 
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular expression).
+	If this option is preceded by an odd number of --not options,
+	then only commits that do not match will be shown.
 
 --grep='pattern'::
 
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
+	If this option is preceded by an odd number of --not options,
+	then only commits that do not match will be shown.
 
 --regexp-ignore-case::
 
@@ -248,7 +252,8 @@ limiting may be applied.
 --not::
 
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-	for all following revision specifiers, up to the next '--not'.
+	for all following revision specifiers as well as the result
+	of matching a pattern, up to the next '--not'.
 
 --all::
 
diff --git a/revision.c b/revision.c
index 5184716..4bf9a0b 100644
--- a/revision.c
+++ b/revision.c
@@ -821,20 +821,30 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
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
+		    enum grep_pat_token what, int not)
+{
+	if (not)
+		add_grep_to_filter(&revs->grep_neg_filter, ptn, what);
+	else
+		add_grep_to_filter(&revs->grep_filter, ptn, what);
+}
+
+static void add_header_grep(struct rev_info *revs, const char *field,
+			    const char *pattern, int not)
 {
 	char *pat;
 	const char *prefix;
@@ -849,12 +859,14 @@ static void add_header_grep(struct rev_info *revs, const char *field, const char
 		pattern++;
 	}
 	sprintf(pat, "^%s %s%s", field, prefix, pattern);
-	add_grep(revs, pat, GREP_PATTERN_HEAD);
+	fprintf(stderr, "not: %d\n", not);
+	add_grep(revs, pat, GREP_PATTERN_HEAD, not);
 }
 
-static void add_message_grep(struct rev_info *revs, const char *pattern)
+static void add_message_grep(struct rev_info *revs, const char *pattern,
+				int not)
 {
-	add_grep(revs, pattern, GREP_PATTERN_BODY);
+	add_grep(revs, pattern, GREP_PATTERN_BODY, not);
 }
 
 static void add_ignore_packed(struct rev_info *revs, const char *name)
@@ -1141,15 +1153,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			 * Grepping the commit log
 			 */
 			if (!prefixcmp(arg, "--author=")) {
-				add_header_grep(revs, "author", arg+9);
+				add_header_grep(revs, "author", arg+9,
+						flags & UNINTERESTING);
 				continue;
 			}
 			if (!prefixcmp(arg, "--committer=")) {
-				add_header_grep(revs, "committer", arg+12);
+				add_header_grep(revs, "committer", arg+12,
+						flags & UNINTERESTING);
 				continue;
 			}
 			if (!prefixcmp(arg, "--grep=")) {
-				add_message_grep(revs, arg+7);
+				add_message_grep(revs, arg+7,
+						flags & UNINTERESTING);
 				continue;
 			}
 			if (!prefixcmp(arg, "--extended-regexp")) {
@@ -1212,6 +1227,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->grep_filter)
 		revs->grep_filter->regflags |= regflags;
 
+	if (revs->grep_neg_filter)
+		revs->grep_neg_filter->regflags |= regflags;
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
@@ -1249,6 +1267,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		compile_grep_patterns(revs->grep_filter);
 	}
 
+	if (revs->grep_neg_filter) {
+		compile_grep_patterns(revs->grep_neg_filter);
+	}
+
 	return left;
 }
 
@@ -1329,11 +1351,14 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 
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
1.5.3.rc0.40.g46ad-dirty
