Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F5C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHKSYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjHKSYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:24:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98030DF
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:24:17 -0700 (PDT)
Received: (qmail 30034 invoked by uid 109); 11 Aug 2023 18:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 18:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28803 invoked by uid 111); 11 Aug 2023 18:24:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 14:24:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 14:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230811182415.GC2816191@coredump.intra.peff.net>
References: <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
 <20230811151102.GE2303200@coredump.intra.peff.net>
 <fbeadf7d-c16f-0612-6256-fc4355e89638@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbeadf7d-c16f-0612-6256-fc4355e89638@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:12PM +0200, René Scharfe wrote:

> > we are defining an inline function with the explicit goal of passing it
> > as a function pointer. I don't remember all of the standard's rules
> > here. Are we guaranteed that it will create a linkable version if
> > necessary?
> 
> I don't see on which basis the compiler could refuse.  We can't expect
> the function address to be the same across compilation units, but we
> don't need that.  If there's a compiler that won't do it or a standards
> verse that makes this dubious then I'd like to know very much.

I seem to recall some quirks where an inline function that is not called
directly is not required to be compiled at all, and the compiler can
assume that there is a definition available in another translation unit.

But I think that only applies when no storage-class specifier is
provided. In this case, you said "static", so I think it's OK?

It's possible I'm mis-remembering the issues, too. One problem is that
pre-C99, you might end up with the opposite problem (a compiled function
with visible linkage that conflicts with other translation units at link
time). E.g. here:

  https://stackoverflow.com/questions/51533082/clarification-over-internal-linkage-of-inline-functions-in-c/51533367#51533367

But I think with "static" we should always be OK.

> > So I dunno. Clever, for sure, and I think it would work. I'm not sure if
> > the extra code merits the return or not.
> 
> Sure, why check types -- script languages get work done as well.  (I'm
> fresh off a Python basics training, nice quirky language..)  But we're
> in C land and static typing is supposed to help us get our operations
> correct and portable.

Don't get me wrong, I like type checking. It's just that doing weird
things with the language and pre-processor also carries a cost,
especially in an open source project where new folks may show up and say
"what the hell is this macro doing?". That's a friction for new
developers, even if they're comfortable with idiomatic C.

That said...

> A good example in parseopt: The patch below adds type checking to the
> int options and yields 79 warning about incompatible pointers, because
> enum pointers were used in integer option definitions.  The storage size
> of enums depends on the member values and the compiler; an enum could be
> char-sized.  When we access such a thing with an int pointer we write up
> to seven bytes of garbage ... somewhere.  We better fix that.

...I do find this evidence compelling.

-Peff
