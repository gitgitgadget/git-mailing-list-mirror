Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F8C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2352081E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgBOGqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:46:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:44130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725822AbgBOGqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 01:46:55 -0500
Received: (qmail 25647 invoked by uid 109); 15 Feb 2020 06:46:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Feb 2020 06:46:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26761 invoked by uid 111); 15 Feb 2020 06:55:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Feb 2020 01:55:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Feb 2020 01:46:54 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] pack-bitmap: fix leak of haves/wants object
 lists
Message-ID: <20200215064654.GA1633703@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182211.GB150965@coredump.intra.peff.net>
 <20200215001552.GE11400@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200215001552.GE11400@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 04:15:52PM -0800, Taylor Blau wrote:

> > +void object_list_free(struct object_list **list)
> > +{
> > +	while (*list) {
> > +		struct object_list *p = *list;
> > +		*list = p->next;
> > +		free(p);
> > +	}
> > +}
> 
> Hmm. I was going to write a comment saying more-or-less, "I think I'm
> nitpicking here, but I'm not crazy about this as a 'while' loop". But,
> when I wrote this as a 'for' loop instead, I wrote a use-after-free, and
> then when I rid the code of that, it wasn't any more readable than the
> version above.

Yep, linked lists are deceptive that way.

This _could_ be converted to use the generic list.h macros. Or better
still, we could probably ditch it entirely in favor of an object_array.
But I'd prefer to do that separately, if at all.

-Peff
