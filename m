Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BDF2018B
	for <e@80x24.org>; Tue, 28 Jun 2016 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbcF1ST4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:19:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752415AbcF1STv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A7A725F8D;
	Tue, 28 Jun 2016 14:13:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I35tnPe+vgIN9fX0ovuDX29W7g8=; b=n8R15m
	JsvAliGvtKzfVVW1RSj1/dF1vixEgiTSHusTnJ41fFKRvoi3wWGGK7S6385l8KoO
	+fWb89TJthguz982lcT6I8D60MJD3L3hag4xduVMbhVaWwoEBijFe/MQeUNvIATi
	FDbOKQ6VcffLBR5Nj5KKCK0MX1ewJt1RKAoVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iwTHNpvnxLEiMyF7JcIVbmBqBo67Eq9q
	zYqiuMmwKUmIUN/Rnq7KZhRHSrDIqxqoI0AZXgMLwsYFgUzFwqAXyBXa64gJrz3Q
	MOaKwslFlUOQmXNtOdgCf/ljmQF7E4HrlgUK5vL2STkmKbg5L9hFhqHCt58/c9LX
	A8iJrCF3sjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00A8F25F8C;
	Tue, 28 Jun 2016 14:13:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7764E25F8B;
	Tue, 28 Jun 2016 14:13:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
	<xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
Date:	Tue, 28 Jun 2016 11:13:19 -0700
In-Reply-To: <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr> (Nicolas
	Pitre's message of "Tue, 28 Jun 2016 13:46:45 -0400 (EDT)")
Message-ID: <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF3EC56C-3D5B-11E6-A65B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

>> When we exit the loop because we set retval to a non-zero value,
>> should we still drain the outbuf?
>
> I would think so.  Anything that the remote sent before any error should 
> be printed nevertheless.  The clue for the error might be in the pending 
> buffer.
>
> However in this case the actual error printout and the pending buffer 
> will appear reversed.
>
> So what I'd suggest is actually something like this:
>
>             if (len < 1) {
>                     strbuf_addf(&outbuf, "\n%s: protocol error: no band designator\n", me);
>                     retval = SIDEBAND_PROTOCOL_ERROR;
>                     break;
>
> And so on for the other error cases.

Makes sense.

Here is what I have as a "SQUASH" on top of Lukas's change to be
queued on 'pu'.

It appears that a few tests get their expectations broken, with or
without this "SQUASH" change, though X-<.

 sideband.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sideband.c b/sideband.c
index 226a8c2..082dfc6 100644
--- a/sideband.c
+++ b/sideband.c
@@ -33,13 +33,15 @@ int recv_sideband(const char *me, int in_stream, int out)
 	else
 		suffix = DUMB_SUFFIX;
 
-	while (retval == 0) {
+	while (!retval) {
 		int band, len;
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
-			fprintf(stderr, "%s: protocol error: no band designator\n", me);
+			strbuf_addf(&outbuf,
+				    "\n%s: protocol error: no band designator\n",
+				    me);
 			retval = SIDEBAND_PROTOCOL_ERROR;
 			break;
 		}
@@ -48,7 +50,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "\n%s%s\n", PREFIX, buf + 1);
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -58,13 +60,12 @@ int recv_sideband(const char *me, int in_stream, int out)
 			 * Append a suffix to each nonempty line to clear the
 			 * end of the screen line.
 			 *
-			 * The output is accumulated in a buffer and each line
-			 * is printed to stderr using fprintf() with a single
-			 * conversion specifier. This is a "best effort"
-			 * approach to supporting both inter-process atomicity
-			 * (single conversion specifiers are likely to end up
-			 * in single atomic write() system calls) and the ANSI
-			 * control code emulation under Windows.
+			 * The output is accumulated in a buffer and
+			 * each line is printed to stderr using
+			 * fwrite(3).  This is a "best effort"
+			 * approach to support inter-process atomicity
+			 * (single fwrite(3) call is likely to end up
+			 * in single atomic write() system calls).
 			 */
 			while ((brk = strpbrk(b, "\n\r"))) {
 				int linelen = brk - b;
@@ -75,8 +76,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				} else {
 					strbuf_addf(&outbuf, "%c", *brk);
 				}
-				fprintf(stderr, "%.*s", (int)outbuf.len,
-					outbuf.buf);
+				fwrite(outbuf.buf, 1, outbuf.len, stderr);
 				strbuf_reset(&outbuf);
 				strbuf_addf(&outbuf, "%s", PREFIX);
 
@@ -90,15 +90,15 @@ int recv_sideband(const char *me, int in_stream, int out)
 			write_or_die(out, buf + 1, len);
 			break;
 		default:
-			fprintf(stderr, "%s: protocol error: bad band #%d\n",
+			strbuf_addf(&outbuf, "\n%s: protocol error: bad band #%d\n",
 				me, band);
 			retval = SIDEBAND_PROTOCOL_ERROR;
 			break;
 		}
 	}
 
-	if (outbuf.len > 0)
-		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
+	if (outbuf.len)
+		fwrite(outbuf.buf, 1, outbuf.len, stderr);
 	strbuf_release(&outbuf);
 	return retval;
 }
