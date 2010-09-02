From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] Move "show_all_errors = 1" to setup_unpack_trees_porcelain()
Date: Thu,  2 Sep 2010 13:57:35 +0200
Message-ID: <1283428655-12680-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
Cc: Jim Meyering <jim@meyering.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 02 13:59:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or8Rh-0007Ye-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 13:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0IBL7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 07:59:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60053 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576Ab0IBL7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 07:59:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o82Bs75r002019
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 13:54:07 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QK-0006nt-29; Thu, 02 Sep 2010 13:57:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QK-0003Jn-0u; Thu, 02 Sep 2010 13:57:44 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpq39ttxumz.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Sep 2010 13:54:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o82Bs75r002019
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1284033247.88373@p0XUs4TngRIipWnX3Qp+SA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155125>

Not only this makes the code clearer since setting up the porcelain error
message is meant to work with show_all_errors, but this fixes a call to
setup_unpack_trees_porcelain() in git_merge_trees() which did not set
show_all_errors.

add_rejected_path() used to double-check whether it was running in
plumbing mode. This check was inefficient since it was setting
show_all_errors too late for traverse_trees() to see it, and is made
useless by this patch. Remove it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    1 -
 builtin/merge.c    |    1 -
 unpack-trees.c     |    8 ++------
 unpack-trees.h     |    2 +-
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b26dfd0..1532669 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -395,7 +395,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
-		topts.show_all_errors = 1;
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/merge.c b/builtin/merge.c
index 389e79c..bfd3d32 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -705,7 +705,6 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
-	opts.show_all_errors = 1;
 	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
diff --git a/unpack-trees.c b/unpack-trees.c
index 17501d3..803445a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -94,6 +94,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		"The following Working tree files would be removed by sparse checkout update:\n%s";
+
+	opts->show_all_errors = 1;
 }
 
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -123,12 +125,6 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     const char *path)
 {
 	struct rejected_paths_list *newentry;
-	int porcelain = o && (o)->msgs[e];
-	/*
-	 * simply display the given error message if in plumbing mode
-	 */
-	if (!porcelain)
-		o->show_all_errors = 0;
 	if (!o->show_all_errors)
 		return error(ERRORMSG(o, e), path);
 
diff --git a/unpack-trees.h b/unpack-trees.h
index fad680d..7c0187d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -24,7 +24,7 @@ enum unpack_trees_error_types {
 
 /*
  * Sets the list of user-friendly error messages to be used by the
- * command "cmd" (either merge or checkout)
+ * command "cmd" (either merge or checkout), and show_all_errors to 1.
  */
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
-- 
1.7.2.2.175.ga619d.dirty
