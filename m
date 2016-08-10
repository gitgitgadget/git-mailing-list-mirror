Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B2B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbcHJTdv (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:33:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53047 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965039AbcHJSy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:54:59 -0400
Received: (qmail 26747 invoked by uid 109); 10 Aug 2016 13:28:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 13:28:17 +0000
Received: (qmail 32382 invoked by uid 111); 10 Aug 2016 13:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 09:28:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 09:28:15 -0400
Date:	Wed, 10 Aug 2016 09:28:15 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
Message-ID: <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-5-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810130411.12419-5-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:04:00PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_write() has two shortcomings. First, it uses format_packet() which
> lets the caller only send string data via "%s". That means it cannot be
> used for arbitrary data that may contain NULs. Second, it will always
> die on error.
> 
> Add packet_write_gently() which writes arbitrary data and returns `0` for
> success and `-1` for an error.

So now we have packet_write() and packet_write_gently(), but they differ
in more than just whether they are gentle. That seems like a weird
interface.

Should we either be picking a new name (e.g., packet_write_mem() or
something), or migrating packet_write() to packet_write_fmt()?

> diff --git a/pkt-line.c b/pkt-line.c
> index e6b8410..4f25748 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -3,6 +3,7 @@
>  #include "run-command.h"
>  
>  char packet_buffer[LARGE_PACKET_MAX];
> +char packet_write_buffer[LARGE_PACKET_MAX];

Should this be static? I.e., are random other bits of the code allowed
to write into it (I guess not because it's not declared in pkt-line.h).

> +int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +	if (size > PKTLINE_DATA_MAXLEN)
> +		return -1;
> +	packet_trace(buf, size, 1);
> +	memmove(packet_write_buffer + 4, buf, size);

It looks like this iteration drops the idea of callers using a
LARGE_PACKET_MAX buffer and only filling it at "buf+4" with
PKTLINE_DATA_MAXLEN bytes (which is fine).

I wonder if we still need PKTLINE_DATA_MAXLEN, or of it is just
obscuring things. The magic number "4" still appears separately here,
and it actually makes it harder to see that things are correct.  I.e.,
doing:

  if (size > sizeof(packet_write_buffer) - 4)
	return -1;
  memmove(packet_write_buffer + 4, buf, size);

is more obviously correct, because you do not have to wonder about the
relationship between the size of your buffer and the macro.

It might still be worth having PKTLINE_DATA_MAXLEN public, though, if
callers use it to size their input to packet_write_gently().

-Peff
