Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8126C433E0
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39EE206C1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGYVlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 17:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37934 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgGYVlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 17:41:19 -0400
Received: (qmail 32387 invoked by uid 109); 25 Jul 2020 21:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2020 21:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 621 invoked by uid 111); 25 Jul 2020 21:41:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2020 17:41:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jul 2020 17:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
Message-ID: <20200725214118.GA4508@coredump.intra.peff.net>
References: <20200724223844.2723397-1-jonathantanmy@google.com>
 <xmqq7dusjyos.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dusjyos.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 04:11:31PM -0700, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > I think the best way for easy authorship and review is to convert each
> > possibly-dying function into a function that either returns a
> > possibly-null error string or returns success/failure and writes the
> > error string into an "out" parameter.
> 
> Ugly.
> 
> Rather, if we were to pass an extra parameter through the entire
> callchain, I'd rather see that parameter to be what to do when we
> see an error.  Depending on that, the callee can die(), return
> error(), or silently return -1, or do something else.

Agreed. I had a proposal a while ago to pass a "struct error_context"
which was basically a function pointer and any accompanying data. That
lets the caller instruct us to die(), call error(), stuff the error in a
strbuf owned by the caller, and so on.

I think it was this one:

  https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/

I still think it's a good idea, but the hard part is lib-ifying all of
the functions that call die() to instead return an error up the stack
(and handle cleanup, etc). Which is why I never really pushed it
further. But if we're going to be lib-ifying such calls anyway, I think
it's nice to do this flexible thing (from their perspective it's no more
work to trigger the callback than it is to call error() and return).

That said, I do think for this particular case, your "just run it in a
sub-process" suggestion may be simpler and more robust.

-Peff
