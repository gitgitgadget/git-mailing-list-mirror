From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] checkout branch: prime cache-tree fully
Date: Mon, 20 Apr 2009 03:58:20 -0700
Message-ID: <1240225100-29960-5-git-send-email-gitster@pobox.com>
References: <1240225100-29960-1-git-send-email-gitster@pobox.com>
 <1240225100-29960-2-git-send-email-gitster@pobox.com>
 <1240225100-29960-3-git-send-email-gitster@pobox.com>
 <1240225100-29960-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrEO-0001Cx-T6
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbZDTK6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbZDTK6h
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:58:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbZDTK6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:58:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53B90ACF05
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B7DAFACF04 for
 <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.18.g66996
In-Reply-To: <1240225100-29960-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 314F792C-2D9A-11DE-B51E-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116969>

When switching to another branch, the earlier code relied on incremental
invalidation of cache-tree entries to degrade it.  While it is not wrong
per-se, we know that the resulting index must fully match the branch we
are switching to unless the -m (merge) option is used.

We should simply fully re-prime the cache-tree using the new tree object
in such a case.  And for safety, invalidate the cache-tree as a whole in
other cases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index ffdb33a..efa1ebf 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -368,14 +368,17 @@ static int merge_working_tree(struct checkout_opts *opts,
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 	int newfd = hold_locked_index(lock_file, 1);
+	int reprime_cache_tree = 0;
 
 	if (read_cache() < 0)
 		return error("corrupt index file");
 
+	cache_tree_free(&active_cache_tree);
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
+		reprime_cache_tree = 1;
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -411,7 +414,9 @@ static int merge_working_tree(struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
-		if (ret == -1) {
+		if (ret != -1) {
+			reprime_cache_tree = 1;
+		} else {
 			/*
 			 * Unpack couldn't do a trivial merge; either
 			 * give up or do a real merge, depending on
@@ -455,6 +460,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 	}
 
+	if (reprime_cache_tree)
+		prime_cache_tree(&active_cache_tree, new->commit->tree);
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die("unable to write new index file");
-- 
1.6.3.rc1.18.g66996
