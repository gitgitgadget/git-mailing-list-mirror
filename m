Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E411FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 10:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbdCIKso (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 05:48:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:41182 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbdCIKr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 05:47:59 -0500
Received: (qmail 8843 invoked by uid 109); 9 Mar 2017 10:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 10:46:59 +0000
Received: (qmail 25934 invoked by uid 111); 9 Mar 2017 10:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 05:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 05:46:57 -0500
Date:   Thu, 9 Mar 2017 05:46:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
Message-ID: <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com>
 <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 11:41:59AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I almost suggested that there simply be an option to invert the match
> > (like --invert-contains or something).  But what you have here is more
> > flexible, if somebody ever wanted to do:
> >
> >   git tag --contains X --no-contains Y
> 
> Yeah that's really useful. E.g. this shows the branches I branched off
> (or have locally) from 2.6..2.8:
> 
>     $ ./git branch --contains v2.6.0 --no-contains v2.8.0
>       avar/monkeypatch-untracked-cache-disabled
>       avar/uc-notifs21
>       dturner/pclouds-watchman-noshm

Oh, that's a clever application.

> But I'd expect this to show all the tags between the two:
> 
>     $ ./git tag --contains v2.6.0 --no-contains v2.8.0
>     $
> 
> But it just returns an empty list. Manually disabling the
> contains_tag_algo() path (i.e. effectively locally reverting your
> ffc4b8012d) makes it "work", but of course it's much slower now. I
> haven't dug into why it's not working yet.

I'm almost certain this is because the contains_tag_algo one doesn't
clean up the flag bits it sets on the commit objects. So running it
twice in the same process is going to give you nonsense results.

Coincidentally, I've been looking into resurrecting the cleaner approach
that I sent long ago:

  http://public-inbox.org/git/20140625233429.GA20457@sigill.intra.peff.net/

But it's sufficiently complex that it's probably worth fixing the
existing algorithm to clean up its bits in the meantime.

> Also I wonder if this should be an error:
> 
>     $ ./git [tag|branch|for-each-ref] --contains A --no-contains A
> 
> I.e. when you give the same argument to both, this can never return
> anything for obvious reasons.

It's clearly nonsense, but I don't think there's any need for it to be
an error. GIGO.

-Peff
