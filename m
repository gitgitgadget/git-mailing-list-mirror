Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DC9201A4
	for <e@80x24.org>; Fri, 12 May 2017 02:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbdELC7S (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 22:59:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50051 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbdELC7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 22:59:17 -0400
Received: (qmail 10634 invoked by uid 109); 12 May 2017 02:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 02:59:15 +0000
Received: (qmail 20598 invoked by uid 111); 12 May 2017 02:59:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 22:59:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 22:59:12 -0400
Date:   Thu, 11 May 2017 22:59:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512025912.smxc47pz64jzeclw@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
 <20170511224639.GC21723@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511224639.GC21723@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 03:46:39PM -0700, Jonathan Nieder wrote:

> > +static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
> > +{
> > +	for (; refs; refs = refs->next)
> > +		oidset_insert(oids, &refs->old_oid);
> > +}
> > +
> > +static int tip_oids_contain(struct oidset *tip_oids,
> > +			    struct ref *unmatched, struct ref *newlist,
> > +			    const struct object_id *id)
> > +{
> > +	if (!tip_oids->map.cmpfn) {
> 
> This feels like a layering violation.  Could it be e.g. a static inline
> function oidset_is_initialized in oidset.h?

It definitely is a layering violation, though we normally are pretty
"open" with letting callers peek in at our data structures.

I'd be fine with it as-is or with the helper function you suggested.
But...

> +/**
> + * Returns true iff "set" has been initialized (for example by inserting
> + * an entry). An oidset is considered uninitialized if it hasn't had any
> + * oids inserted since it was last cleared.
> + */
> +static inline int oidset_initialized(const struct oidset *set)
> +{
> +	return set->map.cmpfn ? 1 : 0;
> +}

Now we're committing our own layering violation. I was surprised to find
that hashmap_free() clears "cmpfn", and I'm not sure if we would want to
count on that (not that it probably matters all that much, but it is
required for the description you gave to be accurate).

The hashmap documentation suggests using "tablesize" for checking
whether something is initialized. Maybe we ought to use that.

-Peff
