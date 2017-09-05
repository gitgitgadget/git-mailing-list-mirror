Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759021F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 08:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbdIEIpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 04:45:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:56984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750891AbdIEIpO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 04:45:14 -0400
Received: (qmail 17808 invoked by uid 109); 5 Sep 2017 08:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:45:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6873 invoked by uid 111); 5 Sep 2017 08:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 04:45:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 04:45:07 -0400
Date:   Tue, 5 Sep 2017 04:45:07 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
Message-ID: <20170905084507.wntm3bfzfezgimcz@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 07:18:22PM +0200, Martin Ågren wrote:

> Observe that split_symref_update() creates a `new_update`-object through
> ref_transaction_add_update(), after which `new_update->refname` is a
> copy of `referent`. The difference is, this copy will be freed, and it
> will be freed *after* `affected_refnames` has been cleared.
> 
> Rearrange the handling of `referent`, so that we don't add it directly
> to `affected_refnames`. Instead, first just check whether `referent`
> exists in the string list, and later add `new_update->refname`.

Coincidentally[1] I came across this same leak, and my solution ended up
slightly different. I'll share it here in case it's of interest.

In your solution we end up searching the string list twice: once to see
if we have the item, and then again to insert it. Whereas in the
original we did both with a single search.

But we can observe that either:

  1. The item already existed, in which case our insert was a noop, and
     we're good.

or

  2. We inserted it, in which case we proceed with creating new_update.

     We can then in O(1) replace the pointer in the string list item
     with the storage in new_update. We know we're not violating any
     string_list invariants because the strings contain the same bytes.

I.e.:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9266f5ab9d..1d16c1b33e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2178,6 +2178,11 @@ static int split_symref_update(struct files_ref_store *refs,
 	update->flags |= REF_LOG_ONLY | REF_NODEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
+	/*
+	 * Re-point at the storage provided by our ref_update, which we know
+	 * will last as long as the affected_refnames list.
+	 */
+	item->string = new_update->refname;
 	item->util = new_update;
 
 	return 0;

It feels pretty dirty, though. It would certainly be a bug if we ever
decided to switch affected_refnames to duplicate its strings.

So given that your solution is only a constant-time factor worse in
efficiency, we should probably prefer it as the more maintainable
option.

-Peff

[1] It's not really a coincidence, of course. All the recent leak
    discussion has got both of us prodding at Git with various tools. :)
