Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3BC1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfD2Xka (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 19:40:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728748AbfD2Xka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 19:40:30 -0400
Received: (qmail 15567 invoked by uid 109); 29 Apr 2019 23:40:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Apr 2019 23:40:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5832 invoked by uid 111); 29 Apr 2019 23:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Apr 2019 19:41:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Apr 2019 19:40:28 -0400
Date:   Mon, 29 Apr 2019 19:40:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?SmFyb3PFgmF3?= Honkis via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SmFyb3PFgmF3?= Honkis <yaras6@gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
Message-ID: <20190429234028.GA24069@sigill.intra.peff.net>
References: <pull.138.git.gitgitgadget@gmail.com>
 <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 03:06:11PM -0700, Jarosław Honkis via GitGitGadget wrote:

> From: =?UTF-8?q?Jaros=C5=82aw=20Honkis?= <yaras6@gmail.com>
> 
> When a user is asked for credentials there is no need to mask the
> username, so the PROMPT_ASKPASS flag on calling credential_ask_one for
> login is unnecessary.
> 
> The `credential_ask_one()` function internally uses `git_prompt()` which
> in case it is given the flag PROMPT_ASKPASS uses masked input method
> instead of git_terminal_prompt, which does not mask user input.

This description (and the patch) doesn't make sense to me. The
PROMPT_ASKPASS flag is just about whether we would trigger the askpass
tool (e.g., if the user does not have a terminal).

The PROMPT_ECHO flag is what you want to tell the underlying code that
the value can be shown to the user. And that's already set.

Now there is a slight issue, which is that the askpass tool has no way
for us to tell it to show the contents to the user.  There's no way
around that without disabling askpass entirely, which I guess is the
strategy this patch is trying to do. But in doing so it's going to break
anybody who _doesn't_ have a terminal, because now we have no way to
prompt there for their username!

So I think our options are:

  1. Leave it. If people don't want askpass to prompt them, they should
     not set up askpass.

  2. Use another tool besides askpass. I don't know of any askpass
     implementations that take something like our ECHO flag, but there
     are lots of other tools. I doubt there's any easy portable
     solution, though. And anyway, credential helpers are a much more
     advanced version of this anyway, so I'd probably steer people in
     that direction.

  3. If we really want to try to try to avoid using askpass for
     usernames we can, but I don't think the logic in this patch is
     right.

     If we want to avoid regressing existing cases, then we'd have to
     first check if there's a usable terminal. And only if _that_ fails,
     try askpass. And then give up if neither work. I.e., invert the
     order in git_prompt() when both ASKPASS and ECHO are set.

     I think I'd still favor option 1 over this, though. Configuring
     askpass has always overridden the terminal for usernames, and this
     would change that. I come back to: if you don't want to use
     askpass, then why are you configuring it?

>  		c->username = credential_ask_one("Username", c,
> -						 PROMPT_ASKPASS|PROMPT_ECHO);
> +						 (getenv("GIT_ASKPASS") ?
> +						  PROMPT_ASKPASS : 0) |
> +						 PROMPT_ECHO);

This logic is weird. It still uses askpass if GIT_ASKPASS isn't set. But
_doesn't_ if it's set elsewhere, e.g. in core.askPass. Which makes
little sense to me.

Maybe the intent was that the original user has SSH_ASKPASS set, and
that is kicking in (which would also explain why "if you don't like it,
don't configure it" didn't work). You can get around that by setting
GIT_ASKPASS (or core.askPass) to the empty string (I don't think that's
documented anywhere, and I don't recall it being intentional, but it
does look like that's how the code works).

-Peff
