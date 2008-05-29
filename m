From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] checkout: consolidate reset_{to_new,clean_to_new|()
Date: Wed, 28 May 2008 17:17:23 -0700
Message-ID: <1212020246-26480-4-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
 <1212020246-26480-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:18:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Vr1-0004Hm-0B
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYE2ARz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYE2ARz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:17:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYE2ARy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:17:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5692224F9
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6847224F8 for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:51 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AE093E30-2D14-11DD-B6AF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83158>

These two were very similar functions with only tiny bit of difference.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This may be a bit hard to read but "struct checkout_opts" is moved up
   at the same time as it is passed to the consolidated function as its
   parameter.

 builtin-checkout.c |   50 +++++++++++++++-----------------------------------
 1 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index cc97724..9af5197 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -151,39 +151,29 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_to_new(struct tree *tree, int quiet)
-{
-	struct unpack_trees_options opts;
-	struct tree_desc tree_desc;
-
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = -1;
-	opts.update = 1;
-	opts.reset = 1;
-	opts.merge = 1;
-	opts.fn = oneway_merge;
-	opts.verbose_update = !quiet;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	parse_tree(tree);
-	init_tree_desc(&tree_desc, tree->buffer, tree->size);
-	if (unpack_trees(1, &tree_desc, &opts))
-		return 128;
-	return 0;
-}
+struct checkout_opts {
+	int quiet;
+	int merge;
+	int force;
+
+	char *new_branch;
+	int new_branch_log;
+	enum branch_track track;
+};
 
-static int reset_clean_to_new(struct tree *tree, int quiet)
+static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
-	opts.skip_unmerged = 1;
+	opts.update = worktree;
+	opts.skip_unmerged = !worktree;
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !quiet;
+	opts.verbose_update = !o->quiet;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -193,16 +183,6 @@ static int reset_clean_to_new(struct tree *tree, int quiet)
 	return 0;
 }
 
-struct checkout_opts {
-	int quiet;
-	int merge;
-	int force;
-
-	char *new_branch;
-	int new_branch_log;
-	enum branch_track track;
-};
-
 struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
@@ -227,7 +207,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	read_cache();
 
 	if (opts->force) {
-		ret = reset_to_new(new->commit->tree, opts->quiet);
+		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
 	} else {
@@ -291,12 +271,12 @@ static int merge_working_tree(struct checkout_opts *opts,
 			add_files_to_cache(NULL, NULL, 0);
 			work = write_tree_from_memory();
 
-			ret = reset_to_new(new->commit->tree, opts->quiet);
+			ret = reset_tree(new->commit->tree, opts, 1);
 			if (ret)
 				return ret;
 			merge_trees(new->commit->tree, work, old->commit->tree,
 				    new->name, "local", &result);
-			ret = reset_clean_to_new(new->commit->tree, opts->quiet);
+			ret = reset_tree(new->commit->tree, opts, 0);
 			if (ret)
 				return ret;
 		}
-- 
1.5.6.rc0.43.g823ea
