Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C187205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbdADHzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 02:55:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:35012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935044AbdADHzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 02:55:09 -0500
Received: (qmail 4757 invoked by uid 109); 4 Jan 2017 07:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 07:55:08 +0000
Received: (qmail 30562 invoked by uid 111); 4 Jan 2017 07:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 02:55:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2017 02:55:06 -0500
Date:   Wed, 4 Jan 2017 02:55:06 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH 2/2] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
References: <20170104014835.22377-1-sbeller@google.com>
 <20170104014835.22377-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170104014835.22377-3-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 05:48:35PM -0800, Stefan Beller wrote:

> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1]. The usual response from the mailing
> list is link to old discussions[2], and acknowledging the problem
> stating it is known.
> 
> This patch accomplishes two things:
> 
>   1. Switch assert() to die("BUG") to give a more readable message.
> 
>   2. Take one of the cases where we hit a BUG and turn it into a normal
>      "there was something wrong with the input" message.

As this last bit is quoted from me, I won't deny that it's brilliant as
usual.

But as this commit message needs to stand on its own, rather than as part of a
larger discussion thread, it might be worth expanding "one of the cases"
here. And talking about what's happening to the other cases.

Like:

  This assertion triggered for cases where there wasn't a programming
  bug, but just bogus input. In particular, if the user asks for a
  pathspec that is inside a submodule, we shouldn't assert() or
  die("BUG"); we should tell the user their request is bogus.

  We'll retain the assertion for non-submodule cases, though. We don't
  know of any cases that would trigger this, but it _would_ be
  indicative of a programming error, and we should catch it here.

or something. Writing the first paragraph made me wonder if a better
solution, though, would be to catch and complain about this case
earlier. IOW, this _is_ a programming bug, because we're violating some
assumption of the pathspec code. And whatever is putting that item into
the pathspec list is what should be fixed.

I haven't looked closely enough to have a real opinion on that, though.

> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..574a0bb158 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,28 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len > item->len ||
> +	    item->prefix         > item->len) {
> +		/* Historically this always was a submodule issue */
> +		for (i = 0; i < active_nr; i++) {
> +			struct cache_entry *ce = active_cache[i];
> +			int len;

Given the discussion, this comment seems funny now. Who cares about
"historically"? It should probably be something like:

  /*
   * This case can be triggered by the user pointing us to a pathspec
   * inside a submodule, which is an input error. Detect that here
   * and complain, but fallback in the non-submodule case to a BUG,
   * as we have no idea what would trigger that.
   */

-Peff
