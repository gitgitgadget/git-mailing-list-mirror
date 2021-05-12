Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C6EC43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C3A61421
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhELXyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:54:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:53030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350065AbhELXgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:36:05 -0400
Received: (qmail 30742 invoked by uid 109); 12 May 2021 23:34:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 23:34:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11018 invoked by uid 111); 12 May 2021 23:34:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 19:34:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 19:34:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Message-ID: <YJxmHbHAn4x93xsr@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 03:48:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This combines by not-picked-up[1] recent patches to remove the support
> for the "sendemail.smtpssl" variable with the later patches showing
> where that effort was really going.
> 
> As noted in the subject this speeds up git-send-email invocations by
> ~2x or more, and brings the very slow t9001 test from running in ~26s
> on my box to ~12s. It's no longer consistently the slowest test I run.

Nice. I have observed that with a decent number of cores, the running
time of the entire test suite correlates strongly with the running time
of t9001. :)

Here are timings for individual tests run with "prove --state=slow,save".
(This is on an 8-core machine using -j32, skipping cvs/svn/p4 tests,
and using a tmpfs via --root). The timings were computed with:

  perl -MYAML -e '
    $_ = do { local $/; <> };
    # prove puts this non-YAML cruft at the end
    s/\.\.\.$//s;

    my $t = YAML::Load($_)->{tests};
    print "$_->[1] $_->[0]\n" for
      sort { $b->[1] <=> $a->[1] }
      map { [$_, $t->{$_}->{elapsed}] }
      keys(%$t);
  ' t/.prove | head

Before your patches, the whole sweet takes ~60-63s, and the top timings
(from a 63s run) are:

    63.2607979774475 t9001-send-email.sh
    51.742644071579 t0027-auto-crlf.sh
    37.7909920215607 t3070-wildmatch.sh
    27.09605717659 t7610-mergetool.sh
    24.7028169631958 t7112-reset-submodule.sh
    24.5535898208618 t5572-pull-submodule.sh
    23.8404550552368 t9500-gitweb-standalone-no-errors.sh
    22.3544380664825 t7400-submodule-basic.sh
    21.7017750740051 t5510-fetch.sh
    21.4575610160828 t3305-notes-fanout.sh

Now after, which takes ~54-59s (this is from a 54s run):

  46.796669960022 t0027-auto-crlf.sh
  32.5747599601746 t3070-wildmatch.sh
  21.5069420337677 t7610-mergetool.sh
  20.8392388820648 t1701-racy-split-index.sh
  19.7403028011322 t5572-pull-submodule.sh
  19.7386808395386 t9001-send-email.sh
  19.4622302055359 t7112-reset-submodule.sh
  18.9555768966675 t9500-gitweb-standalone-no-errors.sh
  18.0672709941864 t7400-submodule-basic.sh
  17.641391992569 t5510-fetch.sh

I have some messy patches to split t9001 into two segments. They were
waiting to get polished, but perhaps I can just discard them now. :)

Some side notes for those interested in timing the test suite:

  - If I run t9001 standalone, it goes much faster, of course; the CPU
    throttles down when we're running all the tests in parallel.

  - Those are with "-x --verbose-log", which is nice for catching flaky
    results. Dropping those seems to shave a few seconds off.

  - A big chunk of time for t0027 and t3070 is spent running the sed-based
    chain-linting for their huge tables of auto-generated tests (1400+
    and 1800+ respectively). Dropping the sed linting for just those
    tests knocks off about 30 CPU-seconds.

-Peff
