Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F0A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbcHCVTH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:19:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:54215 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758351AbcHCVTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:19:05 -0400
Received: (qmail 17991 invoked by uid 102); 3 Aug 2016 21:12:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:12:25 -0400
Received: (qmail 5946 invoked by uid 107); 3 Aug 2016 21:12:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:12:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 17:12:22 -0400
Date:	Wed, 3 Aug 2016 17:12:22 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
Message-ID: <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-2-larsxschneider@gmail.com>
 <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 01:18:55PM -0700, Junio C Hamano wrote:

> larsxschneider@gmail.com writes:
> 
> > From: Lars Schneider <larsxschneider@gmail.com>
> >
> > set_packet_header() converts an integer to a 4 byte hex string. Make
> > this function locally available so that other pkt-line functions can
> > use it.
> 
> Didn't I say that this is a bad idea already in an earlier review?
> 
> The only reason why you want it, together with direct_packet_write()
> (which I think is another bad idea), is because you use
> packet_buf_write() to create a "<header><payload>" in a buf in the
> usercode in step 11/12 like this:
> 
> +	packet_buf_write(&nbuf, "command=%s\n", filter_type);
> +	ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
> 
> which would be totally unnecessary if you just did strbuf_addf()
> into nbuf and used packet_write() like everybody else does.
> 
> Puzzled.  Why are steps 01/12 and 02/12 an improvement?

I think it is an attempt to avoid the extra memcpy() of the bytes into
another packet buffer.

I notice that the solution does still end up a using a double-write() in
some cases, though.  I was curious if this made any difference, though,
so I wrote a short test program:

-- >8 --
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv)
{
        int type;

        if (argv[1] && !strcmp(argv[1], "prepend"))
                type = 0; /* size prepended to buffer */
        else if (argv[1] && !strcmp(argv[1], "write"))
                type = 1;
        else if (argv[1] && !strcmp(argv[1], "memcpy"))
                type = 2;
        else
                return 1;

        while (1) {
                char buf[65520];
                int r = read(0, buf + 4, sizeof(buf));
                if (r <= 0)
                        break;
                if (!type) {
                        memcpy(buf, "1234", 4);
                        write(1, buf, r + 4);
                } else if (type == 1) {
                        write(1, "1234", 4);
                        write(1, buf + 4, r);
                } else if (type == 2) {
                        char packet[sizeof(buf) + 4];
                        memcpy(packet, "1234", 4);
                        memcpy(packet + 4, buf + 4, r);
                        write(1, packet, r + 4);
                }
        }
        return 0;
}
-- >8 --

We'd expect "prepend" to be the fastest, as it does a single write and
zero-copy. And then it is a question of whether the double-write is
worse than the extra memcpy.

On Linux, feeding 100MB of zeroes into stdin, I got (best-of-five):

  - prepend: 11ms
  - write: 11ms
  - memcpy: 15ms

So it _does_ make a difference to avoid the memcpy, though 4ms per 100MB
does not seem like it is probably worth caring about. The double-write
also gets worse if you use a smaller buffer size (e.g., if you drop to
4K, that adds back in about 4ms of overhead because you're calling
write() a lot more times).

The cost of write() may vary on other platforms, but the cost of memcpy
generally shouldn't. So I'm inclined to say that it is not really worth
micro-optimizing the interface.

I think the other issue is that format_packet() only lets you send
string data via "%s", so it cannot be used for arbitrary data that may
contain NULs. So we do need _some_ other interface to let you send a raw
data packet, and it's going to look similar to the direct_packet_write()
thing.

The alternative is to hand-code it, which is what send_sideband() does
(it uses xsnprintf("%04x") to do the hex formatting, though).

-Peff
