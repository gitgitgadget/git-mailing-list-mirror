Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA0A1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbcHYVlJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 17:41:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53370 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754376AbcHYVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 17:41:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8952437654;
        Thu, 25 Aug 2016 17:41:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nzIqNPGgGgQGAAZQYsLw3ZAVfxE=; b=hJMUlh
        vWQ9NO8WAxhdWy7Y0B4/9/biL9sRl0IazWC5rZFbW5RVdT75F6ibgHOyssi8VRly
        HRQ/WKFW/1GB2ipc4uphiSowslmAK90H1XBYMAdvuGcjC0ZHrli8oDmIIi95yQ3Y
        q/KLOv8lXxNdO2rnzaaAttoB4Eutu2U68MB+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZJORlR6Jer/LTaqhVwGLRgK1g/9dNl5
        QubBTNA90X/eBpBQBG4BQSn9C+Py1CjTnSc6Tws1xpOjlnWnv7g6a6UTRdt331w/
        dVu4VvqMPlh4aFIvsUd+79jOKwwplV3TsREax6HPk1x9sBO4i2kXXEefzozHsizQ
        2GNWclb64kQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8143537652;
        Thu, 25 Aug 2016 17:41:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7A5F37651;
        Thu, 25 Aug 2016 17:41:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-4-larsxschneider@gmail.com>
Date:   Thu, 25 Aug 2016 14:41:03 -0700
In-Reply-To: <20160825110752.31581-4-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:42
        +0200")
Message-ID: <xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0A437BA-6B0C-11E6-872F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_fmt() would die in case of a write error even though for
> some callers an error would be acceptable. Add packet_write_fmt_gently()
> which writes a formatted pkt-line and returns `0` for success and `-1`
> for an error.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 12 ++++++++++++
>  pkt-line.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index e8adc0f..3e8b2fb 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -137,6 +137,18 @@ void packet_write_fmt(int fd, const char *fmt, ...)
>  	write_or_die(fd, buf.buf, buf.len);
>  }
>  
> +int packet_write_fmt_gently(int fd, const char *fmt, ...)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	va_list args;
> +
> +	strbuf_reset(&buf);
> +	va_start(args, fmt);
> +	format_packet(&buf, fmt, args);
> +	va_end(args);
> +	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
> +}

Even though its only a handful lines, it is a bit ugly to have a
completely copied implementation only to have _gently().  I suspect
that you should be able to

	static int packet_write_fmt_1(int fd, int gently,
					const char *fmt, va_list args)
        {
		struct strbuf buf = STRBUF_INIT;
		size_t count;

		format_packet(&buf, fmt, args);
		
		count = write_in_full(fd, buf.buf, buf.len);
                if (count == buf.len)
                	return 0;
		if (!gently) {
			check_pipe(errno);
                	die_errno("write error");
		}
                return -1;
	}

and then share that between the existing one:

	void packet_write_fmt(int fd, const char *fmt, ...)
        {
		va_list args;
	        va_start(args, fmt);
                packet_write_fmt_1(fd, 0, fmt, args);
                va_end(args);
	}

and the new one:

	void packet_write_fmt_gently(int fd, const char *fmt, ...)
        {
		int status;
		va_list args;
	        va_start(args, fmt);
                status = packet_write_fmt_1(fd, 1, fmt, args);
                va_end(args);
		return status;
	}

>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
> diff --git a/pkt-line.h b/pkt-line.h
> index 1902fb3..3caea77 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -23,6 +23,7 @@ void packet_flush(int fd);
>  void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  
>  /*
>   * Read a packetized line into the buffer, which must be at least size bytes
