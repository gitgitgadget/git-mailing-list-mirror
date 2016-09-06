Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5761F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbcIFHJB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:09:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:38651 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754586AbcIFHJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:09:00 -0400
Received: (qmail 13434 invoked by uid 109); 6 Sep 2016 07:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 07:08:39 +0000
Received: (qmail 24977 invoked by uid 111); 6 Sep 2016 07:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 03:08:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 03:08:36 -0400
Date:   Tue, 6 Sep 2016 03:08:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff_grep: add assertions verifying that the buffers
 are NUL-terminated
Message-ID: <20160906070836.7brjtijxq7nukjkq@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <a264f55769cd6cfedb842710791d71b11d830091.1473090278.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a264f55769cd6cfedb842710791d71b11d830091.1473090278.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:45:09PM +0200, Johannes Schindelin wrote:

> Before calling regexec() on the file contents, we better be certain that
> the strings fulfill the contract of C strings assumed by said function.

If you have a buffer that is exactly "size" bytes and you are worried
about regexec reading off the end, then...

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 55067ca..88820b6 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -49,6 +49,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
>  	xpparam_t xpp;
>  	xdemitconf_t xecfg;
>  
> +	assert(!one || one->ptr[one->size] == '\0');
> +	assert(!two || two->ptr[two->size] == '\0');
>  	if (!one)
>  		return !regexec(regexp, two->ptr, 1, &regmatch, 0);

...don't your asserts also read off the end?

So you might still segfault, though you do catch a case where we have N
bytes of junk before the end of the page (and you have a 255/256 chance
of catching it).

-Peff
