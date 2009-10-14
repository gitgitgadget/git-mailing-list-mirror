From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 17:45:25 +1300
Message-ID: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: elliot@catalyst.net.nz, Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 07:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw2M-0003iP-G3
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbZJNE5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbZJNE5I
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:57:08 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:36997 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZJNE5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:57:07 -0400
X-Greylist: delayed 653 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 00:57:07 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 3A2E732317;
	Wed, 14 Oct 2009 17:45:35 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bA1JBX-YtE2Q; Wed, 14 Oct 2009 17:45:34 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id BCCBD321F7;
	Wed, 14 Oct 2009 17:45:34 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130243>

Add a simple hook that will run before checkouts.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/githooks.txt |   20 +++++++++++++++-----
 builtin-checkout.c         |   25 ++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 06e0f31..8dc3fbf 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -143,21 +143,31 @@ pre-rebase
 This hook is called by 'git-rebase' and can be used to prevent a branch
 from getting rebased.
 
+pre-checkout
+-----------
 
-post-checkout
-~~~~~~~~~~~~~
-
-This hook is invoked when a 'git-checkout' is run after having updated the
+This hook is invoked when a 'git-checkout' is run after before updating the
 worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of 'git-checkout'.
+This hook can prevent the checkout from proceeding by exiting with an
+error code.
 
 It is also run after 'git-clone', unless the --no-checkout (-n) option is
 used. The first parameter given to the hook is the null-ref, the second the
 ref of the new HEAD and the flag is always 1.
 
+This hook can be used to perform any clean-up deemed necessary before
+checking out the new branch/files.
+
+post-checkout
+-----------
+
+This hook is invoked when a 'git-checkout' is run after having updated the
+worktree.  It takes the same arguments as the 'pre-checkout' hook.
+This hook cannot affect the outcome of 'git-checkout'.
+
 This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..b72a3cb 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -36,6 +36,17 @@ struct checkout_opts {
 	enum branch_track track;
 };
 
+static int pre_checkout_hook(struct commit *old, struct commit *new,
+			      int changed)
+{
+	return run_hook(NULL, "pre-checkout",
+			sha1_to_hex(old ? old->object.sha1 : null_sha1),
+			sha1_to_hex(new ? new->object.sha1 : null_sha1),
+			changed ? "1" : "0", NULL);
+	/* "new" can be NULL when checking out from the index before
+	   a commit exists. */
+}
+
 static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
@@ -256,6 +267,13 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	if (errs)
 		return 1;
 
+	/* Run the pre-checkout hook */
+	resolve_ref("HEAD", rev, 0, &flag);
+	head = lookup_commit_reference_gently(rev, 1);
+	errs = pre_checkout_hook(head, head, 0);
+	if (errs)
+		return 1;
+
 	/* Now we are committed to check them out */
 	memset(&state, 0, sizeof(state));
 	state.force = 1;
@@ -279,9 +297,6 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	    commit_locked_index(lock_file))
 		die("unable to write new index file");
 
-	resolve_ref("HEAD", rev, 0, &flag);
-	head = lookup_commit_reference_gently(rev, 1);
-
 	errs |= post_checkout_hook(head, head, 0);
 	return errs;
 }
@@ -543,6 +558,10 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
 
+	ret = pre_checkout_hook(old.commit, new->commit, 1);
+	if (ret)
+		return ret;
+
 	ret = merge_working_tree(opts, &old, new);
 	if (ret)
 		return ret;
-- 
1.6.3.3
