Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8295C433E3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85EB2089D
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391889AbgE0SGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391878AbgE0SGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:06:12 -0400
Received: (qmail 23196 invoked by uid 109); 27 May 2020 18:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6174 invoked by uid 111); 27 May 2020 18:06:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:06:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:06:11 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/12] upload-pack: move static vars to upload_pack_data
Message-ID: <20200527180611.GA4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-3-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:32PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the 'no_done', 'daemon_mode' and
> 'timeout' variables into this struct.

Makes sense.

> They are only used by protocol v0 code since protocol v2 assumes
> certain baseline capabilities, but rolling them into
> upload_pack_data and just letting v2 code ignore them as it does
> now is more coherent and cleaner.

Is it perhaps worth keeping these v0-only fields grouped together within
the struct, along with a comment? That way nobody has to repeat your
research later into which ones are used and which ones are not.

> -static unsigned int timeout;

This was unsigned, but gets moved as...

> @@ -83,18 +80,21 @@ struct upload_pack_data {
>  	timestamp_t deepen_since;
>  	int deepen_rev_list;
>  	int deepen_relative;
> +	int timeout;

...a signed int.

It probably doesn't matter much in practice for the values we'd give it,
but the alarm() to which it's ultimately fed takes an unsigned int.

-Peff
