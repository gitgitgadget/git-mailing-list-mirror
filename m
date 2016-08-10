Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9BF1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbcHJS6w (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:58:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:53057 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965003AbcHJS6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:58:50 -0400
Received: (qmail 20798 invoked by uid 109); 10 Aug 2016 11:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 11:52:08 +0000
Received: (qmail 31086 invoked by uid 111); 10 Aug 2016 11:52:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 07:52:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 07:52:06 -0400
Date:	Wed, 10 Aug 2016 07:52:06 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/2] pack-objects mru
Message-ID: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
 <20160729041524.GG22408@sigill.intra.peff.net>
 <20160729054536.GA27343@sigill.intra.peff.net>
 <xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
 <20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
 <xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
 <20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
 <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
 <20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
 <xmqq7fbp8tki.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fbp8tki.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 03:29:33PM -0700, Junio C Hamano wrote:

> > @@ -1516,6 +1577,13 @@ static void get_object_details(void)
> >  			entry->no_try_delta = 1;
> >  	}
> >  
> > +	/*
> > +	 * This must happen in a second pass, since we rely on the delta
> > +	 * information for the whole list being completed.
> > +	 */
> > +	for (i = 0; i < to_pack.nr_objects; i++)
> > +		break_delta_cycles(&to_pack.objects[i]);
> > +
> >  	free(sorted_by_offset);
> >  }
> 
> A potential cycle can only come from reusing deltas across packs in
> an unstable order, that happens way before we do the find_delta()
> thing, so this is a good place to have the new call.  While reading
> break_delta_cycles(), I was wondering if what it does is safe under
> multi-threading but there is no need to worry.

It definitely is not multi-threaded safe (and I'm not sure it could
easily be made so). But yeah, it is quick and happens as part of the
get_object_details() look at the objects, which is where we make
decisions about delta reuse.

> The recursiveness of break-delta-cycles is not too bad for the same
> reason why it is OK to recurse in check_delta_limit(), I would guess?

Yes, and for the same reason that it is OK in write_one(); the recursion
is limited by the depth of the delta chains.

> This is not new with this change, but I am not quite sure what in
> the current code prevents us from busting the delta limit for reused
> ones, though.

I think in the current code you are limited by the depth you might find
in a single existing pack (since we never reuse cross-pack deltas).
There is a comment in check_object() that claims:

	* Depth value does not matter - find_deltas() will
	* never consider reused delta as the base object to
	* deltify other objects against, in order to avoid
	* circular deltas.

but I do not recall seeing code to enforce that (but presumably that is
just beacuse it is a corner of the code I have not seen yet).

However, I think with cross-pack deltas, you could have a situation
like:

  pack 1: A -> B -> C
  pack 2: C -> D -> E

and pick A and B from the first pack, and C, D, and E from the second.
Then you end up with:

  A -> B -> C -> D -> E

in the output. IOW, I think the absolute worst case chain is the
max_depth times the number of packs. In practice I'd expect it to be
much smaller.

I'm not sure how much we should be worried about it. We could fill in
the depth values when adding a reused delta, but I don't think we have
the number handy; we'd have to actually walk the chain (though with
delta-base-offset, that is reasonably cheap).

> > I think my preference is to clean up the "hacky" bit of this patch, and
> > then apply the earlier MRU patch on top of it (which takes my repack
> > from 44 minutes to 5 minutes for this particular test set).
> 
> Yup, with something like this to break the delta chain _and_ allow
> an object to go through the usual deltify machinery, I'd say the MRU
> patch is a wonderful thing to have.

Here are cleaned-up patches. The cycle-breaking patch is cleaned up and
has tests. I erred on the side of verbosity in the comments there,
because it literally took me hours to come up with a reliable working
set of commands (and a convincing argument that it's correct). Hopefully
it doesn't put anyone to sleep. :)

The second patch is the same as before, though I tweaked the commit
message a bit, so please replace what is at the tip of
jk/pack-objects-optim-mru.

  [1/2]: pack-objects: break delta cycles before delta-search phase
  [2/2]: pack-objects: use mru list when iterating over packs

-Peff
