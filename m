From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] push: better error message when push.default = tracking
Date: Mon, 28 Feb 2011 22:14:04 +0100
Message-ID: <1298927645-2716-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 28 22:21:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAWu-0001BO-Ac
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab1B1VVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:21:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53536 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab1B1VVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:21:13 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Feb 2011 16:21:13 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1SLECGd015991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Feb 2011 22:14:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PuAQ1-0000Nk-ST; Mon, 28 Feb 2011 22:14:13 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PuAQ1-0000lO-RV; Mon, 28 Feb 2011 22:14:13 +0100
X-Mailer: git-send-email 1.7.4.1.142.g43604.dirty
In-Reply-To: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Feb 2011 22:14:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1SLECGd015991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1299532454.00842@RHunmI5Cu21hgkC0MgAKFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168147>

A common scenario is to create a new branch and push it (checkout -b &&
push [--set-upstream]). In this case, the user was getting "The current
branch %s has no upstream branch.", which doesn't help much.

Provide the user a command to push the current branch. To avoid the
situation in the future, suggest --set-upstream.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/push.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 31da418..210eb36 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -64,14 +64,19 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static void setup_push_upstream(void)
+static void setup_push_upstream(struct remote *remote)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
 		die("You are not currently on a branch.");
 	if (!branch->merge_nr || !branch->merge)
-		die("The current branch %s has no upstream branch.",
+		die("The current branch %s has no upstream branch.\n"
+		    "To push the current branch and set the remote as upstream, use\n"
+		    "\n"
+		    "    git push --set-upstream %s %s\n",
+		    branch->name,
+		    remote->name,
 		    branch->name);
 	if (branch->merge_nr != 1)
 		die("The current branch %s has multiple upstream branches, "
@@ -80,7 +85,7 @@ static void setup_push_upstream(void)
 	add_refspec(refspec.buf);
 }
 
-static void setup_default_push_refspecs(void)
+static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
@@ -89,7 +94,7 @@ static void setup_default_push_refspecs(void)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream();
+		setup_push_upstream(remote);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
@@ -175,7 +180,7 @@ static int do_push(const char *repo, int flags)
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs();
+			setup_default_push_refspecs(remote);
 	}
 	errs = 0;
 	if (remote->pushurl_nr) {
-- 
1.7.4.1.142.g43604.dirty
