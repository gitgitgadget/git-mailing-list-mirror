From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/2] push: remove "push.default is unset" warning message
Date: Thu, 25 Feb 2016 10:21:59 +0100
Message-ID: <1456392120-16298-2-git-send-email-Matthieu.Moy@imag.fr>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
 <1456392120-16298-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, philipoakley@iee.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 10:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYs7v-0005Gy-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214AbcBYJWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 04:22:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:56428 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760104AbcBYJWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 04:22:14 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9M2fI019962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 10:22:02 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9M2e8011904;
	Thu, 25 Feb 2016 10:22:02 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456392120-16298-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 10:22:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P9M2fI019962
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456996925.30278@oKjWcQuJw9GicHrQEM7KYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287354>

The warning was important before the 2.0 transition, and remained
important for a while after, so that new users get push.default
explicitly in their configuration and do not experience inconsistent
behavior if they ever used an older version of Git.

The warning has been there since version 1.8.0 (Oct 2012), hence we can
expect the vast majority of current Git users to have been exposed to
it, and most of them have already set push.default explicitly. The
switch from 'matching' to 'simple' was planned for 2.0 (May 2014), but
actually happened only for 2.3 (Feb 2015).

Today, the warning is mostly seen by beginners, who have not set their
push.default configuration (yet). For many of them, the warning is
confusing because it talks about concepts that they have not learned and
asks them a choice that they are not able to make yet. See for example

  http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0

(1260 votes for the question, 1824 for the answer as of writing)

Remove the warning completely to avoid disturbing beginners. People who
still occasionally use an older version of Git will be exposed to the
warning through this old version.

Eventually, versions of Git without the warning will be deployed enough
and tutorials will not need to advise setting push.default anymore.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/push.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 960ffc3..270db40 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,37 +204,6 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	add_refspec(branch->name);
 }
 
-static char warn_unspecified_push_default_msg[] =
-N_("push.default is unset; its implicit value has changed in\n"
-   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-   "and maintain the traditional behavior, use:\n"
-   "\n"
-   "  git config --global push.default matching\n"
-   "\n"
-   "To squelch this message and adopt the new behavior now, use:\n"
-   "\n"
-   "  git config --global push.default simple\n"
-   "\n"
-   "When push.default is set to 'matching', git will push local branches\n"
-   "to the remote branches that already exist with the same name.\n"
-   "\n"
-   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
-   "behavior, which only pushes the current branch to the corresponding\n"
-   "remote branch that 'git pull' uses to update the current branch.\n"
-   "\n"
-   "See 'git help config' and search for 'push.default' for further information.\n"
-   "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
-   "'current' instead of 'simple' if you sometimes use older versions of Git)");
-
-static void warn_unspecified_push_default_configuration(void)
-{
-	static int warn_once;
-
-	if (warn_once++)
-		return;
-	warning("%s\n", _(warn_unspecified_push_default_msg));
-}
-
 static int is_workflow_triangular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -253,9 +222,6 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_UNSPECIFIED:
-		warn_unspecified_push_default_configuration();
-		/* fallthru */
-
 	case PUSH_DEFAULT_SIMPLE:
 		if (triangular)
 			setup_push_current(remote, branch);
-- 
2.7.2.334.g35ed2ae.dirty
