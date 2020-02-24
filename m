Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0458C38BE1
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000220838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBXTKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:10:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:52942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725860AbgBXTKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 14:10:02 -0500
Received: (qmail 8802 invoked by uid 109); 24 Feb 2020 19:10:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 19:10:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12191 invoked by uid 111); 24 Feb 2020 19:19:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 14:19:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 14:10:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] use strpbrk(3) to search for characters from a given set
Message-ID: <20200224191001.GA2739722@coredump.intra.peff.net>
References: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
 <xmqqy2srrjx1.fsf@gitster-ct.c.googlers.com>
 <21e6eaac-318b-3cb3-bb63-4f65abfae670@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21e6eaac-318b-3cb3-bb63-4f65abfae670@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 08:01:36PM +0100, René Scharfe wrote:

> > The changes in the patch obviously look all correct.
> >
> > I wonder how we can exploit Coccinelle to do this kind of
> > transformations, though.  Would it be possible to say
> >
> >  * if we see "strchr(S, C1) || strchr(S, C2)", transform it to
> >    "strpbrk(S, concat(stringify(C1),stringify(C2)))"; and
> >  * if we see "strpbrk(S, N) || strchr(S, C)", transform it to
> >    "strpbrk(S, concat(N, stringify(C))";
> >
> > and let the tool apply these two rules repeatedly, to catch the
> > pattern to find any number of needle character in the same haystack?
> 
> That would be nice.  I briefly considered it, but I only can think of a
> silly way to convert char literals to strings (by using one rule for
> each possible character value), I don't know how to concatenate strings
> in Coccinelle (simply putting them next to each other as in C doesn't
> seem to work), and I don't know how to apply a rule recursively to allow
> transforming an arbitrarily long chain of strchr() calls. :-/

I suspect you could do it with the python scripting interface of
coccinelle. We haven't relied on that so far (since it's technically
optional), but I think it would be worth doing if it makes impossible
things possible (it also would make some existing very slow things much
faster).

As far as the recursive rules, I thought coccinelle would always
re-apply rules to the result. So the two that Junio gave above would
work (each application of the second one would suck up another strchr).
But I also won't be surprised if I'm totally wrong; it wouldn't be the
first time I've been puzzled by coccinelle. :)

All that said, I don't plan to spend time on this. And I wouldn't really
ask you or anyone to unless they find it fun or interesting. It seems
like a lot of poking around for probably not that much benefit.

-Peff
