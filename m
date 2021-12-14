Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48390C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhLNPMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:12:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:51646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhLNPMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 10:12:54 -0500
Received: (qmail 14122 invoked by uid 109); 14 Dec 2021 15:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 15:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25394 invoked by uid 111); 14 Dec 2021 15:12:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 10:12:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 10:12:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Make upload-pack pack write size configurable
Message-ID: <Ybi0dSddal2DKmXQ@coredump.intra.peff.net>
References: <20211213132345.26310-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213132345.26310-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 02:23:44PM +0100, Jacob Vosmaer wrote:

> When transfering packfile data, upload-pack.c uses an 8KB buffer.
> This is a reasonable size but when you transfer a lot of packfile
> data, like we do on GitLab.com, we find it is beneficial to use a
> larger buffer size.
> 
> Below you will find a commit where we make the size of this 8KB
> buffer configurable at compile time. It appears pack-objects always
> does 8KB writes so I don't think we should change the default. But
> for GitLab, where we have a cache for the output of pack-objects,
> it is beneficial to use a larger IO size because the cache does
> 64KB writes.

I suspect the big reason that it matters for the cache is that for
pack-objects, we're typically CPU bound computing the sha1 of the
outgoing pack (for its trailer).

I do suspect we could just always move to something closer to
LARGE_PACKET_DATA_MAX (probably minus 1 for the sideband marker). Even
if pack-objects only writes in 8k chunks, we may be able to pull several
in one read(), especially if the network is a bottleneck (because we'd
block writing to the client, and pack-objects would fill up the pipe
buffer).

I.e., it doesn't seem like there's any real downside to doing so.

> I have also considered converting the packfile copying code to use
> stdio when writing to stdout, but that would be a bigger change
> because we have to be careful not to interleave stdio and stdlib
> writes. And we would have to make the stdout output buffer size
> configurable, because the default stdio buffer size is 4KB which
> is no better than the status quo. A final argument against the stdio
> approach is that it only reduces the number of writes from upload-pack,
> while a larger buffer size reduces both the number of reads and
> writes.

Yeah, I don't think that would help all that much. We really want to
size this based on pkt-line limits. That reduces syscalls, but also
shrinks the overall size a little (since larger packets minimizes the
framing overhead of the pkt-line headers).

-Peff
