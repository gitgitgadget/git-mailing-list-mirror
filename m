Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C30B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbdBITjR (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:39:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:52453 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbdBITi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:38:57 -0500
Received: (qmail 23287 invoked by uid 109); 9 Feb 2017 19:32:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 19:32:16 +0000
Received: (qmail 6983 invoked by uid 111); 9 Feb 2017 19:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 14:32:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 14:32:13 -0500
Date:   Thu, 9 Feb 2017 14:32:13 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
Message-ID: <20170209193213.eamc3swvbefwlhr7@sigill.intra.peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
 <CAGZ79kau2bYs7zegEiacAdbhn1LyOfAH9__rePfbQkX2iLgmMQ@mail.gmail.com>
 <4a21dba7-76ef-6aec-b326-c1046f3daad2@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a21dba7-76ef-6aec-b326-c1046f3daad2@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 06:40:29PM +0100, Michael Haggerty wrote:

> On 02/09/2017 05:58 PM, Stefan Beller wrote:
> >> @@ -1402,17 +1435,17 @@ struct ref_store *ref_store_init(const char *submodule)
> >>
> >>  struct ref_store *lookup_ref_store(const char *submodule)
> >>  {
> > 
> >> +       if (!submodule_ref_stores.tablesize)
> >> +               hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
> > 
> > 
> > So we can lookup a submodule even before we initialized the subsystem?
> > Does that actually happen? (It sounds like a bug to me.)
> >
> > Instead of initializing, you could return NULL directly here.
> [...]
> I suppose this code path could be changed to return NULL without
> initializing the hashmap, but the hashmap will be initialized a moment
> later by ref_store_init(), so I don't see much difference either way.

I faced a similar issue when adding the oidset API recently: 

  http://public-inbox.org/git/20170208205307.uvgj3saf3cyrvtan@sigill.intra.peff.net/

I came to the same conclusion that it doesn't matter much in practice. A
nice thing about "return NULL" is that you do not have to duplicate the
initialization which happens on the "write" side (so if you ever changed
submodule_hash_cmp, for example, it needs changed in both places).

I also used the "cmpfn" member to check whether the table had been
initialized, which matches existing uses elsewhere. But I do notice that
the documentation explicitly says "tablesize" is good for this purpose,
so it's probably a better choice.

-Peff
