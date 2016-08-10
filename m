Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070501FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934086AbcHJTKc (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:10:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:53091 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932298AbcHJTKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:10:30 -0400
Received: (qmail 27757 invoked by uid 109); 10 Aug 2016 13:43:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 13:43:49 +0000
Received: (qmail 32521 invoked by uid 111); 10 Aug 2016 13:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 09:43:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 09:43:47 -0400
Date:	Wed, 10 Aug 2016 09:43:47 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
Message-ID: <20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-6-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810130411.12419-6-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:04:01PM +0200, larsxschneider@gmail.com wrote:

> +int packet_write_gently_fmt(int fd, const char *fmt, ...)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	va_list args;
> +
> +	strbuf_reset(&buf);
> +	va_start(args, fmt);
> +	format_packet(1, &buf, fmt, args);
> +	va_end(args);
> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
> +	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
> +}

Could the end of this function just be:

  return packet_write_gently(fd, buf.buf, buf.len);

? I guess we'd prefer to avoid that, because it incurs an extra
memmove() of the data.

Similarly, I'd think this could share code with the non-gentle form
(which should be able to just call this and die() if returns an error).
Though sometimes the va_list transformation makes that awkward.

-Peff
