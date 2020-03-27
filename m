Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35DBC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9F206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0JKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:10:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:53318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbgC0JKF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 05:10:05 -0400
Received: (qmail 10027 invoked by uid 109); 27 Mar 2020 09:10:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 09:10:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23324 invoked by uid 111); 27 Mar 2020 09:20:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 05:20:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 05:10:04 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
Message-ID: <20200327091004.GA610157@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 03:27:19PM +0100, Johannes Schindelin wrote:

> > OK. This looks good, even if I cannot help feel that my earlier patch
> > was perfectly sufficient. ;)
> 
> The mistake is all mine. I had totally missed that you turned GPG into a
> lazy prereq. So I had my patch finalized already before you pointed my
> nose at that fact.
> 
> Sorry about that.

No problem. And I hope my review didn't sound too passive-aggressive
with the "well, in MY version we did this...". I focused on the
differences because those were the parts that were new (and therefore
interesting) to me. But I don't think any of them are too important
either way.

> > I have a slight preference for "return 1" here. The "exit 1" works
> > because test_lazy_prereq puts us in an implicit subshell. But I think
> > this sets a bad example for people writing regular tests, where there is
> > no such subshell (and "return 1" is the only correct way to do it).
> 
> There are two reasons why I did not use `return` here:
> 
> - To me, prereq code is very distinct from writing tests. Just like we do
>   not &&-chain all the shell functions that live outside of tests, I don't
>   want to &&-chain all the prereq code.
> 
>   The point of the tests' commands is not to fail. The point of prereq's
>   code is to fail if the prereq is not met.

My only concern is whether people cargo-culting will notice the
distinction. But it's probably not a big deal.

> - Since this code is outside of a function, `return` felt like the wrong
>   semantic concept to me. And indeed, I see this (rather scary) part in
>   Bash's documentation of `return` (I did not even bother to look at the
>   POSIX semantics, it scared me so much):
> 
>       The return status is non-zero if `return` is supplied a non-numeric
>       argument, or is used outside a function and not during execution of
>       a script by `.` or `source`.
> 
>   So: the `1` is totally ignored in this context. That alone is reason
>   enough for me to completely avoid it, and use `exit` instead.

I agree the portability rules there are scary, but none of that applies
because we _are_ in a function: test_eval_inner_(). This behavior is
intentional and due to a7c58f280a (test: cope better with use of return
for errors, 2011-08-08). I thought we specifically advertised this
feature in t/README, but I can't seem to find it.

So my perspective was the opposite of yours: "return" is the officially
sanctioned way to exit early from a test snippet, and "exit" only
happens to work because of the undocumented fact that lazy prereqs
happen in a subshell. But it turns out neither was documented. :)

> > In mine I put the test_have_prereq outside the lazy prereq.
> 
> That makes it essentially a non-lazy prereq.
> 
> > I don't think it really matters either way (when we later ask if GPGSM
> > is set, there is no difference between nobody having defined it, and
> > having a lazy definition that said "no").
> 
> The difference is when running a test with `--run=<n>` where `<n>` refers
> to a test case that requires neither GPG nor GPGSM or RFC1991. My version
> will not evaluate the GPG prereq, yours still will.

Yes. Part of the reason I kept mine as it was is because it matched the
original behavior better (and I was really only using a lazy prereq
because we didn't have a non-lazy version). But there's really no reason
_not_ to be lazy, so as long as it isn't breaking anything I think
that's a better way forward. (And if it is breaking something, that
something should be fixed).

-Peff
