Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC19202BB
	for <e@80x24.org>; Wed, 13 Mar 2019 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMOze (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 10:55:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725870AbfCMOze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 10:55:34 -0400
Received: (qmail 15439 invoked by uid 109); 13 Mar 2019 14:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 14:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11252 invoked by uid 111); 13 Mar 2019 14:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 10:54:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 10:54:17 -0400
Date:   Wed, 13 Mar 2019 10:54:17 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] repack: enable bitmaps by default on bare repos
Message-ID: <20190313145417.GA24101@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313015133.n7f7lyujnlwfytre@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 01:51:33AM +0000, Eric Wong wrote:

> But I did find Ævar's forgotten gitperformance doc and thread
> where the topic was brought up:
> 
>   https://public-inbox.org/git/20170403211644.26814-1-avarab@gmail.com/

One thing that thread reminded me of: we probably also want to default
pack.writebitmaphashcache on. Otherwise the time saved during the object
enumeration can backfire when we spend much more time trying delta
compression (because we don't know the pathnames of any objects).

The reason it defaults to off is for on-disk compatibility with JGit.
But I have very little experience running without the hash-cache on. We
added it very early on because we found performance was not great
without it (I don't know if people running JGit have run into the same
problem and if not, why not).

> ------------8<---------
> Subject: [PATCH] repack: enable bitmaps by default on bare repos
> 
> A typical use case for bare repos is for serving clones and
> fetches to clients.  Enable bitmaps by default on bare repos to
> make it easier for admins to host git repos in a performant way.

This looks good to me, with one minor nit:

> +test_expect_success 'incremental repack does not complain' '
> +	git -C bare.git repack -q 2>repack.err &&
> +	! test -s repack.err
> +'

This last line could use "test_must_be_empty".

-Peff
