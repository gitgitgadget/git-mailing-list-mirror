From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: start warning upcoming default change for push.default
Date: Sun, 24 Jun 2012 13:01:37 +0200
Message-ID: <1340535697-14556-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7v7guzqluh.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 24 13:02:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SikaQ-0006MN-27
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 13:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab2FXLBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 07:01:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36979 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab2FXLBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 07:01:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5OB17ZH010523
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2012 13:01:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SikZZ-000620-5d; Sun, 24 Jun 2012 13:01:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SikZZ-0003nR-2f; Sun, 24 Jun 2012 13:01:41 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <7v7guzqluh.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 24 Jun 2012 13:01:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5OB17ZH010523
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341140470.30877@4G2J4y4qyMIXOVucX25nVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200520>

In preparation for flipping the default to the "simple" mode from
the "matching" mode that is the historical default, start warning
users when they rely on unconfigured "git push" to default to the
"matching" mode.

Also, advertise for 'simple' where 'current' and 'upstream' are advised.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano <gitster@pobox.com> writes:

>>   (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
>>   'current' instead of 'simple' if you sometimes use older versions of Git)
>
> Yeah, that would work (the minority that need to pick 'current'
> cannot cut and paste, but that is not a big deal).
>
> As I did not butcher the version you sent me when I queued it with
> my rewrite, a follow-up patch to update it should be fairly minimal
> ;-)

Here it is.

 builtin/push.c       | 29 +++++++++++++++++++++++++++--
 t/t5541-http-push.sh |  5 ++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 08ccb89..9a0a035 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -147,12 +147,37 @@ static void setup_push_upstream(struct remote *remote, int simple)
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
+   "See 'git help config' and search for 'push.default' for further information.\n"
+   "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
+   "'current' instead of 'simple' if you sometimes use older versions of Git)");
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
@@ -186,8 +211,8 @@ static const char message_advice_pull_before_push[] =
 static const char message_advice_use_upstream[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you did not intend to push that branch, you may want to\n"
-	   "specify branches to push or set the 'push.default' configuration\n"
-	   "variable to 'current' or 'upstream' to push only the current branch.");
+	   "specify branches to push or set the 'push.default' configuration variable\n"
+	   "to 'simple', 'current' or 'upstream' to push only the current branch.");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 5b170be..07fa199 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -64,7 +64,10 @@ test_expect_success 'no empty path components' '
 
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
-	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
+	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
+	(
+		cd test_repo_clone && git config push.default matching
+	)
 '
 
 test_expect_success 'push to remote repository (standard)' '
-- 
1.7.11.5.g0c7e058.dirty
