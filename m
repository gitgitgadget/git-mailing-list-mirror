Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12371F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeC3UXu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:23:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:49346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752490AbeC3UXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:23:49 -0400
Received: (qmail 29862 invoked by uid 109); 30 Mar 2018 20:23:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32719 invoked by uid 111); 30 Mar 2018 20:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 16:24:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:23:47 -0400
Date:   Fri, 30 Mar 2018 16:23:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 03/13] pack-objects: use bitfield for
 object_entry::dfs_state
Message-ID: <20180330202347.GB14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:43AM +0100, Nguyễn Thái Ngọc Duy wrote:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

This probably needs some explanation for people digging in history (even
if it's "this is to shrink the size as part of a larger struct-shrinking
effort" so they know to dig around in the nearby history).

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 647c01ea34..83f8154865 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3049,6 +3049,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  
> +	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
> +		die("BUG: too many dfs states, increase OE_DFS_STATE_BITS");

I thought this was off-by-one at first, but NUM_STATES is one more than
the highest state, so it's right.

I suspect all of the dfs and depth stuff could be pulled into a separate
array that is used only during that depth search. But as you have it
squished down here, I think we may be getting it "for free" in between
other non-word-aligned values in the struct.

-Peff
