Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56CC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11028610E7
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhDGT2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:28:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:43628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDGT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:28:42 -0400
Received: (qmail 17470 invoked by uid 109); 7 Apr 2021 19:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 19:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22167 invoked by uid 111); 7 Apr 2021 19:28:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 15:28:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 15:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        olyatelezhnaya@gmail.com
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
Message-ID: <YG4H3wXI8pZT+zDI@coredump.intra.peff.net>
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <YGc6ybE1wD1ck0uB@coredump.intra.peff.net>
 <CAOLTT8R_kmdNhJaMjj60H0SEzs6-KrzTQhBHzShQ82aoDa5vzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8R_kmdNhJaMjj60H0SEzs6-KrzTQhBHzShQ82aoDa5vzw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 03, 2021 at 10:27:39PM +0800, ZheNing Hu wrote:

> >   - figure out which data will be needed for each item based on the
> >     parsed format, and then do the minimum amount of work to get that
> >     data (using "oid_object_info_extended()" helps here, because it
> >     likewise tries to do as little work as possible to satisfy the
> >     request, but there are many elements that it doesn't know about)
> >
> 
> I have indeed noticed that `oid_object_info_extended()`
> can get information about the object which we actually want.
> In `cat-file.c`, It has been used in `batch_object_write()`, and
> `expanding_atom()` specify what data we need.
> In `ref-filter.c`, It has been used in `get_object()`.
> I am not sure what you mean about "many elements that it
> doesn't know about", For the time being, `cat-file` can get 5
> kind of objects info it need.

I think there are things one might want to format that
oid_object_info_extended() does not know about. For example, if you are
asking about %(authorname), it can't provide that. But we want to do as
little work as possible to satisfy the request. So for example, with the
format "%(objectsize)", we'd prefer _not_ to load the contents of each
object, and just ask oid_object_info_extended() for the size. But if we
are asked for "%(authorname)", we know we'll have to read and parse the
object contents.

So this notion of "figure out the least amount of work" will have to be
part of the format code (and ref-filter and the pretty.c formatters do
make an attempt at this; I'm saying that a universal formatter will want
to keep this behavior).

> Maybe you think that `cat-file` can learn some features in
> `ref-filter` to extend the function of `cat-file --batch`?
> E.g. %(objectname:short)? I think I may have a better
> understanding of the topic of this mini-project now.
> We may not want to port the logic of cat-file,but to learn some
> design in `ref-filter`, right?

Yes, I think the goal is for all of the commands that allow format
specifiers to support the same set (at least where it makes sense;
obviously you cannot ask for %(refname) in cat-file).

And IMHO the best way to do that is to write a new universal formatting
API that takes the best parts from all of the existing ones. It _could_
also be done by choosing ref-filter as the best implementation, slowly
teaching it formats the other commands know (which is what Olga had
started with), and then cleaning up any performance deficiencies. But I
think that last part would actually be easier when starting from scratch
(e.g., I think it would help to actually produce an abstract syntax tree
of the parsed format, and then walk that tree to fill in the values).

-Peff
