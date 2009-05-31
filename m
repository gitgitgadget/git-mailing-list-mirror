From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 03/11] Work around a regression in Windows 7, causing erase_in_line() to crash sometimes
Date: Sun, 31 May 2009 18:15:17 +0200
Message-ID: <1243786525-4493-4-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnhn-0001VR-Ib
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838AbZEaQQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbZEaQQH
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:07 -0400
Received: from mailer.zib.de ([130.73.108.11]:58616 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZEaQQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFVT2006796;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVA021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120407>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The function FillConsoleOutputCharacterA() was pretty content in XP to take a NULL
pointer if we did not want to store the number of written columns.  In Windows 7,
it crashes, but only when called from within Git Bash, not from within cmd.exe.
Go figure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/winansi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 44dc293..4bee335 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -80,6 +80,7 @@ static void set_console_attr(void)
 static void erase_in_line(void)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	long dummy; /* Needed for Windows 7 (or Vista) regression */
 
 	if (!console)
 		return;
@@ -87,7 +88,7 @@ static void erase_in_line(void)
 	GetConsoleScreenBufferInfo(console, &sbi);
 	FillConsoleOutputCharacterA(console, ' ',
 		sbi.dwSize.X - sbi.dwCursorPosition.X, sbi.dwCursorPosition,
-		NULL);
+		&dummy);
 }
 
 
-- 
1.6.3.1.54.g99dd
