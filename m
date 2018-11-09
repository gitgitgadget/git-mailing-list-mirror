Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9644C1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKITvn (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:51:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:45910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727662AbeKITvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:51:43 -0500
Received: (qmail 29856 invoked by uid 109); 9 Nov 2018 10:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 10:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16177 invoked by uid 111); 9 Nov 2018 10:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 05:11:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 05:11:48 -0500
Date:   Fri, 9 Nov 2018 05:11:48 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
Message-ID: <20181109101148.GB7410@sigill.intra.peff.net>
References: <pull.72.git.gitgitgadget@gmail.com>
 <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 01:34:19AM -0800, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When we converted a `git checkout -q $onto^0` call to use
> `reset_head()`, we inadvertently incurred a change from a twoway_merge
> to a oneway_merge, as if we wanted a `git reset --hard` instead.
> 
> This has performance ramifications under certain, though, as the
> oneway_merge needs to lstat() every single index entry whereas
> twoway_merge does not.
> 
> So let's go back to the old behavior.

Makes sense. I didn't think too hard about any possible gotchas with the
twoway/oneway switch, but if that's what git-checkout was doing before,
it seems obviously safe.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6f6d7de156..c1cc50f3f8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -523,11 +523,12 @@ finished_rebase:
>  #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
>  
>  static int reset_head(struct object_id *oid, const char *action,
> -		      const char *switch_to_branch, int detach_head,
> +		      const char *switch_to_branch,
> +		      int detach_head, int reset_hard,

It might be worth switching to a single flag variable here. It would
make calls like this:

> -	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
> +	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
>  	    NULL, msg.buf))

a little more self-documenting (if a little more verbose).

> -	if (!oid) {
> -		if (get_oid("HEAD", &head_oid)) {
> -			rollback_lock_file(&lock);
> -			return error(_("could not determine HEAD revision"));
> -		}
> -		oid = &head_oid;
> +	if (get_oid("HEAD", &head_oid)) {
> +		rollback_lock_file(&lock);
> +		return error(_("could not determine HEAD revision"));
>  	}

This one could actually turn into:

  ret = error(...);
  goto leave_reset_head;

now. We don't have to worry about an uninitialized desc.buffer anymore
(as I mentioned in the previous email), because "nr" would be 0.

It doesn't save any lines, though (but maybe having a single
cleanup/exit point would make things easier to read; I dunno).

Take all my comments as observations, not objections. This looks OK to
me either way.

-Peff
