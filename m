Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3127C1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeGKNpJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:45:09 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:42622 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbeGKNpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:45:09 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BDeKWW001562
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 15:40:20 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6BDeJqK015938;
        Wed, 11 Jul 2018 15:40:20 +0200
Date:   Wed, 11 Jul 2018 15:40:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180711154019.202e75c5@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180711125109.GC23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
        <20180710170901.GH23624@sigill.intra.peff.net>
        <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
        <20180711125109.GC23835@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 11 Jul 2018 08:51:10 -0400
schrieb Jeff King <peff@peff.net>:

> On Wed, Jul 11, 2018 at 12:38:24PM +0200, Henning Schild wrote:
> 
> > > Can we save a dummy generated key and just import it? That's what
> > > we do for the regular gpg case.  
> > 
> > I will look into storing a binary and leaving notes how it was
> > generated, just like regular gpg does. The reason i did not do that
> > in the first place is that x509 certs have a validity and we
> > introduce time into the picture. But i will see if i can generate
> > epoch->infinity to get the host clock or just the future out of the
> > picture.  
> 
> That would be preferable. But even if we can just get something like a
> 10-year expiration, that may be enough. Somebody dealing with failing
> tests and regenerating keys in ten years is probably not the end of
> the world.
> 
> It could hurt people with drastically incorrect system clocks, but I
> suspect there are other tests with similar problems (especially if
> your clock is in the past).

I now have a working version with a pregenerated certificate from
1970-3000. I would be surprised if git is still around at that time ;).

> > > We're going to have a lot of duplicated tests here. That's a
> > > maintenance burden when one of them needs fixes later. And when
> > > new tests are added, we won't automatically get them tested under
> > > each format.
> > > 
> > > Can we move the battery of tests into a function that takes a few
> > > parameters (prereq name, branch to look at, etc) and then call it
> > > for both the gpg/gpgsm cases?  
> > 
> > I guess this is part of the earlier "allow GPGSM without GPG" and i
> > can ignore it if we agree that this is not needed?  
> 
> I think it's orthogonal. Even if GPGSM requires GPG, you'd still want
> to make sure that whatever exercise we give to the GPG code is also
> exercised using GPGSM.
> 
> I will note, though, that _some_ tests are not really exercising
> gpg-specific bits, but more how we react to it (e.g., how we format %G
> placeholders). And it's probably OK for those to just be run once.
> 
> So in an ideal world, the test script would probably look something
> like:
> 
>   # this function holds tests which exercise the interactions
>   # with the gpg binary itself
>   type_specific_tests() {
> 	prereq=$1
> 	branch=$2
> 
> 	test_expect_success $prereq "test whatever ($prereq)" '
> 		some test using $branch here
> 	'
>   }
> 
>   test_expect_success 'setup' '
> 	set up both openpgp and x509 branches here
>   '
> 
>   type_specific_tests GPG openpgp
>   type_specific_tests GPGSM x509
> 
>   # and now tests that generically care about getting _some_ signature
>   # result (e.g., the way we format signature info)
> 
>   # and then probably a few tests specific to how the config is
> handled, # like your new gpg.format coverage
> 
> But in practice, the type-specific bits are often muddled together
> with the type-independent ones (e.g., we happen to test the parsing
> of a failed signature from gpg by checking how %G? is formatted or
> similar).
> 
> So it may be simplest to just run most of the tests twice, once with
> gpg and once with gpgsm. I kind of wonder if all of t7510 could just
> be bumped into a function. Or even into a sourced file and run from
> two different scripts. See the way that t8001 and t8002 use
> annotate-tests.sh for an example.

I do not agree and would like to leave the tests as they are. Instead
of introducing a whole lot of very similar copies, i added just a few.
The original ones are even very similar between each other.
We are again talking about two problems. 1. we need test cases for
gpgsm if we want to merge gpgsm 2. the testsuite is very repetitive

While addressing 1 make 2 obvious and worse, addressing 2 is a whole
different story and should probably be discussed outside of this
thread. And i would not like to inherit responsibility for 2. In
fact the whole discussion emphasizes that it was a good idea to make
GPGSM depend on GPG, because it allows to somewhat reuse existing tests.

Henning

> -Peff

