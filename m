Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88516C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ABB2339D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbhAOKBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 05:01:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:57090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbhAOKBD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 05:01:03 -0500
Received: (qmail 32679 invoked by uid 109); 15 Jan 2021 10:00:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 10:00:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26153 invoked by uid 111); 15 Jan 2021 10:00:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 05:00:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 05:00:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] test_lib: allow test_{must,might}_fail to accept
 non-git on "sigpipe"
Message-ID: <YAFntgQE3NZ3yQx5@coredump.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-4-avarab@gmail.com>
 <YAFPDJHH7ChvnVSD@generichostname>
 <87o8hq4jzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8hq4jzu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 10:39:17AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Compare
> >
> > 	some | test_might_fail ok=sigpipe grep | commands | here
> >
> > to
> >
> > 	some | test_filter | commands | here
> 
> I saw your original series/patch. including Junio's suggestion that
> test_grep_return_success was a bit too verbose & the suggestion for
> "test_filter".
> 
> I think the "test_might_fail" in this case is more readable, readable !=
> short. I.e. imagine you haven't just been looking at this code & open
> that test file. If it's using "test_{might,must}_fail ok=*" you're more
> likely to immediately understand it since you've seen those functions in
> lots of places before.
> 
> If not, then "test might fail ok=sigpipe" is almost so self-documenting
> that you don't need to look at the function.

But I'm left confused...do we expect grep to get sigpipe here? I don't
think so. The problem is that grep will return 0 for "I did not match
anything". We would get sigpipe if "commands | here" exited without
reading all of the input.

So the "ok=sigpipe" seems very misleading to me (and likewise, the whole
"test_might_fail ok=sigpipe" exception seems weird; sigpipe is not the
reason we want to use it with grep here; it is because grep might
actually fail).

Whereas the test-filter approach is expressing what we actually are
interested in (ignoring the exit code of grep, no matter what).

> Whereas a "test_filter" for me at least would prompt an immediate "hrm?
> what's that?", followed by grepping it and the side-quest of reading the
> source for that function we use in a grand total of <10 places.

I agree this is sometimes a problem. But if we want to inline it, it
seems like the correct spelling here is:

  some | { grep ... || true; } | commands | here

> Anyway, just my 0.02. I also think it makes conceptual sense to just
> have a limited whitelist in "test_{might,must}_fail", since in this case
> the reason we recommend against its use for non-git doesn't
> apply. I.e. we're normally not in the business of testing the OS, but in
> this case it's got the useful behavior of knowing how to handle the exit
> code & signal special-case, so we might as well use it.

I'm somewhat lukewarm on the whitelist already, as I got bit recently by
a (not yet published) test doing:

  foo() {
	git --with --some --options "$@"
  }
  test_expect_success '...' '
	# this one is expected to succeed
	foo ok &&
	# this one is not
	test_must_fail foo bad
  '

-Peff
