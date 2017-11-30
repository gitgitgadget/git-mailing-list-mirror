Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFE720C11
	for <e@80x24.org>; Thu, 30 Nov 2017 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbdK3Uvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:51:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:44816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750903AbdK3Uvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:51:39 -0500
Received: (qmail 22694 invoked by uid 109); 30 Nov 2017 20:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 20:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32254 invoked by uid 111); 30 Nov 2017 20:51:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 15:51:58 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 15:51:37 -0500
Date:   Thu, 30 Nov 2017 15:51:37 -0500
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171130205137.GC3313@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129143752.60553-3-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 03:37:52PM +0100, lars.schneider@autodesk.com wrote:

> No message is printed in a "dumb" terminal as it would not be possible
> to remove the message after the editor returns. This should not be a
> problem as this feature is targeted at novice Git users and they are
> unlikely to work with a "dumb" terminal.

I think novice users could end up in this situation with something like:

  ssh remote_host git commit

But then I'd expect most terminal-based editors to give some sort of
error in that situation, too. And at any rate, the worst case is that
they get no special "waiting..." message from Git, which is already the
status quo.  So it's probably not worth worrying about such an obscure
case.

> Power users might not want to see this message or their editor might
> already print such a message (e.g. emacsclient). Allow these users to
> suppress the message by disabling the "advice.waitingForEditor" config.

I'm happy to see the hard-coded emacsclient behavior go. Hopefully we
won't see too many complaints about people having to set the advice
flag.

> The standard advise() function is not used here as it would always add
> a newline which would make deleting the message harder.

I tried to think of ways this "show a message and then delete it" could
go wrong. It should work OK with editors that just do curses-like
things, taking over the terminal and then restoring it at the end.

It does behave in a funny way if the editor produces actual lines of
output outside of the curses handling. E.g. (I just quit vim
immediately, hence the aborting message):

  $ GIT_EDITOR='echo foo; vim' git commit
  hint: Waiting for your editor input...foo
  Aborting commit due to empty commit message.

our "foo" gets tacked onto the hint line, and then our deletion does
nothing (because the newline after "foo" bumped us to a new line, and
there was nothing on that line to erase).

An even worse case (and yes, this is really reaching) is:

  $ GIT_EDITOR='echo one; printf "two\\r"; vim' git commit
  hint: Waiting for your editor input...one
  Aborting commit due to empty commit message.

There we ate the "two" line.

These are obviously the result of devils-advocate poking at the feature.
I doubt any editor would end its output with a CR. But the first case is
probably going to be common, especially for actual graphical editors. We
know that emacsclient prints its own line, and I wouldn't be surprised
if other graphical editors spew some telemetry to stderr (certainly
anything built against GTK tends to do so).

I don't think there's a good way around it. Portably saying "delete
_this_ line that I wrote earlier" would probably require libcurses or
similar. So maybe we just live with it. The deletion magic makes the
common cases better (a terminal editor that doesn't print random
lines, or a graphical editor that is quiet), and everyone else can flip
the advice switch if they need to. I dunno.

> ---
>  Documentation/config.txt |  3 +++
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  editor.c                 | 15 +++++++++++++++
>  4 files changed, 21 insertions(+)

The patch itself looks fine, as far as correctly implementing the
design.

-Peff
