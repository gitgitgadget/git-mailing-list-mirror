Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748A71FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938555AbdD0GVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:21:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:41069 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938553AbdD0GVR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:21:17 -0400
Received: (qmail 25163 invoked by uid 109); 27 Apr 2017 06:21:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 06:21:17 +0000
Received: (qmail 30365 invoked by uid 111); 27 Apr 2017 06:21:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 02:21:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 02:21:14 -0400
Date:   Thu, 27 Apr 2017 02:21:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
Message-ID: <20170427062114.p367j6rojnw4aj5r@sigill.intra.peff.net>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 10:20:16PM +0200, Johannes Schindelin wrote:

> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 30681681c13..c0d88f97512 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>  
>  	do {
>  		peek = fgetc(f);
> -	} while (isspace(peek));
> +	} while (peek >= 0 && isspace(peek));
>  	ungetc(peek, f);

Are we guaranteed that EOF is a negative number?  Also, what is the
behavior of ungetc when we pass it EOF?

It looks like POSIX does what we want (pushing EOF is a noop, and the
stream retains its feof() status), but I don't know if there are other
implementations to worry about.

Perhaps:

  /* soak up whitespace */
  while ((peek = fgetc(f)) != EOF) {
	if (!isspace(peek)) {
		ungetc(peek, f);
		break;
	}
  }

would be more portable.

-Peff
