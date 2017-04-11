Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C2420970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbdDKThO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:37:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:60262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752904AbdDKThN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:37:13 -0400
Received: (qmail 31825 invoked by uid 109); 11 Apr 2017 19:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 19:37:12 +0000
Received: (qmail 6331 invoked by uid 111); 11 Apr 2017 19:37:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 15:37:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 15:37:10 -0400
Date:   Tue, 11 Apr 2017 15:37:10 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two
 separate functions
Message-ID: <20170411193709.w5tz3i3vg5mnnhfe@sigill.intra.peff.net>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-4-benpeart@microsoft.com>
 <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
 <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 09:29:36PM +0200, Lars Schneider wrote:

> >  1. Do we need to save errno before calling sigchain_pop()? It's making
> >     syscalls (though admittedly they are unlikely to fail).
> 
> What if we add the following right before sigchain_pop() ?
> 
> 	if (errno == EPIPE)
> 		err = -1;

Yes, that would be fine (though again, this runs against point 2 below).

> >  2. If err is 0, then nothing failed. Who would have set errno? Aren't
> >     we reading whatever cruft happened to be in errno before the
> >     function started?
> 
> Yeah, looks like you're right:
> https://www.securecoding.cert.org/confluence/pages/viewpage.action?pageId=6619179
> 
> According to this article we shouldn't even check *only* for errno. 
> At least we should add
> 	errno = 0;
> at the beginning of the function, no?

If you initialize errno to 0 right before a syscall, then yes, you can
trust it without checking the return value of the syscall. I wouldn't
trust it before calling more complicated functions, though. Not even
xwrite(), which may see EINTR and keep going (which is OK for checking
for EPIPE, but not checking generally for errno values).

> This means we have many areas in Git where we don't handle errno
> correctly. E.g. right in convert.c where I stole code from:
> https://github.com/git/git/commit/0c4dd67a048b39470b9b95912e4912fecc405a85#diff-7949b716ab0a83e8c422a0d6336f19d6R361
> 
> Should that be addressed?

That one is questionable code, but I don't think it behaves incorrectly.
After the write_in_full() call finishes, then either:

  1. write_err is 0, and conditional is a noop

  2. write_err is non-zero, and errno is relevant

I do think it would be more clear as:

  if (write_err && errno == EPIPE)
	write_err = 0;

similar to the code right below it.

-Peff
