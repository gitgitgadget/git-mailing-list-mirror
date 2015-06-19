From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: Correctly dereference interesting_cache
Date: Fri, 19 Jun 2015 16:49:24 -0400
Message-ID: <20150619204923.GA2964@peff.net>
References: <1434740483-31730-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63OA-0003wW-RK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbbFSU7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:59:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:49165 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932891AbbFSUt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:49:27 -0400
Received: (qmail 7742 invoked by uid 102); 19 Jun 2015 20:49:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 15:49:26 -0500
Received: (qmail 20980 invoked by uid 107); 19 Jun 2015 20:49:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 16:49:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 16:49:24 -0400
Content-Disposition: inline
In-Reply-To: <1434740483-31730-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272205>

On Fri, Jun 19, 2015 at 12:01:23PM -0700, Stefan Beller wrote:

> This was introduced at b6e8a3b5 (2015-04-17, limit_list: avoid
> quadratic behavior from still_interesting), which
> also introduced the check a few lines before, which already dereferences
> `interesting_cache`. So at this point `interesting_cache` is guaranteed to
> be not NULL. The code is called referencing the address of a local
> variable, so `interesting_cache` can actually never be NULL and trigger a
> segmentation fault by dereferencing it a few lines before this.

Yeah, I agree it can never be NULL here or we would have already
segfaulted. Thanks for digging into it.

> I think the right thing is to check for `*interesting_cache` as that
> can become NULL actually.

I don't think this is right. We have found the interesting commit, so we
want to write it into the cache unconditionally, not only if there is
nothing else in the cache (we know if we got here that either there was
no current cache item, or it already became UNINTERESTING).

I think it is simply a misguided defensive measure to make sure that the
caller passed in a cache slot to us. But there is only one caller, and
they always pass a cache, so the first part of the function was lazy and
not defensive.

>  	while (list) {
>  		struct commit *commit = list->item;
>  		list = list->next;
>  		if (commit->object.flags & UNINTERESTING)
>  			continue;
> -		if (interesting_cache)
> +		if (*interesting_cache)
>  			*interesting_cache = commit;

So I think the right solution is just to drop the conditional entirely.
The current code is not wrong (it is always a noop). What you have here
actually misbehaves; it does not update the cache slot when it has
become UNINTERESTING. That does not produce wrong results, but it loses
the benefit of the cache in some cases.

-Peff
