From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] merge-recursive: make the error-message generation an extern function
Date: Sun, 29 Nov 2009 13:18:32 +0100
Message-ID: <1259497113-1393-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 13:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEik4-0003yO-Af
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 13:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbZK2MSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbZK2MSp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 07:18:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49680 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbZK2MSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 07:18:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nATCGkek024873
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 29 Nov 2009 13:16:46 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEiji-00089Q-0K; Sun, 29 Nov 2009 13:18:42 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEijh-0005J3-V9; Sun, 29 Nov 2009 13:18:41 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 29 Nov 2009 13:16:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nATCGkek024873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1260101807.01927@n4p5JBQhgBHxHMfIvMlmVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134017>

The construction of the struct unpack_trees_error_msgs was done within
git_merge_trees(), which prevented using the same messages easily from
another function.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 merge-recursive.c |   41 +++++++++++++++++++++++------------------
 merge-recursive.h |    3 +++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a91208f..70cd6cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -172,23 +172,6 @@ static int git_merge_trees(int index_only,
 	int rc;
 	struct tree_desc t[3];
 	struct unpack_trees_options opts;
-	struct unpack_trees_error_msgs msgs = {
-		/* would_overwrite */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
-		/* not_uptodate_file */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
-		/* not_uptodate_dir */
-		"Updating '%s' would lose untracked files in it.  Aborting.",
-		/* would_lose_untracked */
-		"Untracked working tree file '%s' would be %s by merge.  Aborting",
-		/* bind_overlap -- will not happen here */
-		NULL,
-	};
-	if (advice_commit_before_merge) {
-		msgs.would_overwrite = msgs.not_uptodate_file =
-			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
-			"Please, commit your changes or stash them before you can merge.";
-	}
 
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
@@ -200,7 +183,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	opts.msgs = msgs;
+	opts.msgs = get_porcelain_error_msgs();
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1188,6 +1171,28 @@ static int process_entry(struct merge_options *o,
 	return clean_merge;
 }
 
+struct unpack_trees_error_msgs get_porcelain_error_msgs()
+{
+	struct unpack_trees_error_msgs msgs = {
+		/* would_overwrite */
+		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
+		/* not_uptodate_file */
+		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
+		/* not_uptodate_dir */
+		"Updating '%s' would lose untracked files in it.  Aborting.",
+		/* would_lose_untracked */
+		"Untracked working tree file '%s' would be %s by merge.  Aborting",
+		/* bind_overlap -- will not happen here */
+		NULL,
+	};
+	if (advice_commit_before_merge) {
+		msgs.would_overwrite = msgs.not_uptodate_file =
+			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
+			"Please, commit your changes or stash them before you can merge.";
+	}
+	return msgs;
+}
+
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
diff --git a/merge-recursive.h b/merge-recursive.h
index fd138ca..f4b7f57 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -17,6 +17,9 @@ struct merge_options {
 	struct string_list current_directory_set;
 };
 
+/* Return a list of user-friendly error messages to be used by merge */
+struct unpack_trees_error_msgs get_porcelain_error_msgs();
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
1.6.5.3.435.g5f2e3.dirty
