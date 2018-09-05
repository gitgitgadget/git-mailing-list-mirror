Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6B71F404
	for <e@80x24.org>; Wed,  5 Sep 2018 20:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIFA4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 20:56:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727527AbeIFA4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 20:56:37 -0400
Received: (qmail 28417 invoked by uid 109); 5 Sep 2018 20:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Sep 2018 20:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23170 invoked by uid 111); 5 Sep 2018 20:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 16:24:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 16:24:46 -0400
Date:   Wed, 5 Sep 2018 16:24:46 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with
 --write-junit-xml upon failure
Message-ID: <20180905202445.GA8953@sigill.intra.peff.net>
References: <pull.31.git.gitgitgadget@gmail.com>
 <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
 <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
 <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
 <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 02:38:34PM -0400, Eric Sunshine wrote:

> On Wed, Sep 5, 2018 at 8:39 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > So let's hear some ideas how to improve the situation, m'kay?
> > Just as a reminder, this is the problem I want to solve: I want to run the
> > tests in a light-weight manner, with minimal output, and only in case of
> > an error do I want to crank up the verbosity. Instead of wasting most of the
> > effort to log everything and then throwing it away in most of the common
> > cases, I suggest to re-run the entire test.
> 
> What about the very different approach of capturing the full "verbose"
> output the executed tests in addition to whatever is actually output
> to the terminal? If a test fails, then (and only then) you can insert
> the captured verbose output into the JUnit XML file. This way (if we
> always have the full verbose output at hand), you don't need to re-run
> the test at all.
> 
> I've cc:'d Peff and Jonathan since I believe they are more familiar
> with how all the capturing / output-redirection works in the test
> suite.

I don't think there's much to know beyond what you wrote. The
"--verbose" case does not really cost any more than the non-verbose one,
because the only difference is whether output goes to a file versus
/dev/null. But the commands all call write() regardless.

For --verbose-log, it does of course cost a little extra to run one
`tee` per script, and to write a few kb of logs. I doubt those are
measurable versus the rest of a script run, but I'm happy to be
disproven by numbers. There are some gymnastics done to re-exec the test
script with the same shell, but AFAIK those are robust and don't cost a
lot (again, one extra process per script run).

I'm not overly concerned about the cost of re-running a test, since the
idea is that failed tests should be rare. I would be a little worried
about flaky tests mysteriously righting themselves on the second run (so
you know a failure happened, but you have no good output to describe
it).

I do agree that a test_atexit() cleanup would make a lot more sense than
what's in the original patch. And that's nicer than the exit trap we're
using already, because you may note that each caller has to manually
restore the original 'die' handler that test-lib.sh installs.

That would also help with bitrot. If this funky cleanup case only causes
problems with junit output, then other people are likely to forget to do
it, and the mess falls onto the junit folks (i.e., Dscho). But if the
tests start _relying_ on test_atexit() being called (i.e., don't call
stop_git_daemon manually, but assume that the atexit handler does so),
then the responsible authors are a lot more likely to notice and fix it
early.

-Peff
