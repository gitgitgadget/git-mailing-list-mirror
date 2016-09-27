Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FAD1F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 08:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbcI0IIF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 04:08:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48651 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbcI0IH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 04:07:58 -0400
Received: (qmail 27258 invoked by uid 109); 27 Sep 2016 08:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 08:07:57 +0000
Received: (qmail 13720 invoked by uid 111); 27 Sep 2016 08:08:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 04:08:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 04:07:55 -0400
Date:   Tue, 27 Sep 2016 04:07:55 -0400
From:   Jeff King <peff@peff.net>
To:     Gustavo Grieco <gustavo.grieco@imag.fr>
Cc:     git@vger.kernel.org
Subject: Re: Possible integer overflow parsing malformed objects in git 2.10.0
Message-ID: <20160927080755.evlq3sfkyoolixop@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <381383122.8376940.1474943423005.JavaMail.zimbra@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <381383122.8376940.1474943423005.JavaMail.zimbra@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 04:30:23AM +0200, Gustavo Grieco wrote:

> We found a malformed object file that triggers an allocation with a
> negative size when parsed in git 2.10.0. It can be caused by an
> integer overflow somewhere, so it is better to verify how the code got
> such value.

Are you sure this is triggering a negative integer?

The zlib-inflated contents for the object in your example look like:

  (gdb) print hdr
  $2 = "tree 18446744073709551460\000..."

IOW, this really _is_ a gigantic number, but still within 2^64. So when
we feed it to malloc, that really is correct. And we'd expect malloc to
return NULL, at which point we'll call die, which should look like this
(which I get when running without ASAN):

  $ git fsck
  fatal: Out of memory, malloc failed (tried to allocate 18446744073709551461 bytes)

You'll note that's 1 more than the value in the object; that addition
happens via xmallocz() and _is_ checked for integer overflow.

> The ASAN report is here:
> 
> ==24709==WARNING: AddressSanitizer failed to allocate 0xffffffffffffff65 bytes
> ==24709==AddressSanitizer's allocator is terminating the process instead of returning 0
> ==24709==If you don't like this behavior set allocator_may_return_null=1

I don't think this is an overflow at all. This is just ASAN having
really conservative debugging defaults. A real malloc would return NULL,
and git would notice and abort.

If you follow its suggestion, you get:

  $ ASAN_OPTIONS=allocator_may_return_null=1 git fsck
  ==19380==WARNING: AddressSanitizer failed to allocate 0xffffffffffffff65 bytes
  ==19380==WARNING: AddressSanitizer failed to allocate 0xffffffffffffff65 bytes
  fatal: Out of memory, malloc failed (tried to allocate 18446744073709551461 bytes)

as expected.  So I don't think there is any bug at all in the example
you gave, only a silly-sized object that we cannot handle.

That being said, the parse_sha1_header() function clearly does not
detect overflow at all when parsing the size. So on a 32-bit system, you
end up with:

  $ git fsck
  fatal: Out of memory, malloc failed (tried to allocate 4294967141 bytes)

which is not correct, but I'm not sure it's a security problem.  Integer
overflows are an issue if they cause us to under-allocate, and then to
write more bytes than we allocated. In this case, I would expect
unpack_sha1_rest() to never write more bytes than the "size" we parsed
and allocated (and to complain if the number of bytes we get from the
zlib sequence do not exactly match the claimed size).

So a more interesting example is more like "ULONG_MAX + 5", where we
would overflow to 5 bytes. And we'd hope that unpack_sha1_rest does not
ever write more than 5 bytes. From my reading and a few tests with gdb,
it does not. However, it also does not notice that there were more bytes
that we didn't use.

So I think there's room for improved diagnosis of bogus situations
(including integer overflows), but I don't see any actual security bugs.

-Peff
