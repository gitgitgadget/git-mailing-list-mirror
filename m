Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1DF2018B
	for <e@80x24.org>; Tue, 28 Jun 2016 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbcF1RYw (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:24:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752227AbcF1RYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2318524D0A;
	Tue, 28 Jun 2016 13:24:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwMYeAhJL1GXMTqdwp1IKIbhRCs=; b=w0h9i7
	ONwUjK7MoFHdGhnQaXic94ztjoAAkE4wBtHbaABbgGmIgXTQ/SNuKsbg+L7i4AQl
	BZ/valFWjnE2i47LahXUHdjszHaJR6ySqo8fmIsVelo50jK/hM7UlTSY1FNcjsq0
	Ql74ATU0VOx6YQeA6gZVhYR8CShFoOrSyPoxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yCF3NNeSjd2gMbjDP1cROeI+t6246ypb
	MYepAICvElX9UerPHVL7XLR23NJcKhHdDuob++dRGH6wePll4OlmyJW7JwLh+7Z6
	2hFMAUCPRfeK8qAB8cVzoQQQs+fDJ/PGtdZ+vXz8A2NqHWS/RCuZrLjnm2XrLXKC
	lDZ9s+q04s4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AC5C24D09;
	Tue, 28 Jun 2016 13:24:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7FF024D08;
	Tue, 28 Jun 2016 13:24:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 10:24:42 -0700
In-Reply-To: <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jun 2016 09:57:30 -0700")
Message-ID: <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34B2533C-3D55-11E6-8FBD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> With input from Dscho that recent Git-for-Windows does the right
> thing without limiting us to use only a subset of stdio, perhaps we
> would want to squash something like this in.
>
> diff --git a/sideband.c b/sideband.c
> index 226a8c2..72e2c5c 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -58,13 +58,12 @@ int recv_sideband(const char *me, int in_stream, int out)
>  			 * Append a suffix to each nonempty line to clear the
>  			 * end of the screen line.
>  			 *
> -			 * The output is accumulated in a buffer and each line
> -			 * is printed to stderr using fprintf() with a single
> -			 * conversion specifier. This is a "best effort"
> -			 * approach to supporting both inter-process atomicity
> -			 * (single conversion specifiers are likely to end up
> -			 * in single atomic write() system calls) and the ANSI
> -			 * control code emulation under Windows.
> +			 * The output is accumulated in a buffer and
> +			 * each line is printed to stderr using
> +			 * fwrite(3).  This is a "best effort"
> +			 * approach to suppor inter-process atomicity
> +			 * (single fwrite(3) call is likely to end up
> +			 * in single atomic write() system calls).
>  			 */
>  			while ((brk = strpbrk(b, "\n\r"))) {
>  				int linelen = brk - b;

That may be good, but the remainder is crap.  Sorry about the typo;
s/output/outbuf/g is needed at least.

> @@ -75,8 +74,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				} else {
>  					strbuf_addf(&outbuf, "%c", *brk);
>  				}
> -				fprintf(stderr, "%.*s", (int)outbuf.len,
> -					outbuf.buf);
> +				fwrite(output.buf, 1, output.len, stderr);
>  				strbuf_reset(&outbuf);
>  				strbuf_addf(&outbuf, "%s", PREFIX);
>  
> @@ -98,7 +96,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  	}
>  
>  	if (outbuf.len > 0)
> -		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> +		fwrite(output.buf, 1, output.len, stderr);
>  	strbuf_release(&outbuf);
>  	return retval;
>  }

But we would be better off using the real write(2), now Windows port
does not limit us to stdio.

And then that made me stare at the patch even more.  We still write
some error messages to stderr in the updated code (without my crap
SQUASH) inside "while (!retval)" loop:

	while (retval == 0) {
		int band, len;
		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
		if (len == 0)
			break;
		if (len < 1) {
			fprintf(stderr, "%s: protocol error: no band designator\n", me);
			retval = SIDEBAND_PROTOCOL_ERROR;
			break;
		}
		band = buf[0] & 0xff;
		buf[len] = '\0';
		len--;
		switch (band) {
		case 3:
			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
			retval = SIDEBAND_REMOTE_ERROR;
			break;
		case 2:
			...
			while ((brk = strpbrk(b, "\n\r"))) {
				...
				write(2, outbuf.buf, outbuf.len);
				...
			}

			if (*b)
				strbuf_addf(&outbuf, "%s", b);
			break;
		case 1:
			write_or_die(out, buf + 1, len);
			break;
		default:
			fprintf(stderr, "%s: protocol error: bad band #%d\n",
				me, band);
			retval = SIDEBAND_PROTOCOL_ERROR;
			break;
		}
	}

	if (outbuf.len > 0)
		write(2, outbuf.buf, outbuf.len);

In general, mixing stdio and raw file descriptor access is not such
a good idea, but these remaining calls to fprintf(stderr, ...) above
are for error-exit codepath, so from that point of view, the above
illustration may be acceptable, but there is still one niggle.

When we exit the loop because we set retval to a non-zero value,
should we still drain the outbuf?

IOW, shouldn't the if statement after "while (!retval)" loop be more
like this?

	if (!retval && outbuf.len)
        	write(2, outbuf.buf, outbuf,len);

Thanks.
