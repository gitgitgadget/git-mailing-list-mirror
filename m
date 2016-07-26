Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2926203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028AbcGZQGc (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:61633 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757017AbcGZQGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:30 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlpJU-1ask7Y0CHo-00ZMHd; Tue, 26 Jul 2016 18:06:20
 +0200
Date:	Tue, 26 Jul 2016 18:06:07 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <fb1738d311fc1b6bf0a903acb14155f1ae7b575b.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZHoQLDJAZORCtJbMI8PAG/saqJmkfAiiWprRejXG+C5Qy/v1VlA
 zLyJn8fHL2Q0UnK8Hw0wjSKz3kIjZ4UT16HhL4FV00ZzIQ1YmkeDm51LEBLtT1v6LCLG7eU
 MUAWND6rJXsQTGEBAO0JHNThfWxU+TKpjKLGL3mXZtQ2OxZIOcDjwRsfoewuMdyulD7WTFo
 y0RgfHD1e8Ldwevo7aq8Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WqLZtb4hONE=:giCoOB+yiO98yO43Ogpn7H
 +xgraFMuEES8cX6kPrsqHWqwux7PbaNCSBzDokw72yJgVs0TFMr1HArQBDupG4JH6Xp71uWSS
 l1R3RKI8gPQfYM9pcwOgNLxoif5W2Rin6SKuGOEbysq6CG7EbycGHC65Ye8ZMAVBoUzRKfkJ8
 3W2Dx6Rq7pC/3dv4r0NyRzCgW9zlVDAYAw3VqfMqA7OIL+gkAbXPrTsYbDBNCrM0XGZLtP48s
 AP/8S3cHxjAx6TPxfwfpay2pre/TSZVRdNaY87AHXfGZHR7mUcE07F9zMy4SxWAAedyXV4naM
 GVGkPZsmmHQQ49h3obhgknuLuB5s3532NJniHecru4kSSSBHSEN9iG0PrZHAN2gLUGHxyWH+k
 ns3YvVAAAFPiCK/ozXRivMcxXWBom90ON0LqDUWiNkXuo1NDMInY7fMcM8iMFUp0BDnEj+gkg
 T7qedWqpgMSO8sz4sb72nkuhP8DM+FpK9seARNaYJx5z3nm8to55OOZEpPte05emdgE4Gf5aU
 XgUVhn7qKp5a9L9Qc+2XsRvw18IPmxfDGRBxAEMMnLEmZdLW7QLIMoqYqhX6Ckv6GBJ1UjhV0
 izkOqajQB/MLRPCuf/uM46Qa5ElhDlltQJfqJMIE1HxHGiGD5gk3s3IdPkapznZVxnTMzTkJ9
 dWVPDqnt8gaXxHVPDVaPLvh63Zs3CVk+MXA/EFB0EgEtFxHJwf3aySsGy4pFTzJ6h7NImhowd
 kUNxowPvtCf2I0PSaZBMHuga2jprbfCIIIYqzENuGZF+mQMTscwPV5mx46gqzajBJFe/CUEMF
 I8cjnBJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a couple of places where return values never indicated errors
before, as wie simply died instead of returning.

But now negative return values mean that there was an error and we have to
abort the operation. Let's do exactly that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3a652b7..58ced25 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1949,17 +1949,19 @@ int merge_recursive(struct merge_options *o,
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
-		 * ignored, it was never actually used, as result of
-		 * merge_trees has always overwritten it: the committed
-		 * "conflicts" were already resolved.
+		 * ignored (unless indicating an error), it was never
+		 * actually used, as result of merge_trees has always
+		 * overwritten it: the committed "conflicts" were
+		 * already resolved.
 		 */
 		discard_cache();
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				    NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
@@ -1975,6 +1977,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2031,6 +2035,9 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	if (clean < 0)
+		return clean;
+
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-- 
2.9.0.281.g286a8d9


