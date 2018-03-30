Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3831F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeC3U0s (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:26:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:49384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752069AbeC3U0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:26:47 -0400
Received: (qmail 30042 invoked by uid 109); 30 Mar 2018 20:26:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:26:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 396 invoked by uid 111); 30 Mar 2018 20:27:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 16:27:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:26:45 -0400
Date:   Fri, 30 Mar 2018 16:26:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 04/13] pack-objects: use bitfield for
 object_entry::depth
Message-ID: <20180330202645.GC14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-5-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:44AM +0100, Nguyễn Thái Ngọc Duy wrote:

> Because of struct packing from now on we can only handle max depth
> 4095 (or even lower when new booleans are added in this struct). This
> should be ok since long delta chain will cause significant slow down
> anyway.

OK. This is the first user-facing change, but I think it really
shouldn't hurt anybody. My experiments a while ago showed that chains
longer than 50 aren't really worth it, but so this could probably shrink
to something like 8 bits if we really needed it to.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 83f8154865..205e1f646c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (pack_to_stdout != !base_name || argc)
>  		usage_with_options(pack_usage, pack_objects_options);
>  
> +	if (depth >= (1 << OE_DEPTH_BITS))
> +		die(_("delta chain depth %d is greater than maximum limit %d"),
> +		    depth, (1 << OE_DEPTH_BITS) - 1);

Since this is introducing a new limit, I wonder if we should issue a
warning and just clamp it to the maximum value. That would be kinder to
people who may have existing (admittedly dumb) setups.

-Peff
