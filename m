Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCF62018A
	for <e@80x24.org>; Mon, 27 Jun 2016 20:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcF0UsE (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 16:48:04 -0400
Received: from alt22.smtp-out.videotron.ca ([70.80.0.73]:14224 "EHLO
	alt22.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbcF0UsD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 16:48:03 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id HdRnbaiMMPTiyHdRobatru; Mon, 27 Jun 2016 16:48:01 -0400
X-Authority-Analysis: v=2.1 cv=L469O7n8 c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=PKzvZo6CAAAA:8 a=l7qd0joI-Eg3BzCgipUA:9 a=CjuIK1q_8ugA:10
 a=q92HNjYiIAC_jH7JDaYf:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 7640F2DA01B3;
	Mon, 27 Jun 2016 16:47:59 -0400 (EDT)
Date:	Mon, 27 Jun 2016 16:47:59 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Lukas Fleischer <lfleischer@lfos.de>
cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
In-Reply-To: <146705966655.11886.6547584744094511110@typhoon>
Message-ID: <alpine.LFD.2.20.1606271640230.2550@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de> <20160624153121.GA2494@sigill.intra.peff.net> <alpine.DEB.2.20.1606241942220.12947@virtualbox> <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com> <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de> <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com> <20160627161616.GA4430@sigill.intra.peff.net>
 <xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com> <146705966655.11886.6547584744094511110@typhoon>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfBodhpJGU1wBJl9vjKacdU5damaw6giSGNoXMYd+IL1XL8ZxBKmhk0wt0dILMzGBpQN58eP5/9h/yOq1/W/E26QM+H0pgIsKbkT/4lIeVRNG46vgPyUq
 zSjXG0MgdF1PMXgREyGwKJwtmCTQhJf7fziWYIz/DjZZf59r0BXaiSpVHZxdmM4zBzkzSWITLLUMj2Dk3m3n3wWOAYU1V9u/02JDYJCkrud2n2bqrfFdcvfS
 2p8yc/OksMEEtj6nwGldnLn/+6MIdUUUBQSFOOl/1sBKWdp31hDQOsp0/AXn+INT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 27 Jun 2016, Lukas Fleischer wrote:

> On Mon, 27 Jun 2016 at 19:50:13, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:
> > >
> > >> It's just you used xwrite() there that introduced a different issue.
> > >> Wouldn't replacing it with fwrite(stderr) without changing anything
> > >> else solve that?
> 
> I do not see how using fwrite() buys us anything. Neither fwrite() nor
> fputs() nor fprintf() guarantee to call write() only once. Each of these
> three functions is buffered when printing to stdout and unbuffered when
> printing to stderr.

You are right.  However, in practice:

- fprintf(stderr, "%s", buffer) is likely to call write() only once 
  given there is only one string specifier, and

- On Windows the ANSI escape sequences are interpreted by fprintf() and 
  not by write() nor by the actual display console code. Insane but such 
  is life sometimes.

So the point is simply to replace your call to write() by a call to 
fprintf(..., "%*s", ...) in your patch which should provide the same 
end result as before.


Nicolas
