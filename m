Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58CBC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CACF206C0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOUrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 16:47:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:48208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726212AbgEOUra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 16:47:30 -0400
Received: (qmail 27978 invoked by uid 109); 15 May 2020 20:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 20:47:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15964 invoked by uid 111); 15 May 2020 20:47:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 16:47:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 16:47:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/3] Safer GIT_CURL_VERBOSE
Message-ID: <20200515204729.GA115445@coredump.intra.peff.net>
References: <cover.1589218693.git.jonathantanmy@google.com>
 <cover.1589394456.git.jonathantanmy@google.com>
 <xmqqwo5ftz37.fsf@gitster.c.googlers.com>
 <xmqqlflvtysu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlflvtysu.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 12:33:37PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >> Thanks everyone. I went ahead with GIT_REDACT_AUTHORIZATION to match
> >> GIT_REDACT_COOKIES, with the default being true (i.e. you need to set it
> >> to "0" to have behavior change).
> >
> > Hmm, I would actually have expected us to move in the direction of
> > deprecating specific REDACT_BLAH and consolidate them into one,
> > instead of adding another one.  Especially as the primary reason why
> > we redact cookies is to protect those that are used for auth anyway.
> 
> Also I had forgot to grep for anonymi.e to find transport_anonymize_url(),
> which I was hoping that the new environment variable would cover to help
> those who debug.

Yeah, I'd agree with both of these. If Jonathan doesn't feel like
working on transport_anonymize_url() now, I don't mind if we leave that
for later. But let's come up with a general scheme that we're aiming
for, so we minimize changes to things that users are exposed to.

IMHO an option that only impacts the format of the human-readable trace
output is not something we need to deprecate. It's an internal detail,
and people can't rely on the exact format of the trace anyway. So I'd be
fine to just kill off GIT_REDACT_COOKIES completely (especially if the
default behavior is the safer "always redact").

That said, a boolean GIT_REDACT doesn't quite do the same thing, because
it's actually a list of cookies. My gut feeling is that this is a bit
over-engineered. Any cookies that Git uses are likely to be sensitive,
so just treating their values like auth (redacting by default, but
allowing them to be unblinded when the user asks for it). But maybe
Jonathan had a specific tracing case in mind, as the author of the
original.

-Peff
