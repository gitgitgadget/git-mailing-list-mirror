From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 3/3] Act on WS_WARN for ws_mode_trailing.
Date: Sat,  3 Nov 2007 00:34:21 +1100
Message-ID: <1194010463982-git-send-email-dsymonds@gmail.com>
References: <11940104611948-git-send-email-dsymonds@gmail.com>
 <11940104621856-git-send-email-dsymonds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 14:35:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inwfx-0003VG-J0
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXKBNef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbXKBNef
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:34:35 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:20732 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756253AbXKBNe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 09:34:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAO3DKkd5LCBH/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,362,1188743400"; 
   d="scan'208";a="180027731"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 03 Nov 2007 00:04:25 +1030
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11940104621856-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63117>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 diff.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 6f9b624..ebcc0f3 100644
--- a/diff.c
+++ b/diff.c
@@ -544,17 +544,22 @@ static void emit_line_with_ws(int nparents,
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
-		fputs(set, stdout);
-		fwrite(line + i, tail - i + 1, 1, stdout);
-		fputs(reset, stdout);
-		emit_line(ws, reset, line + tail + 1, len - tail - 1);
+		if (ws_mode_trailing == WS_WARN) {
+			fputs(set, stdout);
+			fwrite(line + i, tail - i + 1, 1, stdout);
+			fputs(reset, stdout);
+			emit_line(ws, reset, line + tail + 1, len - tail - 1);
+		}
+		/* TODO: handle WS_ERROR and WS_AUTOFIX */
 	}
 	else
 		emit_line(set, reset, line + i, len - i);
-- 
1.5.3.1
