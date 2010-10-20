From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] diff: handle lines containing only whitespace better
Date: Tue, 19 Oct 2010 21:46:18 -0700
Message-ID: <1287549978-54280-1-git-send-email-kevin@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 20 06:46:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8QZJ-00057B-JA
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 06:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab0JTEqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 00:46:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45452 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0JTEqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 00:46:23 -0400
Received: by pva18 with SMTP id 18so632951pva.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 21:46:23 -0700 (PDT)
Received: by 10.142.166.16 with SMTP id o16mr3714840wfe.231.1287549983371;
        Tue, 19 Oct 2010 21:46:23 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id t38sm26462059wfc.9.2010.10.19.21.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 21:46:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.211.g81fee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159391>

When a line contains nothing but whitespace and the core.whitespace config
option contains blank-at-eol, the whitespace on the line is being printed
twice, once unhighlighted (unless otherwise matched by one of the other
core.whitespace values), and a second time highlighted for blank-at-eol.

Update the leading indentation check to stop checking when it reaches
the trailing whitespace.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 ws.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/ws.c b/ws.c
index d7b8c33..7302f8f 100644
--- a/ws.c
+++ b/ws.c
@@ -174,8 +174,11 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		}
 	}
 
+	if (trailing_whitespace == -1)
+		trailing_whitespace = len;
+
 	/* Check indentation */
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < trailing_whitespace; i++) {
 		if (line[i] == ' ')
 			continue;
 		if (line[i] != '\t')
@@ -218,8 +221,6 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		 * Now the rest of the line starts at "written".
 		 * The non-highlighted part ends at "trailing_whitespace".
 		 */
-		if (trailing_whitespace == -1)
-			trailing_whitespace = len;
 
 		/* Emit non-highlighted (middle) segment. */
 		if (trailing_whitespace - written > 0) {
-- 
1.7.3.1.211.g81fee.dirty
