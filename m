From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] diff-lib: refactor run_diff_index() and do_diff_cache()
Date: Tue, 19 Jul 2011 11:13:06 -0700
Message-ID: <1311099186-16482-3-git-send-email-gitster@pobox.com>
References: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
 <1311099186-16482-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 20:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjEnG-0001Vj-Hz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab1GSSNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:13:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab1GSSNM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0FA335F6
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RSDf
	0a6250qMskQev2EK0Eu7cWQ=; b=oLA+BaSia1GVTr1DcqpQEuXTwOI7Nx/eOm6A
	iNdtb/lepJ8ph95ozVZ28Zk+1/1yfUuWt5UsrYGCzfI+1axo2Eu36AsOQvwb0Ryi
	oETn3hWZ3pgHy13+cjmMbrW+KG/VliLWxyjZumXdQTFexeozI2O2ew1E+R/9y879
	xvjXAPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cGVRmP
	57/XigvPKJhD7L1zPlz8CqimEfwVG8e/Y7I6uIKFjoi66zbudhd0RARdEVirdk8u
	6/YkaYTthnLlPul+0jeL19aPMD43/s2wMyi6VNB/ZTrvxfgynSeuhQbxLmXdClW4
	V9liZJzIozh9zqi1tDUYRKQjNilrwPdSQjp5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C888135F5
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F7AD35F4 for
 <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.178.g55272
In-Reply-To: <1311099186-16482-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C31D2C0E-B232-11E0-B23D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177489>

The latter is meant to be an API for internal callers that want to inspect
the resulting diff-queue, while the former is an implementation of "git
diff-index" command. Extract the common logic into a single helper
function and make them thin wrappers around it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |   47 +++++++++++++++++++----------------------------
 1 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b5bb58d..c762655 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -440,20 +440,19 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 	return 0;
 }
 
-int run_diff_index(struct rev_info *revs, int cached)
+static int diff_cache(struct rev_info *revs,
+		      const unsigned char *tree_sha1,
+		      const char *tree_name,
+		      int cached)
 {
-	struct object *ent;
 	struct tree *tree;
-	const char *tree_name;
-	struct unpack_trees_options opts;
 	struct tree_desc t;
+	struct unpack_trees_options opts;
 
-	ent = revs->pending.objects[0].item;
-	tree_name = revs->pending.objects[0].name;
-	tree = parse_tree_indirect(ent->sha1);
+	tree = parse_tree_indirect(tree_sha1);
 	if (!tree)
-		return error("bad tree object %s", tree_name);
-
+		return error("bad tree object %s",
+			     tree_name ? tree_name : sha1_to_hex(tree_sha1));
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
@@ -466,7 +465,15 @@ int run_diff_index(struct rev_info *revs, int cached)
 	opts.dst_index = NULL;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
-	if (unpack_trees(1, &t, &opts))
+	return unpack_trees(1, &t, &opts);
+}
+
+int run_diff_index(struct rev_info *revs, int cached)
+{
+	struct object_array_entry *ent;
+
+	ent = revs->pending.objects;
+	if (diff_cache(revs, ent->item->sha1, ent->name, cached))
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
@@ -478,29 +485,13 @@ int run_diff_index(struct rev_info *revs, int cached)
 
 int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 {
-	struct tree *tree;
 	struct rev_info revs;
-	struct unpack_trees_options opts;
-	struct tree_desc t;
 
 	init_revisions(&revs, NULL);
 	init_pathspec(&revs.prune_data, opt->pathspec.raw);
-	tree = parse_tree_indirect(tree_sha1);
-	if (!tree)
-		die("bad tree object %s", sha1_to_hex(tree_sha1));
+	revs.diffopt = *opt;
 
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = 1;
-	opts.index_only = 1;
-	opts.diff_index_cached = !DIFF_OPT_TST(opt, FIND_COPIES_HARDER);
-	opts.merge = 1;
-	opts.fn = oneway_diff;
-	opts.unpack_data = &revs;
-	opts.src_index = &the_index;
-	opts.dst_index = NULL;
-
-	init_tree_desc(&t, tree->buffer, tree->size);
-	if (unpack_trees(1, &t, &opts))
+	if (diff_cache(&revs, tree_sha1, NULL, 1))
 		exit(128);
 	return 0;
 }
-- 
1.7.6.178.g55272
