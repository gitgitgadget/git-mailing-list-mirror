Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA09211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 19:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725739AbeLBHG4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 02:06:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725732AbeLBHGz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 02:06:55 -0500
Received: (qmail 21593 invoked by uid 109); 1 Dec 2018 19:53:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 19:53:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1608 invoked by uid 111); 1 Dec 2018 19:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 14:53:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 14:53:36 -0500
Date:   Sat, 1 Dec 2018 14:53:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, max@max630.net,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181201195336.GB29120@sigill.intra.peff.net>
References: <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
 <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
 <20181122063714.GE5348@jessie.local>
 <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
 <20181122161722.GC28192@sigill.intra.peff.net>
 <878t1dz1wi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t1dz1wi.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 03:56:29PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Thu, Nov 22 2018, Jeff King wrote:
> 
> > On Thu, Nov 22, 2018 at 02:17:01AM -0800, Carlo Arenas wrote:
> >> PS. upstreaming the PERL_PATH fix is likely to be good to do soonish
> >> as I presume at least all BSD might be affected, let me know if you
> >> would rather me do that instead as I suspect we might be deadlocked
> >> otherwise ;)
> >
> > Yeah, the $PERL_PATH thing is totally orthogonal, and should graduate
> > separately.
> 
> On the subject of orthagonal things: This test fails on AIX with /bin/sh
> (but not /bin/bash) due to some interaction of ssize_b100dots and the
> build_option function. On that system:
> 
>     $ ./git version --build-options
>     git version 2.20.0-rc1
>     cpu: 00FA74164C00
>     no commit associated with this build
>     sizeof-long: 4
>     sizeof-size_t: 4
> 
> But it somehow ends up in the 'die' condition in that case statement. I
> dug around briefly but couldn't find the cause, probably some limitation
> in the shell constructs it supports. Just leaving a note about this...

That's weird. The functions involved are pretty vanilla. I'd suspect
something funny with the sed invocation:

  build_option () {
        git version --build-options |
        sed -ne "s/^$1: //p"
  }

but that's the one thing that shouldn't be dependent on the shell in
use.

Can you manually replicate the shell commands to see where it goes
wrong?

-Peff
