Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85932C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDBF61455
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhFOLMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:12:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55928 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFOLMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:12:19 -0400
Received: (qmail 7522 invoked by uid 109); 15 Jun 2021 11:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 11:10:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13674 invoked by uid 111); 15 Jun 2021 11:10:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 07:10:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 07:10:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Message-ID: <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
 <8735tk22if.fsf@evledraar.gmail.com>
 <YMdm5XayUfp4/atY@coredump.intra.peff.net>
 <87r1h4z8k0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1h4z8k0.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 06:55:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Indeed. With Felipe's original patch, the "test" target (but not
> > "prove") in t/Makefile will report, whether you set
> > TEST_OUTPUT_DIRECTORY or not:
> >
> >   failed test(s): t1234 t2345
> >
> >   fixed   0
> >   success 23243
> >   failed  2
> >   broken  221
> >   total   23647
> >
> > though curiously it doesn't exit non-zero back to make (usually we'd
> > also see the failures from the individual make targets, and barf there).
> 
> Odd.

I think it's just that the aggregation script was never meant to signal
to "make". In a regular "make test" (not using prove), each individual
test script is a dependency than can fail on its own. That means a
failure of any of them will signal "make" to fail the overall operation.

Interestingly it means we will not run the "aggregate-results" at all in
that case, so we would not give the nice output (you can run "make
aggregate-results" yourself, though; it doesn't depend on the tests
running itself, but assumes you've already run them).

So arguably we could do something like this:

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 7913e206ed..6198b2ef6b 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -44,3 +44,5 @@ printf "%-8s%d\n" success $success
 printf "%-8s%d\n" failed $failed
 printf "%-8s%d\n" broken $broken
 printf "%-8s%d\n" total $total
+
+test -z "$failed_tests"

but it makes "make aggregate-results" after the fact a little noisier. I
dunno. I don't really care that much about the output from this form of
the tests at all, since the "prove" output is _so_ much better, and I'd
highly recommend anybody use it instead.

The only thing preventing me from suggesting we get rid of the old
make-driven approach entirely is that there are probably platforms that
run the tests where "prove" is not available. And as long as it is not
generating wrong results (e.g., returning 0 when a test has failed), it
is doing that job OK.

> > I'm OK with this general approach. I do think it would be nice if we let
> > the environment supersede the on-disk GIT-BUILD-OPTIONS, which IMHO is
> > the real root of the problem (and possibly others), but that may be more
> > challenging to get right (I posted a patch earlier, but it does rely on
> > stuffing all of "set" into a variable, which makes me concerned some
> > less-able shells may complain).
> 
> Yeah I don't know and haven't dug into who wants all this combination of
> GIT-BUILD-OPTIONS, passing things in the env, or passing things as
> paramaters to make (sometimes under the same names).

To be clear, I doubt it's all that important. It would occasionally be
less surprising when trying to override the environment while running a
test script manually (which is after all, basically the same thing
that's happening here, just driven by a script). But if it's hard to do,
I'm OK with an easier solution provided it doesn't regress any other
cases.

> > It also means that t0000 can't test the results output (since we don't
> > write it), but I assume we don't do that now (I didn't actually try
> > running with your patch).
> 
> Yeah, but only in the trivial wrapper function, you can still write the
> test script and check the output yourself.

Sort of. You can avoid its setting of TEST_NO_RESULTS_OUTPUT, but we're
still left without a way to reliably override TEST_OUTPUT_DIRECTORY.
Again, I'm OK punting on that for now if there are no such tests.

> > We do look at them elsewhere, though (in --tee as you noted, and I think
> > for --stress). I'd prefer to notice the "no results" flag explicitly
> > there and report something sensible, rather than getting:
> 
> If we edit every single current callsite instead of setting it to
> something you can't write to then we're setting ourselves up for subtle
> bugss when someone uses $TEST_RESULTS_DIR for something else.

I was thinking we'd still set it to /dev/null as a belt-and-suspenders
(so the worst case is just an ugly error message). But...

> >   mkdir: cannot create directory ‘/dev/null’: Not a directory
> >
> > or similar.
> 
> Yeah that error sucks, but nobody will see it unless they're hacking on
> the guts of this $TEST_NO_RESULTS_OUTPUT, and I think it beats being fragile.

I think that's a good point. You're unlikely to stumble into
accidentally using TEST_NO_RESULTS_OUTPUT, so it might not be worth
caring about too much.

-Peff
