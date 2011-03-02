From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 v3] push: better error messages when push.default = tracking
Date: Wed,  2 Mar 2011 21:12:10 +0100
Message-ID: <1299096731-14194-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vhbbmellx.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 02 21:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PusPS-00006g-5a
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab1CBUM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 15:12:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36022 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab1CBUM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 15:12:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p22KCEeu029745
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Mar 2011 21:12:14 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PusPA-0004MZ-Vn; Wed, 02 Mar 2011 21:12:17 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PusPA-0003hi-Tr; Wed, 02 Mar 2011 21:12:16 +0100
X-Mailer: git-send-email 1.7.4.1.176.g6b069.dirty
In-Reply-To: <7vhbbmellx.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Mar 2011 21:12:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p22KCEeu029745
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1299701539.57954@ZfxTa2VF8rSlwCQm6JdFOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168336>

A common scenario is to create a new branch and push it (checkout -b &&
push [--set-upstream]). In this case, the user was getting "The current
branch %s has no upstream branch.", which doesn't help much.

Provide the user a command to push the current branch. To avoid the
situation in the future, suggest --set-upstream.

While we're there, also improve the error message in the "detached HEAD"
case. We mention explicitly "detached HEAD" since this is the keyword to
look for in documentations.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

I applied Junio's suggestion to suggest pushing HEAD in detached HEAD
state. I don't care very much either way indeed (and I didn't want to
make the message too heavy, just give the user a way to do something).

hope that's OK for inclusion.

 builtin/push.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 31da418..1b493fb 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -64,14 +64,24 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static void setup_push_upstream(void)
+static void setup_push_upstream(struct remote *remote)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
-		die("You are not currently on a branch.");
+		die("You are not currently on a branch.\n"
+		    "To push the history leading to the current (detached HEAD)\n"
+		    "state now, use\n"
+		    "\n"
+		    "    git push %s HEAD:<name-of-remote-branch>\n",
+		    remote->name);
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
@@ -80,7 +90,7 @@ static void setup_push_upstream(void)
 	add_refspec(refspec.buf);
 }
 
-static void setup_default_push_refspecs(void)
+static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
@@ -89,7 +99,7 @@ static void setup_default_push_refspecs(void)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream();
+		setup_push_upstream(remote);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
@@ -175,7 +185,7 @@ static int do_push(const char *repo, int flags)
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs();
+			setup_default_push_refspecs(remote);
 	}
 	errs = 0;
 	if (remote->pushurl_nr) {
-- 
1.7.4.1.176.g6b069.dirty
