From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH v2] blame: add a range option to -L
Date: Mon,  3 May 2010 14:06:35 -0400
Message-ID: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 03 20:06:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O902U-0007eI-6c
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 20:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab0ECSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 14:06:37 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:33433 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab0ECSGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 14:06:36 -0400
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
	id A6CE141192; Mon,  3 May 2010 14:06:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146247>

In addition to <start>,<end> you can now use <center>%<radius>
to specify how many lines around <center> that you want to see.
For example: -L 20%5 would show lines 15 through 25

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---

This is like the previous patch to create a range option to -L in git-blame.
However, this one uses -L<start>%<end>

I chose to use % since it's on a standard keyboard.


 Documentation/blame-options.txt |    4 ++++
 Documentation/git-blame.txt     |    8 ++++++++
 builtin/blame.c                 |   18 +++++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index d820569..f65e69c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -32,6 +32,10 @@ This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 +
 
+-L <center>%<radius>::
+	This works like <start>,<end> with the annotated range
+	centered on <center> and showing <radius> lines around it.
+
 -l::
 	Show long rev (Default: off).
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a27f439..73f6b83 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -110,6 +110,14 @@ line 40):
 	git blame -L 40,60 foo
 	git blame -L 40,+21 foo
 
+A range of lines around a particular line can be shown by using '%'
+instead of ','.  If you wanted to see line 20 along with the 5
+lines around it:
+
+       git blame -L 20%5 foo
+
+
+
 Also you can use a regular expression to specify the line range:
 
 	git blame -L '/^sub hello {/,/^}$/' foo
diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..eabc292 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1887,6 +1887,9 @@ static const char *parse_loc(const char *spec,
 	/* Allow "-L <something>,+20" to mean starting at <something>
 	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
 	 * <something>.
+	 *
+	 * In addition "-L <something>%5" means starting at
+	 * <something>-5 and ending at <something>+5
 	 */
 	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
 		num = strtol(spec + 1, &term, 10);
@@ -1958,10 +1961,19 @@ static void prepare_blame_range(struct scoreboard *sb,
 	const char *term;
 
 	term = parse_loc(bottomtop, sb, lno, 1, bottom);
-	if (*term == ',') {
+	if (*term == ',')
+		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
+	else if (*term == '%') {
+		long x;
+		/* ignore + or - if it's there */
+		if ((*(term+1) == '+') || (*(term+1) == '-'))
+			term++;
 		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
-		if (*term)
-			usage(blame_usage);
+		x = *top;
+		*top = *bottom - x;
+		*bottom += x;
+		if (*bottom < 1)
+			*bottom = 1;
 	}
 	if (*term)
 		usage(blame_usage);
-- 
1.7.1
