Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591E41FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 09:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753756AbcLLJkO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 04:40:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:55062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753437AbcLLJkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 04:40:13 -0500
Received: (qmail 24910 invoked by uid 109); 12 Dec 2016 09:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 09:40:12 +0000
Received: (qmail 4430 invoked by uid 111); 12 Dec 2016 09:40:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 04:40:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 04:40:09 -0500
Date:   Mon, 12 Dec 2016 04:40:09 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com, gitster@pobox.com
Subject: Re: [RFC/PATCH] merge: Add '--continue' option as a synonym for 'git
 commit'
Message-ID: <20161212094009.wfejbdullac37oi3@sigill.intra.peff.net>
References: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
 <20161212083413.7334-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161212083413.7334-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 09:34:13PM +1300, Chris Packham wrote:

> Teach 'git merge' the --continue option which allows 'continuing' a
> merge by completing it. The traditional way of completing a merge after
> resolving conflicts is to use 'git commit'. Now with commands like 'git
> rebase' and 'git cherry-pick' having a '--continue' option adding such
> an option to 'git merge' presents a consistent UI.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> So here is a quick patch that adds the --continue option. I need to add
> some tests (suggestions for where to start are welcome).

I'm not sure if there's much to test besides concluding a successful
merge, and possibly some error cases where --continue should complain.
Probably that could go at the end of t7600.

> @@ -1166,6 +1169,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		goto done;
>  	}
>  
> +	if (continue_current_merge) {
> +		int nargc = 1;
> +		const char *nargv[] = {"commit", NULL};
> +
> +		if (!file_exists(git_path_merge_head()))
> +			die(_("There is no merge in progress (MERGE_HEAD missing)."));
> +
> +		/* Invoke 'git commit' */
> +		ret = cmd_commit(nargc, nargv, prefix);
> +		goto done;
> +	}
> +

I know this block is just adapted from the "--abort" one above, but
should both of these complain when other arguments are given? I can't
imagine what the user might mean with "git merge --no-commit
--continue", but probably it should be an error.  :)

-Peff
