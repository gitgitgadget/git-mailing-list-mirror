Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BDAC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 09:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKAJMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKAJMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 05:12:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1E625F
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 02:12:32 -0700 (PDT)
Received: (qmail 5429 invoked by uid 109); 1 Nov 2022 09:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 09:12:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21050 invoked by uid 111); 1 Nov 2022 09:12:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 05:12:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 05:12:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2Di/5Hgp6IdSuuk@coredump.intra.peff.net>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
 <Y2DNS0W5vgk2Q3qJ@coredump.intra.peff.net>
 <221101.86sfj33wmg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.86sfj33wmg.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 09:15:00AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So I really didn't revisit this commit much at all, and was just trying
> > to save Dscho (or Taylor) the work of having to rebase it, if we go with
> > my patch 1.
> >
> > IMHO it is OK enough as it is, but if I were writing it from scratch I
> > probably would have given the rationale that the tests are insiting on a
> > dumb, sub-optimal behavior. And flakes or inconsistencies aside, they
> > should be asserting only the presence or absence of the message. And
> > probably would have left each at "grep" and dropped the test_line_count
> > totally.
> 
> Do you mean that even if we fix the bug and consistently emit one and
> only one such message you'd like to have the tests not assert that
> that's the case?

No, I wouldn't mind it, if that is a bug we've fixed. I just mean that
the tests as written never wanted to say "3 is the absolute right number
of times to write this message". They only put "3" there because it made
things pass.

> I do think that UX is important enough to test for, particularly if
> we've had a bug related to that that we've fixed. I.e. if something in
> the direction of my [1] goes in.

Sure, I don't mind at all a test for it. In the short-term, if you want
a test that fails, I'd prefer it be separate so that we can test the
useful existing behavior that _does_ work. If the multiple-messages bug
is fixed, I don't mind folding them together into a single test that
passes.

> > It is not even clear to me that the remote-https is the one being
> > swallowed (at least, I have not seen an argument or evidence that this
> > is so; it does seem plausible).
> 
> It is the case, the only ones that are going to be duplicated are the
> "warn" ones, because for "die" we'll die right away in the parent
> process.

Right, I understand why "die" produces only one. My question was when we
produce 2 on Windows (sometimes?) but 3 elsewhere, are we sure it is the
one from remote-https that is eaten, or could it ever be one of the
others?

In a sense we do not need to worry about "why is it sometimes eaten" if
the bug is fixed to produce only the one message. But it may point to a
separate and interesting problem (e.g., is stderr from remote-https not
reliable?).

> >> > @@ -654,7 +654,7 @@ test_expect_success 'push warns or fails when using username:password' '
> >> >  	test_must_fail git -c transfer.credentialsInUrl=die \
> >> >  		push $url_userpass 2>err &&
> >> >  	grep "fatal: $message" err >warnings &&
> >> > -	test_line_count = 1 warnings
> >> > +	test_line_count -ge 1 warnings
> >> >  '
> >> 
> >> ...but then why are we modifying these codepaths that have nothing to do
> >> with invoking the remote helper, i.e. where we die early before we get
> >> to that?
> >
> > If you're arguing that we should only do s/= 3/-ge 1/ for the test that
> > is flaking, I could buy that.
> 
> I'm saying that if we're doing a handwaivy-fix and saying "sometimes the
> message gets swallowed" and fixing this blindly without checking how it
> works, then changing "= 1" to "-ge 1" doesn't make sense.

Right, I'm fine with that (I perhaps should have said something stronger
than "I could buy that"). As I said, I was mostly just rebasing Dscho's
patch and I think it was good enough in the sense that it was
hand-waving away the whole "there may be more than one" problem.

But I do agree that we'll never see more in the "die" cases, and there
is no need to change them.

> > I thought the point is that the outer program calling the helper would
> > consistently produce the error, always yielding at least one instance.
> > The helper one is generally "extra" and undesired.
> 
> Yes, exactly. Which is what my fix[1] the root cause addresses.
> 
> Anyway, I'm just trying to help here. If you/Johannes/others want to go
> with the "hotfix" as-is that's fine my me.
> 
> I just don't see what the hurry is, it's been this way for two releases,
> if it's flaky that's been the case for months, I'd think we could just
> fix the root cause.

It recently bit me twice, so maybe I am giving it more urgency than it
deserves (or maybe something changed in CI to make it more likely).

I do think it would be nice to fix it. I don't love your patch for the
reasons I replied there (not your fault; it's inherently a crappy and
complicated problem). In the meantime, I'd like to see CI fixed, as
it is wasting developer's time. And that's why I called Dscho's
loosening "good enough". It is hopefully a temporary state anyway.

But I would be just as happy to see a similar patch which just changed
the 2/3 lines to "-ge 1" (or just a straight grep).

-Peff
