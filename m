Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F3C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjC2X2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjC2X2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 19:28:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514AD1A8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 16:28:06 -0700 (PDT)
Received: (qmail 17302 invoked by uid 109); 29 Mar 2023 23:28:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 23:28:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12475 invoked by uid 111); 29 Mar 2023 23:28:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 19:28:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 19:28:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 1/4] tests: run internal chain-linter under "make test"
Message-ID: <20230329232804.GC2314218@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202207.GA1241631@coredump.intra.peff.net>
 <230329.86wn2zvo9u.gmgdl@evledraar.gmail.com>
 <xmqq7cuzd0cs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7cuzd0cs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 08:49:07AM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Now the comment in the Makefile still says (as seen in the context):
> >
> > 	# `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
> > 	# checks all tests in all scripts via a single invocation, so tell individual
> > 	# scripts not to "chainlint" themselves
> >
> > But as the commit message notes that's not accurate anymore. We're *not*
> > telling them to turn off chainlint in its entirety, we're telling them
> > to only suppress the chainlint.pl part.
> 
> Correct.  To avoid a confusion we saw in the thread that led to this
> series, we need an explanation that clearly distinguishes the "exit
> 117" one and the "script that parses the shell" one.  If we consider
> that the name "chainlint" refers to the latter, the script, and
> re-read the three lines with that in mind, I think they are OK.  It
> would become even clearer if we insert four words, like so:
> 
> 	`test-chainlint' (which is ...) checks ... via a single
> 	invocation of the "chainlint" script, so tell ...

I had hoped that "chainlint" in that comment would remain sufficient, as
the context implies that we're disabling the script. But it's easy
enough to expand. I squashed this in:

diff --git a/t/Makefile b/t/Makefile
index 10881affdd0..3e00cdd801d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -44,7 +44,7 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-# scripts not to "chainlint" themselves
+# scripts not to run the external "chainlint.pl" script themselves
 CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
 
 all: $(DEFAULT_TEST_TARGET)

> > I haven't looked too deeply, but it seems that we should at least adjust
> > that comment in the Makefile, or perhaps we should rename this "eval
> > 117" thing to be "internal lint" or something, and not "chain lint", to
> > avoid conflating it with chainlint.pl itself.
> 
> I agree that it would help to clarify that we mean by "chainlint"
> the script that parses (or the act of running the script, when it is
> used as a verb), and the above may be a way to do so.  I however do
> not see the need to come up with a new name for the other one, until
> we have a way to toggle it enabled/disabled, which is not something
> the discussion in the other thread found necessary.

Yeah. This distinction is not something anybody who is running or
writing tests should have to worry about (and the fact that it did come
up was a bug that this patch is fixing). So adding an option like
"--no-chain-lint-internal" is just making things more confusing, and
nobody would use it. You'd need it only if you are working on
chainlint.pl itself (and comparing results with the internal linter or
something), and there you are better off running "perl chainlint.pl
t1234-foo.sh" itself.

-Peff
