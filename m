Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24871F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeKMAtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:49:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:35802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726912AbeKMAtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:49:36 -0500
Received: (qmail 29718 invoked by uid 109); 12 Nov 2018 14:56:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:56:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11482 invoked by uid 111); 12 Nov 2018 14:55:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:55:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:55:58 -0500
Date:   Mon, 12 Nov 2018 09:55:58 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 9/9] fetch-pack: drop custom loose object cache
Message-ID: <20181112145558.GI7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 024aa4696c (fetch-pack.c: use oidset to check existence of loose
object, 2018-03-14) added a cache to avoid calling stat() for a bunch of
loose objects we don't have.

Now that OBJECT_INFO_QUICK handles this caching itself, we can drop the
custom solution.

Note that this might perform slightly differently, as the original code
stopped calling readdir() when we saw more loose objects than there were
refs. So:

  1. The old code might have spent work on readdir() to fill the cache,
     but then decided there were too many loose objects, wasting that
     effort.

  2. The new code might spend a lot of time on readdir() if you have a
     lot of loose objects, even though there are very few objects to
     ask about.

In practice it probably won't matter either way; see the previous commit
for some discussion of the tradeoff.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b3ed7121bc..25a88f4eb2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -636,23 +636,6 @@ struct loose_object_iter {
 	struct ref *refs;
 };
 
-/*
- *  If the number of refs is not larger than the number of loose objects,
- *  this function stops inserting.
- */
-static int add_loose_objects_to_set(const struct object_id *oid,
-				    const char *path,
-				    void *data)
-{
-	struct loose_object_iter *iter = data;
-	oidset_insert(iter->loose_object_set, oid);
-	if (iter->refs == NULL)
-		return 1;
-
-	iter->refs = iter->refs->next;
-	return 0;
-}
-
 /*
  * Mark recent commits available locally and reachable from a local ref as
  * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
@@ -670,30 +653,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	struct ref *ref;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
-	struct oidset loose_oid_set = OIDSET_INIT;
-	int use_oidset = 0;
-	struct loose_object_iter iter = {&loose_oid_set, *refs};
-
-	/* Enumerate all loose objects or know refs are not so many. */
-	use_oidset = !for_each_loose_object(add_loose_objects_to_set,
-					    &iter, 0);
 
 	save_commit_buffer = 0;
 
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
-		unsigned int flags = OBJECT_INFO_QUICK;
 
-		if (use_oidset &&
-		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
-			/*
-			 * I know this does not exist in the loose form,
-			 * so check if it exists in a non-loose form.
-			 */
-			flags |= OBJECT_INFO_IGNORE_LOOSE;
-		}
-
-		if (!has_object_file_with_flags(&ref->old_oid, flags))
+		if (!has_object_file_with_flags(&ref->old_oid,
+						OBJECT_INFO_QUICK))
 			continue;
 		o = parse_object(the_repository, &ref->old_oid);
 		if (!o)
@@ -710,8 +677,6 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		}
 	}
 
-	oidset_clear(&loose_oid_set);
-
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
-- 
2.19.1.1577.g2c5b293d4f
