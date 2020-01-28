Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB069C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F2124684
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgA1JTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:19:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:46114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725901AbgA1JTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 04:19:15 -0500
Received: (qmail 8540 invoked by uid 109); 28 Jan 2020 09:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 09:19:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5666 invoked by uid 111); 28 Jan 2020 09:26:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 04:26:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 04:19:14 -0500
From:   Jeff King <peff@peff.net>
To:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
Message-ID: <20200128091914.GA574544@coredump.intra.peff.net>
References: <20200127100933.10765-1-git@zjvandeweg.nl>
 <20200127100933.10765-2-git@zjvandeweg.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127100933.10765-2-git@zjvandeweg.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:09:33AM +0100, Zeger-Jan van de Weg wrote:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 899e92a1c9..9f7462284d 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
>  'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
>  'git config' [<file-option>] --get-color name [default]
>  'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
> +'git config' [<file-option>] [-z|--null] --stdin

Instead of a stdin mode just for setting, you have a general --stdin
mode. That would later allow "get" commands, too. I'm not sure if that's
a good idea, though. Here are two complications which came to mind
immediately:

  - the permissions models for getting and setting might be different.
    Might we ever feed untrusted input to something like "git config
    --get --stdin", but not want it to be able to set any values?

  - what happens when get/set commands are intermixed? When are set
    commands flushed? E.g., if I send:

     set foo.bar baz
     get foo.bar

    then do I see "baz", or whatever was there before?

I think those are solvable, but unless we have a compelling use case for
a process that will both get and set values, it seems like it might be
simpler to keep the major modes separate.

> +STDIN
> +-----
> +
> +With `--stdin`, config reads instructions from standard input and performs
> +all modifications in sequence.
> +
> +Specify commands of the form:
> +
> +	set SP <key> SP <newvalue>
> +	unset SP <key>

This protocol doesn't leave much room for giving more details about each
set operation. There are several things you can do on the command line
now that you might want to specify on a per-key basis:

  - adding keys versus replacing

  - likewise, replace-all versus a single replace

  - likewise, unset versus unset-all

  - type interpretation / normalization

  - value regex matching

Even if we don't implement all of that immediately, it would be nice to
have a plan for how they'd be added to stdin mode eventually.

> +Alternatively, use `-z` or `--null` to specify in NUL-terminated format, without
> +quoting:

This mentions quoting, but the earlier form doesn't discuss it at all. I
can see from the quote that it does unquote_c_style(). It might be worth
saying so explicitly; since we're dealing with config, people may assume
that the syntax is like the one in config files (which is similar, but
not quite the same).

> +static const char *parse_cmd_set(const char *next, const char *max_char)
> +{
> +	char *key, *value;
> +	int ret;
> +
> +	key = parse_key_or_value(&next, max_char);
> +	if (!key)
> +		die(_("set: missing key"));
> +
> +	value = parse_key_or_value(&next, max_char);
> +	if (!value)
> +		die(_("set: missing value"));
> +
> +	ret = git_config_set_in_file_gently(given_config_source.file, key, value);
> +	if (ret)
> +		die(_("cannot set key value pair: %d"), ret);
> +
> +	free(key);
> +	free(value);
> +	return next;
> +}

I mentioned flushing earlier. It looks like this will flush each
individual "set" command by rewriting the whole file. But another reason
one might want to use --stdin is to set multiple keys in one go, either
for efficiency or because you'd like readers to see the result
atomically.

I don't think we actually have a function to set multiple keys in one
pass yet. And I'd be OK starting with a less-efficient implementation.
But we probably should document that the current flushing behavior is
not something people should count on, to leave us room to change it in
the future.


The code itself looked cleanly done, though I admit I didn't look too
closely. If I've convinced you on any of the design considerations
above, I think it would need rewritten a bit.

-Peff
