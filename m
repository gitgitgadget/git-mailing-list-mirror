From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/3] git-apply: fix whitespace stripping
Date: Sun, 16 Sep 2007 18:49:00 -0400
Message-ID: <11899829424173-git-send-email-bfields@citi.umich.edu>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2vQ-00059K-3g
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbXIPWtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbXIPWtH
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:49:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48530 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbXIPWtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:49:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX2vG-00038n-H2; Sun, 16 Sep 2007 18:49:02 -0400
X-Mailer: git-send-email 1.5.3
In-Reply-To: <11899829424040-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58360>

The algorithm isn't right here: it accumulates any set of 8 spaces into
tabs even if they're separated by tabs, so

	<four spaces><tab><four spaces><tab>

is converted to

	<tab><tab><tab>

when it should be just

	<tab><tab>

So teach git-apply that a tab hides any group of less than 8 previous
spaces in a row.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-apply.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 976ec77..70359c1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1642,15 +1642,22 @@ static int apply_line(char *output, const char *patch, int plen)
 
 	buf = output;
 	if (need_fix_leading_space) {
+		int consecutive_spaces = 0;
 		/* between patch[1..last_tab_in_indent] strip the
 		 * funny spaces, updating them to tab as needed.
 		 */
 		for (i = 1; i < last_tab_in_indent; i++, plen--) {
 			char ch = patch[i];
-			if (ch != ' ')
+			if (ch != ' ') {
+				consecutive_spaces = 0;
 				*output++ = ch;
-			else if ((i % 8) == 0)
-				*output++ = '\t';
+			} else {
+				consecutive_spaces++;
+				if (consecutive_spaces == 8) {
+					*output++ = '\t';
+					consecutive_spaces = 0;
+				}
+			}
 		}
 		fixed = 1;
 		i = last_tab_in_indent;
-- 
1.5.3.1.42.gfe5df
