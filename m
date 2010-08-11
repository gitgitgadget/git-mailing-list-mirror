From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5 v2] merge-recursive: porcelain messages for checkout
Date: Wed, 11 Aug 2010 10:38:05 +0200
Message-ID: <1281515888-31089-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8w4fse8w.fsf@bauges.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 11 10:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6un-0004m1-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab0HKInt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:43:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58587 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700Ab0HKIns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:43:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7B8a30e007453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:36:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6pT-00023D-Gr; Wed, 11 Aug 2010 10:38:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6pT-00086D-Fl; Wed, 11 Aug 2010 10:38:31 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpq8w4fse8w.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Aug 2010 10:36:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7B8a30e007453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1282120565.1807@vYdHk99sCxwIjjcv8CiMEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153212>

From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>

A porcelain message was first added in checkout.c in the commit
8ccba008 (Junio C Hamano, Sat May 17 21:03:49 2008, unpack-trees:
allow Porcelain to give different error messages) to give better feedback
in the case of merge errors.

This patch adapts the porcelain messages for the case of checkout
instead. This way, when having a checkout error, "merge" no longer
appears in the error message.

While we're there, we add an advice in the case of
would_lose_untracked_file.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 merge-recursive.c  |   31 ++++++++++++++++++++++---------
 merge-recursive.h  |    7 +++++--
 unpack-trees.c     |    5 ++---
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d1706e..22bf47c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -373,7 +373,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		topts.msgs[ERROR_NOT_UPTODATE_FILE] = "You have local changes to '%s'; cannot switch branches.";
+		set_porcelain_error_msgs(topts.msgs, "checkout");
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 115a288..de5a0f6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,7 +704,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
-	set_porcelain_error_msgs(opts.msgs);
+	set_porcelain_error_msgs(opts.msgs, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/merge-recursive.c b/merge-recursive.c
index d3bd963..b1e526b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -185,7 +185,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	set_porcelain_error_msgs(opts.msgs);
+	set_porcelain_error_msgs(opts.msgs, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1178,19 +1178,32 @@ static int process_entry(struct merge_options *o,
 	return clean_merge;
 }
 
-void set_porcelain_error_msgs(const char **msgs)
+void set_porcelain_error_msgs(const char **msgs, const char *cmd)
 {
+	const char *msg;
+	char *tmp;
+	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 	if (advice_commit_before_merge)
-		msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
-			"Please, commit your changes or stash them before you can merge.";
+		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.\n"
+			"Please, commit your changes or stash them before you can %s.";
 	else
-		msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-			"Your local changes to '%s' would be overwritten by merge.  Aborting.";
+		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
+	sprintf(tmp, msg, cmd, cmd2);
+	msgs[ERROR_WOULD_OVERWRITE] = tmp;
+	msgs[ERROR_NOT_UPTODATE_FILE] = tmp;
+
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		"Updating '%s' would lose untracked files in it.  Aborting.";
-	msgs[ERROR_WOULD_LOSE_UNTRACKED] =
-		"Untracked working tree file '%s' would be %s by merge.  Aborting";
+
+	if (advice_commit_before_merge)
+		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting"
+			"Please move or remove them before you can %s.";
+	else
+		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
+	sprintf(tmp, msg, cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED] = tmp;
 }
 
 int merge_trees(struct merge_options *o,
diff --git a/merge-recursive.h b/merge-recursive.h
index 8412db8..08f9850 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -23,8 +23,11 @@ struct merge_options {
 	struct string_list current_directory_set;
 };
 
-/* Sets the list of user-friendly error messages to be used by merge */
-void set_porcelain_error_msgs(const char **msgs);
+/*
+ * Sets the list of user-friendly error messages to be used by the
+ * command "cmd" (either merge or checkout)
+ */
+void set_porcelain_error_msgs(const char **msgs, const char *cmd);
 
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
diff --git a/unpack-trees.c b/unpack-trees.c
index 304e59a..e325831 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -13,9 +13,8 @@
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messages
  * and in fact are encouraged to reword them to better suit their particular
- * situation better.  See how "git checkout" replaces ERROR_NOT_UPTODATE_FILE to
- * explain why it does not allow switching between branches when you have
- * local changes, for example.
+ * situation better.  See how "git checkout" and "git merge" replaces
+ * them using set_porcelain_error_msgs(), for example.
  */
 const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
-- 
1.7.2.1.52.g95e25.dirty
