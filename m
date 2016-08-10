Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110571FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbcHJSF0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:05:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932649AbcHJSFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 352C830572;
	Wed, 10 Aug 2016 12:27:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/lD55f/P1CL3p94OjJuuN0EwVLM=; b=PkhYdu
	RBopy/gzwGaVFEkQvuuRBLKJobAolZMbzDE9y0RFoOiIXDhDUzQdZGcSvJ2ySema
	dKQf389pMT0o1hYdLr0++KruEnaQWOa8pR9dY9AoamxdEIZPi0HhjcPpfz4ekf1Y
	8HyWn18IjXy2lyFY526wr87jGZ91DwZyjRgYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhZr/zW+Eydz4/udFtbf/K0lC3TG+vOf
	ihkFqNZx5//6U+XkqfKzvV8s8kO7xk8ZwK7ITE9xhVG5YbcWvlG+lUC77PO/fi4v
	fy36+ebBfDuTAmo8xKf67q2RPthP44Srn/Tx0fJsew6m2mREq0zbDn77uucRKBuF
	VMRFrIc3Hfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E5AB30571;
	Wed, 10 Aug 2016 12:27:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A27DF30570;
	Wed, 10 Aug 2016 12:27:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: buffer headers before sending
References: <20160809234731.GA10310@dcvr>
Date:	Wed, 10 Aug 2016 09:27:14 -0700
In-Reply-To: <20160809234731.GA10310@dcvr> (Eric Wong's message of "Tue, 9 Aug
	2016 23:47:31 +0000")
Message-ID: <xmqqlh047fod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D46F73E-5F17-11E6-8BA1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> diff --git a/http-backend.c b/http-backend.c
> index 0d59499..adc8c8c 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -75,55 +75,57 @@ static void format_write(int fd, const char *fmt, ...)
>  	write_or_die(fd, buffer, n);
>  }
>  
> -static void http_status(unsigned code, const char *msg)
> +static void http_status(struct strbuf *hdr, unsigned code, const char *msg)
>  {
> -	format_write(1, "Status: %u %s\r\n", code, msg);
> +	strbuf_addf(hdr, "Status: %u %s\r\n", code, msg);
>  }

The idea is to pass "struct strbuf *hdr" around the callchain to
helpers so that they can all append into it instead of doing
format_write(), which is sensible.  This pattern continues quite a
bit (omitted).

> -static void end_headers(void)
> +static void end_headers(struct strbuf *hdr)
>  {
> -	write_or_die(1, "\r\n", 2);
> +	strbuf_add(hdr, "\r\n", 2);
> +	write_or_die(1, hdr->buf, hdr->len);
> +	strbuf_release(hdr);
>  }

Then end_headers() is taught to drain the buffered headers.  The
helpers used by other helpers in the next level of abstraction that
emit the header and the body also need to take the buffer as their
parameter, like this one:

> -static void send_strbuf(const char *type, struct strbuf *buf)
> +static void send_strbuf(struct strbuf *hdr,
> +			const char *type, struct strbuf *buf)
>  {
> -	hdr_int(content_length, buf->len);
> -	hdr_str(content_type, type);
> -	end_headers();
> +	hdr_int(hdr, content_length, buf->len);
> +	hdr_str(hdr, content_type, type);
> +	end_headers(hdr);
>  	write_or_die(1, buf->buf, buf->len);
>  }

because their caller already has something to say in the header
part.

> +static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
> +{
> +	const char *proto = getenv("SERVER_PROTOCOL");
> +
> +	if (proto && !strcmp(proto, "HTTP/1.1")) {
> +		http_status(hdr, 405, "Method Not Allowed");
> +		hdr_str(hdr, "Allow",
> +			!strcmp(c->method, "GET") ? "GET, HEAD" : c->method);
> +	} else
> +		http_status(hdr, 400, "Bad Request");
> +	hdr_nocache(hdr);
> +	end_headers(hdr);
> +	return 0;
> +}
> +

This is like other helpers that respond with 4xx, e.g. forbidden(),
but it did not exist only because there was a single callsite that
needed this feature, which made it open-coded directly in main().
It was somewhat surprising to see a new helper, because the only
thing this patch changes logically is where the output is sent, but
this is a very sensible refactoring.

>  int cmd_main(int argc, const char **argv)
>  {
>  	char *method = getenv("REQUEST_METHOD");
> ...
> @@ -659,18 +681,8 @@ int cmd_main(int argc, const char **argv)
>  		if (!regexec(&re, dir, 1, out, 0)) {
>  			size_t n;
>  
> -			if (strcmp(method, c->method)) {
> -				const char *proto = getenv("SERVER_PROTOCOL");
> -				if (proto && !strcmp(proto, "HTTP/1.1")) {
> -					http_status(405, "Method Not Allowed");
> -					hdr_str("Allow", !strcmp(c->method, "GET") ?
> -						"GET, HEAD" : c->method);
> -				} else
> -					http_status(400, "Bad Request");
> -				hdr_nocache();
> -				end_headers();
> -				return 0;
> -			}
> +			if (strcmp(method, c->method))
> +				return bad_request(&hdr, c);

... and this is where it came from.  It could have been a separate
"preparatory cleanup" step, but it is so trivial that "while at it"
clean-up is perfectly fine.

Thanks, will queue.

