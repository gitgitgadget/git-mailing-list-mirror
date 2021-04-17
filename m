Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89514C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5119661152
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhDQIrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:47:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:54916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQIrg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:47:36 -0400
Received: (qmail 29955 invoked by uid 109); 17 Apr 2021 08:47:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Apr 2021 08:47:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2354 invoked by uid 111); 17 Apr 2021 08:47:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Apr 2021 04:47:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Apr 2021 04:47:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
Message-ID: <YHqgjR0YDDgergpS@coredump.intra.peff.net>
References: <xmqqa6pznlgq.fsf@gitster.g>
 <YHj9mUzs+jlgNuVE@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2104161320250.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2104161320250.52@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 01:21:01PM +0200, Johannes Schindelin wrote:

> > Looks like this fails CI on the Windows VS build. I get:
> >
> >   ++ env GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=/dev/null git config --global --list
> >   fatal: unable to access 'nul': Invalid argument
> >
> > from t1300.181. I thought we had some magic to make /dev/null work there
> > (or maybe this _is_ the magic kicking in, since it is looking for the
> > Windows-ish nul, but it is not working for some reason).
> 
> Seems that this fixes it for me:
> [...]
> Subject: [PATCH] msvc: avoid calling `access("NUL", flags)`

Doh, I should have realized it was about access() from the message.
Thank you for a quick fix!

I do wonder if we should (not now, but in the longer term) ditch these
access() calls in git-config entirely (and just rely on errno we see
after calling fopen). The current code is a TOCTOU race (though one that
is unlikely to matter much in practice).

-Peff
