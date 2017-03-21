Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AFC20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756019AbdCUB4I (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:56:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756004AbdCUB4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:56:07 -0400
Received: (qmail 12417 invoked by uid 109); 21 Mar 2017 01:49:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:49:26 +0000
Received: (qmail 10074 invoked by uid 111); 21 Mar 2017 01:49:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:49:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:49:21 -0400
Date:   Mon, 20 Mar 2017 21:49:21 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] t1400: set core.logAllRefUpdates in "logged by
 touch" tests
Message-ID: <20170321014920.qas2xbbx66zqo5lp@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com>
 <20170321005616.31324-3-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321005616.31324-3-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 08:56:13PM -0400, Kyle Meyer wrote:

> A group of update-ref tests verifies that logs are created when either
> the log file for the ref already exists or core.logAllRefUpdates is
> "true".  However, when the default for core.logAllRefUpdates was
> changed in 0bee59186 (Enable reflogs by default in any repository with
> a working directory., 2006-12-14), the setup for the tests was not
> updated.  As a result, the "logged by touch" tests would pass even if
> the log file did not exist (i.e., if "--create-reflog" was removed
> from the first "git update-ref" call).
> 
> Update the "logged by touch" tests to disable core.logAllRefUpdates
> explicitly so that the behavior does not depend on the default value.

Good catch.

> While we're here, update the "logged by config" tests to use
> test_config() rather than setting core.logAllRefUpdates to "true"
> outside of the tests.

Yeah, I agree that makes the result more obvious to read.

> I'm confused about the setup for the "logged by touch" tests.
> d0ab05849 (tests: remove some direct access to .git/logs, 2015-07-27)
> changed the setup to delete the log file itself rather than its
> contents.  The reflog was then recreated by using "--create-reflog" in
> the "create $m (logged by touch)" test.  What I don't understand is
> how this change fits with d0ab05849, which seems to be concerned with
> loosening the assumption that the logs are stored in .git/logs.

I suspect the answer is that the conversion was incomplete. That commit
was done for alternate ref backends, which is an ongoing saga.

I think it's OK to leave it as-is for now. It's not clear what "logged
by touch" will look like for backends that don't use the filesystem.
Probably it will need to call "update-ref --create-reflog" to kickstart
it, and then further updates will automatically write to it.

At that point the "rm -f" would need to become "tell the backend to
delete this reflog". There's no command for that now, but we can add one
later. Until then, I suspect the "rm -f" would be a noop. That means
that the first --create-reflog test is failing to test what it claims,
but the result passes anyway.

And that probably answers the question about why the conversion is
half-done. It was enough to get the tests to stop complaining when built
with an alternate ref backend. :)

> For these particular tests, we are still removing
> .git/logs/refs/heads/master explictly, so why not leave the empty file
> around so that the "create $m (logged by touch)" actually tests that
> update-ref call is logged by the existence of the log rather than
> using "--create-reflog", which overrides this?

I think the tests just wanted to start at a known state. I agree that
be correct (and would even work with an alternate backend), but it is a
bit subtle that we are relying on the leftover state from the previous
tests.

>  t/t1400-update-ref.sh | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Patch itself looks good.

-Peff
