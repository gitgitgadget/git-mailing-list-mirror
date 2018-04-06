Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EC61F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDFS7s (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:59:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750815AbeDFS7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:59:47 -0400
Received: (qmail 23572 invoked by uid 109); 6 Apr 2018 18:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 18:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28107 invoked by uid 111); 6 Apr 2018 19:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:00:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 14:59:45 -0400
Date:   Fri, 6 Apr 2018 14:59:45 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] ref-filter: factor ref_array pushing into its own
 function
Message-ID: <20180406185945.GC11108@sigill.intra.peff.net>
References: <20180406185801.GA921@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180406185801.GA921@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for callers constructing their own ref_array
structs, let's move our own internal push operation into its
own function.

While we're at it, we can replace REALLOC_ARRAY() with
ALLOC_GROW(), which should give the growth operation
amortized linear complexity (as opposed to growing by one,
which is potentially quadratic, though in-place realloc
growth often makes this faster in practice).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 16 +++++++++++++---
 ref-filter.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c1c3cc9480..6e9328b274 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1840,6 +1840,18 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+struct ref_array_item *ref_array_push(struct ref_array *array,
+				      const char *refname,
+				      const struct object_id *oid)
+{
+	struct ref_array_item *ref = new_ref_array_item(refname, oid);
+
+	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
+	array->items[array->nr++] = ref;
+
+	return ref;
+}
+
 static int ref_kind_from_refname(const char *refname)
 {
 	unsigned int i;
@@ -1930,13 +1942,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid);
+	ref = ref_array_push(ref_cbdata->array, refname, oid);
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
 
-	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
-	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 68268f9ebc..76cf87cb6c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -135,4 +135,12 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
+/*
+ * Push a single ref onto the array; this can be used to construct your own
+ * ref_array without using filter_refs().
+ */
+struct ref_array_item *ref_array_push(struct ref_array *array,
+				      const char *refname,
+				      const struct object_id *oid);
+
 #endif /*  REF_FILTER_H  */
-- 
2.17.0.686.g08b0810b04
