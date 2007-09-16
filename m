From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/3] git-apply: complain about >=8 consecutive spaces in initial indent
Date: Sun, 16 Sep 2007 18:49:01 -0400
Message-ID: <1189982942187-git-send-email-bfields@citi.umich.edu>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
 <11899829424173-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2vf-0005CX-U8
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXIPWtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbXIPWtN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:49:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48532 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbXIPWtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:49:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX2vG-00038p-Je; Sun, 16 Sep 2007 18:49:02 -0400
X-Mailer: git-send-email 1.5.3
In-Reply-To: <11899829424173-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58361>

Complain if we find 8 spaces or more in a row as part of the initial
whitespace on a line, and (with --whitespace=stripspace) replace such by
a tab.

Well, linux's checkpatch.pl complains about this sort of thing.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-apply.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 70359c1..fb63089 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -918,6 +918,7 @@ static void check_whitespace(const char *line, int len)
 {
 	const char *err = "Adds trailing whitespace";
 	int seen_space = 0;
+	int consecutive_spaces = 0;
 	int i;
 
 	/*
@@ -944,6 +945,18 @@ static void check_whitespace(const char *line, int len)
 		else
 			break;
 	}
+
+	err = "Initial indent contains eight or more spaces in a row";
+	for (i = 1; i < len; i++) {
+		if (line[i] == ' ')
+			consecutive_spaces++;
+		else if (line[i] == '\t')
+			consecutive_spaces = 0;
+		else
+			break;
+		if (consecutive_spaces == 8)
+			goto error;
+	}
 	return;
 
  error:
@@ -1607,9 +1620,10 @@ static int apply_line(char *output, const char *patch, int plen)
 	int i;
 	int add_nl_to_tail = 0;
 	int fixed = 0;
-	int last_tab_in_indent = -1;
+	int after_indent = -1;
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
+	int consecutive_spaces = 0;
 	char *buf;
 
 	if ((new_whitespace != strip_whitespace) || !whitespace_error ||
@@ -1630,23 +1644,27 @@ static int apply_line(char *output, const char *patch, int plen)
 	for (i = 1; i < plen; i++) {
 		char ch = patch[i];
 		if (ch == '\t') {
-			last_tab_in_indent = i;
+			consecutive_spaces = 0;
 			if (0 <= last_space_in_indent)
 				need_fix_leading_space = 1;
 		}
-		else if (ch == ' ')
+		else if (ch == ' ') {
+			consecutive_spaces++;
 			last_space_in_indent = i;
-		else
+		} else
 			break;
+		if (consecutive_spaces == 8)
+			need_fix_leading_space = 1;
 	}
+	after_indent=i;
 
 	buf = output;
 	if (need_fix_leading_space) {
-		int consecutive_spaces = 0;
+		consecutive_spaces = 0;
 		/* between patch[1..last_tab_in_indent] strip the
 		 * funny spaces, updating them to tab as needed.
 		 */
-		for (i = 1; i < last_tab_in_indent; i++, plen--) {
+		for (i = 1; i < after_indent; i++, plen--) {
 			char ch = patch[i];
 			if (ch != ' ') {
 				consecutive_spaces = 0;
@@ -1660,7 +1678,9 @@ static int apply_line(char *output, const char *patch, int plen)
 			}
 		}
 		fixed = 1;
-		i = last_tab_in_indent;
+		i = after_indent;
+		i -= consecutive_spaces;
+		plen += consecutive_spaces;
 	}
 	else
 		i = 1;
-- 
1.5.3.1.42.gfe5df
