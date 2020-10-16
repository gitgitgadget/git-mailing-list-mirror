Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3863DC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16F420795
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbgJPAit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 20:38:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33812 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbgJPAit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 20:38:49 -0400
Received: (qmail 25821 invoked by uid 109); 16 Oct 2020 00:38:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 00:38:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3079 invoked by uid 111); 16 Oct 2020 00:38:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 20:38:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 20:38:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201016003847.GB2932796@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
 <20201015194648.GB1490964@coredump.intra.peff.net>
 <xmqq7drrfe15.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7drrfe15.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 01:08:22PM -0700, Junio C Hamano wrote:

> > The sub-thread between me and Jonathan starting here:
> >
> >   https://lore.kernel.org/git/20201005082448.GB2862927@coredump.intra.peff.net/
> >
> > but specifically:
> >
> >   https://lore.kernel.org/git/20201005084946.GE2862927@coredump.intra.peff.net/
> 
> Ah, I see.  I actually do use "git ls-files t/ | grep ..." to look
> for tests that are relevant to the issue I have at hand quite often,
> so unlike what Jonathan said in the thread, having a good name does
> matter to me.

I'm not sure where he suggests worse names. I'd think if anything we'd
have better names, because they'd be even more meaningful (if people
start using them for test selectors). FWIW, I also grep like that when
looking for scripts.

> As far as I can tell, the numbers in the test names serve only two
> purposes.
> 
> One is as a unique key to avoid colliding in the test result
> aggrevation database, and the other is as a unique key to use in
> GIT_SKIP_TESTS (which in turn is used by the Meta/Make wrapper I
> use, found on the todo branch, like 'Meta/Make --test=0050,1400
> test').

Yeah, that sounds right. We also frequently talk about "t5601" in
human-readable messages. I often use that to either tab-complete or run
"./t5601-*". So they do serve as short unique identifiers there. You
could tell me "t-foo-bar-baz" and that would similarly be unique, but
it's not as short. :)

They do serve as unique keys in places like test-results/, but really
the whole test name is the key. Most of them have unique text
descriptions. If I do:

  git ls-files t/ |
  perl -lne '/t[0-9]{4}-(.*).sh$/ and print "$1"' |
  sort | uniq -d

that only yields two duplicates (and we'd probably be better off giving
them unique names anyway).

> I would be heavily inconvenienced if we decide to remove numbers
> becuase it would rob the latter use case from me, but I'd survive if
> we just are going to lift the requirement that numbers must be
> unique.

My plan is that you'd be able to say:

  Meta/make --test=filesystem,update-ref

for t0050 and t1400 respectively. Or more interesting things like
"git-svn-*" to skip all of the t91xx tests (or "git-svn/*" if we split
them by directories).

> I may end up running irrelevant 0050 and 1400 when the
> tests I really want to run are the other 0050 and 1400 with
> "--test=0050,1400", but when I am trying to run only 2 among 900+
> scripts, running 2 extra ones I didn't have to run only because
> their prefix collide is still much better and tolerable.

I think you could already do this in general. The only thing standing in
the way is test-lint-duplicates. I added that because I thought it would
be better to catch the duplicates early rather than get confused by them
later when you can't uniquely identify a test.  But in practice I do
feel like I spend more time de-duping tests when I rebase or merge
(because my branch raced with somebody else allocating the test number)
than I ever did dealing with unexpectedly skipped tests.

I definitely don't want to make anybody's life harder. But if the
numbers aren't unique and the text connected to them is, then it seems
like we should just use the text primarily.

-Peff
