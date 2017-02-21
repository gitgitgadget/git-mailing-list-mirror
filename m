Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBD0201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbdBUXsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:00 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39884 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753463AbdBUXrs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EF21B280B6;
        Tue, 21 Feb 2017 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720863;
        bh=CXDBzHlSBieTWZdeaFBGOTi0fuuRaZ+oUL1CuCq8Oes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYTHjhYlCq5V3yqf6HnqyJReJgSd4Ii4GWhYlLJJP7I5UPsViyxgRYQrAMJrHD2hJ
         YnQRb2em3mM4csMsyPq3dXpL28vO5hG/3ZcRwPUNWJ+pegeVbO1V8pyFRoGU5Avfvr
         p7YiUHyBZK1Alc470Sw/38OH/yPstUvYjXSWMEWhxGPC80OvsvrCIOvLe6fB3V/6so
         q5KEndsLIjQAXqZEaPZLjUuKNQez+t9XRez+YP4KG8N2heuUxsHbAdJh574zDiSf1e
         OXOO/F6bzYK+jqc+pcZhmor+hNI4zE+g9tEy/MkaFU3X2a5j+DHoFMtDYm/MYwZzt0
         +n9OEh9N3J+moRWN2M3Nrh92ZLpu7u5toWliADQdCJth5WLp9FQqhZDd9rVxdEUL3V
         6IVY1IcEXfcuKhtyvHu+wZLKgZ/jb2J3a1bSRGnPp+Ilrmew0pBL0Q7Ul4VQ6ykr2F
         x+B5//EbZCGt7chMK7aeS97IL+polifInRPHSuED/lksZkntWNh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 09/19] builtin/clone: convert to struct object_id
Date:   Tue, 21 Feb 2017 23:47:27 +0000
Message-Id: <20170221234737.894681-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edbbf9..b4c929bb8a 100644
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

