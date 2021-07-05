Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2050BC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E703360241
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGEMEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:04:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:41500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhGEMEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:04:44 -0400
Received: (qmail 11940 invoked by uid 109); 5 Jul 2021 12:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Jul 2021 12:02:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12394 invoked by uid 111); 5 Jul 2021 12:02:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Jul 2021 08:02:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Jul 2021 08:02:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Message-ID: <YOL0voZhJolF8Rg4@coredump.intra.peff.net>
References: <xmqq4kdft122.fsf@gitster.g>
 <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
 <87czrx6v9w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czrx6v9w.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 05, 2021 at 10:03:58AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> * ab/send-email-optim (2021-05-28) 13 commits
> >>  - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
> >>  - send-email: move trivial config handling to Perl
> >>  - perl: lazily load some common Git.pm setup code
> >>  - send-email: lazily load modules for a big speedup
> >>  - send-email: get rid of indirect object syntax
> >>  - send-email: use function syntax instead of barewords
> >>  - send-email: lazily shell out to "git var"
> >>  - send-email: lazily load config for a big speedup
> >>  - send-email: copy "config_regxp" into git-send-email.perl
> >>  - send-email: refactor sendemail.smtpencryption config parsing
> >>  - send-email: remove non-working support for "sendemail.smtpssl"
> >>  - send-email tests: test for boolean variables without a value
> >>  - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
> >>
> >>  "git send-email" optimization.
> >>
> >>  Will merge to 'next'.
> >
> > Wahoo!
> 
> Do you find the faster t9001*.sh helps your overall test-run time?

It does for me. Running "make test" on 'next' (with -O2, and prove
--state=slow,save so it realizes t9001 is slow) takes 66 wallclock
seconds total. The top culprits are:

  $ perl -MYAML -e ' 
      $_ = do { local $/; <> };
      # prove puts this non-YAML cruft at the end
      s/\.\.\.$//s;
      my $t = YAML::Load($_)->{tests};
      print "$_->[1] $_->[0]\n" for
        sort { $b->[1] <=> $a->[1] } 
        map { [$_, $t->{$_}->{elapsed}] } 
        keys(%$t);
    ' t/.prove  | head
  65.4168658256531 t9001-send-email.sh
  40.6761560440063 t0027-auto-crlf.sh
  26.0225791931152 t7610-mergetool.sh
  24.0760719776154 t7112-reset-submodule.sh
  23.5710120201111 t5572-pull-submodule.sh
  23.2557609081268 t9500-gitweb-standalone-no-errors.sh
  20.9747018814087 t1701-racy-split-index.sh
  20.7937531471252 t7400-submodule-basic.sh
  20.4510779380798 t5510-fetch.sh
  20.0246639251709 t3305-notes-fanout.sh

Merging in ab/send-email-optim takes 60s, and yields:

  39.4541878700256 t0027-auto-crlf.sh
  27.2213349342346 t7610-mergetool.sh
  26.2227098941803 t9001-send-email.sh
  25.0272631645203 t5572-pull-submodule.sh
  24.3502569198608 t7112-reset-submodule.sh
  24.0568630695343 t9500-gitweb-standalone-no-errors.sh
  22.3555839061737 t7400-submodule-basic.sh
  21.2626190185547 t3305-notes-fanout.sh
  21.1138088703156 t5510-fetch.sh
  21.0040950775146 t1701-racy-split-index.sh

So we shaved 39s of CPU (albeit clocked-down-due-to-parallelism
seconds), and gained 6 wallclock seconds. Subsequent runs seem to shave
off a few more seconds even (presumably because the test-slowness
ordering is updated).

-Peff
