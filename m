Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5952027C
	for <e@80x24.org>; Sun, 16 Jul 2017 14:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdGPOEe (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 10:04:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:42110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752388AbdGPOEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 10:04:11 -0400
Received: (qmail 3645 invoked by uid 109); 16 Jul 2017 14:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 14:04:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25931 invoked by uid 111); 16 Jul 2017 14:04:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:04:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 10:04:09 -0400
Date:   Sun, 16 Jul 2017 10:04:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] dir: support platforms that require aligned reads
Message-ID: <20170716140409.3ywepgvo5c6ognsy@sigill.intra.peff.net>
References: <d3db2984-f238-7166-affa-f1f7df566404@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3db2984-f238-7166-affa-f1f7df566404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 02:17:37PM +0200, René Scharfe wrote:

> -static void stat_data_from_disk(struct stat_data *to, const struct stat_data *from)
> +static void stat_data_from_disk(struct stat_data *to, const unsigned char *data)
>  {
> -	to->sd_ctime.sec  = get_be32(&from->sd_ctime.sec);
> -	to->sd_ctime.nsec = get_be32(&from->sd_ctime.nsec);
> -	to->sd_mtime.sec  = get_be32(&from->sd_mtime.sec);
> -	to->sd_mtime.nsec = get_be32(&from->sd_mtime.nsec);
> -	to->sd_dev	  = get_be32(&from->sd_dev);
> -	to->sd_ino	  = get_be32(&from->sd_ino);
> -	to->sd_uid	  = get_be32(&from->sd_uid);
> -	to->sd_gid	  = get_be32(&from->sd_gid);
> -	to->sd_size	  = get_be32(&from->sd_size);
> +	memcpy(to, data, sizeof(*to));
> +	to->sd_ctime.sec  = ntohl(to->sd_ctime.sec);
> +	to->sd_ctime.nsec = ntohl(to->sd_ctime.nsec);
> +	to->sd_mtime.sec  = ntohl(to->sd_mtime.sec);
> +	to->sd_mtime.nsec = ntohl(to->sd_mtime.nsec);
> +	to->sd_dev	  = ntohl(to->sd_dev);
> +	to->sd_ino	  = ntohl(to->sd_ino);
> +	to->sd_uid	  = ntohl(to->sd_uid);
> +	to->sd_gid	  = ntohl(to->sd_gid);
> +	to->sd_size	  = ntohl(to->sd_size);
>  }

Hmm. I would have written this to pull the bytes directly out of the
array, like:

  to->sd_ctime.sec  = get_be32(data); data += 4;
  to->sd_ctime.nsec = get_be32(data); data += 4;

etc. Or even a helper to do the advancing like:

  to->sd_ctime.sec = parse_be32(&data);

That reduces assumptions about padding in "struct stat_data". But
looking more at this code, and reading your comment:

> Side note: The OS name is not enough for determining the layout of
> struct ondisk_untracked_cache.  Different platforms can have different
> int sizes and padding.  Adding the machine type could help, but that
> would be a breaking change.  At that point we would be better off
> defining a machine-independent format, no?

it looks like assumptions about struct layout are pervasive and part of
the on-disk format. Yuck. :(

-Peff
