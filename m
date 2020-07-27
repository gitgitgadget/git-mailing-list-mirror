Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB1C433F4
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67242074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgG0RLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:11:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgG0RLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 13:11:44 -0400
Received: (qmail 17561 invoked by uid 109); 27 Jul 2020 17:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2020 17:11:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16223 invoked by uid 111); 27 Jul 2020 17:11:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2020 13:11:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jul 2020 13:11:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
Message-ID: <20200727171143.GA789310@coredump.intra.peff.net>
References: <20200724223844.2723397-1-jonathantanmy@google.com>
 <xmqq7dusjyos.fsf@gitster.c.googlers.com>
 <20200725214118.GA4508@coredump.intra.peff.net>
 <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 25, 2020 at 04:01:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it was this one:
> >
> >   https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/
> >
> > I still think it's a good idea, but the hard part is lib-ifying all of
> > the functions that call die() to instead return an error up the stack
> > (and handle cleanup, etc). Which is why I never really pushed it
> > further. But if we're going to be lib-ifying such calls anyway, I think
> > it's nice to do this flexible thing (from their perspective it's no more
> > work to trigger the callback than it is to call error() and return).
> 
> Yeah, I almost 80%+ agree.
> 
> The remainder of 20% is that I am not so convinced that (fmt_string
> + va_list) that isn't pretty much usable for anything but generating
> human readable error messages is enough.  It is certainly a good
> enough replacement for (and much better than) the approach to
> prepare an error string in a "struct strbuf err" that was passeed by
> the caller, but I am not sure if that is a good bar to aim to pass
> to begin with ;-).

Yeah, I certainly agree that just passing around strings does not
provide as much information as some callers would like. But I think
introducing a system of machine-readable error tokens would be
cumbersome for a lot of cases, to the point that it may tip this from
"seems like an easy enough change" to something that nobody wants to
take on.

One in-between step that would be pretty easy is to record errno when
available (i.e., if error_errno() becomes error_ctx_errno(), then we
just stuff that errno value into the error_context struct). That would
let us reliably propagate errno up the stack, or even give intermediate
callers the opportunity to munge it (e.g., if a ref lookup failed with
EISDIR while opening a file, it might convert that to ENOENT as it
propagates up the stack).

-Peff
