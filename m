Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4558F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 11:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCLLFw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:05:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:47056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725811AbfCLLFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:05:51 -0400
Received: (qmail 26007 invoked by uid 109); 12 Mar 2019 11:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 11:05:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31502 invoked by uid 111); 12 Mar 2019 11:06:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 07:06:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 07:05:49 -0400
Date:   Tue, 12 Mar 2019 07:05:49 -0400
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
Message-ID: <20190312110549.GC2023@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
 <20190311182328.GB16865@sigill.intra.peff.net>
 <8736nscw2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736nscw2y.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 09:53:41AM +0100, Ævar Arnfjörð Bjarmason wrote:

> There's a at least a couple of aspects to this.
> 
> One is whether we should have the submodule in
> sha1collisiondetection/. I agree that's probably a bad idea now
> per-se. Honestly I wasn't expecting the answer when I submitted the
> final patch to switch to it fully to be to the effect of submodules
> being too immature for the git project itself to use. So now we're
> effectively mid-series, and should maybe just back out.

I think it's especially funky because we have three different ways of
getting sha1dc (in-tree, submodule, or against an external library). And
I almost blindly submitted a patch making the in-tree version work
(since that's what's used by default, and what I use) which could have
totally broken things for the other use cases without anybody realizing
until the change trickled down to somebody who uses those flags.

(Technically in this case it wouldn't actually have _broken_ them, but
just not helped them, so they'd be no worse off. But hopefully you get
the point).

Speaking of external libraries, in some ways the issue I raised is no
different than it is for any external library, where we're at the mercy
of whatever version is on the system. The big dependency for us is
usually libcurl, and we do have to sometimes work around old versions
there.

But I do think there's one thing that make the sha1dc submodule approach
more painful is that we don't control the content of the code, but we
_do_ build it ourselves with our usual compiler flags. So we're weirdly
intimate with it (and in fact, an external library would not have the
problem being discussed here, since it would have been built separately
without UBSan).

> I fully agree with what you've said in theory, but if we look at what's
> happened in practice we as a project are demonstrably not disciplined
> enough to manage upstream code like this without overtly perma-forking
> it.

I'm not sure I agree completely. Most of the things we've imported are
small enough that we're reasonably happy to accept them as a snapshot in
time and take ownership. I.e., I do not recall a lot of instances of
fixing bugs in compat/regex or compat/poll that we could have gotten
more easily by merging from upstream. But I admit I don't actually pay
much attention to those areas, so I might be completely off-base.

The one place I really _would_ have liked to remain compatible with
upstream is xdiff. And we were traditionally pretty hesitant to clean
things up there for fear of diverging. But in practice, upstream there
has been stagnant, and we've done most of the bug fixes and improvements
to it (in-tree).

> As far as I can tell none of the people changing that code went through
> the process of submitting a parallel upstream fix or seeing if the issue
> was fixed upstream and we could just update the code we were carrying,
> and of course that gets progressively harder for any one contributor as
> our divergence grows.

To be clear, I do sympathize with the notion that not pulling things
in-tree keeps our relationship with upstream more disciplined, and that
has value. I'm just not altogether clear how much it's really hurt us
overall to be undisciplined.

-Peff
