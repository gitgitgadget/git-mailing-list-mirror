Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C9C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419B720656
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgD0MC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:02:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:40716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726260AbgD0MC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 08:02:26 -0400
Received: (qmail 11751 invoked by uid 109); 27 Apr 2020 12:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 12:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22414 invoked by uid 111); 27 Apr 2020 12:13:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 08:13:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 08:02:25 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules
Message-ID: <20200427120225.GB1718141@coredump.intra.peff.net>
References: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
 <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:44:08AM -0400, Denton Liu wrote:

> When the usage for `git push` is shown, it includes the following
> lines
> 
> 	--recurse-submodules[=(check|on-demand|no)]
> 			      control recursive pushing of submodules
> 
> which seem to indicate that the argument for --recurse-submodules is
> optional. However, we cannot actually run that optiion without an
> argument:
> 
> 	$ git push --recurse-submodules
> 	fatal: recurse-submodules missing parameter
> 
> Unset PARSE_OPT_OPTARG so that it is clear that this option requires an
> argument. Since the parse-options machinery guarantees that an argument
> is present now, assume that `arg` is set in the else of
> option_parse_recurse_submodules().

Yeah, I think this is the right solution. It looks like it was broken
since the option was introduced in d2b17b3220 (push: Don't push a
repository with unpushed submodules, 2011-08-20).

I wondered if it was copied from another similar option in another
command, and if so whether that option had the same problem. But it
doesn't look like it. The other --recurse-submodules options are all
PARSE_OPT_OPTARG, but they actually do something useful when they are
not given an option (they turn it to "on").

I don't know enough about the "push" case to say whether it would be a
good idea for it to behave similarly, but certainly your patch is an
improvement until somebody decides to look into it.

> diff --git a/builtin/push.c b/builtin/push.c
> index 6dbf0f0bb7..90f071fcf2 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -434,10 +434,8 @@ static int option_parse_recurse_submodules(const struct option *opt,
>  
>  	if (unset)
>  		*recurse_submodules = RECURSE_SUBMODULES_OFF;
> -	else if (arg)
> -		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
>  	else
> -		die("%s missing parameter", opt->long_name);
> +		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);

What a lousy diff. It would be much easier to read if we chose to
replace the "else" and keep the big complicated line intact. :)
Both Myers and --histogram give the diff above, but --patience gives:

diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb7..ac6cc07c8c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -434,10 +434,8 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 	if (unset)
 		*recurse_submodules = RECURSE_SUBMODULES_OFF;
-	else if (arg)
+	else
 		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
-	else
-		die("%s missing parameter", opt->long_name);
 
 	return 0;
 }

Obviously not a complaint about your patch. I'm always just curious to
see cases where the various diff implementations do better or worse than
each other.

> @@ -554,7 +552,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
>  		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
>  			N_("control recursive pushing of submodules"),
> -			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
> +			0, option_parse_recurse_submodules },

This could collapse down to OPT_CALLBACK() now, though I don't think
it's a big deal either way.

-Peff
