Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57591FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 04:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdBJElz (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 23:41:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:52755 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdBJEly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 23:41:54 -0500
Received: (qmail 31198 invoked by uid 109); 10 Feb 2017 04:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 04:41:54 +0000
Received: (qmail 9889 invoked by uid 111); 10 Feb 2017 04:04:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 23:04:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 23:04:00 -0500
Date:   Thu, 9 Feb 2017 23:04:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
Message-ID: <20170210040400.kf6hurtcblnoxdqi@sigill.intra.peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
 <xmqqh943p0hv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh943p0hv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 12:34:04PM -0800, Junio C Hamano wrote:

> > +static struct submodule_hash_entry *alloc_submodule_hash_entry(
> > +		const char *submodule, struct ref_store *refs)
> > +{
> > +	size_t len = strlen(submodule);
> > +	struct submodule_hash_entry *entry = malloc(sizeof(*entry) + len + 1);
> 
> I think this (and the later memcpy) is what FLEX_ALLOC_MEM() was
> invented for.

Yes, it was. Though since the length comes from a strlen() call, it can
actually use the _STR variant, like:

  FLEX_ALLOC_STR(entry, submodule, submodule);

Besides being shorter, this does integer-overflow checks on the final
length.

> > @@ -1373,16 +1405,17 @@ void base_ref_store_init(struct ref_store *refs,
> >  			die("BUG: main_ref_store initialized twice");
> >  
> >  		refs->submodule = "";
> > -		refs->next = NULL;
> >  		main_ref_store = refs;
> >  	} else {
> > -		if (lookup_ref_store(submodule))
> > +		refs->submodule = xstrdup(submodule);
> > +
> > +		if (!submodule_ref_stores.tablesize)
> > +			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
> 
> Makes me wonder what "20" stands for.  Perhaps the caller should be
> allowed to say "I do not quite care what initial size is" by passing
> 0 or some equally but more clealy meaningless value (which of course
> would be outside the scope of this series).

I think this is what "0" already does (grep for HASHMAP_INITIAL_SIZE).
In fact, that constant is 64. The 20 we pass in goes through some magic
load-factor computation and ends up as 25. That being smaller than the
INITIAL_SIZE constant, I believe that we end up allocating 64 entries
either way (that's just from reading the code, though; I didn't run it
to double check).

-Peff
