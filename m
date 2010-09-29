From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/2] Make sure that git_getpass() never returns NULL
Date: Wed, 29 Sep 2010 23:22:32 +0100
Message-ID: <1285798953-15320-2-git-send-email-patthoyts@users.sourceforge.net>
References: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:23:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P153a-0006PL-7t
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab0I2WXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 18:23:17 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:57970 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674Ab0I2WXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 18:23:16 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P153S-0003eS-Ju; Wed, 29 Sep 2010 23:23:14 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P153L-0007J3-Eu; Wed, 29 Sep 2010 23:23:07 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2121626646; Wed, 29 Sep 2010 23:23:07 +0100 (BST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157614>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The result of git_getpass() is used without checking for NULL, so let's
just die() instead of returning NULL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 3450cab..57dc20c 100644
--- a/connect.c
+++ b/connect.c
@@ -631,8 +631,12 @@ char *git_getpass(const char *prompt)
 		askpass = askpass_program;
 	if (!askpass)
 		askpass = getenv("SSH_ASKPASS");
-	if (!askpass || !(*askpass))
-		return getpass(prompt);
+	if (!askpass || !(*askpass)) {
+		char *result = getpass(prompt);
+		if (!result)
+			die_errno("Could not read password");
+		return result;
+	}
 
 	args[0] = askpass;
 	args[1]	= prompt;
-- 
1.7.3
