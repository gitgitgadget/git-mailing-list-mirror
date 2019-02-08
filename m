Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1701F453
	for <e@80x24.org>; Fri,  8 Feb 2019 21:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBHVAo (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 16:00:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726524AbfBHVAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 16:00:44 -0500
Received: (qmail 21371 invoked by uid 109); 8 Feb 2019 21:00:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 21:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27415 invoked by uid 111); 8 Feb 2019 21:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 16:00:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:00:42 -0500
Date:   Fri, 8 Feb 2019 16:00:42 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208210041.GA788@sigill.intra.peff.net>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <003a01d4bfee$349245b0$9db6d110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003a01d4bfee$349245b0$9db6d110$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc kernel and packagers; this is really just git development at this
point]

On Fri, Feb 08, 2019 at 03:38:05PM -0500, Randall S. Becker wrote:

> > Exactly (if we even care about them being NULs; otherwise, we can omit the
> > "tr" invocation).
> 
> I'm a bit perplexed about this... Obviously added some debugging info,
> but why we're getting No REQUEST_METHOD is perplexing. Is this a lack
> of an apache2 instance?

No, this shouldn't be using apache at all. But...

> expecting success:
>         NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
>         env \
>                 CONTENT_TYPE=application/x-git-upload-pack-request \
>                 QUERY_STRING=/repo.git/git-upload-pack \
>                 PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>                 GIT_HTTP_EXPORT_ALL=TRUE \
>                 REQUEST_METHOD=POST \
>                 CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
>                 yes | tr "y" "\\0" | git http-backend 2>err &&
>         echo "Err is" &&
>         cat err &&
>         grep "fatal:.*CONTENT_LENGTH" err
> 
> Status: 500 Internal Server Error
> Expires: Fri, 01 Jan 1980 00:00:00 GMT
> Pragma: no-cache
> Cache-Control: no-cache, max-age=0, must-revalidate
> 
> Err is
> fatal: No REQUEST_METHOD from server
> not ok 15 - CONTENT_LENGTH overflow ssite_t

The problem is that you're setting the environment now for "yes". You'd
need:

  yes | tr "y" "\\0" | env \
    CONTENT_TYPE=... \
    REQUEST_METHOD=POST \
    ...etc...
    git http-backend

-Peff
