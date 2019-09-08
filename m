Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68A11F461
	for <e@80x24.org>; Sun,  8 Sep 2019 10:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfIHK2l (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 06:28:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:43310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727018AbfIHK2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 06:28:41 -0400
Received: (qmail 17602 invoked by uid 109); 8 Sep 2019 10:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 10:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 336 invoked by uid 111); 8 Sep 2019 10:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 06:30:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 06:28:40 -0400
From:   Jeff King <peff@peff.net>
To:     Douglas Graham <douglas.graham@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: O_NONBLOCK: should I blame git or ssh?
Message-ID: <20190908102839.GC15641@sigill.intra.peff.net>
References: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 11:50:41PM +0000, Douglas Graham wrote:

> We have a parallel build that occasionally fails with the error message
> "make: write error".  Make prints that error message as it is exiting when
> it detects that it has seen errors while writing to stdout.  The error it
> is enountering is an EAGAIN error, which implies that something has made
> its stdout non-blocking.  As far as I've been able to tell so far, this is
> occurring while make is running the command "git fetch --quiet --tags".
> Once that command finishes, stdout goes back to being blocking but since
> this is a parallel build, make is doing other work while this git command
> is running, and may attempt to write to stdout during that time.

As I understand it, the mechanism you describe here for your symptoms is
plausible, because O_NONBLOCK is not attached to a particular
descriptor, but a POSIX "file description". So a sub-process setting
flags on its stdout can impact the parent process.

But...

> By stracing this git command, I can see it running subcommand
> 
> ssh -p 29418 user@gerrit.domain "git-upload-pack '/repo'"

I don't think this can directly be the culprit, because that ssh's
stdout will be hooked to a pipe talking to Git, not to the original
stdout of "git fetch". It should not have even received a descriptor
that is a copy of the original stdout (nor stdin), since those would
have been closed as part of the fork+exec.

The child ssh _does_ have access to the original stderr, which could
plausibly be a dup of the original stdout. But your strace shows ssh
setting the flag only for stdin/stdout.

> Should this be considered a git bug or an ssh bug or something else?

I'm not convinced that what you've found is the root cause of your
problem. But even if it is, I don't think you can fault Git. We never
touch the descriptor flags ourselves, and ssh is a black box to us.

> I thought I had finally figured out exactly what is happening but while writing this,
> now I'm not sure why my workaround appears to be working.  My workaround is to pipe
> make's stdout into a simple program that reads make's output and writes it to where
> make uses to write to, except it does a select() on descriptor 1 before writing, and
> it makes sure to handle short counts.  But now I'm thinking that if it's the ssh started
> indirectly by make that is messing with O_NONBLOCK, presumably it would be messing
> with O_NONBLOCK on the write side of the pipe that make writes to, so make should
> still be encountering EAGAIN errors. And yet my workaround does seem to work.

It's possible that it helps because your pipe-reading program is
(almost) always trying to read, and thus "make" on the writing end of
the pipe never sees EAGAIN. As long as your program reads the output
before the pipe buffer fills up, you'd be fine. Where did the output go
in your original? If to a regular file, I'd expect O_NONBLOCK to have no
effect anyway.

-Peff
