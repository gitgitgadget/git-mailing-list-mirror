From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] diff-lib: simplify do_diff_cache()
Date: Tue, 19 Jul 2011 11:13:05 -0700
Message-ID: <1311099186-16482-2-git-send-email-gitster@pobox.com>
References: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
 <1311099186-16482-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 20:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjEnF-0001Vj-W5
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab1GSSNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:13:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab1GSSNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6B9635F0
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4nmC
	xZM/JIbXh8VJC1M378Ih9CA=; b=detk3xZB79NKhKv4B07lHNkWMQ7NmiJk+6/K
	wZGL/4aaIJOnZXZPiW8Ely+7f8r1IYsAMewQ5GR8I1vZfP/xheooakinKvjR1sS/
	8LwX+1ex+uPfrwyt6ScsqmZJg8NnmcLx0OibqMjkctsrTbfKFhjJEVyA0RtmngCK
	IyzMkms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tG34lr
	21FMmzxLNGgQewQirVMJuVOHUVtwlHI9BfI7UL+LDcZ8M6huk/p5OXeDsfNHsNMJ
	UUWSMfXoT4cPR/b1qo7GqVr7zy4tSiKLWzLpL/P7Kyfbcpsjsolk7Ly3TaMUs4EC
	lIZcU3Gvuctc2cLC6Wwr+5MDvV7qYlEiQ406s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEC9535EF
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7177335EE for
 <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.178.g55272
In-Reply-To: <1311099186-16482-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C20B1E70-B232-11E0-9090-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177490>

Since 34110cd (Make 'unpack_trees()' have a separate source and
destination index, 2008-03-06), we can run unpack_trees() without munging
the index at all, but do_diff_cache() tried ever so carefully to work
around the old behaviour of the function.

We can just tell unpack_trees() not to touch the original index and there
is no need to clean-up whatever the previous round has done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index fd61acb..b5bb58d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -480,33 +480,9 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 {
 	struct tree *tree;
 	struct rev_info revs;
-	int i;
-	struct cache_entry **dst;
-	struct cache_entry *last = NULL;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
 
-	/*
-	 * This is used by git-blame to run diff-cache internally;
-	 * it potentially needs to repeatedly run this, so we will
-	 * start by removing the higher order entries the last round
-	 * left behind.
-	 */
-	dst = active_cache;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce)) {
-			if (last && !strcmp(ce->name, last->name))
-				continue;
-			cache_tree_invalidate_path(active_cache_tree,
-						   ce->name);
-			last = ce;
-			ce->ce_flags |= CE_REMOVE;
-		}
-		*dst++ = ce;
-	}
-	active_nr = dst - active_cache;
-
 	init_revisions(&revs, NULL);
 	init_pathspec(&revs.prune_data, opt->pathspec.raw);
 	tree = parse_tree_indirect(tree_sha1);
@@ -521,7 +497,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	opts.fn = oneway_diff;
 	opts.unpack_data = &revs;
 	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
+	opts.dst_index = NULL;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
-- 
1.7.6.178.g55272
