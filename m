Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5AC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1952421D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:54:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:47096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726283AbgBRTyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:54:04 -0500
Received: (qmail 19928 invoked by uid 109); 18 Feb 2020 19:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 19:54:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21961 invoked by uid 111); 18 Feb 2020 20:03:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:03:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 14:54:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200218195402.GA21586@coredump.intra.peff.net>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
 <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net>
 <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 11:31:35AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the conversion of the die() to warning() makes sense here. Do we
> > want to cover that with a test?
> 
> I presume that you are talking about this case.
> 
> >  	if (n->tag && !n->name_checked) {
> >  		if (!n->tag->tag)
> > -			die(_("annotated tag %s has no embedded name"), n->path);
> > +			warning(_("annotated tag %s has no embedded name"), n->path);

Yep, that's the one.

> The attached is my attempt to craft such a test.  It turns out that
> it is tricky to trigger this die/warning.  I haven't dug deeply
> enough, but I suspect this might be a dead code now.

Thanks for digging so deeply on this. I think you're right that we'll
never get a "struct tag" with a NULL tag field because
parse_tag_buffer() unconditionally puts something there or returns an
error.

We probably used to be able to trigger this by "double parsing" the tag
(probably with two refs pointing at the same tag object), in which case
the first would mark it as parsed but return an error, and the second
would quietly return "oh, it's already parsed". But I fixed that
recently in 228c78fbd4 (commit, tag: don't set parsed bit for parse
failures, 2019-10-25).

So yeah, I think I'd be OK to turn this into a BUG(), or just eliminate
it entirely (we'd segfault, which is BUG-equivalent ;) ).

-Peff
