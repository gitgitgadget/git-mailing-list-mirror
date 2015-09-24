From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] branch: handle errors on setting tracking branches
Date: Thu, 24 Sep 2015 12:32:01 +0200
Message-ID: <1443090721-14519-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 12:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf3p8-0000Y9-33
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 12:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbIXKcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 06:32:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55927 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900AbbIXKcO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2015 06:32:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 80D2A20712
	for <git@vger.kernel.org>; Thu, 24 Sep 2015 06:32:13 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 24 Sep 2015 06:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=rKMHELa/NKw09uxH8YUYbwj5LI
	Q=; b=KQwfq6cV0StPepN2qde0RBWa8MNVNComDGt1ynHLlIKsDFZHuPI/DW6xVk
	xJ6+JCnbw1Q/SGVFb6oAw2RfW6r0rclanNeDe4UDzSRXLLSGmm4Zi4BNFT2PZR6Y
	bLQrYf4WB534DFqEbPPf6yxcYt34Wu1EgDA+JFi9RaJJeSKrs=
X-Sasl-enc: cNsWu93atHfaSeeDpcUJpxwEDMKmsi/t6XlIZynnqAlo 1443090733
Received: from localhost (x55b3b82f.dyn.telefonica.de [85.179.184.47])
	by mail.messagingengine.com (Postfix) with ESMTPA id 101DE6801CB;
	Thu, 24 Sep 2015 06:32:12 -0400 (EDT)
X-Mailer: git-send-email 2.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278544>

The function `install_branch_config`, which is used to set up
tracking branches, does not verify return codes of
`git_config_set`. Due to this we may incorrectly print that a
tracking branch has been set up when in fact we did not due to an
error.

Fix this by checking the return value of `git_config_set` and
returning early in the case of an error. The
`install_branch_config` function has been changed to return an
error code that reflects whether it has been successful.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've run into this issue when a stale config.lock has been left:

> git branch --set-upstream-to=origin/next
error: could not lock config file /path/to/repo/git/config: File exists
error: could not lock config file /path/to/repo/git/config: File exists
Branch next set up to track remote branch next from origin.

While we spit out some errors, we still claim that we set up the
tracking branch correctly, which is not the case.

Actually, there are quite a few places where we don't check the
return values of git_config_set and related functions. I didn't
go through them yet, but might do so if you deem this to be of
value.

 branch.c | 24 ++++++++++++++++--------
 branch.h |  3 ++-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/branch.c b/branch.c
index d013374..5ab3ad4 100644
--- a/branch.c
+++ b/branch.c
@@ -48,22 +48,24 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
-	int rebasing = should_setup_rebase(origin);
+	int ret = 0, rebasing = should_setup_rebase(origin);
 
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
 			local);
-		return;
+		return ret;
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	ret = git_config_set(key.buf, origin ? origin : ".");
+	if (ret)
+		goto out;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
@@ -72,9 +74,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		ret = git_config_set(key.buf, "true");
+		if (ret)
+			goto out;
 	}
-	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (shortname) {
@@ -101,6 +104,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 					  local, remote);
 		}
 	}
+
+out:
+	strbuf_release(&key);
+	return ret;
 }
 
 /*
@@ -133,8 +140,9 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error(_("Not tracking: ambiguous information for ref %s"),
 				orig_ref);
 
-	install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref);
+	if (install_branch_config(config_flags, new_ref, tracking.remote,
+				  tracking.src ? tracking.src : orig_ref))
+		return error(_("Could not setup tracking branch"));
 
 	free(tracking.src);
 	return 0;
diff --git a/branch.h b/branch.h
index d3446ed..d287884 100644
--- a/branch.h
+++ b/branch.h
@@ -43,9 +43,10 @@ void remove_branch_state(void);
 /*
  * Configure local branch "local" as downstream to branch "remote"
  * from remote "origin".  Used by git branch --set-upstream.
+ * Returns zero on success, non-zero otherwise.
  */
 #define BRANCH_CONFIG_VERBOSE 01
-extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+extern int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
 /*
  * Read branch description
-- 
2.5.3
