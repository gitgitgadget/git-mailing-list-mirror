Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898452018A
	for <e@80x24.org>; Wed, 29 Jun 2016 03:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbcF2DAj (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 23:00:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752455AbcF2DAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 23:00:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57BA7270C1;
	Tue, 28 Jun 2016 23:00:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LOx3Knm2SzW8BG7VzNlsiATJhZY=; b=makXNV
	A2dIiBA6oQufPG4hMXrij7y+cOjSnqvO4VPssM6Qtqj5TNrd51Tdc5KC2mKNsdyz
	k2eE92Le5D0dGc9KVxrDwr3iwG3ffHRRhFFK8WTMylPbF6MUJ/GBGDA1/QSND2fr
	UZVNvCzrCyYtyLWucGmxMeOT8P2ktEWPuX0HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k98w+f78wh7Y7sRbIh8TPsUFnUPNMfKP
	6DrDQ9Zt250Zva2ajk3mXw2NPR6RAPsOvI9GwTZ9K+MQvUEgSxyEQ+OK+8+G1q8l
	4bClWvG4dJwxRXKC3LaHKjEkrV0Kem2uQHlJWlwhpZ6u6eVC2FoEXMvlVH0TlFok
	byc0KHcMaz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 501D0270C0;
	Tue, 28 Jun 2016 23:00:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D0F3270BB;
	Tue, 28 Jun 2016 23:00:06 -0400 (EDT)
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
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
	<xmqq60st853d.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
	<xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
	<xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
	<xmqq8txp6icn.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 20:00:03 -0700
In-Reply-To: <xmqq8txp6icn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jun 2016 15:47:52 -0700")
Message-ID: <xmqqshvw66oc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95302702-3DA5-11E6-A20A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It's just that if you take the latter, then the conditional after
> the loop exits (i.e. the last transmission was an incomplete line)
> cannot be "is outbuf empty?", as your base state is "has PREFIX and
> can never be empty".  I was working back from that if statement.

Let's try this again.  How does this look?

In this version:

 - "outbuf" is where we keep the (possibly partial) data collected
   to be eventually shown;

 - output of pending (possibly partial) data is handled by a helper
   function drain().  It is responsible for prepending of the
   PREFIX, which is treated purely as a cosmetic thing.  It also is
   responsible for completing an incomplete line at the end of the
   transmission (e.g. flushing of the buffered input upon reception of
   the emergency exit packet).

 - locally generated errors go directly to fprintf(stderr),
   bypassing outbuf (hence drain()).

 sideband.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/sideband.c b/sideband.c
index 226a8c2..6873137 100644
--- a/sideband.c
+++ b/sideband.c
@@ -18,6 +18,16 @@
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
+static void drain(struct strbuf *outbuf)
+{
+	if (!outbuf->len)
+		return;
+	strbuf_splice(outbuf, 0, 0, PREFIX, strlen(PREFIX));
+	strbuf_complete_line(outbuf);
+	fwrite(outbuf->buf, 1, outbuf->len, stderr);
+	strbuf_reset(outbuf);
+}
+
 int recv_sideband(const char *me, int in_stream, int out)
 {
 	const char *term, *suffix;
@@ -26,20 +36,21 @@ int recv_sideband(const char *me, int in_stream, int out)
 	const char *b, *brk;
 	int retval = 0;
 
-	strbuf_addf(&outbuf, "%s", PREFIX);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
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
+			drain(&outbuf);
+			fprintf(stderr, "%s: protocol error: no band designator\n",
+				me);
 			retval = SIDEBAND_PROTOCOL_ERROR;
 			break;
 		}
@@ -48,7 +59,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
+			drain(&outbuf);
+			strbuf_addf(&outbuf, "%s\n", buf + 1);
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -58,13 +70,12 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -75,11 +86,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				} else {
 					strbuf_addf(&outbuf, "%c", *brk);
 				}
-				fprintf(stderr, "%.*s", (int)outbuf.len,
-					outbuf.buf);
-				strbuf_reset(&outbuf);
-				strbuf_addf(&outbuf, "%s", PREFIX);
-
+				drain(&outbuf);
 				b = brk + 1;
 			}
 
@@ -90,6 +97,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 			write_or_die(out, buf + 1, len);
 			break;
 		default:
+			drain(&outbuf);
 			fprintf(stderr, "%s: protocol error: bad band #%d\n",
 				me, band);
 			retval = SIDEBAND_PROTOCOL_ERROR;
@@ -97,8 +105,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 		}
 	}
 
-	if (outbuf.len > 0)
-		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
+	drain(&outbuf);
 	strbuf_release(&outbuf);
 	return retval;
 }
