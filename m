Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6180C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A481B608FB
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhKCLzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:55:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhKCLzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:55:38 -0400
Received: (qmail 5049 invoked by uid 109); 3 Nov 2021 11:53:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:53:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18631 invoked by uid 111); 3 Nov 2021 11:53:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:53:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:53:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 1/2] prompt.c: split up the password and non-password
 handling
Message-ID: <YYJ4HYyl1tBs2cZN@coredump.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-1.2-ce5bea43f03-20211102T155046Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-ce5bea43f03-20211102T155046Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 05:48:09PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Rather than pass PROMPT_ASKPASS and PROMPT_ECHO flags to git_prompt()
> let's split it up into git_prompt_echo() and git_prompt_noecho()
> functions, the latter only ever needs to be called from credential.c,
> and the same goes for the previous password-only codepath in
> git_prompt(), which is now exposed as a git_prompt_password().

I'm pretty "meh" on this direction. Moving from a flag field to separate
functions means a potential combinatoric explosion if new callers are
added later, or new flags are added.

And callers get more awkward, as the choices are no longer expressed
as data, so you need new conditionals like:

> -	r = git_prompt(prompt.buf, flags);
> +	/* We'll try "askpass" for both usernames and passwords */
> +	r = git_prompt_askpass(prompt.buf);
> +	if (!r)
> +		r = password ? git_prompt_noecho(prompt.buf)
> +			     : git_prompt_echo(prompt.buf);

And we lose the human-readable names for the flags in favor of ad-hoc
booleans:

> @@ -192,11 +197,9 @@ static char *credential_ask_one(const char *what, struct credential *c,
>  static void credential_getpass(struct credential *c)
>  {
>  	if (!c->username)
> -		c->username = credential_ask_one("Username", c,
> -						 PROMPT_ASKPASS|PROMPT_ECHO);
> +		c->username = credential_ask_one(c, 0);
>  	if (!c->password)
> -		c->password = credential_ask_one("Password", c,
> -						 PROMPT_ASKPASS);
> +		c->password = credential_ask_one(c, 1);

The only thing I do like here is that askpass can be split into its own
function (as in the first hunk above), and callers can simply decide
whether they need to go on to prompt at the terminal. But even there it
feels like closing a potential door around PROMPT_ECHO. The standard
askpass interface doesn't have a way for us to ask for it to show the
contents to the user (which is useful for the username prompt). But it
would be a reasonable extension to add one. Say, a GIT_ASKPASS_ECHO
that, if set, is preferred for the username prompt.

So I dunno. This seems somewhere between churn and making things worse,
and I don't see what it's buying us at all.

-Peff
