Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C0A2070C
	for <e@80x24.org>; Tue,  5 Jul 2016 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbcGEUfy (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 16:35:54 -0400
Received: from alt42.smtp-out.videotron.ca ([23.233.128.29]:10534 "EHLO
	alt42.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbcGEUfx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 16:35:53 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id KX4Qblf3t6cTKKX4RbI6I8; Tue, 05 Jul 2016 16:35:52 -0400
X-Authority-Analysis: v=2.1 cv=TfA2zUkh c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=cAmyUtKerLwA:10 a=dg4UtMH5AAAA:8 a=gmOmvIjuo_xqjdmS-JAA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 4E4722DA0543;
	Tue,  5 Jul 2016 16:35:50 -0400 (EDT)
Date:	Tue, 5 Jul 2016 16:35:50 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1607051625581.1824@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr> <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr> <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJOoX5bX3/4Sm6O/i1c8gutVRi1rg6w7iB87x8tOoGjEVDC+kRdbAUQ34ncjlE8Nmyuvn9gJT/cJ/2QYanEGwNREEUWEFZPJwvcN7WXxoINqr8U045Uz
 vVLcs276FF0rv9S++GEWILL8wFAjuNymbNNq5Q6P52BJShBgbTtm0HiXzBtnz7elvU/tb54nJmysBV5oA254wOl1WOVklqOa1e0=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > To make it clearer, here's a patch on top of pu that fixes all the 
> > issues I think are remaining. All tests pass now.
> 
> Lukas, can you see what is in 'pu' after I push out today's
> integration result in several hours and tell us if you like the
> result of the SQUASH??? change?

Here's a patch on top of it providing small optimizations.

----- >8
Subject: sideband.c: small optimization of strbuf usage

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/sideband.c b/sideband.c
index 3cf3ced..b7e196b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -68,12 +68,12 @@ int recv_sideband(const char *me, int in_stream, int out)
 				int linelen = brk - b;
 
 				if (!outbuf.len)
-					strbuf_addf(&outbuf, "%s", PREFIX);
+					strbuf_addstr(&outbuf, PREFIX);
 				if (linelen > 0) {
 					strbuf_addf(&outbuf, "%.*s%s%c",
 						    linelen, b, suffix, *brk);
 				} else {
-					strbuf_addf(&outbuf, "%c", *brk);
+					strbuf_addch(&outbuf, *brk);
 				}
 				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);
@@ -97,7 +97,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 	}
 
 	if (outbuf.len) {
-		strbuf_addf(&outbuf, "\n");
+		strbuf_addch(&outbuf, "\n");
 		xwrite(2, outbuf.buf, outbuf.len);
 	}
 	strbuf_release(&outbuf);
