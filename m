Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68B71F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 01:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbcITBrh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 21:47:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:45373 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752263AbcITBrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 21:47:36 -0400
Received: (qmail 12575 invoked by uid 109); 20 Sep 2016 01:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 01:47:36 +0000
Received: (qmail 16258 invoked by uid 111); 20 Sep 2016 01:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Sep 2016 21:47:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 18:47:34 -0700
Date:   Mon, 19 Sep 2016 18:47:34 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
Message-ID: <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net>
References: <nrmbrl$hsk$1@blaine.gmane.org>
 <nrmd6u$imf$1@blaine.gmane.org>
 <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 09:03:05AM -0700, Junio C Hamano wrote:

> Anatoly Borodin <anatoly.borodin@gmail.com> writes:
> 
> >> I think, the pagination should be turned off when the editor is being
> >> called.
> 
> This is a fun one.  IIRC, we decide to spawn a pager and run our
> output via pipe thru it fairly early, even before we figure out
> which subcommand is being run (especially if you do "git -p
> subcommand"), which by definition is way before we know if that
> subcommand wants to let the user edit things with the editor.

Right. Once the pager is spawned, it is too late to change things (even
if we spawned the editor directed to /dev/tty, it would be racily
competing for input with the pager).

And this isn't really limited to the editor. It's more _annoying_ with
the editor, but really "pager.tag" does not make any sense to set right
now, because it is handled outside of the "tag" command entirely, and
doesn't know what mode the tag command will be running in. So it's
_also_ the wrong thing to do with "git tag foo", which doesn't run an
editor (but you don't tend to notice if you use "less -F" because the
pager just quits immediately).

So you really only want to page tag-listing (and the same for branch,
config, etc). A long time ago I had a patch to add "pager.tag.list", and
the tag command would decide whether and how to page after realizing it
was in listing mode. Looks like I did send it to the list:

  http://public-inbox.org/git/20111007144438.GA30318@sigill.intra.peff.net/

though I think there are some rough edges (like handling "git stash
list").

I also wonder if there are any commands that actually have more than one
sub-command. So another option would be to teach the main git.c a
blacklist of "do not respect pager config" commands (like tag), and then
tag itself could decide to respect pager.tag at the right moment.

I think that makes things worse for a third-party command, though; we
cannot know whether a script "git-foobar" dropped into the $PATH would
like us to respect pager.foobar or if it would prefer to decide itself
later.

-Peff
