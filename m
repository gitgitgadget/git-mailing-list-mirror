Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09471FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbdFSTxd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:53:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:44930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751054AbdFSTxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:53:32 -0400
Received: (qmail 22683 invoked by uid 109); 19 Jun 2017 19:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 19:47:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31092 invoked by uid 111); 19 Jun 2017 19:53:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 15:53:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 15:53:30 -0400
Date:   Mon, 19 Jun 2017 15:53:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
Message-ID: <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
 <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
 <20170619194315.tzdmo7xel2dztoju@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170619194315.tzdmo7xel2dztoju@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 03:43:15PM -0400, Jeff King wrote:

> > > Is the iterator over packed-refs correctly skipping over what are
> > > covered by loose refs?  The entries in the packed-refs file that are
> > > superseded by loose refs should be allowed to point at an already
> > > expired object.
> > 
> > Here it is in a test form for easier diagnosis.
> 
> Thanks, I was just starting to do that myself. The problem is in
> ca6b06eb7 (packed_ref_store: support iteration, 2017-05-15) and is
> pretty obvious: the packed_ref iterator checks whether the entry
> resolves.
> 
> I think that _neither_ of the loose and packed iterators should be
> checking this. It's only the merged result (where loose trumps packed)
> that should bother checking.

It looks like this is mostly already the case. files_ref_iterator
combines the two and does check. The loose iteration is done by
cache_ref_iterator[1], and does not. So it's just this new packed_refs
iterator that is wrong, and we just need:

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 311fd014c..ad1143e64 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -416,12 +416,6 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->iter0->refname,
-					    iter->iter0->oid,
-					    iter->iter0->flags))
-			continue;
-
 		iter->base.refname = iter->iter0->refname;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
@@ -473,8 +467,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
-		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
 	iter = xcalloc(1, sizeof(*iter));

At least that makes sense to me and passes the tests (including the new
one). I haven't actually reviewed the patches yet.

-Peff
