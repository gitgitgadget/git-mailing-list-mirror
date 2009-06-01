From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 03/11 v2] Work around a regression in Windows 7, causing erase_in_line() to crash sometimes
Date: Mon,  1 Jun 2009 08:04:16 +0200
Message-ID: <1243836256-11958-1-git-send-email-prohaska@zib.de>
References: <4A22C674.603@kdbg.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB0df-0004f3-UE
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 08:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbZFAGEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 02:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZFAGEn
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 02:04:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:61566 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbZFAGEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 02:04:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n5164Mib006427;
	Mon, 1 Jun 2009 08:04:27 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n5164GL2013260;
	Mon, 1 Jun 2009 08:04:16 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <4A22C674.603@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120444>

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

I squashed the second chunk of 05/11, as suggested by Hannes.

diff --git a/compat/winansi.c b/compat/winansi.c
index 44dc293..9217c24 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -80,6 +80,7 @@ static void set_console_attr(void)
 static void erase_in_line(void)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	DWORD dummy; /* Needed for Windows 7 (or Vista) regression */
 
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
