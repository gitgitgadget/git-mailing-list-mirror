Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32870C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CCB2098B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDVTSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:18:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725913AbgDVTSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:18:42 -0400
Received: (qmail 10004 invoked by uid 109); 22 Apr 2020 19:18:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:18:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1029 invoked by uid 111); 22 Apr 2020 19:29:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 15:29:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:18:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422191841.GA558336@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
 <20200422165358.GB140314@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422165358.GB140314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 09:53:58AM -0700, Jonathan Nieder wrote:

> When process_acks sees an ACK, it passes it on to the negotiator.
> It wants to record that it received an ack to reset in_vain, but
> it forgets to!  The function is initialized and read but never
> written to.

I wondered if it might be something like this, too (and this might well
be an independent bug), but...

> So I'd expect the following to help:
> 
> diff --git i/fetch-pack.c w/fetch-pack.c
> index 1734a573b01..a1d743e1f61 100644
> --- i/fetch-pack.c
> +++ w/fetch-pack.c
> @@ -1287,6 +1287,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
>  			struct object_id oid;
>  			if (!get_oid_hex(arg, &oid)) {
>  				struct commit *commit;
> +
> +				received_ack = 1;
>  				oidset_insert(common, &oid);
>  				commit = lookup_commit(the_repository, &oid);
>  				if (negotiator)

It doesn't. We never get any ACK from the server at all, because we give
up on sending haves before hitting any common commit.

-Peff
