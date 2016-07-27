Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28562203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 09:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcG0JlF (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 05:41:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60676 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbcG0JlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 05:41:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BCA6203E2;
	Wed, 27 Jul 2016 09:41:03 +0000 (UTC)
Date:	Wed, 27 Jul 2016 09:41:02 +0000
From:	Eric Wong <e@80x24.org>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160727094102.GA31374@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727000605.49982-6-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com wrote:
> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)

I'm no expert in C, but this might be const-correctness taken
too far.  I think basing this on the read(2) prototype is less
surprising:

   static ssize_t multi_packet_read(int fd, struct strbuf *sb, size_t size)

Also what Jeff said about off_t vs size_t, but my previous
emails may have confused you w.r.t. off_t usage...

> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)

Same comment about over const ints above.
len can probably be off_t based on what is below; but you need
to process the loop in ssize_t-friendly chunks.

> +{
> +	int ret = 1;
> +	char header[4];
> +	char buffer[8192];
> +	off_t bytes_to_write;

What Jeff said, this should be ssize_t to match read(2) and xread

> +	while (ret) {
> +		if (in >= 0) {
> +			bytes_to_write = xread(in, buffer, sizeof(buffer));
> +			if (bytes_to_write < 0)
> +				ret &= 0;
> +			src = buffer;
> +		} else {
> +			bytes_to_write = len > LARGE_PACKET_MAX - 4 ? LARGE_PACKET_MAX - 4 : len;
> +			len -= bytes_to_write;
> +		}
> +		if (!bytes_to_write)
> +			break;

The whole ret &= .. style error handling is hard-to-follow and
here, a source of bugs.  I think the expected convention on
hitting errors is:

	1) stop whatever you're doing
	2) cleanup
	3) propagate the error to callers

"goto" is an acceptable way of accomplishing this.

For example, byte_to_write may still be negative at this point
(and interpreted as a really big number when cast to unsigned
size_t) and src/buffer could be stack garbage.

> +		set_packet_header(header, bytes_to_write + 4);
> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
> +	}
> +	ret &= write_in_full(out, "0000", 4) == 4;
> +	return ret;
> +}
> +

> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> +						int fd, struct strbuf *dst, const char *cmd,
> +						const char *filter_type)
> +{

<snip>

> +	if (fd >= 0 && !src) {
> +		ret &= fstat(fd, &file_stat) != -1;
> +		len = file_stat.st_size;

Same truncation bug I noticed earlier; what I originally meant
is the `len' arg probably ought to be off_t, here, not size_t.
32-bit x86 Linux systems have 32-bit size_t (unsigned), but
large file support means off_t is 64-bits (signed).

Also, is it worth continuing this function if fstat fails?

> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	packet_write(process->in, "%s\n", filter_type);
> +	packet_write(process->in, "%s\n", path);
> +	packet_write(process->in, "%zu\n", len);

I'm not sure if "%zu" is portable since we don't do C99 (yet?)
For 64-bit signed off_t, you can probably do:

	packet_write(process->in, "%"PRIuMAX"\n", (uintmax_t)len);

Since we don't have PRIiMAX or intmax_t, here, and a negative
len would be a bug (probably from failed fstat) anyways.

> +	ret &= multi_packet_write(src, len, fd, process->in);

multi_packet_write will probably fail if fstat failed above...

> +	strbuf = packet_read_line(process->out, NULL);

And this may just block or timeout if multi_packet_write failed.


Naptime, I may look at the rest another day.
