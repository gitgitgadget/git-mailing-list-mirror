Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91DF7203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbcGYWWN (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:22:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:48936 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754994AbcGYWWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:22:10 -0400
Received: (qmail 18842 invoked by uid 102); 25 Jul 2016 22:22:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:22:05 -0400
Received: (qmail 29936 invoked by uid 107); 25 Jul 2016 22:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 18:22:02 -0400
Date:	Mon, 25 Jul 2016 18:22:02 -0400
From:	Jeff King <peff@peff.net>
To:	Jan Smets <jan.smets@nokia.com>
Cc:	git@vger.kernel.org, Stephen Morton <stephen.morton@nokia.com>
Subject: Re: Client exit whilst running pre-receive hook : commit accepted
 but no post-receive hook ran
Message-ID: <20160725222201.GC13589@sigill.intra.peff.net>
References: <5795EB1C.1080102@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5795EB1C.1080102@nokia.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 12:34:04PM +0200, Jan Smets wrote:

> I have always assumed the post-receive hook to be executed whenever a commit
> is "accepted" by the (gitolite) server. That does not seem to be true any
> more.

Generally, yeah, I would expect that to be the case, too.

> Since 9658846 is appears that, when a client bails out, the pre-receive hook
> continues to run and the commit is written to the repository, but no
> post-receive hook is executed. No signal of any kind is received in the
> hook, not even a sig pipe when the post- hook is writing to stdout whilst
> the client has disconnected.

I see. The problem is that cmd_receive_pack() does this:

        execute_commands(commands, unpack_status, &si);
        if (pack_lockfile)
                unlink_or_warn(pack_lockfile);
        if (report_status)
                report(commands, unpack_status);
        run_receive_hook(commands, "post-receive", 1);
        run_update_post_hook(commands);

It reports the status to the client, and _then_ runs the post-receive
hook. But if that reporting fails (either because of an error, or if we
just get SIGPIPE because the client hung up), then we don't actually run
the hooks.

Leaving 9658846 out of it entirely, it is always going to be racy
whether we notice that the client hung up during the pre-receive step.
E.g.:

  - your pre-receive might not write any output, so the muxer has
    nothing to write to the other side, and we never notice that the
    connection closed until we write the status out in report()

  - if NO_PTHREADS is set, the sideband muxer runs in a sub-process, not
    a sub-thread. And thus we don't know of a hangup except by checking
    the result of finish_async(), which we never do.

  - the client could hang up just _after_ we've written the pre-receive
    output, but before report() is called, so there's nothing to notice
    until we're in report()

So I think 9658846 just made that race a bit longer, because it means
that a write error in the sideband muxer during the pre-receive hook
means we return an error via finish_async() rather than unceremoniously
calling exit() from a sub-thread. So we have a longer period during
which we might actually finish off execute_commands() but not make it
out of report().

And the real solution is to make cmd_receive_pack() more robust, and try
harder to run the hooks even when the client hangs up or we have some
other reporting error (because getting data back to the user is only one
use of post-receive hooks; they are also used to queue jobs or do
maintenance).

But that's a bit tricky, as it requires report() to ignore SIGPIPE, and
to stop using write_or_die() or any other functions that can exit (some
of which happen at a lower level). Plus if a client does hangup, we
don't want our hook to die with SIGPIPE either, so we'd want to proxy
the data into /dev/null.

-Peff
