From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 7/7] push: start warning upcoming default change for push.default
Date: Tue, 24 Apr 2012 09:50:06 +0200
Message-ID: <1335253806-9059-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 09:51:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMaWy-0002B7-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab2DXHvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 03:51:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49120 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605Ab2DXHvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:51:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3O7iBr7018731
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 09:44:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0007Jb-BL; Tue, 24 Apr 2012 09:50:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0002Np-9N; Tue, 24 Apr 2012 09:50:33 +0200
X-Mailer: git-send-email 1.7.10.234.g365b0
In-Reply-To: <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Apr 2012 09:44:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3O7iBr7018731
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335858256.2543@M9UBjOUUonQk6Hf809huOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196198>

In preparation for flipping the default to the "simple" mode from
the "matching" mode that is the historical default, start warning
users when they rely on unconfigured "git push" to default to the
"matching" mode.

Also, advertise for 'simple' where 'current' and 'upstream' are advised.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8e663db..be4525a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -146,12 +146,35 @@ static void setup_push_upstream(struct remote *remote, int simple)
 	add_refspec(refspec.buf);
 }
 
+static char warn_unspecified_push_default_msg[] =
+N_("push.default is unset; its implicit value is changing in\n"
+   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
+   "and maintain the current behavior after the default changes, use:\n"
+   "\n"
+   "  git config --global push.default matching\n"
+   "\n"
+   "To squelch this message and adopt the new behavior now, use:\n"
+   "\n"
+   "  git config --global push.default simple\n"
+   "\n"
+   "See 'git help config' and search for 'push.default' for further information.");
+
+static void warn_unspecified_push_default_configuration(void)
+{
+	static int warn_once;
+
+	if (warn_once++)
+		return;
+	warning("%s\n", _(warn_unspecified_push_default_msg));
+}
+
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 		default_matching_used = 1;
+		warn_unspecified_push_default_configuration();
 		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
@@ -185,8 +208,8 @@ static const char message_advice_pull_before_push[] =
 static const char message_advice_use_upstream[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you did not intend to push that branch, you may want to\n"
-	   "specify branches to push or set the 'push.default' configuration\n"
-	   "variable to 'current' or 'upstream' to push only the current branch.");
+	   "specify branches to push or set the 'push.default' configuration variable\n"
+	   "to 'simple', 'current' or 'upstream' to push only the current branch.");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-- 
1.7.10.234.g365b0
