Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B03C6FA86
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 09:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIVJfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiIVJfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 05:35:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35190815
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 02:35:34 -0700 (PDT)
Received: (qmail 5536 invoked by uid 109); 22 Sep 2022 09:35:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 09:35:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 756 invoked by uid 111); 22 Sep 2022 09:35:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 05:35:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 05:35:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] list-objects-filter: initialize sub-filter structs
Message-ID: <YywsZU9UUoC08UcN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit c54980ab83 (list-objects-filter: convert filter_spec to a
strbuf, 2022-09-11), building with SANITIZE=undefined triggers an error
in t5616.

The problem is that we end up with a strbuf that has been
zero-initialized instead of via STRBUF_INIT. Feeding that strbuf to
strbuf_addbuf() in list_objects_filter_copy() means we will call memcpy
like:

   memcpy(some_actual_buffer, NULL, 0);

This works on most systems because we're copying zero bytes, but it is
technically undefined behavior to ever pass NULL to memcpy.

Even though c54980ab83 is where the bug manifests, that is only because
we switched away from a string_list, which is OK with being
zero-initialized (though it may cause other problems by not duplicating
the strings, it happened to be OK in this instance).

The actual bug is caused by the commit before that, 2a01bdedf8
(list-objects-filter: add and use initializers, 2022-09-11). There we
consistently initialize the top-level filter structs, but we forgot the
dynamically allocated ones we stick in filter_options->sub when creating
combined filters.

Note that we need to fix two spots here: where we parse a "combine:"
filter, but also where we transform from a single-filter into a combined
one after seeing multiple "--filter" options. In the second spot, we'll
do some minor refactoring to avoid repeating our very-long array index.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a regression in v2.38.0-rc1. The fix should go on top of
jk/list-objects-filter-cleanup.

Sorry to have missed it before. I was carefully running all of those
commits through SANITIZE=address (because I was worried about missing
exactly this kind of thing), but for some reason I didn't add UBSan.

The existing BUG() I added there didn't catch it either, because the
sub-filter creation doesn't call into parse_list_objects_filter()
directly. We could try to beef that up with more BUG()s, but I don't
think it's worthwhile. The point there is to catch outside callers not
initializing correctly; this was just a bug in the list-objects code
itself.

 list-objects-filter-options.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d46ce4acc4..5339660238 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -143,6 +143,7 @@ static int parse_combine_subfilter(
 
 	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 		      filter_options->sub_alloc);
+	list_objects_filter_init(&filter_options->sub[new_index]);
 
 	decoded = url_percent_decode(subspec->buf);
 
@@ -263,6 +264,8 @@ void parse_list_objects_filter(
 		parse_error = gently_parse_list_objects_filter(
 			filter_options, arg, &errbuf);
 	} else {
+		struct list_objects_filter_options *sub;
+
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
@@ -273,10 +276,11 @@ void parse_list_objects_filter(
 		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
+		sub = &filter_options->sub[filter_options->sub_nr - 1];
 
-		parse_error = gently_parse_list_objects_filter(
-			&filter_options->sub[filter_options->sub_nr - 1], arg,
-			&errbuf);
+		list_objects_filter_init(sub);
+		parse_error = gently_parse_list_objects_filter(sub, arg,
+							       &errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
-- 
2.38.0.rc1.583.ga560cd8328
