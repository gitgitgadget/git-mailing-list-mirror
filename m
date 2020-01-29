Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E3AC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00342064C
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgA2KRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:17:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:47346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726068AbgA2KRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:17:14 -0500
Received: (qmail 16136 invoked by uid 109); 29 Jan 2020 10:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 10:17:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15460 invoked by uid 111); 29 Jan 2020 10:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 05:24:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 05:17:13 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
Message-ID: <20200129101713.GB4218@coredump.intra.peff.net>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 06:26:41PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> If a user somehow creates a directory with an asterisk (*) or backslash
> (\), then the "git sparse-checkout set" command will struggle to provide
> the correct pattern in the sparse-checkout file. When not in cone mode,
> the provided pattern is written directly into the sparse-checkout file.
> However, in cone mode we expect a list of paths to directories and then
> we convert those into patterns.

Is this really about cone mode? It seems more like it is about --stdin.
I.e., what are the rules for when the input is a filename and when it is
a pattern? In our earlier discussion, I had assumed that command-line
arguments to "sparse-checkout set" were actual filenames, and "--stdin"
just read them from stdin.

But looking at the documentation, they are always called "patterns" on
the command-line. Should the "--stdin" documentation make it clear that
we are no longer taking patterns, but instead actual filenames?

Or am I confused, and in non-cone-mode the "ls-tree | sparse-checkout"
pipeline is not supposed to work at all? (I.e., they really are always
patterns)?

> Even more specifically, the goal is to always allow the following from
> the root of a repo:
> 
>   git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
> 
> The ls-tree command provides directory names with an unescaped asterisk.
> It also quotes the directories that contain an escaped backslash. We
> must remove these quotes, then keep the escaped backslashes.
> 
> However, there is some care needed for the timing of these escapes. The
> in-memory pattern list is used to update the working directory before
> writing the patterns to disk. Thus, we need the command to have the
> unescaped names in the hashsets for the cone comparisons, then escape
> the patterns later.

OK, this part make sense.

> Use unquote_c_style() when parsing lines from stdin. Command-line
> arguments will be parsed as-is, assuming the user can do the correct
> level of escaping from their environment to match the exact directory
> names.

I think there's two issues here: escaping characters from the shell so
that they make it intact to Git, and the question of whether Git is
expecting patterns or raw filenames. I agree the user is responsible for
the shell half, but I think we need to clarify what we're expecting.
I.e., if I say:

 git sparse-checkout set 'f*'

am I trying to match "foo", or the literal file "f*"?

> +static char *escaped_pattern(char *pattern)
> +{
> +	char *p = pattern;
> +	struct strbuf final = STRBUF_INIT;
> +
> +	while (*p) {
> +		if (*p == '*' || *p == '\\')
> +			strbuf_addch(&final, '\\');
> +
> +		strbuf_addch(&final, *p);
> +		p++;
> +	}
> +
> +	return strbuf_detach(&final, NULL);
> +}

Do we need to catch other metacharacters here (using is_glob_special()
perhaps)?

> @@ -423,8 +442,21 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  		pl.use_cone_patterns = 1;
>  
>  		if (set_opts.use_stdin) {
> -			while (!strbuf_getline(&line, stdin))
> +			struct strbuf unquoted = STRBUF_INIT;
> +			while (!strbuf_getline(&line, stdin)) {
> +				if (line.buf[0] == '"') {
> +					strbuf_setlen(&unquoted, 0);

A minor nit, but strbuf_reset(&unquoted) would be more idiomatic here.

> +					if (unquote_c_style(&unquoted, line.buf, NULL))
> +						die(_("unable to unquote C-style string '%s'"),
> +						line.buf);
> +
> +					strbuf_swap(&unquoted, &line);
> +				}
> +
>  				strbuf_to_cone_pattern(&line, &pl);
> +			}

OK, overall this input procedure makes sense to me.

-Peff
