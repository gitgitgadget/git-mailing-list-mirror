Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECC61F463
	for <e@80x24.org>; Sun, 15 Sep 2019 01:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfIOBNs (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 21:13:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:50582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725805AbfIOBNs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 21:13:48 -0400
Received: (qmail 23320 invoked by uid 109); 15 Sep 2019 01:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Sep 2019 01:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28938 invoked by uid 111); 15 Sep 2019 01:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Sep 2019 21:15:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Sep 2019 21:13:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: [PATCH 3/3] list-objects-filter: give a more specific error sparse
 parsing error
Message-ID: <20190915011347.GC11208@sigill.intra.peff.net>
References: <20190915010942.GA19787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915010942.GA19787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jon Simons <jon@jonsimons.org>

The sparse:oid filter has two error modes: we might fail to resolve the
name to an OID, or we might fail to parse the contents of that OID. In
the latter case, let's give a less generic error message, and mention
the OID we did find.

While we're here, let's also mark both messages as translatable.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects-filter.c    | 5 +++--
 t/t5616-partial-clone.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index d2cdc03a73..50f0c6d07b 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -469,11 +469,12 @@ static void *filter_sparse_oid__init(
 	if (get_oid_with_context(the_repository,
 				 filter_options->sparse_oid_name,
 				 GET_OID_BLOB, &sparse_oid, &oc))
-		die("unable to access sparse blob in '%s'",
+		die(_("unable to access sparse blob in '%s'"),
 		    filter_options->sparse_oid_name);
 	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(&sparse_oid, NULL, 0, &d->el) < 0)
-		die("could not load filter specification");
+		die(_("unable to parse sparse filter data in %s"),
+		    oid_to_hex(&sparse_oid));
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 84365b802a..b85d3f5e4c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -274,7 +274,7 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
 	test_must_fail git clone --no-local --bare \
 				 --filter=sparse:oid=master \
 				 sparse-src dst.git 2>err &&
-	test_i18ngrep "could not load filter specification" err
+	test_i18ngrep "unable to parse sparse filter data in" err
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.23.0.667.gcccf1fbb03
