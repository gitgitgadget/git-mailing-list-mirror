Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980D52018B
	for <e@80x24.org>; Tue, 28 Jun 2016 17:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbcF1Rqt (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:46:49 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:62855 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752462AbcF1Rqs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 13:46:48 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id Hx5xbHSeOWjC4Hx5ybRTWI; Tue, 28 Jun 2016 13:46:47 -0400
X-Authority-Analysis: v=2.1 cv=FfyXvMK6 c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=Mx7TBeJlNWgpLitEXX0A:9 a=CjuIK1q_8ugA:10
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 85B7F2DA0200;
	Tue, 28 Jun 2016 13:46:45 -0400 (EDT)
Date:	Tue, 28 Jun 2016 13:46:45 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOQndfXinkshXRgRhQUyF4Azkzzc7/bups1KbgdicCo5gqUYfUw0WQpKlKgq28viO7NvEPiMbvnf81G9+l6NRp+7Kb7bh0t94cGCqXnDSViEsFuzi3AZ
 SOjIvImBdjyj7MRYsI7RY3bZzhgbMSgdIsFBIumbgju7Od74N3ZciwqtHBHaBBNoV9W1I6jhEff90F9CaFdLvTrIJKNQf/9eadDWkH61MeGfgkwzw3G2FFua
 vhkbn1KiaqqEPaz8wE47LrIJSX6/UTLU9UZcQt+U8+Y=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> And then that made me stare at the patch even more.  We still write
> some error messages to stderr in the updated code (without my crap
> SQUASH) inside "while (!retval)" loop:
> 
> 	while (retval == 0) {
> 		int band, len;
> 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
> 		if (len == 0)
> 			break;
> 		if (len < 1) {
> 			fprintf(stderr, "%s: protocol error: no band designator\n", me);
> 			retval = SIDEBAND_PROTOCOL_ERROR;
> 			break;
> 		}
> 		band = buf[0] & 0xff;
> 		buf[len] = '\0';
> 		len--;
> 		switch (band) {
> 		case 3:
> 			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
> 			retval = SIDEBAND_REMOTE_ERROR;
> 			break;
> 		case 2:
> 			...
> 			while ((brk = strpbrk(b, "\n\r"))) {
> 				...
> 				write(2, outbuf.buf, outbuf.len);
> 				...
> 			}
> 
> 			if (*b)
> 				strbuf_addf(&outbuf, "%s", b);
> 			break;
> 		case 1:
> 			write_or_die(out, buf + 1, len);
> 			break;
> 		default:
> 			fprintf(stderr, "%s: protocol error: bad band #%d\n",
> 				me, band);
> 			retval = SIDEBAND_PROTOCOL_ERROR;
> 			break;
> 		}
> 	}
> 
> 	if (outbuf.len > 0)
> 		write(2, outbuf.buf, outbuf.len);
> 
> In general, mixing stdio and raw file descriptor access is not such
> a good idea, but these remaining calls to fprintf(stderr, ...) above
> are for error-exit codepath, so from that point of view, the above
> illustration may be acceptable, but there is still one niggle.
> 
> When we exit the loop because we set retval to a non-zero value,
> should we still drain the outbuf?

I would think so.  Anything that the remote sent before any error should 
be printed nevertheless.  The clue for the error might be in the pending 
buffer.

However in this case the actual error printout and the pending buffer 
will appear reversed.

So what I'd suggest is actually something like this:

            if (len < 1) {
                    strbuf_addf(&outbuf, "\n%s: protocol error: no band designator\n", me);
                    retval = SIDEBAND_PROTOCOL_ERROR;
                    break;

And so on for the other error cases.


Nicolas
