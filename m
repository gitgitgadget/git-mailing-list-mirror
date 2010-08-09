From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5] merge-recursive: porcelain messages for checkout
Date: Mon,  9 Aug 2010 16:19:59 +0200
Message-ID: <1281363602-27856-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 16:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTDz-0002me-L9
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab0HIOUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:20:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46115 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756340Ab0HIOUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:20:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o79EHlms001051
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 16:17:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD0-0006QV-E3; Mon, 09 Aug 2010 16:20:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD0-0008OY-D2; Mon, 09 Aug 2010 16:20:10 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 16:17:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79EHlms001051
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281968270.10154@WC/MGNfFpAyGPkuE+bekcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152967>

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
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8854aab..22bf47c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -373,7 +373,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		topts.msgs[not_uptodate_file] = "You have local changes to '%s'; cannot switch branches.";
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
index 755f530..bd26497 100644
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
-		msgs[would_overwrite] = msgs[not_uptodate_file] =
-			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
-			"Please, commit your changes or stash them before you can merge.";
+		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.\n"
+			"Please, commit your changes or stash them before you can %s.";
 	else
-		msgs[would_overwrite] = msgs[not_uptodate_file] =
-			"Your local changes to '%s' would be overwritten by merge.  Aborting.";
+		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
+	sprintf(tmp, msg, cmd, cmd2);
+	msgs[would_overwrite] = tmp;
+	msgs[not_uptodate_file] = tmp;
+
 	msgs[not_uptodate_dir] =
 		"Updating '%s' would lose untracked files in it.  Aborting.";
-	msgs[would_lose_untracked_file] =
-		"Untracked working tree file '%s' would be %s by merge.  Aborting";
+
+	if (advice_commit_before_merge)
+		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting"
+			"Please move or remove them before you can %s.";
+	else
+		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
+	sprintf(tmp, msg, cmd, cmd2);
+	msgs[would_lose_untracked_file] = tmp;
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
-- 
1.7.2.1.52.g95e25.dirty
