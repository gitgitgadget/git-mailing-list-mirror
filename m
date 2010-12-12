From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Sun, 12 Dec 2010 13:32:54 +0100
Message-ID: <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 13:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRlNK-00041O-SQ
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 13:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0LLMt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 07:49:57 -0500
Received: from animux.de ([78.46.93.45]:33637 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0LLMtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 07:49:53 -0500
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 291F182E6003; Sun, 12 Dec 2010 13:33:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=7.0 tests=ALL_TRUSTED,AWL
	autolearn=disabled version=3.3.1
Received: from laptop (unknown [93.214.50.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 773F182E6003;
	Sun, 12 Dec 2010 12:33:19 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 12 Dec 2010 13:33:18 +0100
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163480>

call ssh-askpass only if the display environment variable is also set
---
 connect.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 57dc20c..2810e3b 100644
--- a/connect.c
+++ b/connect.c
@@ -621,7 +621,7 @@ int finish_connect(struct child_process *conn)
 
 char *git_getpass(const char *prompt)
 {
-	const char *askpass;
+	const char *askpass, *display;
 	struct child_process pass;
 	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
@@ -631,7 +631,10 @@ char *git_getpass(const char *prompt)
 		askpass = askpass_program;
 	if (!askpass)
 		askpass = getenv("SSH_ASKPASS");
-	if (!askpass || !(*askpass)) {
+
+	/* only call askpass if display is set */
+	display = getenv("DISPLAY");
+	if (!display || !(*display) || !askpass || !(*askpass))
 		char *result = getpass(prompt);
 		if (!result)
 			die_errno("Could not read password");
-- 
1.7.2.2
