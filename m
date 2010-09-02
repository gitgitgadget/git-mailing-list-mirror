From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] setup_unpack_trees_porcelain: take the whole options struct as parameter
Date: Thu,  2 Sep 2010 13:57:34 +0200
Message-ID: <1283428655-12680-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
Cc: Jim Meyering <jim@meyering.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 02 13:58:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or8RH-0007J4-I5
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 13:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0IBL6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 07:58:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44938 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab0IBL6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 07:58:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o82BjgYi015468
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 13:45:43 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QG-0006mr-Aw; Thu, 02 Sep 2010 13:57:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QG-0003Jk-9g; Thu, 02 Sep 2010 13:57:40 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpq39ttxumz.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Sep 2010 13:45:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o82BjgYi015468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1284032746.37215@e1wuX60X+B3BnggYU6KzQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155123>

This is a preparation patch to let setup_unpack_trees_porcelain set
show_all_errors itself.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 merge-recursive.c  |    2 +-
 unpack-trees.c     |    4 +++-
 unpack-trees.h     |    3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e5c0ef0..b26dfd0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -376,7 +376,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		setup_unpack_trees_porcelain(topts.msgs, "checkout");
+		setup_unpack_trees_porcelain(&topts, "checkout");
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index da52b10..389e79c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -706,7 +706,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.merge = 1;
 	opts.fn = twoway_merge;
 	opts.show_all_errors = 1;
-	setup_unpack_trees_porcelain(opts.msgs, "merge");
+	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/merge-recursive.c b/merge-recursive.c
index 61e237b..ebe6700 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -180,7 +180,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	setup_unpack_trees_porcelain(opts.msgs, "merge");
+	setup_unpack_trees_porcelain(&opts, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
diff --git a/unpack-trees.c b/unpack-trees.c
index 4520aa0..17501d3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -50,8 +50,10 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
-void setup_unpack_trees_porcelain(const char **msgs, const char *cmd)
+void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
+				  const char *cmd)
 {
+	const char **msgs = opts->msgs;
 	const char *msg;
 	char *tmp;
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
diff --git a/unpack-trees.h b/unpack-trees.h
index d62bba9..fad680d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,7 +26,8 @@ enum unpack_trees_error_types {
  * Sets the list of user-friendly error messages to be used by the
  * command "cmd" (either merge or checkout)
  */
-void setup_unpack_trees_porcelain(const char **msgs, const char *cmd);
+void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
+				  const char *cmd);
 
 struct rejected_paths_list {
 	char *path;
-- 
1.7.2.2.175.ga619d.dirty
