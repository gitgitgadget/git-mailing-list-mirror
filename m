Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013631F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeJ3BWe (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:22:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:59336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727519AbeJ3BWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:22:34 -0400
Received: (qmail 25399 invoked by uid 109); 29 Oct 2018 16:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 16:33:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19555 invoked by uid 111); 29 Oct 2018 16:32:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 12:32:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 12:33:12 -0400
Date:   Mon, 29 Oct 2018 12:33:12 -0400
From:   Jeff King <peff@peff.net>
To:     Pete <pietro.cagnoni@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Prevent warning
Message-ID: <20181029163312.GB31497@sigill.intra.peff.net>
References: <01020166c07adf27-0c2cb5ac-2292-4ce3-808e-b627202fd45f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020166c07adf27-0c2cb5ac-2292-4ce3-808e-b627202fd45f-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 03:39:30PM +0000, Pete wrote:

> Prevent the following warning in the web server error log:
> gitweb.cgi: Odd number of elements in anonymous hash at /usr/share/gitweb/gitweb.cgi line 3305
> [...]
> -		$remotes{$remote} ||= { 'heads' => () };
> +		$remotes{$remote} ||= { 'heads' => [] };

This will indeed silence the warning, but the end result is different.
In the original, 'heads' would be set to undef, but now it is set to an
empty array reference.

Do the later users of the struct care about the distinction?

Grepping around, I see two callers that look at "heads":

 1. fill_remote_heads() assigns to it unconditionally, overwriting
    whatever was there before.

 2. git_remote_block() dereferences it as an array reference, and so
    probably would have complained if we ever got there with the undef.
    But we never would, because every call to git_remote_block() is
    preceded by a call to fill_remote_heads().

So nobody actually ever looks at the value we set here. Is an empty
array reference better than undef as a default value? I'd actually argue
no. If we add new code that does not call fill_remote_heads(), it's
probably better for it to be undef to distinguish it from the empty list
(and possibly raise an error that would tell us that we forgot to call
fill_remote_heads().

So I'd say that:

  $remotes{$remote} ||= { heads => undef };

is a preferable conversion. Or simply deleting the line entirely, which
has roughly the same effect.

-Peff
