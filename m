Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EC01F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 05:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfACFOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 00:14:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726126AbfACFOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 00:14:35 -0500
Received: (qmail 19356 invoked by uid 109); 3 Jan 2019 05:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 05:14:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7566 invoked by uid 111); 3 Jan 2019 05:14:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 00:14:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 00:14:33 -0500
Date:   Thu, 3 Jan 2019 00:14:33 -0500
From:   Jeff King <peff@peff.net>
To:     Erin Dahlgren <eedahlgren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20190103051432.GE20047@sigill.intra.peff.net>
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 03:36:29PM -0800, Erin Dahlgren wrote:

> Before this change are two misleading additional behaviors:
> 
>   - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
> 	apparent reason. We never had the chance to change directories
> 	up to this point so chdir(current cwd) is pointless.
>   - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
> 	of a static struct strbuf (cwd). This is unnecessary because the
> 	struct is static so its buffer is always reachable. This is also
> 	misleading because nowhere else in the function is this buffer
> 	released.
> [..]

Overall this looks good to me, and I'd be fine to see it go in as-is.

A few minor nits/comments, though:

> During review, this change was amended to additionally include:
> [...]

When I find myself writing big bullet lists of changes in a commit
message, that is often a good time to split the commit into several
sub-parts.

This patch isn't _too_ big, so I don't think it's worth the effort at
this point for this particular case, but just something to think about
for the future. A series around this topic would probably be something
like:

  1: drop the useless chdir and fold setup_nongit() into the main
     function

  2: stop doing the early return from HIT_MOUNT_POINT, and treat it just
     like HIT_CEILING (and drop the useless strbuf release)

  3: treat GIT_DIR_NONE as a BUG

  4: rearrange the nongit logic at the end of the function for clarity

> +	/*
> +	 * At this point, nongit_ok is stable. If it is non-NULL and points
> +	 * to a non-zero value, then this means that we haven't found a
> +	 * repository and that the caller expects startup_info to reflect
> +	 * this.

Right, makes sense.

> +	 *
> +	 * Regardless of the state of nongit_ok, startup_info->prefix and
> +	 * the GIT_PREFIX environment variable must always match. For details
> +	 * see Documentation/config/alias.txt.
> +	 */

I think this "must match" makes sense to comment. I didn't find
config/alias.txt particularly enlightening in that regard, though. :)

> +	if (nongit_ok && *nongit_ok) {
> +		startup_info->have_repository = 0;
> +		startup_info->prefix = NULL;
>  		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
> -
> -	startup_info->have_repository = !nongit_ok || !*nongit_ok;
> -	startup_info->prefix = prefix;
> +	} else {
> +		// !nongit_ok || !*nongit_ok
> +		startup_info->have_repository = 1;
> +		startup_info->prefix = prefix;
> +		if (prefix)
> +			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> +		else
> +			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
> +	}

We usually avoid "//" comments, even for single lines (though that is
perhaps superstition at this point, as we've started to embrace several
other C99-isms). IMHO this particular comment is not even really
necessary, as the whole conditional is suitably short and obvious after
your refactor.

> @@ -1132,7 +1142,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
>  	 * GIT_DIR values at some point in the future.
>  	 */
> -	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
> +	if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
> +	    startup_info->have_repository ||
> +	    // GIT_DIR_EXPLICIT
> +	    getenv(GIT_DIR_ENVIRONMENT)) {

Same "//" style issue as above. I'm not sure how much value there is in
repeating the GIT_DIR_* cases here, as they're likely to grow out of
sync with the switch() statement above.

At first I thought this could all be folded into the "else" clause of
the conditional above (which would make the logic much easier to
follow), but that wouldn't cover the case of GIT_DIR=/bogus, which is
what that getenv() is trying to handle here.

So I think this is the best we can do for now.

-Peff
