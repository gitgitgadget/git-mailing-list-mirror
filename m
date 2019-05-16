Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABF01F461
	for <e@80x24.org>; Thu, 16 May 2019 22:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfEPWC5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:02:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726491AbfEPWC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:02:56 -0400
Received: (qmail 2647 invoked by uid 109); 16 May 2019 22:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 22:02:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7792 invoked by uid 111); 16 May 2019 22:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 18:03:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 18:02:54 -0400
Date:   Thu, 16 May 2019 18:02:54 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH v2] grep: provide sane default to grep_source struct
Message-ID: <20190516220254.GG10787@sigill.intra.peff.net>
References: <20190516020023.61161-1-emilyshaffer@google.com>
 <20190516214444.191743-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516214444.191743-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 02:44:44PM -0700, Emily Shaffer wrote:

> grep_buffer creates a struct grep_source gs and calls grep_source()
> with it. However, gs.name is null, which eventually produces a
> segmentation fault in
> grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
> not set.

Funny wrapping here.

> This seems to be unreachable from existing commands but is reachable in
> the event that someone rolls their own revision walk and neglects to set
> rev_info->grep_filter->status_only. Conceivably, someone might want to
> print all changed lines of all commits which match some regex.
> 
> To futureproof, give developers a heads-up if grep_source() is called
> and a valid name field is expected but not given. This path should be
> unreachable now, but in the future may become reachable if developers
> want to add the ability to use grep_buffer() in prepared in-core data
> and provide hints to the user about where the data came from.

So I guess this is probably my fault, as I was the one who factored out
the grep_source bits long ago (though I would also not be surprised if
it could be triggered before, too).

I think adding a BUG() is the right thing to do.

> I've added the BUG() line to grep_source(). I considered adding it to
> grep_source_1() but didn't see much difference. Looks like
> grep_source_1() exists purely as a helper to grep_source() and is never
> called by anybody else... but it's the function where the crash would
> happen. So I'm not sure.

I agree it probably doesn't matter. I'd probably stick at at the top of
grep_source_1(), just with the rationale that it could possibly catch
more cases if somebody ever refactors grep_source() to have two
different callers (e.g., imagine we later add a variant that takes more
options, but leave the old one to avoid disrupting existing callers).

> I also modified the wording for the BUG("") statement a little from
> jrn's suggestion to hopefully make it more explicit, but I welcome
> wordsmithing.
> [...]
> +		BUG("grep call which could print a name requires "
> +		    "grep_source.name be non-NULL");

It looks fine to me. The point is that nobody should ever see this. And
if they do, we should already get a file/line number telling us where
the problem is (and a coredump to poke at). So as long as it's enough to
convince a regular user that they should make a report to the mailing
list, it will have done its job.

> diff --git a/grep.c b/grep.c
> index 0d50598acd..6ceb880a8c 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -2021,6 +2021,9 @@ static int chk_hit_marker(struct grep_expr *x)
>  
>  int grep_source(struct grep_opt *opt, struct grep_source *gs)
>  {
> +	if (!opt->status_only && gs->name == NULL)
> +		BUG("grep call which could print a name requires "
> +		    "grep_source.name be non-NULL");
>  	/*
>  	 * we do not have to do the two-pass grep when we do not check
>  	 * buffer-wide "all-match".

Minor nit, but can we put a blank line between the new block and the
comment?

> @@ -2045,7 +2048,11 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
>  	struct grep_source gs;
>  	int r;
>  
> -	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
> +	/* TODO: In the future it may become desirable to pass in the name as
> +	 * an argument to grep_buffer(). At that time, "(in core)" should be
> +	 * replaced.
> +	 */
> +	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in core)"), NULL, NULL);

Hmm. I don't see much point in this one, as it would just avoid
triggering our BUG(). If somebody is adding new grep_buffer() callers
that don't use status_only, wouldn't we want them to see the BUG() to
know that they need to refactor grep_buffer() to provide a name?

-Peff
