From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] Make reset_tree() in builtin-checkout.c a bit more
 library-ish
Date: Fri,  5 Dec 2008 17:54:12 -0800
Message-ID: <1228528455-3089-4-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
 <1228528455-3089-2-git-send-email-gitster@pobox.com>
 <1228528455-3089-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mOa-0005h5-O1
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbYLFBy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYLFBy2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbYLFBy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A1F084EF1
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 626C484EF0 for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:26 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D048073C-C338-11DD-8390-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102432>

The function demanded an internal structure "struct checkout_opts" as its
argument, but we'd want to split this (and one of its callers) out into a
separate library.  This makes what the function wants a bit more explicit
and much less dependent on the rest of builtin-checkout.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index c2c0561..d88fce2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -319,7 +319,7 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
+static int reset_tree(struct tree *tree, int quiet, int worktree, int *wt_error)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
@@ -331,14 +331,14 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet;
+	opts.verbose_update = !quiet;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
 	case -2:
-		o->writeout_error = 1;
+		*wt_error = 1;
 		/*
 		 * We return 0 nevertheless, as the index is all right
 		 * and more importantly we have made best efforts to
@@ -377,7 +377,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		return error("corrupt index file");
 
 	if (opts->force) {
-		ret = reset_tree(new->commit->tree, opts, 1);
+		ret = reset_tree(new->commit->tree, opts->quiet, 1,
+				 &opts->writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -446,14 +447,16 @@ static int merge_working_tree(struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(new->commit->tree, opts, 1);
+			ret = reset_tree(new->commit->tree, opts->quiet, 1,
+					 &opts->writeout_error);
 			if (ret)
 				return ret;
 			o.branch1 = new->name;
 			o.branch2 = "local";
 			merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
-			ret = reset_tree(new->commit->tree, opts, 0);
+			ret = reset_tree(new->commit->tree, opts->quiet, 0,
+					 &opts->writeout_error);
 			if (ret)
 				return ret;
 		}
-- 
1.6.1.rc1.72.ga5ce6
