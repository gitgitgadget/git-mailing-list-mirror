Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5451F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeHITiI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 15:38:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730634AbeHITiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 15:38:08 -0400
Received: (qmail 27143 invoked by uid 109); 9 Aug 2018 17:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 17:12:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11382 invoked by uid 111); 9 Aug 2018 17:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 13:12:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 13:12:19 -0400
Date:   Thu, 9 Aug 2018 13:12:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180809171219.GF1439@sigill.intra.peff.net>
References: <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
 <20180809014302.GB34639@genre.crustytoothpaste.net>
 <20180809143010.GD1439@sigill.intra.peff.net>
 <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 08:30:25AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There was a patch at the start of this thread, but it specifically
> > checks for "sigc->result == U".  That's probably OK, since I think it
> > restores the behavior in earlier versions of Git. But I wonder if we
> > should simply be storing the fact that gpg exited non-zero and relaying
> > that. That would fix this problem and truly make the rule "if gpg
> > reported an error, we propagate that".
> 
> Yeah, I like that.  Something like this, perhaps?  Points to note:
> 
>  * status gets the return value from verify_signed_buffer(), which
>    essentially is what wait_or_whine() gives us for the "gpg
>    --verify" process.
> 
>  * Even if status says "failed", we still need to parse the output
>    to set sigc->result.  We used to use sigc->result as the sole
>    source of our return value, but now we turn 'status' into 'bad'
>    (i.e. non-zero) after parsing and finding it is not mechanically
>    good (which is the same criteria as we have always used before).
>    An already bad status is left as bad.
> 
>  * And we return 'status'.

Yeah, this is exactly what I had in mind. And the size of the code
change is much smaller than I feared. The case that I thought might be
complicated is still reading the output after we've seen the non-zero
status, but the existing "if (status && !gpg_output.len)" covers that.

> If we choose to blindly trust the exit status of "gpg --verify" and
> not interpret the result ourselves, we can lose the "smudge status
> to be bad if not G/U" bit, which I offhand do not think makes much
> difference either way.  I just left it there because showing what
> can be removed and saying it can be dropped is easier than showing
> the result of removal and saying it can be added--simply because I
> need to describe "it" if I go the latter route.

I guess leaving it serves as a sort of cross-check if gpg would return a
zero exit code but indicate in the status result that the signature was
not good. Sort of a belt-and-suspenders, I guess (which might not be
that implausible if we think about somebody wrapping gpg with a sloppy
bit of shell code that loses the exit code -- it's their fault, but it
might be nice for us to err on the conservative side).

Probably it should go back to just "result != G" then, though (thus
bringing the whole conversation full circle :) ).

I could live with or without it, though.

-Peff
