Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F83C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJKNVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKNV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:21:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70EC95E4F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:20:20 -0700 (PDT)
Received: (qmail 32304 invoked by uid 109); 11 Oct 2022 13:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 13:20:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22332 invoked by uid 111); 11 Oct 2022 13:20:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Oct 2022 09:20:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Oct 2022 09:20:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Message-ID: <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
 <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
 <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
 <xmqq35buykz1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35buykz1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:42:42PM -0700, Junio C Hamano wrote:

> >> -			struct strvec argv = STRVEC_INIT;
> >> +			const char *argv[] = { "checkout", start_head.buf,
> >> +					       "--", NULL };
> >> 
> >> -			strvec_pushl(&argv, "checkout", start_head.buf,
> >> -				     "--", NULL);
> >> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> >> +			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
> >
> > This is OK with me, but note that one thing we lose is compiler
> > protection that we remembered the trailing NULL pointer in the argv
> > array (whereas strvec_pushl() has an attribute that makes sure the last
> > argument is a NULL).
> 
> The first parameter to run_command_v_opt() must be a NULL terminated
> array of strings.  argv.v[] after strvec_push*() is such a NULL
> terminated array, and is suitable to be passed to the function.
> 
> That much human programmers would know.
> 
> But does the compiler know that run_command_v_opt() requires a NULL
> terminated array of strings, and does it know to check that argv.v[]
> came from strvec_pushl() without any annotation in the first place?

No, but I don't think that's the interesting part. If you're using
strvec, it does the right thing, and it's hard to get it wrong. I'm more
concerned about places where we manually write a list of strings, and
it's easy to forget the trailing NULL.

In the existing code, that's done in the interface of strvec_pushl(),
which will remind you if you write:

  strvec_pushl(&arg, "checkout", start_head.buf, "--");

But after it is done in an initializer, which has no clue about the
expected semantics. We only have to get strvec's invariants right once.
But every ad-hoc command argv has to remember the trailing NULL.

> For such a check to happen, I think we need to tell the compiler
> with some annotation that the first parameter to run_command_v_opt()
> is supposed to be a NULL terminated char *[] array.

Right, but I would not expect the compiler to realize that strvec
maintains the ends-in-NULL invariant. It would have to be quite a clever
compiler.

In theory it could realize that argv is declared as an array locally,
and could make sure it ends in NULL as a compile-time check.

So it would have to be: "check this statically if you can, but otherwise
assume it's OK" kind of warning. But it's all kind of moot since I don't
think any such annotation exists. :)

Possibly a linter like sparse could complain about declaring a variable
called argv that doesn't end in NULL. I don't think it's worth anybody
spending too much time on it, though. This hasn't historically been a
big source of bugs.

> > Probably not that big a deal in practice. It would be nice if there was
> > a way to annotate this for the compiler, but I don't think there's any
> > attribute for "this pointer-to-pointer parameter should have a NULL at
> > the end".
> 
> But the code before this patch is safe only for strvec_pushl() call,
> not run_command_v_opt() call, so we are not losing anything, I would
> think.

The bug I'm worried about it is in a human writing the list of strings
and forgetting the NULL, so there we are losing the (admittedly minor)
protection.

-Peff
