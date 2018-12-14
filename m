Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCFD20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeLNKRK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:17:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:41898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728829AbeLNKRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:17:10 -0500
Received: (qmail 26147 invoked by uid 109); 14 Dec 2018 10:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 10:17:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2429 invoked by uid 111); 14 Dec 2018 10:16:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 05:16:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 05:17:08 -0500
Date:   Fri, 14 Dec 2018 05:17:08 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 7/8] builtin/fetch-pack: support protocol version 2
Message-ID: <20181214101708.GD13465@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213155817.27666-8-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 04:58:16PM +0100, Ævar Arnfjörð Bjarmason wrote:

> From: Jonathan Tan <jonathantanmy@google.com>
> 
> Currently, if support for running Git's entire test suite with protocol
> v2 were added, some tests would fail because the fetch-pack CLI command
> dies if it encounters protocol v2. To avoid this, teach fetch-pack
> support for protocol v2.

I'm definitely on board with this goal.

> @@ -219,9 +220,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  			   PACKET_READ_CHOMP_NEWLINE |
>  			   PACKET_READ_GENTLE_ON_EOF);
>  
> -	switch (discover_version(&reader)) {
> +	version = discover_version(&reader);
> +	switch (version) {
>  	case protocol_v2:
> -		die("support for protocol v2 not implemented yet");
> +		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
> +		break;
>  	case protocol_v1:
>  	case protocol_v0:
>  		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> @@ -231,7 +234,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
> -			 &shallow, pack_lockfile_ptr, protocol_v0);
> +			 &shallow, pack_lockfile_ptr, version);

This implementation looks absurdly simple. So simple that it makes me
wonder why we did not just do this in the first place. I.e., is there
some hidden gotcha blocking it, or was it simply that all of the
necessary work happened in the meantime and nobody bothered to flip the
switch?

-Peff
