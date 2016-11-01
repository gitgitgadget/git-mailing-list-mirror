Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D88020229
	for <e@80x24.org>; Tue,  1 Nov 2016 15:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755548AbcKAPEd (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 11:04:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36981 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbcKAPEc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 11:04:32 -0400
Received: (qmail 1480 invoked by uid 109); 1 Nov 2016 15:04:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 15:04:31 +0000
Received: (qmail 26729 invoked by uid 111); 1 Nov 2016 15:04:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 11:04:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 11:04:29 -0400
Date:   Tue, 1 Nov 2016 11:04:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: make wraparound of the index into ring-buffer
 explicit
Message-ID: <20161101150429.fohpchtlfvohzood@sigill.intra.peff.net>
References: <a1e2c4a4-4720-fc26-c866-6ab959543c3b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1e2c4a4-4720-fc26-c866-6ab959543c3b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 09:49:07AM +0100, René Scharfe wrote:

> Overflow is defined for unsigned integers, but not for signed ones.
> Wrap around explicitly for the new ring-buffer in find_unique_abbrev()
> as we did in bb84735c for the ones in sha1_to_hex() and get_pathname(),
> thus avoiding signed overflows and getting rid of the magic number 3.

Thanks. I didn't mean to make you do this, but my procrastination won
again.

> diff --git a/sha1_name.c b/sha1_name.c
> index 06409a3..73a915f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -510,7 +510,8 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  {
>  	static int bufno;
>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
> -	char *hex = hexbuffer[3 & ++bufno];
> +	char *hex = hexbuffer[bufno];
> +	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);

Code looks obviously correct (and it even does the "start at 0" thing).

-Peff
