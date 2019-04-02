Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A5320248
	for <e@80x24.org>; Tue,  2 Apr 2019 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfDBOgR (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 10:36:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:44328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728359AbfDBOgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 10:36:17 -0400
Received: (qmail 30011 invoked by uid 109); 2 Apr 2019 14:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Apr 2019 14:36:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23700 invoked by uid 111); 2 Apr 2019 14:36:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Apr 2019 10:36:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2019 10:36:15 -0400
Date:   Tue, 2 Apr 2019 10:36:15 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: support Unicode scissors
Message-ID: <20190402143615.GC10564@sigill.intra.peff.net>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
 <20190401215334.18678-1-rybak.a.v@gmail.com>
 <20190401215334.18678-2-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401215334.18678-2-rybak.a.v@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 11:53:34PM +0200, Andrei Rybak wrote:

> diff --git a/mailinfo.c b/mailinfo.c
> index f4aaa89788..804b07cd8a 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
>  			c++;
>  			continue;
>  		}
> +		if (starts_with(c, "\xE2\x9C\x82" /* U-2702 ✂ in UTF-8 */)) {
> +			in_perforation = 1;
> +			perforation += 3;
> +			scissors += 3;
> +			c += 2;
> +			continue;
> +		}

It might be worth using skip_prefix() instead of starts_with() to
compute the size automatically. E.g.:

  if (skip_prefix(c, "\xE2\x9C\x82", &end)) {
	size_t len = end - c; /* no magic number needed! */
  }

In fact, I think you could then combine this with the previous
conditional and get:

  if (skip_prefix(c, ">8", &end) ||
      skip_prefix(c, "8<", &end) ||
      skip_prefix(c, ">%", &end) ||
      skip_prefix(c, "%<", &end) ||
      /* U-2702 in UTF-8 */
      skip_prefix(c, "\xE2\x9C\x82", &end)) {
          in_perforation = 1;
	  perforation += end - c;
	  scissors += end - c;
	  c = end - 1; /* minus one to account for loop increment */
  }

(Though I'm still on the fence regarding the whole idea, so do not take
this as an endorsement ;) ).

-Peff
