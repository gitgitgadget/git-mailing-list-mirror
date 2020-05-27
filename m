Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8DC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA582075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgE0TFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 15:05:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:58012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgE0TFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 15:05:01 -0400
Received: (qmail 23430 invoked by uid 109); 27 May 2020 18:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:38:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6414 invoked by uid 111); 27 May 2020 18:38:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:38:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 08/12] upload-pack: move keepalive to upload_pack_data
Message-ID: <20200527183820.GF4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-9-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-9-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:38PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the 'keepalive' static variable
> into this struct.
> 
> It is used by code common to protocol v0 and protocol v2.

Sounds good.

> @@ -248,7 +250,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
>  
>  	while (1) {
>  		struct pollfd pfd[2];
> -		int pe, pu, pollsize;
> +		int pe, pu, pollsize, polltimeout;
>  		int ret;
>  
>  		reset_timeout(pack_data->timeout);
> @@ -272,8 +274,11 @@ static void create_pack_file(struct upload_pack_data *pack_data)
>  		if (!pollsize)
>  			break;
>  
> -		ret = poll(pfd, pollsize,
> -			keepalive < 0 ? -1 : 1000 * keepalive);
> +		polltimeout = pack_data->keepalive < 0
> +			? -1
> +			: 1000 * pack_data->keepalive;
> +
> +		ret = poll(pfd, pollsize, polltimeout);

The new variable isn't strictly necessary, but it keeps the line-length
down now that the variable name is much longer. Looks reasonable.

-Peff
