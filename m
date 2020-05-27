Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3618C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEAE2075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgE0SzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:55:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:57948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0SzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:55:07 -0400
Received: (qmail 23559 invoked by uid 109); 27 May 2020 18:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6549 invoked by uid 111); 27 May 2020 18:55:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:55:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:55:06 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 12/12] upload-pack: move pack_objects_hook to
 upload_pack_data
Message-ID: <20200527185506.GI4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-13-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-13-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:42PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the 'pack_objects_hook' static
> variable into this struct.
> 
> It is used by code common to protocol v0 and protocol v2.
> 
> While at it let's also free() it in upload_pack_data_clear().

Makes sense.

> @@ -133,6 +134,8 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
>  	object_array_clear(&data->shallows);
>  	string_list_clear(&data->deepen_not, 0);
>  	list_objects_filter_release(&data->filter_options);
> +
> +	free((char *)data->pack_objects_hook);

This cast is ugly, but unavoidable because git_config_string() takes a
pointer-to-const.

-Peff
