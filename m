Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9502036B
	for <e@80x24.org>; Thu,  5 Oct 2017 11:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdJELX6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 07:23:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751710AbdJELX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 07:23:57 -0400
Received: (qmail 20442 invoked by uid 109); 5 Oct 2017 11:23:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 11:23:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27389 invoked by uid 111); 5 Oct 2017 11:23:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 07:23:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 07:23:55 -0400
Date:   Thu, 5 Oct 2017 07:23:55 -0400
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, jrnieder@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
Message-ID: <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-3-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005104407.65948-3-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 12:44:07PM +0200, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If we are checking out a file and somebody else racily deletes our file,
> then we would write garbage to the cache entry. Fix that by checking
> the result of the lstat() call on that file. Print an error to the user
> if the file does not exist.

My gut tells me this is the right thing to be doing, but this commit
message gives very little analysis. Let's see if we can talk it out a
bit.

Aside from bizarre lstat failures, the plausible reason for seeing this
is that somebody racily deleted the file. I.e.,:

  1. We wrote the file.

  2. They deleted it.

  3. We ran lstat() on it and found that it went away.

But imagine that the race went the other way, and (3) happened before
(2). Then we'd actually get a real index entry, but the file would
appear deleted to anybody who checks the filesystem against the stat
data.

So I guess my question is: is step 3 an integral part of the checkout
procedure, or is it simply an opportunity to refresh the index (since we
know we just wrote out the content)?

If it's an integral part, then I agree that the error return you add
here is the right thing to do. But if it's just an index refresh, then I
wonder if we should report a successful checkout, but mark the entry as
stat-dirty.

I dunno. It's pretty philosophical, and I have a feeling that nobody
really cares all that much in practice. Certainly the error return seems
like the easiest fix.

> diff --git a/entry.c b/entry.c
> index 5dab656364..2252d96756 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -355,7 +355,8 @@ static int write_entry(struct cache_entry *ce,
>  	if (state->refresh_cache) {
>  		assert(state->istate);
>  		if (!fstat_done)
> -			lstat(ce->name, &st);
> +			if (lstat(ce->name, &st) < 0)
> +				return error("unable to get status of file %s", ce->name);

We could probably be a bit more specific about the situation, since the
user will see this message with no context. Maybe something like:

  unable to stat just-written file %s

or something. We should probably also use error_errno(). I'd bet if this
ever triggers that it's likely to be ENOENT, but certainly if it _isn't_
that would be interesting information.

-Peff
