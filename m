Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7ED2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbcF1Q5f (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:57:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752230AbcF1Q5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:57:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 117FB2532D;
	Tue, 28 Jun 2016 12:57:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pO8kaSQtGfFaYtvzqiHvdl6ue7M=; b=YzjQvh
	vexU7MNOs5WvTZWbDV8aCkod/z/rGlBBTQspKBkooF6UaaOEyfC1htODJHW+GCLI
	4ixhGIX+WdnRFV5EUjHLz0rC5QGGTvqhzUqCn/D8XBN0bGhQ+xB+MNnNDhYPg//c
	/q4z+vcBmuI9Vu/qIaaYsnIYwjfaiRm4+WlQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOPuXT9dt9IDRyX8g6dfJ4eQ15AoIBLO
	M9GgGqLSZadzKvrWSQ8JsStXyV6nTJ+5FTcuiPwd0QpYCWsbShSjhlg5LzVBc2D8
	F1gyUO5LRGOgECKGSpmbx7Vt92oGSkrGoGr9D2nhkegjwxyQyBJv1IW+fLBZ6PAO
	iVwkf0FVqFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 097872532A;
	Tue, 28 Jun 2016 12:57:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6573C25329;
	Tue, 28 Jun 2016 12:57:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
Date:	Tue, 28 Jun 2016 09:57:30 -0700
In-Reply-To: <20160628043526.19403-1-lfleischer@lfos.de> (Lukas Fleischer's
	message of "Tue, 28 Jun 2016 06:35:26 +0200")
Message-ID: <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67D2F266-3D51-11E6-9B98-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lukas Fleischer <lfleischer@lfos.de> writes:

> Before this patch, we used character buffer manipulations to split
> messages from the sideband at line breaks and insert "remote: " at the
> beginning of each line, using the packet size to determine the end of a
> message. However, since it is safe to assume that diagnostic messages
> from the sideband never contain NUL characters, we can also
> NUL-terminate the buffer, use strpbrk() for splitting lines and use
> format strings to insert the prefix.
>
> A strbuf is used for accumulating the output which is then printed using
> a single fprintf() call with a single conversion specifier per line,
> such that the atomicity of the output is preserved. See 9ac13ec (atomic
> write for sideband remote messages, 2006-10-11) for details.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> Changes since v3:
> * The new code always frees the strbuf used for the output.
> * Switched back to fprintf() to support ANSI codes under Windows.
> * Added a comment on the tradeoff between atomicity and Windows support.

With input from Dscho that recent Git-for-Windows does the right
thing without limiting us to use only a subset of stdio, perhaps we
would want to squash something like this in.

diff --git a/sideband.c b/sideband.c
index 226a8c2..72e2c5c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -58,13 +58,12 @@ int recv_sideband(const char *me, int in_stream, int out)
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
+			 * approach to suppor inter-process atomicity
+			 * (single fwrite(3) call is likely to end up
+			 * in single atomic write() system calls).
 			 */
 			while ((brk = strpbrk(b, "\n\r"))) {
 				int linelen = brk - b;
@@ -75,8 +74,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				} else {
 					strbuf_addf(&outbuf, "%c", *brk);
 				}
-				fprintf(stderr, "%.*s", (int)outbuf.len,
-					outbuf.buf);
+				fwrite(output.buf, 1, output.len, stderr);
 				strbuf_reset(&outbuf);
 				strbuf_addf(&outbuf, "%s", PREFIX);
 
@@ -98,7 +96,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 	}
 
 	if (outbuf.len > 0)
-		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
+		fwrite(output.buf, 1, output.len, stderr);
 	strbuf_release(&outbuf);
 	return retval;
 }
