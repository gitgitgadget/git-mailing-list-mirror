Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A7471F454
	for <e@80x24.org>; Thu,  7 Nov 2019 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKGVWh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 16:22:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:42450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725770AbfKGVWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 16:22:37 -0500
Received: (qmail 7635 invoked by uid 109); 7 Nov 2019 21:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 21:22:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5881 invoked by uid 111); 7 Nov 2019 21:25:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 16:25:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 16:22:35 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] progress: create GIT_PROGRESS_DELAY
Message-ID: <20191107212235.GB29042@sigill.intra.peff.net>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <656dba5afb818d0caa7616d0e58c9728803f8d04.1573148818.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <656dba5afb818d0caa7616d0e58c9728803f8d04.1573148818.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 05:46:57PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The start_delayed_progress() method is a preferred way to show
> optional progress to users as it ignores steps that take less
> than two seconds. However, this makes testing unreliable as tests
> expect to be very fast.
> 
> In addition, users may want to decrease or increase this time
> interval depending on their preferences for terminal noise.
> 
> Create the GIT_PROGRESS_DELAY environment variable to control
> the delay set during start_delayed_progress(). Set the value
> in some tests to guarantee their output remains consistent.

Thanks for wrapping this up. I obviously think this is a good direction
to go. :) A few thoughts:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 9b82564d1a..1c420da208 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -544,6 +544,10 @@ other
>  	a pager.  See also the `core.pager` option in
>  	linkgit:git-config[1].
>  
> +`GIT_PROGRESS_DELAY`::
> +	A number controlling how many seconds to delay before showing
> +	optional progress indicators. Defaults to 2.

Not all progress meters use delay. I wonder if that might confuse some
users, who would try:

  GIT_PROGRESS_DELAY=10 git repack -ad

or something, but still see "Enumerating objects".

I guess the key word in your documentation is "optional", but maybe it
needs to be spelled out more clearly. I dunno.

> @@ -269,7 +270,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  
>  struct progress *start_delayed_progress(const char *title, uint64_t total)
>  {
> -	return start_progress_delay(title, total, 2, 0);
> +	static int delay_in_secs = -1;
> +
> +	if (delay_in_secs < 0)
> +		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
> +
> +	return start_progress_delay(title, total, delay_in_secs, 0);
>  }

You asked earlier if it was worth memo-izing the git_env_ulong() call
like this. I suspect it doesn't matter much either way, since progress
only starts and stops a few times in a given program. But I'm certainly
happy with it this way, as it matches most other environment lookups.

-Peff
