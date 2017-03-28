Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9B520958
	for <e@80x24.org>; Tue, 28 Mar 2017 07:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbdC1HH0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 03:07:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:52774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754137AbdC1HHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 03:07:25 -0400
Received: (qmail 25228 invoked by uid 109); 28 Mar 2017 07:07:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 07:07:14 +0000
Received: (qmail 2172 invoked by uid 111); 28 Mar 2017 07:07:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 03:07:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 03:07:12 -0400
Date:   Tue, 28 Mar 2017 03:07:12 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] builtin/receive-pack: convert portions to
 struct object_id
Message-ID: <20170328070712.p2o7wziysy7n2vxk@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-8-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170326160143.769630-8-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 04:01:29PM +0000, brian m. carlson wrote:

> Convert some hardcoded constants into uses of parse_oid_hex.
> Additionally, convert all uses of struct command, and miscellaneous
> other functions necessary for that.  This work is necessary to be able
> to convert sha1_array_append later on.
> 
> To avoid needing to specify a constant, reject shallow lines with the
> wrong length instead of simply ignoring them.

It took me a while to find it. This is the switch from "len == 48" to
"len > 8" when matching "shallow" lines. I think this makes sense.

> Note that in queue_command we are guaranteed to have a NUL-terminated
> buffer or at least one byte of overflow that we can safely read, so the
> linelen check can be elided.  We would die in such a case, but not read
> invalid memory.

I think linelen is always just strlen(line). Since the queue_command
function no longer cares about it, perhaps we can just omit it?

> @@ -1541,12 +1541,12 @@ static struct command *read_head_info(struct sha1_array *shallow)
>  		if (!line)
>  			break;
>  
> -		if (len == 48 && starts_with(line, "shallow ")) {
> -			unsigned char sha1[20];
> -			if (get_sha1_hex(line + 8, sha1))
> +		if (len > 8 && starts_with(line, "shallow ")) {
> +			struct object_id oid;
> +			if (get_oid_hex(line + 8, &oid))
>  				die("protocol error: expected shallow sha, got '%s'",
>  				    line + 8);

This would be much nicer as:

  if (skip_prefix(line, "shallow ", &hex))

It's probably best to keep to one type of cleanup at a time here. I'm
just making a mental note.

-Peff
