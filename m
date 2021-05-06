Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D2C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C08613B5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEFUEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 16:04:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:46704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhEFUEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 16:04:22 -0400
Received: (qmail 30782 invoked by uid 109); 6 May 2021 20:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 May 2021 20:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24858 invoked by uid 111); 6 May 2021 20:03:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 16:03:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 16:03:22 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] clean: remove unnecessary variable
Message-ID: <YJRLim10cznG5G3d@coredump.intra.peff.net>
References: <4f88ac58e46782c7cf335e13fabd14c8b4438267.1620329445.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f88ac58e46782c7cf335e13fabd14c8b4438267.1620329445.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 04:33:15PM -0300, Matheus Tavares wrote:

> The variable `matches` used to hold the return of a `dir_path_match()`
> call that was removed in 95c11ecc73 ("Fix error-prone fill_directory()
> API; make it only return matches", 2020-04-01). Now `matches` will
> always hold 0, which is the value it's initialized with; and the
> condition `matches != MATCHED_EXACTLY` will always evaluate to true. So
> let's remove this unnecessary variable.
>
> Interestingly, it seems that `matches != MATCHED_EXACTLY` was already
> unnecessary before 95c11ecc73. That's because `remove_directories` is
> always set to 1 when we have pathspecs; So, in the condition
> `!remove_directories && matches != MATCHED_EXACTLY`, we would either:
> 
> - have pathspecs (or have been given `-d`) and ignore `matches` because
>   `remove_directories` is 1; or
> 
> - not have pathspecs (nor `-d`) and end up just checking that
>   `0 != MATCHED_EXACTLY`, as `matches` would never get reassigned
>   after its zero initialization (because there is no pathspec to match).

Thanks for this digging and the extra analysis. We can see from the
patch that this variable can't possibly be doing anything, but it is
always a comfort to see authors researching the source of the oddity and
explaining what they found.

I'm adding Elijah to the cc as an area expert, just in case he has any
other insight.

> diff --git a/builtin/clean.c b/builtin/clean.c
> index 995053b791..f6d7e8119c 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -1003,7 +1003,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	for (i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];
> -		int matches = 0;
>  		struct stat st;
>  		const char *rel;
>  
> @@ -1013,8 +1012,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		if (lstat(ent->name, &st))
>  			die_errno("Cannot lstat '%s'", ent->name);
>  
> -		if (S_ISDIR(st.st_mode) && !remove_directories &&
> -		    matches != MATCHED_EXACTLY)
> +		if (S_ISDIR(st.st_mode) && !remove_directories)
>  			continue;
>  
>  		rel = relative_path(ent->name, prefix, &buf);

Definitely not necessary, but on a patch like this I'll sometimes
manually specify "-U4" (and I always have diff.interhunkcontext set to
"1") to show the complete code between the declaration and use. It makes
it even more obvious that the result is correct (though obviously
applying and compiling shows it, too). #gitlifehacks

-Peff
