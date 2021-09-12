Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CBAC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6577C60F51
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbhILV7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:59:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:45660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236547AbhILV7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 17:59:48 -0400
Received: (qmail 16976 invoked by uid 109); 12 Sep 2021 21:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 21:58:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2612 invoked by uid 111); 12 Sep 2021 21:58:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 17:58:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 17:58:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] strvec: use size_t to store nr and alloc
Message-ID: <YT54CNYgtGcqexwq@coredump.intra.peff.net>
References: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
 <87o88z82pc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o88z82pc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 06:13:18PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I don't really think any of that needs to go into the commit message,
> > but if that's a hold-up, I can try to summarize it (though I think
> > referring to the commit which _already_ did this and was accidentally
> > reverted would be sufficient).
> 
> Thanks, I have a WIP version of this outstanding starting with this
> patch that I was planning to submit sometime, but I'm happy to have you
> pursue it, especially with the ~100 outstanding patches I have in
> master..seen.
> 
> It does feel somewhere between iffy and a landmine waiting to be stepped
> on to only convert the member itself, and not any of the corresponding
> "int" variables that track it to "size_t".

I don't think it's a landmine. If those other places are using "int" and
have trouble with a too-big strvec after the patch, then they were
generally already buggy before, too. I have poked around before for
cases where half-converting some code from size_t to int can possibly
make things worse, but it's pretty rare.

Meanwhile, strvec using an int has obvious and easy-to-trigger overflow
problems. Try this:

  yes '000aagent' | GIT_PROTOCOL=version=2 ./git-upload-pack .

where we will happily allocate an arbitrarily-large strvec. If you have
the patience and the RAM, this will overflow the alloc field. Luckily we
catch it before under-allocating the array. Because our ALLOC_GROW()
growth pattern is fixed, we'll always end up with a negative 32-bit int,
which gets cast to a very large size_t, and an st_mult() invocation
complains.

Much scarier to me is that string_list seems to be using "unsigned int"
for its counter, so it never goes negative! Try this:

  yes | git pack-objects --stdin-packs foo

which reads into a string_list. It takes even more RAM to overflow
because string_list is so horribly inefficient. But here once again
we're saved by a quirk of ALLOC_GROW() dating back to 4234a76167 (Extend
--pretty=oneline to cover the first paragraph,, 2007-06-11).

alloc_nr() will overflow to a small number when it hits around 2^32 / 3.
Before that patch, we'd then realloc a too-small buffer and have a heap
overflow. After that patch (I think in order to catch growth by more
than 1 element), we notice the case that alloc_nr() didn't give us a big
enough size, and extend it exactly to what was asked for. So no heap
overflow, though we do enter a quadratic growth loop. :-/

So I don't think we have any heap overflows here, which is good. But we
are protected by a fair bit of luck, and none of this would get nearly
as close to danger if we just used a sensible type for our allocation
sizes.

I do think we should separately fix the v2 protocol not to just allocate
arbitrary-sized strvecs on behalf of the user. I took a stab at that
this weekend and have a series I'm pretty happy with, but of course it
conflicts with your ab/serve-cleanup (and in fact, I ended up doing some
of those same cleanups, like not passing "keys" around). I'll see if I
can re-build it on top.

> If you do the change I suggested in
> https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/ you'll
> find that there's at least one first-order reference to this that now
> uses "int" that if converted to "size_t" will result in a wrap-around
> error, we're lucky that one has a test failure.
> 
> I can tell you what that bug is, but maybe it's better if you find it
> yourself :) I.e. I found *that* one, but I'm not sure I found them
> all. I just s/int nr/size_t *nr/ and eyeballed the wall off compiler
> errors & the code context (note: pointer, obviously broken, but makes
> the compiler yell).

Yes, having converted s/int/size_t/ for other structures before, you
have to be very careful of signedness. A safer conversion is ssize_t
(which similarly avoids overflow problems on LP64 systems).

I'm sure there are other overflow bugs lurking around use of strvecs, if
you really push them hard. But I care a lot less about something like
"oops, I accidentally overwrite list[0] instead of list[2^32-1]". Those
are bugs that normal people will never see, because they aren't doing
stupid or malicious things. I care a lot more about our allocating
functions being vulnerable to heap overflows from malicious attackers.

So I was really hoping to do the size_t fix separately. It's hard for it
to screw anything up, and it addresses the most vulnerable and important
use.

-Peff
