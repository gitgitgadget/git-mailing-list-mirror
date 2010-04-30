From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH] blame: add a range option to -L
Date: Fri, 30 Apr 2010 17:29:49 -0400
Message-ID: <1272662989-563-1-git-send-email-wfp5p@virginia.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 30 23:39:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7xwA-0000Tj-3k
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 23:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759695Ab0D3Vjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 17:39:36 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:53039 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758800Ab0D3Vjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 17:39:35 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2010 17:39:35 EDT
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
	id F1A62409AC; Fri, 30 Apr 2010 17:29:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146065>

In addition to + and - you can now use r to specify how many lines
around <start> that you want to see.  For example: -L 20,r5 would show
lines 15 through 25

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---

I've been using a perl wrapper script to get this functionality.
In case others may find this a useful feature, I went ahead and
added it to blame.c


 Documentation/blame-options.txt |    6 ++++++
 Documentation/git-blame.txt     |    6 ++++++
 builtin/blame.c                 |   19 +++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index d820569..acbbc91 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -32,6 +32,12 @@ This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 +
 
+- rrange
++
+This is only valid for <end> and will specify a number
+of lines before and after the line given by <start>.
++
+
 -l::
 	Show long rev (Default: off).
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a27f439..7a9b99a 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -110,6 +110,12 @@ line 40):
 	git blame -L 40,60 foo
 	git blame -L 40,+21 foo
 
+A range of lines around a particular line can be shown by using 'r'
+before the second number.  If you wanted to see line 20 along with the
+5 lines around it:
+
+  	git blame -L 20,r5 foo
+
 Also you can use a regular expression to specify the line range:
 
 	git blame -L '/^sub hello {/,/^}$/' foo
diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..03a8948 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1887,13 +1887,18 @@ static const char *parse_loc(const char *spec,
 	/* Allow "-L <something>,+20" to mean starting at <something>
 	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
 	 * <something>.
+	 * In addition "-L <something>,r5" means starting at
+	 * <something>-5 and ending at <something>+5
 	 */
-	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
+	if (1 < begin &&
+	    (spec[0] == '+' || spec[0] == '-' || spec[0] == 'r')) {
 		num = strtol(spec + 1, &term, 10);
 		if (term != spec + 1) {
 			if (spec[0] == '-')
 				num = 0 - num;
-			if (0 < num)
+			if (spec[0] == 'r')
+				*ret = 0 - num;
+			else if (0 < num)
 				*ret = begin + num - 2;
 			else if (!num)
 				*ret = begin;
@@ -1960,6 +1965,16 @@ static void prepare_blame_range(struct scoreboard *sb,
 	term = parse_loc(bottomtop, sb, lno, 1, bottom);
 	if (*term == ',') {
 		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
+
+		/* if top is negative then top is actually a range
+		   that was specified with the r option */
+		if (*top < 1) {
+		    long x = *top;
+		    *top = *bottom - x;
+		    *bottom += x;
+		    if (*bottom < 1)
+			*bottom = 1;
+		}
 		if (*term)
 			usage(blame_usage);
 	}
-- 
1.7.0.6
