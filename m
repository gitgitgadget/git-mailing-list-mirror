From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/3] git-rev-list: Add regexp tuning options
Date: Sat, 19 May 2007 02:13:29 +0200
Message-ID: <20070519001329.28618.31334.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 02:13:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCZm-0002hb-6W
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbXESANc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbXESANb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:13:31 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52342 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbXESANb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:13:31 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 5F9998B722;
	Sat, 19 May 2007 02:13:29 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47692>

This patch introduces --extended-regexp and --regexp-ignore-case options to
tune what kind of patterns the pattern-limiting options (--grep, --author,
...) accept.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-rev-list.txt |   10 ++++++++++
 revision.c                     |   12 ++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index c3c2043..0dba73f 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
+	     [ \--regexp-ignore-case ] [ \--extended-regexp ]
 	     [ \--date={local|relative|default} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
@@ -214,6 +215,15 @@ limiting may be applied.
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
 
+--regexp-ignore-case::
+
+	Match the regexp limiting patterns without regard to letters case.
+
+--extended-regexp::
+
+	Consider the limiting patterns to be extended regular expressions
+	instead of the default basic regular expressions.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index 0125d41..0a29b53 100644
--- a/revision.c
+++ b/revision.c
@@ -881,6 +881,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	const char **unrecognized = argv + 1;
 	int left = 1;
 	int all_match = 0;
+	int regflags = 0;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1152,6 +1153,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				add_message_grep(revs, arg+7);
 				continue;
 			}
+			if (!prefixcmp(arg, "--extended-regexp")) {
+				regflags |= REG_EXTENDED;
+				continue;
+			}
+			if (!prefixcmp(arg, "--regexp-ignore-case")) {
+				regflags |= REG_ICASE;
+				continue;
+			}
 			if (!strcmp(arg, "--all-match")) {
 				all_match = 1;
 				continue;
@@ -1200,6 +1209,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
+	if (revs->grep_filter)
+		revs->grep_filter->regflags |= regflags;
+
 	if (show_merge)
 		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
