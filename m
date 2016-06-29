Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44F02018A
	for <e@80x24.org>; Wed, 29 Jun 2016 02:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcF2Cuw (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 22:50:52 -0400
Received: from alt22.smtp-out.videotron.ca ([70.80.0.73]:14585 "EHLO
	alt22.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752450AbcF2Cuv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 22:50:51 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id I4q3befk2PTiyI4q4bd93b; Tue, 28 Jun 2016 22:02:53 -0400
X-Authority-Analysis: v=2.1 cv=L469O7n8 c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=Wndwbp34r4s3ELBlSEMA:9
 a=7QR2YfpzeocusIPy:21 a=6iGz4vdewQOhZOSG:21 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id E9A452DA0200;
	Tue, 28 Jun 2016 22:02:50 -0400 (EDT)
Date:	Tue, 28 Jun 2016 22:02:50 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr> <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfPget0Io4Ksy6Kr2mJTJ6JXLbcTVy5VW5IC7dkmvLL8931m7qRMo3BCHQTpLDAoNl0/xwl+xV2loj5Sa6ssGgwlbPtR/hXSnxafQQj0dVpIDNeoPgwrR
 6ttBjNs3H7g6TZCDwNm4KIJU8rz6A6sJt79epUaK3ul8qQD7d5pnvH8b8TqiQlbgdjgJmHoxaJA9p+db+vrAzxo1L8Ssl0Fh6ayGSw/hFaiHvT00HUKcpWe/
 j/Jb4U7gAhPsMEmZ7GE2yDNfc+MPvb+YbISDsex+ioE=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> The basic structure of the code (without the "SQUASH" we discussed)
> >> looks like this:
> >> 
> >> 	strbuf_addf(&outbuf, "%s", PREFIX);
> >> 	while (retval == 0) {
> >> 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
> >> 		...
> >> 		band = buf[0] & 0xff;
> >> 		switch (band) {
> >> 		case 3:
> >> 			... /* emergency exit */
> >> 		case 2:
> >> 			while ((brk = strpbrk(b, "\n\r"))) {
> >> 				int linelen = brk - b;
> >> 
> >> 				if (linelen > 0) {
> >> 					strbuf_addf(&outbuf, "%.*s%s%c",
> >> 						    linelen, b, suffix, *brk);
> >> 				} else {
> >> 					strbuf_addf(&outbuf, "%c", *brk);
> >> 				}
> >> 				fprintf(stderr, "%.*s", (int)outbuf.len,
> >> 					outbuf.buf);
> >> 				strbuf_reset(&outbuf);
> >> 				strbuf_addf(&outbuf, "%s", PREFIX);
> >> 				b = brk + 1;
> >> 			}
> >> 			if (*b)
> >> 				strbuf_addf(&outbuf, "%s", b);
> >> 			break;
> >> 		...
> >> 		}
> >> 	}
> >> 
> >> 	if (outbuf.len > 0)
> >> 		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> >>  ...
> > That won't work. If at this point there is the beginning of a partial 
> > line queued in the buffer from the previous round waiting to see its 
> > line break, you just deleted the beginning of that line.
> 
> Ahh, OK, a single logical line split into two and sent in two
> packets--the first one would not result in any output (just does "if
> (*b) strbuf_addf(...)" to buffer it) and then the second one finally
> finds a LF.  Yeah, that won't work if we cleared.
> 
> But then my observation still holds, no?

I think it does... but I'm no longer sure of what you meant.

To make it clearer, here's a patch on top of pu that fixes all the 
issues I think are remaining. All tests pass now.

diff --git a/sideband.c b/sideband.c
index 36a032f..0e6c6df 100644
--- a/sideband.c
+++ b/sideband.c
@@ -23,10 +23,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 	const char *term, *suffix;
 	char buf[LARGE_PACKET_MAX + 1];
 	struct strbuf outbuf = STRBUF_INIT;
-	const char *b, *brk;
 	int retval = 0;
 
-	strbuf_addf(&outbuf, "%s", PREFIX);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
@@ -34,14 +32,15 @@ int recv_sideband(const char *me, int in_stream, int out)
 		suffix = DUMB_SUFFIX;
 
 	while (!retval) {
+		const char *b, *brk;
 		int band, len;
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
 			strbuf_addf(&outbuf,
-				    "\n%s: protocol error: no band designator\n",
-				    me);
+				    "%s%s: protocol error: no band designator",
+				    outbuf.len ? "\n" : "", me);
 			retval = SIDEBAND_PROTOCOL_ERROR;
 			break;
 		}
@@ -50,7 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			strbuf_addf(&outbuf, "\n%s%s\n", PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
+				    PREFIX, buf + 1);
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -70,6 +70,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 			while ((brk = strpbrk(b, "\n\r"))) {
 				int linelen = brk - b;
 
+				if (!outbuf.len)
+					strbuf_addf(&outbuf, "%s", PREFIX);
 				if (linelen > 0) {
 					strbuf_addf(&outbuf, "%.*s%s%c",
 						    linelen, b, suffix, *brk);
@@ -78,27 +80,29 @@ int recv_sideband(const char *me, int in_stream, int out)
 				}
 				fwrite(outbuf.buf, 1, outbuf.len, stderr);
 				strbuf_reset(&outbuf);
-				strbuf_addf(&outbuf, "%s", PREFIX);
 
 				b = brk + 1;
 			}
 
 			if (*b)
-				strbuf_addf(&outbuf, "%s", b);
+				strbuf_addf(&outbuf, "%s%s",
+					    outbuf.len ? "" : PREFIX, b);
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
 			break;
 		default:
-			strbuf_addf(&outbuf, "\n%s: protocol error: bad band #%d\n",
-				me, band);
+			strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
+				    outbuf.len ? "\n" : "", me, band);
 			retval = SIDEBAND_PROTOCOL_ERROR;
 			break;
 		}
 	}
 
-	if (outbuf.len)
+	if (outbuf.len) {
+		strbuf_addf(&outbuf, "\n");
 		fwrite(outbuf.buf, 1, outbuf.len, stderr);
+	}
 	strbuf_release(&outbuf);
 	return retval;
 }
