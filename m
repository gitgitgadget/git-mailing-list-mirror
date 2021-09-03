Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA3EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC4F60FC4
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhICLOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:14:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:38622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhICLOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 07:14:33 -0400
Received: (qmail 27090 invoked by uid 109); 3 Sep 2021 11:13:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Sep 2021 11:13:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7508 invoked by uid 111); 3 Sep 2021 11:13:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Sep 2021 07:13:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Sep 2021 07:13:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] add a test mode for SANITIZE=leak, run it in CI
Message-ID: <YTIDXHx/IMtcaQR5@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
 <877dfzb0tw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dfzb0tw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 02:25:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Hmm. This still seems more complicated than we need. If we just want a
> > flag in each script, then test-lib.sh can use that flag to tweak
> > LSAN_OPTIONS. See the patch below.
> 
> On the "pragma" include v.s. env var + export: I figured this would be
> easier to read as I thought the export was required (I don't think it is
> in most cases, but e.g. for t0000*.sh I think it is, but that's from
> memory...).

I admit that half of my complaint with the pragma is the weird filename
with an "=" in it. :) But I do think just assigning the variable is the
most readable thing.  If t0000 needs to export for whatever reason, it
can do so (preferably with a comment explaining why).

> > That has two drawbacks:
> >
> >   - it doesn't have any way to switch the flag per-test. But IMHO it is
> >     a mistake to go in that direction. This is all temporary scaffolding
> >     while we have leaks, and the script-level of granularity is fine.
> 
> We have a lot of tests that do simple checking of the tool itself, and
> later in the script might be stressing trace2, or common sources of
> leaks like "git log" in combination with the tool (e.g. the commit-graph
> tests).
> 
> So being able to tweak this inside the script is useful, but that can of
> course also be done with this proposed TEST_LSAN_OK + prereq.

Getting rid of the "let's tell the tests that we were built with LSAN"
was part of the simplicity I was going for (and obviously does preclude
a prerequisite). I had hoped we wouldn't need to do per-test stuff,
because this was all a temporary state. But maybe that's naive.

> >     If we do care about not running them, then I think it makes more
> >     sense to extend the run/skip mechanisms and build on that.
> 
> The patch I have here is already nicely integrated with the skip
> mechanism. I.e. we use skip_all which shows a summary in any TAP
> consumer, and we can skip individual tests with prerequisites.

I meant here that we'd be driving the selection externally from the
tests using the skip/run mechanisms (something along the lines of what I
sketched out before).

But I admit that there isn't really a big difference between the two
approaches. Since you've coded this one up already, let's go in that
direction (i.e., this series).

> I was interested in doing some summaries of existing leaks
> eventually. It seems even with LSAN_OPTIONS=detect_leaks=0 compiling
> with SANITIZE=leak make things a bit slower, but not by much (but actual
> leak checking is much slower).
> 
> But I'd prefer to leave any "write out leak logs and summarize" step for
> some later change.

OK, I can live with that (especially given how apparently difficult it
is to convince LSAN to do it).

> > Sort of a meta-question, but what's the plan for folks who add a new
> > test to say t0000, and it reveals a leak in code they didn't touch?
> 
> Then CI will fail on this job. We'd have those same failures now
> (e.g. the mentioned current delta between master..seen), we just don't
> see them. Having visibility on them seems like an improvement.
> 
> > They'll get a CI failure (as will Junio if he picks up the patch), so
> > somebody is going to have to deal with it. Do they fix it? Do they unset
> > the "this script is OK" flag? Do they mark the individual test as
> > non-lsan-ok?
> 
> I'd think they'd fix it, or make marking the regression as OK part of
> their re-roll, just like failures on master..seen now.
> 
> If you're getting at that we should start out this job as an FYI job
> that doesn't impact the CI run's overall status if it fails I think that
> would be OK as a start.

I think that would be OK, but I'm not quite sure of the best way to do
it. Why don't we start it as a regular required job, and then we can see
how often it is causing a headache. If once every few months somebody
fixes a leak, I'd be happy. If new developers are getting tangled up
constantly in unrelated leaks, then that's something we'd need to
revisit.

> > I do like the idea of finding real regressions. But while the state of
> > leak-checking is still so immature, I'm worried about this adding extra
> > friction for developers. Especially if they get some spooky action at a
> > distance caused by a leak in far-away code.
> 
> Yeah, ultimately this series is an implicit endorsement of us caring
> more than we do now.
> 
> I think this friction point is going to be mitigated a lot by the
> ability I've added to not just skip entire test scripts, but allow
> prereq skipping of some tests, early bailing out etc.

I half-agree with your final paragraph. The biggest friction point I
think will be for new folks when CI starts failing, and they don't
understand why (or where the problem is, or how to debug it, etc). But
like I said, let's see what happens.

> > Anyway, here's LSAN_OPTIONS thing I was thinking of.
> 
> Thanks, that & your follow-up is very interesting. Can I assume this has
> your SOB? I'd like to add that redirect to fd 4 change to this series.

Yes, go for it.

-Peff
