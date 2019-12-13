Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DDC7CFDD
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33702475E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfLMRpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:45:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:46156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728012AbfLMRpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:45:43 -0500
Received: (qmail 2682 invoked by uid 109); 13 Dec 2019 17:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 17:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26055 invoked by uid 111); 13 Dec 2019 17:50:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 12:50:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 12:45:42 -0500
From:   Jeff King <peff@peff.net>
To:     Ed Maste <emaste@FreeBSD.org>
Cc:     git@vger.kernel.org, lukasz@niemier.pl
Subject: Re: [PATCH] userdiff: remove empty subexpression from elixir regex
Message-ID: <20191213174542.GB117158@coredump.intra.peff.net>
References: <20191213173902.71541-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213173902.71541-1-emaste@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 05:39:02PM +0000, Ed Maste wrote:

> diff --git a/userdiff.c b/userdiff.c
> index 324916f20f..165d7e8653 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -35,7 +35,7 @@ PATTERNS("dts",
>  PATTERNS("elixir",
>  	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
>  	 /* Atoms, names, and module attributes */
> -	 "|[@:]?[a-zA-Z0-9@_?!]+"
> +	 "[@:]?[a-zA-Z0-9@_?!]+"
>  	 /* Numbers with specific base */
>  	 "|[-+]?0[xob][0-9a-fA-F]+"
>  	 /* Numbers */

It took me a minute to see why this was different than the similar
"Numbers" line below. The issue is the comma at the end of the previous
line; this is starting a new string, whereas the "Numbers" line is
pasting to the existing string.

And that is the right thing, since these strings are the funcname and
word_regex patterns, respectively.

So I think this is the correct fix. Many of the other regexes in this
list use "/* -- */" to seperate the two for readability. Maybe worth
doing here, too?

-Peff
