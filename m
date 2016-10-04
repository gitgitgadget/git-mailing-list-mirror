Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0F320986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbcJDTxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:53:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752780AbcJDTxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:53:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A15942434;
        Tue,  4 Oct 2016 15:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qZ1IJURqpwxHe8HFCnUvxahCbUY=; b=QG6Xgg
        xEHzZyhrC7xe4WH6s6wfuV/BTVdB80fwYCjXqZzie0LggiEeqMeDcviYcS8NN7tz
        vNuZC1HzE9HHdINBMIlTRmIq1sFz3G4ztqURK+dXUAbjEmxssVer3Vt9Dgsg0LQW
        De0cq5CPQwG1FYMAi++EbIAJ28Eg2I/d89iDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xcJhGu4torgTz/N1YQCkRkbuAthm8x3j
        m7X7aXW6ujB2PP9MRA8jUwF+V1S/XRBP8VUXDN04lf6uDgYLxCXFNPQtiyq7vl5E
        xr/lP6ZentS15zM6EB5TaixYgeJR361F7u7g7h+XYFqpO0inPNlCo+I7KtZv1Ne7
        +Mvt/hmGJLw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5221442433;
        Tue,  4 Oct 2016 15:53:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C663A42431;
        Tue,  4 Oct 2016 15:53:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 10/14] pkt-line: add functions to read/write flush terminated packet streams
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-11-larsxschneider@gmail.com>
Date:   Tue, 04 Oct 2016 12:53:50 -0700
In-Reply-To: <20161004125947.67104-11-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Tue, 4 Oct 2016 14:59:43
        +0200")
Message-ID: <xmqq8tu3ubzl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46B3617A-8A6C-11E6-8BFF-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> write_packetized_from_fd() and write_packetized_from_buf() write a
> stream of packets. All content packets use the maximal packet size
> except for the last one. After the last content packet a `flush` control
> packet is written.
>
> read_packetized_to_strbuf() reads arbitrary sized packets until it
> detects a `flush` packet.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  pkt-line.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pkt-line.h |  8 ++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 3fd4dc0..8ffde22 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -196,6 +196,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +int write_packetized_from_fd(int fd_in, int fd_out)
> +{
> +	static char buf[LARGE_PACKET_DATA_MAX];
> +	int err = 0;
> +	ssize_t bytes_to_write;
> +
> +	while (!err) {
> +		bytes_to_write = xread(fd_in, buf, sizeof(buf));
> +		if (bytes_to_write < 0)
> +			return COPY_READ_ERROR;
> +		if (bytes_to_write == 0)
> +			break;
> +		err = packet_write_gently(fd_out, buf, bytes_to_write);
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}

OK.

> +int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
> +{
> +	static char buf[LARGE_PACKET_DATA_MAX];
> +	int err = 0;
> +	size_t bytes_written = 0;
> +	size_t bytes_to_write;
> +
> +	while (!err) {
> +		if ((len - bytes_written) > sizeof(buf))
> +			bytes_to_write = sizeof(buf);
> +		else
> +			bytes_to_write = len - bytes_written;
> +		if (bytes_to_write == 0)
> +			break;
> +		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
> +		bytes_written += bytes_to_write;
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}

Hmph, what is buf[] used for, other than its sizeof() taken to yield
a constant LARGE_PACKET_DATA_MAX?

> @@ -305,3 +346,31 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
>  {
>  	return packet_read_line_generic(-1, src, src_len, dst_len);
>  }
> +
> +ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
> +{
> +	int packet_len;
> +
> +	size_t orig_len = sb_out->len;
> +	size_t orig_alloc = sb_out->alloc;
> +
> +	for (;;) {
> +		strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
> +		packet_len = packet_read(fd_in, NULL, NULL,
> +			// TODO: explain + 1

No // C99 comment please.

And I agree that the +1 needs to be explained.

> +			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
> +			PACKET_READ_GENTLE_ON_EOF);
> +		if (packet_len <= 0)
> +			break;

Hmph.  So at the end of a data stream, we ask packet_read() to read
64kB or so, packet_read() gets the packet length by calling
get_packet_data() and then another get_packet_data() reads that much
and return.  What happens during the next round?  The first call to
get_packet_data() in packet_read() will find that the stream has
ended and returns -1, which is stored in packet_len here?  But then
the data is discarded after the loop when packet_len is negative.

I must be missing something.  Is the other side always supposed to
give a flush packet or something?  Perhaps that is what is happening
here.  If so, I am OK with that, even though it somehow sounds a bit
wasteful.

