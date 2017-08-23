Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80971F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbdHWV3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:29:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751085AbdHWV3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:29:35 -0400
Received: (qmail 29327 invoked by uid 109); 23 Aug 2017 21:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 21:22:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4743 invoked by uid 111); 23 Aug 2017 21:23:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 17:23:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 17:22:51 -0400
Date:   Wed, 23 Aug 2017 17:22:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Doc: clarify that pack-objects makes packs, plural
Message-ID: <20170823212251.li5fs4kypeveydbm@sigill.intra.peff.net>
References: <20170822182242.20862-1-jonathantanmy@google.com>
 <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 12:56:25PM -0700, Junio C Hamano wrote:

>  - There should be an update to say max-pack-size is not something
>    normal users would ever want.

Agreed.

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 8973510a41..3aa6234501 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -108,9 +108,13 @@ base-name::
>  	is taken from the `pack.windowMemory` configuration variable.
>  
>  --max-pack-size=<n>::
> -	Maximum size of each output pack file. The size can be suffixed with
> +	In unusual scenarios, you may not be able to create files
> +	larger than certain size on your filesystem, and this option
> +	can be used to tell the command to split the output packfile
> +	into multiple independent packfiles and what the maximum
> +	size of each packfile is. The size can be suffixed with
>  	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
> -	If specified, multiple packfiles may be created, which also
> +	This option
>  	prevents the creation of a bitmap index.
>  	The default is unlimited, unless the config variable
>  	`pack.packSizeLimit` is set.

I wonder if it is worth mentioning the other downside: that the sum of
the split packfiles may be substantially larger than a single packfile
would be (due to lost delta opportunities between the split packs).

For the sneaker-net case, you are much better off generating a single
pack and then using "split" and "cat" to reconstruct it on the other end
Not that I think we should go into such detail in the manpage, but I
have to wonder if --max-pack-size has outlived its usefulness. The only
use case I can think of is a filesystem that cannot hold files larger
than N bytes.

-Peff
