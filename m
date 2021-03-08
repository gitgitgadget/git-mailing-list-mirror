Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77396C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CE652B4
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCHTq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:46:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:55970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhCHTqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:46:14 -0500
Received: (qmail 26842 invoked by uid 109); 8 Mar 2021 19:46:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:46:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21523 invoked by uid 111); 8 Mar 2021 19:46:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:46:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:46:13 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 7/7] parse-options: don't leak alias help messages
Message-ID: <YEZ/BWWbpfVwl6nO@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <fb456bee0f69e0ca5e596b30705c42cc037edecc.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb456bee0f69e0ca5e596b30705c42cc037edecc.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:20PM +0000, Andrzej Hunt via GitGitGadget wrote:

> preprocess_options() allocates new strings for help messages for
> OPTION_ALIAS. Therefore we also need to clean those help messages up
> when freeing the returned options.

Yep, makes sense.

> The preprocessed options themselves no longer contain any indication
> that a given option is/was an alias: the easiest and fastest way to
> figure it out is to look back at the original options. Alternatively we
> could iterate over the alias_groups list - but that would require nested
> looping and is likely to be a (little) less efficient.

Yeah, this is a bit ugly. We could probably set a bit in the aliased
struct's flags field to indicate that it's an alias, though.

> As far as I can tell, parse_options() is only ever used once per
> command, and the help messages are small - hence this leak has very
> little impact.

We _could_ UNLEAK() it, but I prefer this actual cleanup. We're getting
far enough away from main() that we aren't actually sure that we'll only
be called once per process.

> +static void free_preprocessed_options(const struct option ** preprocessed_options, const struct option *original_options)

A few style nits:

  - omit the space between "**" and preprocessed_options

  - we'd usually break a long line (after the first parameter comma)

I think preprocessed_options shouldn't be const here. After all, our aim
is to free it! I'm also not sure why it's a pointer-to-pointer. If we
were setting it to NULL after freeing, that would be valuable, but we
don't. So all together:

  static void free_preprocessed_options(struct option *preprocessed_options,
                                        const struct option *original_options)

> +{
> +	int i;
> +
> +	if (!*preprocessed_options) {
> +		return;
> +	}

Style: we'd generally omit the curly braces for a single-liner like
this.

Without the double-pointer, we can omit the extra "*" here, too.

> +	for (i = 0; original_options[i].type != OPTION_END; i++) {
> +		if (original_options[i].type == OPTION_ALIAS) {
> +			free((void *)(*preprocessed_options)[i].help);
> +		}
> +	}

OK, so we look through the original options to find ones that became an
alias, and then free them. Makes sense.

Do the indexes always correspond between the original and the
preprocessed arrays? I _think_ so, but preprocess_options() is a little
hard to follow.

If the preprocess code set a flag in the resulting option, though, we
could make it much more obviously correct. And avoid having to pass
original_options at all.

> +	free((void *)*preprocessed_options);

With the interface suggestions above, this becomes just:

  free(preprocessed_options);

> @@ -838,15 +855,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  		  int flags)
>  {
>  	struct parse_opt_ctx_t ctx;
> -	struct option *real_options;
> +	const struct option *preprocessed_options, *original_options = NULL;
>  
>  	disallow_abbreviated_options =
>  		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
>  
>  	memset(&ctx, 0, sizeof(ctx));
> -	real_options = preprocess_options(&ctx, options);
> -	if (real_options)
> -		options = real_options;
> +	preprocessed_options = preprocess_options(&ctx, options);
> +	if (preprocessed_options) {
> +		original_options = options;
> +		options = preprocessed_options;
> +	}

OK, we have to keep two variables now rather than aliasing "options",
because we need the original for feeding to the free function (but this
hunk too would go away if we set a flag).

To spell it out, I mean something like on the writing side:

diff --git a/parse-options.c b/parse-options.c
index fbea16eaf5..43431b96b1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -678,6 +678,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 			newopt[i].short_name = short_name;
 			newopt[i].long_name = long_name;
 			newopt[i].help = strbuf_detach(&help, NULL);
+			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
 			break;
 		}
 
diff --git a/parse-options.h b/parse-options.h
index ff6506a504..32b0b49a2d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -47,7 +47,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_SHELL_EVAL = 256,
 	PARSE_OPT_NOCOMPLETE = 512,
 	PARSE_OPT_COMP_ARG = 1024,
-	PARSE_OPT_CMDMODE = 2048
+	PARSE_OPT_CMDMODE = 2048,
+	PARSE_OPT_FROM_ALIAS = 4096,
 };
 
 enum parse_opt_result {

(as an aside, these manual bitfield values are tedious; I wouldn't be
sad to see them converted to "1 << 0", "1 << 1", and so on).

-Peff
