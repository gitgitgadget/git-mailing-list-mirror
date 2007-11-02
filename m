From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 2/2] git-diff: Respect core.whitespace.{space-indent,space-before-tab,trailing}.
Date: Sat,  3 Nov 2007 02:08:13 +1100
Message-ID: <11940160942802-git-send-email-dsymonds@gmail.com>
References: <11940160932021-git-send-email-dsymonds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 16:08:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iny8V-0004Go-U6
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbXKBPIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbXKBPIV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:08:21 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:53508 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754122AbXKBPIU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 11:08:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAMfYKkd5LCBH/2dsb2JhbACBW45c
X-IronPort-AV: E=Sophos;i="4.21,363,1188743400"; 
   d="scan'208";a="180068628"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 03 Nov 2007 01:38:17 +1030
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11940160932021-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63125>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 diff.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index a6aaaf7..aa86fa1 100644
--- a/diff.c
+++ b/diff.c
@@ -503,12 +503,15 @@ static void emit_line_with_ws(int nparents,
 	int tail = len;
 	int need_highlight_leading_space = 0;
 	/* The line is a newly added line.  Does it have funny leading
-	 * whitespaces?  In indent, SP should never precede a TAB.
+	 * whitespaces?  In indent, SP should never precede a TAB. In
+	 * addition, under "indent with non tab" rule, there should not
+	 * be 8 or more consecutive spaces.
 	 */
 	for (i = col0; i < len; i++) {
 		if (line[i] == '\t') {
 			last_tab_in_indent = i;
-			if (0 <= last_space_in_indent)
+			if ((ws_mode_space_before_tab != WS_OKAY) &&
+			    (0 <= last_space_in_indent))
 				need_highlight_leading_space = 1;
 		}
 		else if (line[i] == ' ')
@@ -516,6 +519,13 @@ static void emit_line_with_ws(int nparents,
 		else
 			break;
 	}
+	if ((ws_mode_space_indent != WS_OKAY) &&
+	    (0 <= last_space_in_indent) &&
+	    (last_tab_in_indent < 0) &&
+	    (8 <= (i - col0))) {
+		last_tab_in_indent = i;
+		need_highlight_leading_space = 1;
+	}
 	fputs(set, stdout);
 	fwrite(line, col0, 1, stdout);
 	fputs(reset, stdout);
@@ -540,10 +550,12 @@ static void emit_line_with_ws(int nparents,
 	tail = len - 1;
 	if (line[tail] == '\n' && i < tail)
 		tail--;
-	while (i < tail) {
-		if (!isspace(line[tail]))
-			break;
-		tail--;
+	if (ws_mode_trailing != WS_OKAY) {
+		while (i < tail) {
+			if (!isspace(line[tail]))
+				break;
+			tail--;
+		}
 	}
 	if ((i < tail && line[tail + 1] != '\n')) {
 		/* This has whitespace between tail+1..len */
-- 
1.5.3.1
