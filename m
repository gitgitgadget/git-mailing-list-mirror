Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E053E1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeHRCh6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 22:37:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725825AbeHRCh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 22:37:58 -0400
Received: (qmail 14441 invoked by uid 109); 17 Aug 2018 23:32:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 23:32:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30241 invoked by uid 111); 17 Aug 2018 23:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 19:32:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 19:32:34 -0400
Date:   Fri, 17 Aug 2018 19:32:34 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180817233234.GA4472@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
 <20180817210604.GF20088@sigill.intra.peff.net>
 <CAGZ79kY9o_38WRX2TXC1JMA+9Y_ihf_jK8-f2pcYA+cYPF6B4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY9o_38WRX2TXC1JMA+9Y_ihf_jK8-f2pcYA+cYPF6B4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 03:57:18PM -0700, Stefan Beller wrote:

> On Fri, Aug 17, 2018 at 2:06 PM Jeff King <peff@peff.net> wrote:
> >
> > When we serve a fetch, we pass the "wants" and "haves" from
> > the fetch negotiation to pack-objects. That tells us not
> > only which objects we need to send, but we also use the
> > boundary commits as "preferred bases": their trees and blobs
> > are candidates for delta bases, both for reusing on-disk
> > deltas and for finding new ones.
> >
> > However, this misses some opportunities. Modulo some special
> > cases like shallow or partial clones, we know that every
> > object reachable from the "haves" could be a preferred base.
> > We don't use them all for two reasons:
> 
> s/all/at all/ ?

No, I meant "we don't use all of them". As in the Pokemon "gotta catch
'em all" slogan. ;)

Probably writing out "all of them" is better.

> > The first is that check_object() needs access to the
> > relevant information (the thin flag and bitmap result). We
> > can do this by pushing these into program-lifetime globals.
> 
> I discussed internally if extending the fetch protocol to include
> submodule packs would be a good idea, as then you can get all
> the superproject+submodule updates via one connection. This
> gives some benefits, such as a more consistent view from the
> superproject as well as already knowing the have/wants for
> the submodule.
> 
> With this background story, moving things into globals
> makes me sad, but I guess we can flip this decision once
> we actually move towards "submodule packs in the
> main connection".

I don't think it significantly changes the existing code, which is
already relying on a ton of globals (most notably to_pack). The first
step in doing multiple packs in the same process is going to be to shove
all of that into a "struct pack_objects_context" or similar, and these
can just follow the rest.

> >
> > The second is that the rest of the code assumes that any
> > reused delta will point to another "struct object_entry" as
> > its base. But by definition, we don't have such an entry!
> 
> I got lost here by the definition (which def?).
> 
>   The delta that we look up from the bitmap, doesn't may
>   not be in the pack, but it could be based off of an object
>   the client already has in its object store and for that
>   there is no struct object_entry in memory.
> 
> Is that correct?

Right, we are interested in objects that we _couldn't_ find a struct
for.  I agree this could be more clear.

-Peff
