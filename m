Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4852C63797
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 20:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAOUIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 15:08:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B2C64E
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 12:08:27 -0800 (PST)
Received: (qmail 8534 invoked by uid 109); 15 Jan 2023 20:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 20:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23476 invoked by uid 111); 15 Jan 2023 20:08:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 15:08:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 15:08:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8RdOt02JTvDnLiX@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
 <xmqqv8l9ks86.fsf@gitster.g>
 <Y8LjTYhTycp/tTBn@coredump.intra.peff.net>
 <xmqq4jssi8qh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jssi8qh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 10:59:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On the other hand, I don't know how useful those deprecations are going
> > to be, as it depends on the timeframe. If the deprecation is added for
> > the same version of libcurl that implements the alternative (which is
> > roughly the case here), then we'd always be stuck supporting the old and
> > new forms (old for backwards compatibility, and new to silence the
> > deprecation warning).
> 
> ... or just keep the warning without promoting, with "-Wno-error=...".

I'm pretty strongly against that solution for anything long-term. Having
to see those warnings is not only ugly, but it's confusing and trains
people to ignore them (and many times I've noticed ugly warnings
floating by and realized that oops, I had temporarily disabled -Werror
because I had been working with some older code).

> > We care a lot more about the deprecation once the
> > alternative has been around for a while, and/or the old way of doing
> > things is about to be removed. And if we just wait until that removal,
> > then we do not have to rely on deprecation warnings. The build will
> > break just fine on its own. :)
> 
> Yes and no.  It is not always like "this symbol is now known under
> this different name", which is trivial to adjust.  I briefly tried
> to see how IOCTL -> SEEK change should look like until I realized
> that the new way was invented too recently and stopped looking, but
> it would involve changes to the function logic in the callback
> functions, as the function signature---both parameters and its
> return values---of the callback changes.  I do not want to see us
> scrambling to make such adjustments to the code at the last minute,
> so some sort of advance warning is a good thing to have.

True.

I do think the IOCTL/SEEK one is old enough that we can do, though. The
deprecation is newer, but the SEEK interface was added in an old enough
version.

-Peff
