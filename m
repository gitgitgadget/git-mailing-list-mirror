Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D4AC47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D05613F6
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFDD5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:57:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:45836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhFDD5C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 23:57:02 -0400
Received: (qmail 8420 invoked by uid 109); 4 Jun 2021 03:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Jun 2021 03:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32161 invoked by uid 111); 4 Jun 2021 03:55:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 23:55:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 23:55:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLmkI4a4J60KFY2W@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <YLfl4jkuwSCiNrrS@nand.local>
 <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
 <xmqqk0na2yyc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0na2yyc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 10:36:11AM +0900, Junio C Hamano wrote:

> Thanks.  I was hoping somebody in the thread would tie the loose
> ends, but upon inspection of the output from
> 
>     $ git grep -e fsync\( maint seen -- \*.[ch]
> 
> it turns out that fsync_or_die() is the only place that calls
> fsync(), so perhaps doing it in a way that is quite different from
> what has been discussed may be even a better alternative.
> 
> If any new callers care about the return value of fsync(), I'd
> expect that they would be calling this wrapper, and the "best
> effort" callers that do not check the returned value by definition
> do not care if fsync() does not complete due to an interrupt, so I
> am hoping that the current "we only call it from this wrapper" is
> not just "the code currently happens to be this way", but it is
> sensible that the code will stay that way in the future.
> 
> Obviously I appreciate reviews and possibly tests, but sanity
> checking my observation that fsync() is called only from here is a
> good thing to have.

Thanks for digging further. I didn't even think to look at how many
calls there were, but I agree there is only the one. And moreover, I
agree that it is unlikely we'd ever have more than one, for the reasons
you listed. So I think your patch is a nice and simple solution, and we
don't need worry about magic macro wrappers at all.

One brief aside: I'm still not entirely convinced that NonStop isn't
violating POSIX. Yes, as Eric noted, fsync() is allowed to return EINTR.
But should it do so when the signal it got was set up with SA_RESTART?

The sigaction(3posix) page says:

     SA_RESTART   This flag affects the behavior of interruptible functions;
		  that is, those specified to fail with errno set to
		  [EINTR]. If set, and a function specified as
		  interruptible is interrupted by this signal, the
		  function shall restart and shall not fail with [EINTR]
		  unless otherwise specified. [...]

and I could not find anywhere that it is "otherwise specified" for
fsync(). Of course, whatever POSIX says, if NonStop needs this
workaround, we should provide it. But this may explain why we never saw
it on other systems.

It also means it's less important for this workaround to kick in
everywhere. But given how low-cost it is, I'm just as happy to avoid
having a separate knob to enable it.

> -- >8 --
> Subject: fsync(): be prepared to see EINTR

The patch itself looks good to me.

-Peff
