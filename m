Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B795E1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 04:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeAXECf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 23:02:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:55116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752126AbeAXECe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 23:02:34 -0500
Received: (qmail 29471 invoked by uid 109); 24 Jan 2018 04:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 04:02:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21994 invoked by uid 111); 24 Jan 2018 04:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 23:03:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 23:02:32 -0500
Date:   Tue, 23 Jan 2018 23:02:32 -0500
From:   Jeff King <peff@peff.net>
To:     "Juan F. Codagnone" <jcodagnone@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: avoid segfault when can't open files
Message-ID: <20180124040232.GB1330@sigill.intra.peff.net>
References: <20180124025417.32497-1-jcodagnone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180124025417.32497-1-jcodagnone@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 11:54:17PM -0300, Juan F. Codagnone wrote:

> If <msg> or <patch> files can't be opened, clear_mailinfo crash as
> it follows NULL pointers.
> 
> Can be reproduced using `git mailinfo . .`

Thanks for finding this.

Looking at the offending code and your solution, it looks like:

  1. mailinfo() sometimes allocates mi->p_hdr_data and mi->s_hdr_data
     and sometimes not, depending on how far we get before seeing an
     error. The caller cannot know whether we did so or not based on
     seeing an error return, but most call clear_mailinfo() if it wants
     to avoid a leak.

  2. There are two callers of mailinfo(). git-am simply dies on an
     error, and so is unaffected. But git-mailinfo unconditionally calls
     clear_mailinfo() before returning, regardless of the return code.

  3. When we get to clear_mailinfo(), the arrays are either populated or
     are NULL. We know they're initialized to NULL because of
     setup_mailinfo(), which zeroes the whole struct.

So I think your fix does the right thing. I do think this is a pretty
awkward interface, and it would be less error-prone if either[1]:

  a. we bumped the allocation of these arrays up in mailinfo() so
     that they were simply always initialized. This fixes the bug in
     clear_mailinfo(), but also any other function which looks at the
     mailinfo struct (though I don't think there are any such cases).

  b. we had mailinfo() clean up after itself on error, so that it was
     always in a de-initialized state.

But given the lack of callers, it may not be worth the effort. So I'm OK
with this solution. It may be worth giving an abbreviated version of the
above explanation in the commit message. Perhaps:

  If <msg> or <patch> files can't be opened, then mailinfo() returns an
  error before it even initializes mi->p_hdr_data or mi->s_hdr_data.
  When cmd_mailinfo() then calls clear_mailinfo(), we dereference the
  NULL pointers trying to free their contents.

As for the patch itself, it looks correct but I saw two style nits:

> diff --git a/mailinfo.c b/mailinfo.c
> index a89db22ab..035abbbf5 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1167,11 +1167,13 @@ void clear_mailinfo(struct mailinfo *mi)
>  	strbuf_release(&mi->inbody_header_accum);
>  	free(mi->message_id);
>  
> -	for (i = 0; mi->p_hdr_data[i]; i++)
> -		strbuf_release(mi->p_hdr_data[i]);
> +	if(mi->p_hdr_data != NULL)
> +		for (i = 0; mi->p_hdr_data[i]; i++)
> +			strbuf_release(mi->p_hdr_data[i]);

We usually say "if (" with an extra space. And we generally just check
pointers for their truth value. So:

  if (mi->p_hdr_data) {
	for (i = 0; ...)

-Peff

[1] Actually, it seems a little funny that we use xcalloc() here at all,
    since the size is determined by a compile-time constant. Why not
    just put an array directly into the struct and let it get zeroed
    with the rest of the struct? That sidesteps the question of whether
    we need to clear() after an error return, but it would fix this bug. :)
