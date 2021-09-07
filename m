Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4DD610A3
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbhIGQxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:53:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344220AbhIGQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:53:06 -0400
Received: (qmail 19648 invoked by uid 109); 7 Sep 2021 16:51:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 16:51:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15265 invoked by uid 111); 7 Sep 2021 16:51:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 12:51:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 12:51:58 -0400
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
Subject: Re: [PATCH v4 3/3] tests: add a test mode for SANITIZE=leak, run it
 in CI
Message-ID: <YTeYrq1/BlFobAGk@coredump.intra.peff.net>
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
 <patch-v4-3.3-fffbfc35c00-20210907T151855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-3.3-fffbfc35c00-20210907T151855Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 05:33:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Subject: [PATCH v4 3/3] tests: add a test mode for SANITIZE=leak, run it in CI

The patch looks OK to me. There are a bunch of typos/nits in the commit
message which made it a little harder to read. I don't care _that_ much,
but there's one inaccuracy I wanted to point out, and the others are
along for the ride. :)

> While git can be compiled with SANITIZE=leak we have not run
> regression tests under that mode, memory leaks have only been fixed as
> one-offs without structured regression testing.

Funky comma placement. Maybe:

  While git can be compiled with SANITIZE=leak, we have not run
  regression tests under that mode. Memory leaks have only been fixed as
  one-offs without structured regression testing.

> This change add CI testing for it. We'll now build with GCC under
> Linux and test t000[04]*.sh with SANITIZE=leak, and likewise with GCC
> on OSX. The new jobs are called "linux-SANITIZE=leak" and
> "osx-SANITIZE=leak".

s/add/adds/

A matter of taste, but I find the "linux-SANITIZE=leak" a little funny
to read because of the mixed-caps and punctuation. Just linux-leaks or
something is descriptive enough. Pure bikeshedding, of course.

> On the topi of "LSAN_OPTIONS": It would be nice to have a mode to
> aggregate all failures in our various scripts, see [2] for a start at
> doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
> that for now, it can be added later, and that proposed patch is also
> hindered by us wanting to test e.g. test-tool leaks (and by proxy, any
> API leaks they uncover), not just the "common-main.c" entry point.

I think test-tool does actually use common-main.c, so we'd be covered
there, too. That said, I'm perfectly fine to leave this for now (or
perhaps never; if we can get the whole suite passing with leak-checking
on, then aggregating the many leak reports without having test failures
will become a moot point).

> +# skip non-whitelisted tests when compiled with SANITIZE=leak
> +if test -n "$SANITIZE_LEAK"
> +then
> +	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> +	then
> +		# We need to see it in "git env--helper" (via
> +		# test_bool_env)
> +		export TEST_PASSES_SANITIZE_LEAK
> +
> +		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
> +		then
> +			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> +			test_done
> +		fi
> +	fi
> +elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> +then
> +	error "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
> +fi

I wondered if it would be helpful for this to be more forgiving. But
there's not much point in setting GIT_TEST_PASSING_SANITIZE_LEAK all the
time (say, in your config.mak), since it will just skip a bunch of
tests. So it probably does make sense to alert the user that "oops, you
did not actually build things correctly".

-Peff
