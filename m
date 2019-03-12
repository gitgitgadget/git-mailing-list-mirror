Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD8920248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCLVB1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:01:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:47758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726618AbfCLVB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:01:27 -0400
Received: (qmail 2760 invoked by uid 109); 12 Mar 2019 21:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 21:01:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3687 invoked by uid 111); 12 Mar 2019 21:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 17:01:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:01:25 -0400
Date:   Tue, 12 Mar 2019 17:01:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
Message-ID: <20190312210124.GA5025@sigill.intra.peff.net>
References: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
 <20190311182328.GB16865@sigill.intra.peff.net>
 <8736nscw2y.fsf@evledraar.gmail.com>
 <20190312110549.GC2023@sigill.intra.peff.net>
 <87y35kb8ft.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y35kb8ft.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 01:09:42PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > To be clear, I do sympathize with the notion that not pulling things
> > in-tree keeps our relationship with upstream more disciplined, and that
> > has value. I'm just not altogether clear how much it's really hurt us
> > overall to be undisciplined.
> 
> I agree that say the compat/regex divergence hasn't hurt us much if at
> all. Just that we have a few conflicting desires:
> 
>  A. Make sure you can "make" git by default without pulling down a bunch
>     of libraries, especially if they're not ubiquitous. Thus shipping
>     the likes of sha1dc.
> 
>  B. Being able to hotfix those libraries.
> 
>  C. Upstreaming those hotfixes when they happen.
> 
>  D. Updating the library we pulled in due to "A" from upstream.
> 
> In practice because we've wanted "A" we've felt the need to do "B", but
> then also not "C" without ever having the discussion that skipping that
> part was a good idea, and as a result "D" is hard.
> 
> Do we urgently need "D"? No. I'm just pointing out that in addition to
> optimzing for "B" being easy we should also weigh being good free
> software citizens and coordinate fixes with upstream, which also makes a
> future "D" easier.

Yeah, I think your mental model there makes some sense.

> Also, while I don't know of any bugs in compat/regex. I think it's a bit
> concerning that we're carrying 2010-era code for something like the
> regex engine that we expose e.g. over gitweb.

TBH, I think it's probably a bad idea to open any version of that code
to untrusted people, because it's easy to write a DoS regex against it.
There are libraries (like re2) that would be a better fit (I seem to
recall that there may be some DFA-only support in pcre, too, but I
haven't looked at it in a long time; if there is, it might be a sane
gitweb feature to only expose that engine).

-Peff
