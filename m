Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A4C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9E72071A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFOV7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:59:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgFOV7j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:59:39 -0400
Received: (qmail 16209 invoked by uid 109); 15 Jun 2020 21:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jun 2020 21:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7168 invoked by uid 111); 15 Jun 2020 21:59:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jun 2020 17:59:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Jun 2020 17:59:37 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Possible Bug] Use of write on size-limited platforms
Message-ID: <20200615215937.GA636737@coredump.intra.peff.net>
References: <015c01d63ddd$97d65080$c782f180$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <015c01d63ddd$97d65080$c782f180$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 05:41:34PM -0400, Randall S. Becker wrote:

> I just wanted to check the following calls to make sure that it does not
> fwrite or write should be xread/xwrite or are guaranteed not to exceed
> MAX_IO_SIZE:
> 
> strbuf.c: strbuf_write, strbuf_write_fd, the size is not specified.
> 
> The other uses of read/write appear to be safe.

strbuf_write() is using fwrite(), and we don't enforce MAX_IO_SIZE with
stdio anywhere else. And I'd expect in general that if there are any
platform limitations, the system libc would choose a sane value anyway.
So that one is probably fine.

I think strbuf_write_fd() is wrong to use a raw write(), but for several
reasons:

 - it won't enforce MAX_IO_SIZE, as you note

 - it won't handle EINTR, etc; callers need to be prepared to restart
   such a write

 - it won't handle a partial write by looping until all output is sent

For the latter two, there are cases where some callers want the
flexibility to stop when seeing a signal or a partial write. But I don't
think that makes any sense for strbuf_write_fd(). If I pass in a strbuf
with 8kb of data and I get a return value that indicates we only wrote
4kb, what do I do next? I certainly can't call strbuf_write_fd() again,
since it would write from the beginning of the strbuf again. I'd have to
call xwrite() myself after that. At which point I may as well have done
so for the first call. :)

So I think this really ought to be using write_in_full(). There's only
one caller, and I think it would be improved by the switch. Do you want
to write a patch?

You could make an argument that the fwrite() version ought to also loop,
since it's possible to get a partial write there, too. But we don't do
that in general. I suspect in practice most stdio implementations will
keep writing until they see an error, and most callers don't bother
checking stdio errors at all, or use ferror().

-Peff
