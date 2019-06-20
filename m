Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8901F462
	for <e@80x24.org>; Thu, 20 Jun 2019 08:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfFTI6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 04:58:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:45630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725875AbfFTI6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 04:58:34 -0400
Received: (qmail 17960 invoked by uid 109); 20 Jun 2019 08:58:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 08:58:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13789 invoked by uid 111); 20 Jun 2019 08:59:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 04:59:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 04:58:32 -0400
Date:   Thu, 20 Jun 2019 04:58:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] delta-islands: respect progress flag
Message-ID: <20190620085832.GA5039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The delta island code always prints "Marked %d islands", even if
progress has been suppressed with --no-progress or by sending stderr to
a non-tty.

Let's pass a progress boolean to load_delta_islands(). We already do
the same thing for the progress meter in resolve_tree_islands().

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this should be a real progress meter that counts up, but I'm
not sure what it should be counting. Refs we analyzed? Islands found?
Unless you have a ton of refs, it doesn't really matter, so I just
punted on that part for now and only fixed the egregious bug. :)

 builtin/pack-objects.c | 2 +-
 delta-islands.c        | 5 +++--
 delta-islands.h        | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b2be8869c2..698c901523 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3134,7 +3134,7 @@ static void get_object_list(int ac, const char **av)
 		return;
 
 	if (use_delta_islands)
-		load_delta_islands(the_repository);
+		load_delta_islands(the_repository, progress);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/delta-islands.c b/delta-islands.c
index 2186bd0738..b959f6c380 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -454,7 +454,7 @@ static void deduplicate_islands(struct repository *r)
 	free(list);
 }
 
-void load_delta_islands(struct repository *r)
+void load_delta_islands(struct repository *r, int progress)
 {
 	island_marks = kh_init_sha1();
 	remote_islands = kh_init_str();
@@ -463,7 +463,8 @@ void load_delta_islands(struct repository *r)
 	for_each_ref(find_island_for_ref, NULL);
 	deduplicate_islands(r);
 
-	fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
+	if (progress)
+		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
 }
 
 void propagate_island_marks(struct commit *commit)
diff --git a/delta-islands.h b/delta-islands.h
index 3ac8045d8c..eb0f952629 100644
--- a/delta-islands.h
+++ b/delta-islands.h
@@ -11,7 +11,7 @@ int in_same_island(const struct object_id *, const struct object_id *);
 void resolve_tree_islands(struct repository *r,
 			  int progress,
 			  struct packing_data *to_pack);
-void load_delta_islands(struct repository *r);
+void load_delta_islands(struct repository *r, int progress);
 void propagate_island_marks(struct commit *commit);
 int compute_pack_layers(struct packing_data *to_pack);
 
-- 
2.22.0.732.g5402924b4b
