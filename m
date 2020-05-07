Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2BC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9479208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGWZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:25:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726437AbgEGWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:25:11 -0400
Received: (qmail 3515 invoked by uid 109); 7 May 2020 22:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 22:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22816 invoked by uid 111); 7 May 2020 22:25:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 18:25:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 18:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
Message-ID: <20200507222510.GA42822@coredump.intra.peff.net>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 09:29:40PM +0000, Christopher Warrington via GitGitGadget wrote:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1e..8406a9adc36 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -209,7 +209,11 @@ bisect_replay () {
>  	test "$#" -eq 1 || die "$(gettext "No logfile given")"
>  	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
>  	git bisect--helper --bisect-reset || exit
> -	while read git bisect command rev
> +
> +	# We remove any CR in the input to handle bisect log files that have
> +	# CRLF line endings. The assumption is that CR within bisect
> +	# commands also don't matter.
> +	tr -d '\r' <"$file" | while read git bisect command rev
>  	do
>  		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
>  		if test "$git" = "git-bisect"
> @@ -231,7 +235,9 @@ bisect_replay () {
>  		*)
>  			die "$(gettext "?? what are you talking about?")" ;;
>  		esac
> -	done <"$file"
> +	done

This puts the while-loop on the right-hand side of a pipe, which means
that it's not running in the main shell environment any longer. So any
variables set will be lost after the loop ends, any calls to exit will
only exit the loop and not the whole script, etc.

It looks like we might call into bisect_start inside the loop, which
does exit. I didn't trace all the way through its sub-functions to see
if they set variables.

The simplest fix is probably to clean up "$file" into another tempfile,
and then read from that.

-Peff
