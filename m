Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DEC1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfH0JtX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:49:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42300 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfH0JtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:49:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 54F971F461;
        Tue, 27 Aug 2019 09:49:23 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:49:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
Message-ID: <20190827094923.6qhwqosiucsi43td@whir>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-5-e@80x24.org>
 <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> On Mon, 26 Aug 2019, Eric Wong wrote:
> 
> > By renaming the "hash" field to "_hash", it's easy to spot
> > improper initialization of hashmap_entry structs which
> > can leave "hashmap_entry.next" uninitialized.
> 
> Would you mind elaborating a bit? This explanation does not enlighten
> me, sadly, all I see is that it makes it (slightly) harder for me to
> maintain Git for Windows' patches on top of `pu`, as the FSCache patches
> access that field directly (so even if they rebase cleanly, the build
> breaks).

I renamed it to intentionally break my build.

That way I could easily spot if there were any other improper
initializations of the .hash field.  It's fine to revert,
actually, it could be more of a "showing my work" patch.

(AFAIK, it's a pretty common practice, but maybe not here :x)

I've also pondered adding a
"hashmap_entry_hash(const struct hashmap_entry *)"
accessor method for reading the field value (but not setting
it), but it's a bit verbose...

I'm also wondering where/if hashmap offers a real benefit over
khash nowadays; the latter ought to have better locality.
Would like benchmark at some point in the future;
but safety fixes first :)
