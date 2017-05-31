Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC121FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdEaWBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:01:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:60971 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdEaWBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:01:02 -0400
Received: (qmail 18733 invoked by uid 109); 31 May 2017 22:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 22:01:01 +0000
Received: (qmail 10868 invoked by uid 111); 31 May 2017 22:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 18:01:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 18:01:01 -0400
Date:   Wed, 31 May 2017 18:01:01 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/2] format-patch: have progress option while generating
 patches
Message-ID: <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170531150427.7820-2-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531150427.7820-2-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 08:04:26AM -0700, Kevin Willford wrote:

> When generating patches for the rebase command if the user does
> not realize the branch they are rebasing onto is thousands of
> commits different there is no progress indication after initial
> rewinding message.
> 
> This patch allows a progress option to be passed to format-patch
> so that the user can be informed the progress of generating the
> patch.  This option will then be used by the rebase command when
> calling format-patch.

I'm generally in favor of progress meters, though it does seem a little
funny to me that we'd need one on format-patch. It's basically the same
operation as "git log -p", after all. I guess one difference is that
usually the output of "log" would stream to the pager, so the user would
see immediate output. That's true of format-patch, too, but in the
instance you care about we're probably doing something more like:

  git format-patch "$@" >patches

and the user sees nothing.

That makes me wonder two things:

  1. Should this really be tied to isatty(2), as the documentation
     claims?  It seems like you'd really only want it to kick in for
     certain cases. Arguably whenever stdout is _not_ going to a tty
     you'd want progress, but I think probably the caller should
     probably just decide whether to ask for it or not.

  2. Should this apply to other commands in the log family besides
     format-patch? E.g., should "git log --progress -p >commits" work?

     I added a progress meter to rev-list a while ago (for connectivity
     checks). I don't think we could push this down as far as the
     revision traversal code, because only its callers really understand
     what's the right unit to be counting.

     It may not be worth the trouble, though. Only "format-patch" does a
     pre-pass to find the total number of commits. So "git log
     --progress" would inherently just be counting up, with no clue what
     the final number is.

> @@ -283,6 +285,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  	range are always formatted as creation patches, independently
>  	of this flag.
>  
> +--progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal, unless -q
> +	is specified. This flag forces progress status even if the
> +	standard error stream is not directed to a terminal.

Checking whether stderr is a tty would match our usual progress meters.
But I don't actually see any code in the patch implementing this.

As I said above, I think I'd prefer it to require "--progress", as
format-patch is quite often used as plumbing. But we'd need to fix the
documentation here to match.

> @@ -1739,8 +1744,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		start_number--;
>  	}
>  	rev.add_signoff = do_signoff;
> +
> +	if (show_progress && !quiet)
> +		progress = start_progress(_("Generating patch"), total);

The meter code here all looks correct, but let me bikeshed for a moment. :)

Should this use start_progress_delay()? In most cases the command will
complete very quickly, and the progress report is just noise. For many
commands (e.g., checkout) we wait 1-2 seconds before bothering to show
progress output.

I would have expected this to say "Generating patches"; most of our
other progress messages are pluralized. You could use Q_() to handle the
mono/plural case, but I think it's fine to just always say "patches"
(that's what other messages do).

One final thought is whether callers would want to customize this
message, since it will often be used as plumbing. E.g., would rebase
want to say something besides "Generating patches". I'm not sure.
Anyway, if you're interested in that direction, there's prior art in
the way rev-list handles "--progress" (and its sole caller,
check_connected()).

-Peff
