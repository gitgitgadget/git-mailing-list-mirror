Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991691F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933159AbcHYWp2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:45:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50177 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933081AbcHYWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:45:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E4137E24;
        Thu, 25 Aug 2016 18:27:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iX3CYb8wYTHVQNtS0yuLc2bkJBc=; b=i4t/po
        nIQcyIj5BljX2MMhfXlzf0d5oRi3r9EMi0ZfA1GskOWsHiZeciEnVueVMvjxkiD+
        nA70zNUenvjeG2nIGAAjWk8h508BE3scIMMlNInQ707m+5Sy+VeWhYygu2B+S6Do
        cDVKbVE4JNkf5IdtppG9x7sMkMn6eto+ZmARo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E5mfqbWwwVCBvSCxUYpZgo5zOD9rH4dA
        10c9nDJXhW08DrO4SN9ZpZMaNeFiKZcMx8enRH/j7VcVE4x28TRPf2z2AinuVZwd
        74bCC8ygZ7l6Pf5GoXEjnHCqwf2d9k2gI5olGXkCWxk6IVW+q7xmuoD67SH29V9M
        H2Xx7HnLmcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3143D37E23;
        Thu, 25 Aug 2016 18:27:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93F8437E22;
        Thu, 25 Aug 2016 18:27:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-7-larsxschneider@gmail.com>
Date:   Thu, 25 Aug 2016 15:27:16 -0700
In-Reply-To: <20160825110752.31581-7-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:45
        +0200")
Message-ID: <xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15461F1A-6B13-11E6-BD99-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_stream_with_flush_from_fd() and
> packet_write_stream_with_flush_from_buf() write a stream of packets. All
> content packets use the maximal packet size except for the last one.
> After the last content packet a `flush` control packet is written.
> packet_read_till_flush() reads arbitrary sized packets until it detects
> a `flush` packet.

These are awkwardly named and I couldn't guess what the input is (I
can tell one is to read from fd and the other is <mem,len> buffer,
but it is unclear if that is in packetized form or just raw data
stream to be copied to the end from their names) without reading the
implementation.  I _think_ you read a raw stream of data through the
end (either EOF or length limit) and write it out packetized, and
use the flush packet to mark the end of the stream.  In my mind,
that is "writing a packetized stream".  The words "packetizing" and
"stream" imply that the stream could consist of more data than what
would fit in a single packet, which in turn implies that there needs
a way to mark the end of one data item, so with_flush does not
necessarily have to be their names.

The counter-part would be "reading a packetized stream".

> +int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
> +{

Especially this one I am tempted to suggest "copy-to-packetized-stream",
as it reads a stream from one fd and then copies out while packetizing.

> +	int err = 0;
> +	ssize_t bytes_to_write;
> +
> +	while (!err) {
> +		bytes_to_write = xread(fd_in, packet_write_buffer, sizeof(packet_write_buffer) - 4);
> +		if (bytes_to_write < 0)
> +			return COPY_READ_ERROR;
> +		if (bytes_to_write == 0)
> +			break;
> +		if (bytes_to_write > sizeof(packet_write_buffer) - 4)
> +			return COPY_WRITE_ERROR;

... and you seem to agree with me by using COPY here.

> +		err = packet_write_gently(fd_out, packet_write_buffer, bytes_to_write);
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}
> +
> +int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out)
> +{
> +	int err = 0;
> +	size_t bytes_written = 0;
> +	size_t bytes_to_write;
> +
> +	while (!err) {
> +		if ((len - bytes_written) > sizeof(packet_write_buffer) - 4)
> +			bytes_to_write = sizeof(packet_write_buffer) - 4;
> +		else
> +			bytes_to_write = len - bytes_written;
> +		if (bytes_to_write == 0)
> +			break;

The lack of COPY_WRITE_ERROR puzzled me briefly here.  If you are
assuming that your math at the beginning of this loop is correct and
bytes_to_write will never exceed the write-buffer size, I think you
should be able to (and it would be better to) assume that the math
you do to tell xread() up to how many bytes it is allowed to read at
once is also correct, losing the COPY_WRITE_ERROR check in the other
function.  You can choose to play safer and do a check in this
function, too.  Either way, we would want to be consistent.

> +		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
> +		bytes_written += bytes_to_write;
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}

> +ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out)
> +{
> +	int len, ret;
> +	int options = PACKET_READ_GENTLE_ON_EOF;
> +	char linelen[4];
> +
> +	size_t oldlen = sb_out->len;
> +	size_t oldalloc = sb_out->alloc;
> +
> +	for (;;) {
> +		/* Read packet header */
> +		ret = get_packet_data(fd_in, NULL, NULL, linelen, 4, options);
> +		if (ret < 0)
> +			goto done;
> +		len = packet_length(linelen);
> +		if (len < 0)
> +			die("protocol error: bad line length character: %.4s", linelen);
> +		if (!len) {
> +			/* Found a flush packet - Done! */
> +			packet_trace("0000", 4, 0);
> +			break;
> +		}
> +		len -= 4;
> +
> +		/* Read packet content */
> +		strbuf_grow(sb_out, len);
> +		ret = get_packet_data(fd_in, NULL, NULL, sb_out->buf + sb_out->len, len, options);
> +		if (ret < 0)
> +			goto done;
> +		if (ret != len) {
> +			error("protocol error: incomplete read (expected %d, got %d)", len, ret);
> +			goto done;
> +		}
> +
> +		packet_trace(sb_out->buf + sb_out->len, len, 0);

All of the above seems to pretty much duplicate the logic in
packet_read(), except that this user does not need options handling
it has.  Is optimizing that out the reason why you open-coded it
here?

Or is it because you cannot tell if you got a truly empty packet or
you got a flush from outside packet_read(), and you wanted to make
sure that you won't be fooled by a normal packet with 0-length
payload?

If the latter is the reason, it may be a viable alternative to
update packet_read() to take PACKET_READ_IGNORE_EMPTY_PACKET, i.e. a
new bit in its options parameter, so that a normal packet with
0-length payload is simply ignored there (i.e. even without
returning, packet_read() would repeat from the beginning when it got
such a packet).  That way, the above would become 

	strbuf_grow(); /* enough to hold max-packet-len more bytes */
	len = packet_read();
        if (!len)
        	/* we cannot get 0 unless we see flush */
                break;

which may be a lot cleaner?

> +		sb_out->len += len;
> +	}
> +
> +done:
> +	if (ret < 0) {
> +		if (oldalloc == 0)
> +			strbuf_release(sb_out);
> +		else
> +			strbuf_setlen(sb_out, oldlen);
> +		return ret;  /* unexpected EOF */
> +	}
> +	return sb_out->len - oldlen;
> +}
> diff --git a/pkt-line.h b/pkt-line.h
> index 3fa0899..9616117 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,6 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  int packet_flush_gently(int fd);
>  int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out);
> +int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out);
>  
>  /*
>   * Read a packetized line into the buffer, which must be at least size bytes
> @@ -77,6 +79,11 @@ char *packet_read_line(int fd, int *size);
>   */
>  char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>  
> +/*
> + * Reads a stream of variable sized packets until a flush packet is detected.
> + */
> +ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out);
> +
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
>  extern char packet_buffer[LARGE_PACKET_MAX];
