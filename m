Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F581F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbeELJ2N (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:28:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750722AbeELJ2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:28:12 -0400
Received: (qmail 24844 invoked by uid 109); 12 May 2018 09:28:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:28:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13763 invoked by uid 111); 12 May 2018 09:28:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:28:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:28:10 -0400
Date:   Sat, 12 May 2018 05:28:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/12] sequencer.c: use commit-slab to associate todo
 items to commits
Message-ID: <20180512092810.GF28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-6-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:21AM +0200, Nguyễn Thái Ngọc Duy wrote:

> @@ -3446,9 +3451,9 @@ int rearrange_squash(void)
>  			else if (!strchr(p, ' ') &&
>  				 (commit2 =
>  				  lookup_commit_reference_by_name(p)) &&
> -				 commit2->util)
> +				 *commit_todo_item_at(&commit_todo, commit2))
>  				/* found by commit name */
> -				i2 = (struct todo_item *)commit2->util
> +				i2 = *commit_todo_item_peek(&commit_todo, commit2)
>  					- todo_list.items;

Directly dereferencing _peek() is an anti-pattern, since it may return
NULL. We know it's OK here because the earlier call to _at() would have
extended the slab. But it probably makes sense to use _at() in both
places then (or even to use _peek() for the earlier one if you want to
avoid extending, but as I said in the other message, I kind of
suspect most of these cases end up allocating slab space for most of the
commits anyway).

-Peff
