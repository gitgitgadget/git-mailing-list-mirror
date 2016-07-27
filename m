Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67B8203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 01:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777AbcG0BdV (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 21:33:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758830AbcG0Bc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 21:32:56 -0400
Received: (qmail 23767 invoked by uid 102); 27 Jul 2016 01:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 21:32:55 -0400
Received: (qmail 13792 invoked by uid 107); 27 Jul 2016 01:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 21:33:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 21:32:51 -0400
Date:	Tue, 26 Jul 2016 21:32:51 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160727013251.GA12159@sigill.intra.peff.net>
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

On Wed, Jul 27, 2016 at 02:06:05AM +0200, larsxschneider@gmail.com wrote:

> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
> +{
> +	off_t bytes_read;
> +	off_t total_bytes_read = 0;

I haven't looked carefully at the whole patch yet, but there seems to be
some type issues here. off_t is a good type for storing the whole size
of a file (which may be larger than the amount of memory we can
allocate). But size_t is the right size for an in-memory object.

This function takes a size_t size, which makes sense if it is meant to
read everything into a strbuf.

So I think our total_bytes_read would probably want to be a size_t here,
too, because it cannot possibly grow larger than that (and that is
enforced by the loop below). Otherwise you get weirdness like "sb->buf +
total_bytes_ref" possibly overflowing memory.

> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush

What happens if size is the maximum for size_t here (i.e., 4GB-1 on a
32-bit system)?

> +	do {
> +		bytes_read = packet_read(
> +			fd, NULL, NULL,
> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
> +			PACKET_READ_GENTLE_ON_EOF
> +		);

packet_read() actually returns an int, and may return "-1" on EOF (and
int is fine because we know that we are constrained to 16-bit values
by the pkt-line definition). You read it into an "off_t". I _think_ that
is OK, because I believe POSIX says off_t must be signed. But probably
"int" is the more correct type here.

> +		total_bytes_read += bytes_read;

If you do get "-1", I think you need to detect it here before adjusting
total_bytes_read.

> +	while (
> +		bytes_read > 0 && 					// the last packet was no flush
> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
> +	);

And I'm not sure if you need to distinguish between "0" and "-1" when
checking byte_read here.

> +	strbuf_setlen(sb, total_bytes_read);

Passing an off_t to something expecting a size_t, which can involve
truncation (though I think in practice you really are limited to
size_t).

> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)
> +{
> +	int ret = 1;
> +	char header[4];
> +	char buffer[8192];
> +	off_t bytes_to_write;
> +	while (ret) {
> +		if (in >= 0) {
> +			bytes_to_write = xread(in, buffer, sizeof(buffer));

Likewise here, xread() is returning ssize_t. Again, OK if we can assume
off_t is signed, but it probably makes sense to use the correct type (we
also know it cannot be larger than 8K, of course).

Why 8K? The pkt-line format naturally restricts us to just under 64K, so
why not take advantage of that and minimize the framing overhead for
large data?

> +			if (bytes_to_write < 0)
> +				ret &= 0;

I think "&= 0" is unusual for our codebase? Would just writing "= 0" be
more clear?

We do sometimes do "ret |= something()" but that is in cases where
"ret" is zero for success, and non-zero (usually -1) otherwise. Perhaps
your function's error-reporting is inverted from our usual style?

> +		set_packet_header(header, bytes_to_write + 4);
> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
> +	}

If you look at format_packet(), it pulls a slight trick: we have a
buffer 4 bytes larger than we need, format into "buf + 4", and then
write the final size at the beginning. That lets us write() it all in
one go.

At first I thought this function was simply reinventing packet_write(),
but I guess you are trying to avoid the extra copy of the data (once
into the buffer from xread, and then again via format_packet just to add
the extra bytes at the beginning).

I agree with what Junio said elsewhere, that there may be a way to make
the pkt-line code handle this zero-copy situation better. Perhaps
something like:

  struct pktline {
	/* first 4 bytes are reserved for length header */
	char buf[LARGE_PACKET_MAX];
  };
  #define PKTLINE_DATA_START(pkt) ((pkt)->buf + 4)
  #define PKTLINE_DATA_LEN (LARGE_PACKET_MAX - 4)

  ...
  struct pktline pkt;
  ssize_t len = xread(fd, PKTLINE_DATA_START(&pkt), PKTLINE_DATA_LEN);
  packet_send(&pkt, len);

Then packet_send() knows that the first 4 bytes are reserved for it. I
suspect that the strbuf used by format_packet() could get away with
using such a "struct pktline" too, though in practice I doubt there's
any real efficiency to be gained (we generally reuse the same strbuf
over and over, so it will grow once to 64K and get reused).

> +	ret &= write_in_full(out, "0000", 4) == 4;

packet_flush() ?

I know the packet functions are keen on write_or_die() versus
write_in_full().  That is perhaps something that should be fixed.

This was just supposed to be a short note about off_t before eating
dinner (oops), so I didn't read past here.

-Peff
