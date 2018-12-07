Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5161820A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLGBO1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 20:14:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:33630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726112AbeLGBO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 20:14:27 -0500
Received: (qmail 11971 invoked by uid 109); 7 Dec 2018 01:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Dec 2018 01:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16472 invoked by uid 111); 7 Dec 2018 01:13:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 20:13:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 20:14:25 -0500
Date:   Thu, 6 Dec 2018 20:14:25 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181207011425.GB21992@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205140106.GM30222@szeder.dev>
 <20181205215621.GE19936@sigill.intra.peff.net>
 <20181206231005.GP30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206231005.GP30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 07, 2018 at 12:10:05AM +0100, SZEDER Gábor wrote:

> On Wed, Dec 05, 2018 at 04:56:21PM -0500, Jeff King wrote:
> > Could we just kill them all?
> > 
> > I guess it's a little tricky, because $! is going to give us the pid of
> > each subshell. We actually want to kill the test sub-process. That takes
> > a few contortions, but the output is nice (every sub-job immediately
> > says "ABORTED ...", and the final process does not exit until the whole
> > tree is done):
> 
> It's trickier than that:
> 
>   - Nowadays our test lib translates SIGINT to exit, but not TERM (or
>     HUP, in case a user decides to close the terminal window), which
>     means that if the test runs any daemons in the background, then
>     those won't be killed when the stress test is aborted.
> 
>     This is easy enough to address, and I've been meaning to do this
>     in an other patch series anyway.

Yeah, trapping on more signals seems reasonable (or just propagating INT
instead of TERM). I'm more worried about this one:

>   - With the (implied) '--verbose-log' the process killed in the
>     background subshell's SIGTERM handler is not the actual test
>     process, because '--verbose-log' runs the test again in a piped
>     subshell to save its output:

Hmm, yeah. The patch I sent earlier already propagates through the
subshell, so this is really just another layer there. I.e., would it be
reasonable when we are using --verbose-log (or --tee) for the parent
process to propagate signals down to child it spawned?

That would fix this case, and it would make things more predictable in
general (e.g., a user who manually runs kill).

It does feel like a lot of boilerplate to be propagating these signals
manually. I think the "right" Unix-y solution here is process groups:
each sub-job should get its own group, and then the top-level runner
script can kill the whole group. We may run into portability issues,
though (setsid is in util-linux, but I don't know if there's an
equivalent elsewhere; a small perl or C helper could do it, but I have
no idea what that would mean on Windows).

>       (GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
>        echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
> 
>     That 'kill' kills the "outer" shell process.
>     And though I get "ABORTED..." immediately and I get back my
>     prompt right away, the commands involved in the above construct
>     are still running in the background:
> 
>       $ ./t3903-stash.sh --stress=1
>       ^CABORTED  0.0
>       $ ps a |grep t3903
>       1280 pts/17   S      0:00 /bin/sh ./t3903-stash.sh --stress=1
>       1281 pts/17   S      0:00 tee -a <...>/test-results/t3903-stash.stress-0.out
>       1282 pts/17   S      0:00 /bin/sh ./t3903-stash.sh --stress=1
>       4173 pts/17   S+     0:00 grep t3903
> 
>     I see this behavior with all shells I tried.
>     I haven't yet started to think it through why this happens :)

I think you get ABORTED because we are just watching for the
parent-process to exit (and reporting its status). The fact that that
the subshell (and the tee) are still running is not important. That all
makes sense to me.

>     Not implying '--verbose-log' but redirecting the test script's
>     output, like you did in your 'stress' script, seems to work in
>     dash, ksh, and ks93, but not in Bash v4.3 or later, where, for
>     whatever reason, the subshell get SIGINT before the SIGTERM would
>     arrive.
>     While we could easily handle SIGINT in the subshell with the same
>     signal handler as SIGTERM, it bothers me that something
>     fundamental is wrong here.

Yeah, I don't understand the SIGINT behavior you're seeing with bash. I
can't replicate it with bash 4.4.23 (from Debian unstable).

-Peff
