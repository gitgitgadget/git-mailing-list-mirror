Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C6120248
	for <e@80x24.org>; Fri,  1 Mar 2019 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfCATAy (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 14:00:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:34794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728570AbfCATAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 14:00:46 -0500
Received: (qmail 21100 invoked by uid 109); 1 Mar 2019 19:00:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 19:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 627 invoked by uid 111); 1 Mar 2019 19:01:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 14:01:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 14:00:42 -0500
Date:   Fri, 1 Mar 2019 14:00:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20190301190042.GF30847@sigill.intra.peff.net>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
 <20180814223246.GA2379@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
 <20190208195459.GA32556@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 04:02:22PM +0100, Johannes Schindelin wrote:

> > I think that patch does the write_or_die conversion to handle EPIPE, but
> > it would still need to turn off SIGPIPE for the whole process.
> > 
> > So you'd also need to stick a:
> > 
> >   sigchain_push(SIGPIPE, SIG_IGN);
> > 
> > somewhere near the start of cmd_fetch(). (There may be a less
> > coarse-grained place to put it, but at this point I think we're just
> > trying to find out whether this approach even solves the problem).
> 
> This fixes it, it seems. I let the job run with `--stress=50` and even
> after half an hour, it did not fail:
> 
> attempts ://git.visualstudio.com/git/_build/results?buildId=354

Cool, I'm glad it works!

> (I had to cancel it, I thought that `--stress=50` would stop trying after
> 50 runs, but I was obviously incorrect in that assumption...)

No, that will do 50 simultaneous jobs. You want --stress-limit=50.

It might make more sense to have --stress-jobs, and make --stress=X set
the limit, as I think it's much more useful to set the limit than it is
to set the number of jobs. At least that's my experience.

> So. Good, we have a diff that works. But you mentioned that you'd like to
> put it somewhere else? I am a bit unfamiliar with the code paths of
> `cmd_fetch()`, so I would be hard pressed to find a better spot. Any hint?

Well, I'm of two minds there. If we want to make the minimum change,
then we'd just want to disable SIGPIPE while we're actually conversing
with the other side. So I guess that would be somewhere in do_fetch(),
before we start talking to the other side, and restoring it after we've
finished our half of the conversation (i.e., after we've done all the
want/have bits and we're receiving the pack). But that's actually pretty
awkward to do, because most of those details are handled under the hood
by the transport code.

So probably something like this is the least-terrible place to put it:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b620fd54b4..4ba63d5ac6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1556,7 +1556,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
+	sigchain_push(SIGPIPE, SIG_IGN);
 	exit_code = do_fetch(gtransport, &rs);
+	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;

That said, I actually think it's kind of pointless for git-fetch to use
SIGPIPE at all. The purpose of SIGPIPE is that you can write a naive
program that spews output, and you'll get informed (forcefully) by the
OS if the process consuming your output stops listening. That makes
sense for programs like "git log", whose primary purpose is generating
output.

But for git-fetch, our primary purpose is receiving data and writing it
to disk. We should be checking all of our write()s already, and SIGPIPE
is just confusing. The only "big" output we generate is the status table
at the end. And even if that is going to a pipe that closes, I don't
think we'd want to fail the whole command (we'd want to finalize any
writes for what we just fetched, clean up after ourselves, etc).

So I'd actually be fine with just declaring that certain commands (like
fetch) just ignore SIGPIPE entirely.

-Peff
