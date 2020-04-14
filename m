Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7670FC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAA1206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 19:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505263AbgDNTzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:55:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2505250AbgDNTzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 15:55:36 -0400
Received: (qmail 7393 invoked by uid 109); 14 Apr 2020 19:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 19:55:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1224 invoked by uid 111); 14 Apr 2020 20:06:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 16:06:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 15:55:35 -0400
From:   Jeff King <peff@peff.net>
To:     luciano.rocha@booking.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/1] freshen_file(): use NULL `times' for implicit
 current-time
Message-ID: <20200414195535.GA1879302@coredump.intra.peff.net>
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:27:26PM +0200, luciano.rocha@booking.com wrote:

> Update freshen_file() to use a NULL `times', semantically equivalent to
> the currently setup, with an explicit `actime' and `modtime' set to the
> "current time", but with the advantage that it works with other files
> not owned by the current user.
> 
> Fixes an issue on shared repos with a split index, where eventually a
> user's operation creates a shared index, and another user will later do
> an operation that will try to update its freshness, but will instead
> raise a warning:
>   $ git status
>   warning: could not freshen shared index '.git/sharedindex.bd736fa10e0519593fefdb2aec253534470865b2'

Thanks, this makes sense. And as a bonus, it's less code. ;)

I don't recall having any particular reason not to use NULL in the
original (I may simply not have been aware it was an option), and I
can't find any discussion either way.

One observation:

>  static int freshen_file(const char *fn)
>  {
> -	struct utimbuf t;
> -	t.actime = t.modtime = time(NULL);
> -	return !utime(fn, &t);
> +	return !utime(fn, NULL);
>  }

The old code was setting the time based on the system time from time().
We've occasionally hit cases where the filesystem time and the system
time do not match exactly (this might be true on an NFS mount, for
example).

It's not clear to me whether utime(NULL) would be using the system or
filesystem time in such a case. If the former, then there's no change in
behavior. If the latter, I'd argue that it's probably an _improvement_,
since we're simulating the case that we wrote a new file with a new
mtime.

-Peff
