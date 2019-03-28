Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A74C20248
	for <e@80x24.org>; Thu, 28 Mar 2019 02:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1CC3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 22:02:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:38486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726143AbfC1CC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 22:02:29 -0400
Received: (qmail 13258 invoked by uid 109); 28 Mar 2019 02:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 02:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2132 invoked by uid 111); 28 Mar 2019 02:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 22:02:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 22:02:27 -0400
Date:   Wed, 27 Mar 2019 22:02:27 -0400
From:   Jeff King <peff@peff.net>
To:     Farhan Khan <farhan@farhan.codes>
Cc:     git@vger.kernel.org
Subject: Re: Calculating pack file SHA value
Message-ID: <20190328020227.GB7887@sigill.intra.peff.net>
References: <a48b86698802006045ed0af060b4e822@farhan.codes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a48b86698802006045ed0af060b4e822@farhan.codes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 09:06:20PM -0400, Farhan Khan wrote:

> I am trying to figure out how to calculate the SHA value of a pack file when you
> run `git index-pack file.pack`. I am close, but having a bit of trouble at the
> end. Here's my understanding so far.

It's all but the last 20 bytes. You should be able to reproduce it with:

  # the computed sha1
  size=$(stat --format=%s $pack)
  head -c $((size-20)) $pack | sha1sum

  # the sha1 stored in the file, which should match
  tail -c 20 $pack | xxd

> Git buffers data to be processed and when its exhausted, updates the SHA
> checksum with the previously read data. This is from builtin/index-pack.c,
> specifically fill() which calls flush() to update the SHA value. My question is,
> how does git determine how many bytes at a time to process?
> 
> The size of the buffer is the file-scope variable input_len. This size seems to
> be 4096 several times until the very end where it reduces to less-than 4096
> (obviously this depends on the pack file, but in my case its 1074 bytes).
> Ordinarily I would think its a result of the read() call not receiving the full
> 4096 bytes, but there still are left over bytes in the file but my manual
> verification shows there are still remaining bytes in the file which are not run
> through the SHA checksum.

On the fill() side, we may over-read bytes into our buffer. But it's on
the use() side that we actually decide bytes have been used. Note that
it increments input_offset, and then flush() only hashes bytes up to
that offset.

So index-pack is not just blindly hashing N-20 bytes. It's actually
parsing the packfile as it goes, and putting any data it has parsed
correctly into the hash. At the end, we _should_ be left with exactly 20
bytes, and they should match exactly the hash we've computed up to that
point. And in --verify mode (and maybe even other modes) it should be
confirming that.

> How does git calculate a pack file's SHA verification? How does it know what
> size (number of bytes) to read when running flush() to update the buffer?
> (typically 4096). How does it know when in the file to stop updating the SHA1
> value?

The key observation is that flush() isn't actually reading into the
buffer. It's throwing away bytes that have already been marked as used
by use() and shifting the rest to the front of the buffer. And then
fill() is free to read more data into the rest of it.

-Peff
