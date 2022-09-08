Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F8FC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIHE5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIHE5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:57:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DDB08AB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:57:30 -0700 (PDT)
Received: (qmail 24578 invoked by uid 109); 8 Sep 2022 04:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 04:57:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17820 invoked by uid 111); 8 Sep 2022 04:57:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 00:57:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 00:57:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/5] transport: deep-copy object-filter struct for fetch-pack
Message-ID: <Yxl2OSCCYDFqCp1/@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the transport code for the git protocol calls into fetch_pack(), it
has to fill out a fetch_pack_args struct that is mostly taken from the
transport options. We pass along any object-filter data by doing a
struct assignment of the list_objects_filter_options struct. But doing
so isn't safe; it contains allocated pointers in its filter_spec
string_list, which could lead to a double-free if one side mutates or
frees the string_list.

And indeed, the fetch-pack code does clear and rewrite the list via
expand_list_objects_filter_spec(), leaving the transport code with
dangling pointers.

This hasn't been a problem so far, though, because the transport code
doesn't look further at the filter struct. But it should, because in
some cases (when fetch-pack doesn't rewrite the list), it ends up
leaking the string_list.

So let's start by turning this shallow copy into a deep one, which
should let us fix the transport leak in a subsequent patch. Likewise,
we'll free the deep copy we made here when we're done with it (to avoid
leaking).

Note that it would also work to pass fetch-pack a pointer to our filter
struct, rather than a copy. But it's awkward for fetch-pack to take a
pointer in its arg struct; the actual git-fetch-pack command allocates a
fetch_pack_args struct on the stack and expects it to contain the filter
options. It could be rewritten to avoid this, but a deep copy serves our
purposes just as well.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote up the "pass a pointer" version and it's really not too bad. But
on the other hand, the deep copy here did turn up the bug in the
previous patch (once we start freeing both copies, it caused a
double-free of the sparse_oid_name field).

 transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index b51e991e44..24540f642a 100644
--- a/transport.c
+++ b/transport.c
@@ -386,7 +386,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
-	args.filter_options = data->options.filter_options;
+	list_objects_filter_copy(&args.filter_options,
+				 &data->options.filter_options);
 	args.refetch = data->options.refetch;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
@@ -453,6 +454,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 	free_refs(refs);
+	list_objects_filter_release(&args.filter_options);
 	return ret;
 }
 
-- 
2.37.3.1139.g47294c03c7

