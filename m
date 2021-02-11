Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BEAC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F646024A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBKKYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 05:24:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:57526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBKKWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 05:22:30 -0500
Received: (qmail 5074 invoked by uid 109); 11 Feb 2021 10:21:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Feb 2021 10:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31625 invoked by uid 111); 11 Feb 2021 10:21:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Feb 2021 05:21:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Feb 2021 05:21:41 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] diff: add an API for deferred freeing
Message-ID: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
References: <20201020064809.14297-1-michal@isc.org>
 <20210205141320.18076-1-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2102101557160.29765@tvgsbejvaqbjf.bet>
 <878s7vcnqo.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2102111039080.29765@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2102111039080.29765@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 10:40:45AM +0100, Johannes Schindelin wrote:

> On Thu, 11 Feb 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Wed, Feb 10 2021, Johannes Schindelin wrote:
> >
> > > On Fri, 5 Feb 2021, Ævar Arnfjörð Bjarmason wrote:
> > >
> > >> Add a diff_free() function to free anything we may have allocated in
> > >> the "diff_options" struct, and the ability to make calling it a noop
> > >> by setting "no_free" in "diff_options".
> > >
> > > Why do we need a `no_free` flag? Why not simply set the `free()`d (or
> > > `fclose()`d) attributes to `NULL`?
> 
> Hmm. That was not even clear to me until I read this reply.
> 
> Doesn't this indicate that the closing is done at the wrong layer? If we
> want to call a function N times and only at the last iteration should it
> clean up our resources, doesn't that indicate that the clean-up should be
> pulled out from that function?
> 
> I thought that's exactly what you did, but I must have glanced over
> something obvious...

I think the issue then is that every caller must now be modified to do
the clean up (which otherwise happens automatically when flushing the
diff).

So I definitely agree that the current API is weird and backwards. But
flipping it now may introduce new leaks in existing callers.

-Peff
