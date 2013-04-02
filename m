From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] branch: give advice when tracking start-point is missing
Date: Tue, 2 Apr 2013 15:05:12 -0400
Message-ID: <20130402190512.GE32316@sigill.intra.peff.net>
References: <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Wi-0007lk-1K
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028Ab3DBTFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:05:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932991Ab3DBTFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:05:16 -0400
Received: (qmail 13127 invoked by uid 107); 2 Apr 2013 19:07:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:07:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:05:12 -0400
Content-Disposition: inline
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219848>

If the user requests to --set-upstream-to a branch that does
not exist, then either:

  1. It was a typo.

  2. They thought the branch should exist.

In case (1), there is not much we can do beyond showing the
name we tried to use. For case (2), though, we can help to
guide them through common workflows.

Signed-off-by: Jeff King <peff@peff.net>
---
 advice.c |  2 ++
 advice.h |  1 +
 branch.c | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 3bc8626..a8deee6 100644
--- a/advice.c
+++ b/advice.c
@@ -13,6 +13,7 @@ int advice_detached_head = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
+int advice_set_upstream_failure = 1;
 
 static struct {
 	const char *name;
@@ -31,6 +32,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "setupstreamfailure", &advice_set_upstream_failure },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index af0c983..94caa32 100644
--- a/advice.h
+++ b/advice.h
@@ -16,6 +16,7 @@ extern int advice_detached_head;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_set_upstream_failure;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/branch.c b/branch.c
index d6f4001..6ae6a4c 100644
--- a/branch.c
+++ b/branch.c
@@ -200,7 +200,16 @@ static const char upstream_missing[] =
 static const char upstream_not_branch[] =
 N_("Cannot setup tracking information; starting point '%s' is not a branch.");
 static const char upstream_missing[] =
-N_("Cannot setup tracking information; starting point '%s' does not exist");
+N_("the requested upstream branch '%s' does not exist");
+static const char upstream_advice[] =
+N_("\n"
+"If you are planning on basing your work on an upstream\n"
+"branch that already exists at the remote, you may need to\n"
+"run \"git fetch\" to retrieve it.\n"
+"\n"
+"If you are planning to push out a new local branch that\n"
+"will track its remote counterpart, you may want to use\n"
+"\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
@@ -230,8 +239,14 @@ void create_branch(const char *head,
 
 	real_ref = NULL;
 	if (get_sha1(start_name, sha1)) {
-		if (explicit_tracking)
+		if (explicit_tracking) {
+			if (advice_set_upstream_failure) {
+				error(_(upstream_missing), start_name);
+				advise(_(upstream_advice));
+				exit(1);
+			}
 			die(_(upstream_missing), start_name);
+		}
 		die("Not a valid object name: '%s'.", start_name);
 	}
 
-- 
1.8.2.rc0.33.gd915649
