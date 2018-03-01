Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF651F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935347AbeCAHlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:41:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:42336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933286AbeCAHlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:41:32 -0500
Received: (qmail 16187 invoked by uid 109); 1 Mar 2018 07:41:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 07:41:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12604 invoked by uid 111); 1 Mar 2018 07:42:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 02:42:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 02:41:29 -0500
Date:   Thu, 1 Mar 2018 02:41:29 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
Message-ID: <20180301074129.GE31079@sigill.intra.peff.net>
References: <cover.1519843916.git.martin.agren@gmail.com>
 <20180228195809.9145-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228195809.9145-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 08:58:09PM +0100, Martin Ågren wrote:

> > I'll follow up with a patch to
> > address the confusing pattern which Peff mentioned and which fooled me
> > when I prepared v1.
> 
> Here is such a patch on top of the others. I'm not particularly proud of the
> name SKIP_IF_UNCHANGED, but don't think it's any worse than, e.g.,
> IGNORE_UNCHANGED or NO_UNCHANGED_WRITE. :-/ Suggestions welcome.
> 
> I think this makes the current users a bit more obvious, and should help future
> users get this optimization right.

IMHO the result is easier to follow. Except for one case:

> -	if (active_cache_changed || force_write) {
> -		if (newfd < 0) {
> -			if (refresh_args.flags & REFRESH_QUIET)
> -				exit(128);
> -			unable_to_lock_die(get_index_file(), lock_error);
> -		}
> -		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> -			die("Unable to write new index file");
> +	if (newfd < 0 && (active_cache_changed || force_write)) {
> +		if (refresh_args.flags & REFRESH_QUIET)
> +			exit(128);
> +		unable_to_lock_die(get_index_file(), lock_error);
>  	}
>  
> -	rollback_lock_file(&lock_file);
> +	if (write_locked_index(&the_index, &lock_file,
> +			       COMMIT_LOCK | (force_write ? 0 : SKIP_IF_UNCHANGED)))
> +		die("Unable to write new index file");

where I think the logic just ends up repeating itself. I guess you were
anxious to try to get rid of active_cached_changed, but I don't think
keeping it around is really that big a deal (and certainly another trick
is to just say "the_index.cache_changed").

-Peff
