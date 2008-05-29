From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] checkout: "best effort" checkout
Date: Wed, 28 May 2008 17:17:25 -0700
Message-ID: <1212020246-26480-6-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
 <1212020246-26480-3-git-send-email-gitster@pobox.com>
 <1212020246-26480-4-git-send-email-gitster@pobox.com>
 <1212020246-26480-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VrC-0004LH-MH
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYE2ASJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYE2ASJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:18:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbYE2ASH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:18:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF5452B63
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D00292B62 for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:03 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B585BB7A-2D14-11DD-9C5D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83159>

When unpack_trees() returned an error while switching branches, we used to
stop right there, exiting without writing the index out or switching HEAD.

This is Ok when unpack_trees() detected a locally modified paths or
untracked files that could be overwritten by branch switching, but it is
undesirable if unpack_trees() already committed to update the work tree
and a failure is returned because some but not all paths are updated
(perhaps a directory that some files need to go in was made read-only by
mistake, or a file that will be overwritten by branch switching had a
mandatory lock on it and we could not unlink).

This changes the behaviour upon such an error to complete the branch
switching; the files updated in the work tree will hopefully much more
consistent with the index and HEAD derived from the switched-to branch.

We still issue error messages, and exit the command with non-zero status,
so scripted callers need to notice it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9af5197..93ea69b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -155,6 +155,7 @@ struct checkout_opts {
 	int quiet;
 	int merge;
 	int force;
+	int writeout_error;
 
 	char *new_branch;
 	int new_branch_log;
@@ -178,9 +179,20 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.dst_index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
-	if (unpack_trees(1, &tree_desc, &opts))
+	switch (unpack_trees(1, &tree_desc, &opts)) {
+	case -2:
+		o->writeout_error = 1;
+		/*
+		 * We return 0 nevertheless, as the index is all right
+		 * and more importantly we have made best efforts to
+		 * update paths in the work tree, and we cannot revert
+		 * them.
+		 */
+	case 0:
+		return 0;
+	default:
 		return 128;
-	return 0;
+	}
 }
 
 struct branch_info {
@@ -243,7 +255,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		tree = parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
-		if (unpack_trees(2, trees, &topts)) {
+		ret = unpack_trees(2, trees, &topts);
+		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
 			 * give up or do a real merge, depending on
@@ -478,7 +491,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 
 	update_refs_for_switch(opts, &old, new);
 
-	return post_checkout_hook(old.commit, new->commit, 1);
+	ret = post_checkout_hook(old.commit, new->commit, 1);
+	return ret || opts->writeout_error;
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
-- 
1.5.6.rc0.43.g823ea
