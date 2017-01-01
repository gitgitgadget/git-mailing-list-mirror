Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8CA1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbdAATTn (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:19:43 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53808 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932183AbdAATTl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:41 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1A174280B2;
        Sun,  1 Jan 2017 19:19:40 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/17] builtin/clone: convert to struct object_id
Date:   Sun,  1 Jan 2017 19:18:38 +0000
Message-Id: <20170101191847.564741-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ef81927a..e0916e5f3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -681,7 +681,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int checkout(int submodule_progress)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *head;
 	struct lock_file *lock_file;
 	struct unpack_trees_options opts;
@@ -692,7 +692,7 @@ static int checkout(int submodule_progress)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, oid.hash, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
@@ -700,7 +700,7 @@ static int checkout(int submodule_progress)
 	}
 	if (!strcmp(head, "HEAD")) {
 		if (advice_detached_head)
-			detach_advice(sha1_to_hex(sha1));
+			detach_advice(oid_to_hex(&oid));
 	} else {
 		if (!starts_with(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
@@ -721,7 +721,7 @@ static int checkout(int submodule_progress)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid.hash);
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)
@@ -731,7 +731,7 @@ static int checkout(int submodule_progress)
 		die(_("unable to write new index file"));
 
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
-			   sha1_to_hex(sha1), "1", NULL);
+			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && option_recursive) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-- 
2.11.0

