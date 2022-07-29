Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6DC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiG2TGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiG2TG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:06:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE98AEFB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:04:53 -0700 (PDT)
Received: (qmail 22132 invoked by uid 109); 29 Jul 2022 19:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 19:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27818 invoked by uid 111); 29 Jul 2022 19:04:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 15:04:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 15:04:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YuQvUDlGPTHu2sOm@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
 <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
 <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
 <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
 <YuQg5M/cSLtqOgdw@coredump.intra.peff.net>
 <YuQpBwUt8rAE9oym@coredump.intra.peff.net>
 <xmqqk07v69bh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk07v69bh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 11:52:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The more interesting question is whether it causes any use-after-free
> > bugs.
> 
> Thanks for mentioning this.  All the "plug more leaks" patches make
> me worried for exactly that.  Another is a potential subtle breakage
> hidden by use of FREE_AND_NULL() and friends, which the sanitizers
> would probably not see, but can appear as behaviour change.

Yeah, agreed that is a potential pitfall.

> > I don't think it does, and certainly SANITIZE=address agrees.
> 
> ;-)

Just to expound a bit: I'm quite sure _this_ call site is fine, because
we are passing pretty vanilla options to setup_revisions(), and I looked
at how we handle the strings there. I'd worry a little more that there's
some dark corner of setup_revisions() which relies on memory lifetimes,
and so this isn't a safe thing to do in the general case.

But IMHO we should assume that setup_revisions() makes copies of strings
it needs, and if there is a dark corner where it doesn't, we should find
and fix that.

-Peff
