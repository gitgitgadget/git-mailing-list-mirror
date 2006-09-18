From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] revision traversal: --author, --committer, and --grep.
Date: Sun, 17 Sep 2006 17:42:26 -0700
Message-ID: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Blin <kai.blin@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 18 02:42:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7DW-0000pg-M8
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWIRAma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWIRAm3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:42:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1014 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965177AbWIRAm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:42:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918004227.CTQK12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 20:42:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PciE1V00Y1kojtg0000000
	Sun, 17 Sep 2006 20:42:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27217>

This adds three options to setup_revisions(), which lets you
filter resulting commits by the author name, the committer name
and the log message with regexp.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-list.txt |   11 ++++++
 revision.c                     |   76 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 28966ad..00a95e2 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
+	     [ \--(author|committer|grep)=<pattern> ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
@@ -154,6 +155,16 @@ limiting may be applied.
 
 	Limit the commits output to specified time range.
 
+--author='pattern', --committer='pattern'::
+
+	Limit the commits output to ones with author/committer
+	header lines that match the specified pattern.
+
+--grep='pattern'::
+
+	Limit the commits output to ones with log message that
+	matches the specified pattern.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index 8fda20d..19f7272 100644
--- a/revision.c
+++ b/revision.c
@@ -673,6 +673,40 @@ int handle_revision_arg(const char *arg,
 	return 0;
 }
 
+static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
+{
+	char *pat;
+	int patlen, fldlen;
+
+	if (!revs->header_filter) {
+		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
+		opt->status_only = 1;
+		opt->pattern_tail = &(opt->pattern_list);
+		opt->regflags = REG_NEWLINE;
+		revs->header_filter = opt;
+	}
+
+	fldlen = strlen(field);
+	patlen = strlen(pattern);
+	pat = xmalloc(patlen + fldlen + 3);
+	sprintf(pat, "^%s %s", field, pattern);
+	append_grep_pattern(revs->header_filter, pat,
+			    "command line", 0, GREP_PATTERN);
+}
+
+static void add_message_grep(struct rev_info *revs, const char *pattern)
+{
+	if (!revs->message_filter) {
+		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
+		opt->status_only = 1;
+		opt->pattern_tail = &(opt->pattern_list);
+		opt->regflags = REG_NEWLINE;
+		revs->message_filter = opt;
+	}
+	append_grep_pattern(revs->message_filter, pattern,
+			    "command line", 0, GREP_PATTERN);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -896,6 +930,18 @@ int setup_revisions(int argc, const char
 				revs->relative_date = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--author=", 9)) {
+				add_header_grep(revs, "author", arg+9);
+				continue;
+			}
+			if (!strncmp(arg, "--committer=", 12)) {
+				add_header_grep(revs, "committer", arg+12);
+				continue;
+			}
+			if (!strncmp(arg, "--grep=", 7)) {
+				add_message_grep(revs, arg+7);
+				continue;
+			}
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
 				revs->diff = 1;
@@ -956,6 +1002,11 @@ int setup_revisions(int argc, const char
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
+	if (revs->header_filter)
+		compile_grep_patterns(revs->header_filter);
+	if (revs->message_filter)
+		compile_grep_patterns(revs->message_filter);
+
 	return left;
 }
 
@@ -1030,10 +1081,33 @@ static void mark_boundary_to_show(struct
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
+	char *header, *message;
+	unsigned long header_len, message_len;
+
 	if (!opt->header_filter && !opt->message_filter)
 		return 1;
 
-	/* match it here */
+	header = commit->buffer;
+	message = strstr(header, "\n\n");
+	if (message) {
+		message += 2;
+		header_len = message - header - 1;
+		message_len = strlen(message);
+	}
+	else {
+		header_len = strlen(header);
+		message = header;
+		message_len = 0;
+	}
+
+	if (opt->header_filter &&
+	    !grep_buffer(opt->header_filter, NULL, header, header_len))
+		return 0;
+
+	if (opt->message_filter &&
+	    !grep_buffer(opt->message_filter, NULL, message, message_len))
+		return 0;
+
 	return 1;
 }
 
-- 
1.4.2.1.g414e5
