Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE0C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhK3HRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:17:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:39966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233216AbhK3HRw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:17:52 -0500
Received: (qmail 11851 invoked by uid 109); 30 Nov 2021 07:14:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 07:14:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12327 invoked by uid 111); 30 Nov 2021 07:14:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 02:14:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 02:14:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Message-ID: <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <xmqqtufu2pll.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtufu2pll.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 09:13:10PM -0800, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > This is RFC because I naturally worry about potential fallout from
> > making a change to such a core function. I can't think of any case that
> > it wouldn't be advantageous to flush stdout before stderr, so this
> > change _seems_ safe, however, it may be that I'm just not imaginative
> > enough, hence my hesitancy.
> 
> If stdout and stderr are both going to the same place (e.g. the
> user's terminal), this would probably is an improvement, but if the
> standard output is going to a pipe talking to another process, which
> may care when the output is flushed, this may hurt.
> 
> But as long as the calling code is using stdio, it cannot precisely
> control when the buffered contents are flushed anyway, so as long as
> the caller has working standard output, this may be OK.

Yeah, I think this logic applies to the "happy" case. Any caller which
is depending on the time of flush is already racily buggy.

What I wonder about is the error case. What can happen if flushing
fails? There are two interesting cases I can think of:

  - flushing causes an error (which is quite likely, as we may
    vreportf() because of an error on stdout). We should be OK, as we do
    not care about the return value here, nor eventually checking
    ferror(stdout). We may overwrite errno, but at this point in
    vreportf(), we are committed to whatever error we're going to show
    (and obviously the stderr flush below could cause the same issues).

  - flushing causes us to block. This implies our stdout is connected to
    a pipe or socket, and the other side is not expecting to read. A
    plausible case here is a client sending us a big input which we find
    to be bogus (maybe index-pack checking an incoming pack). We call
    die() to complain about the input, but the client is still writing.
    In the current code, we'd write out our error and then exit; the
    client would get SIGPIPE or a write() error and abort. But with a
    flush here, we could block writing back to the client, and now we're
    in a deadlock; they are trying to write to us but we are no longer
    reading, and we are blocked trying to get out a little bit of
    irrelevant stdout data.

    I _think_ we're probably OK here. The scenario above means that the
    caller is already doing asynchronous I/O via stdio and is subject to
    deadlock. Because the segment of buffer we try to flush here _could_
    have been flushed already under the hood, which would have caused
    the same blocking. A careful caller might be using select() or
    similar to decide when it is OK to write, but I find it highly
    unlikely they'd be using stdio in that case.

Of the two, the deadlock case worries me more, just because it would be
quiet subtle and racy. As I said, I think we may be OK, but my reasoning
there is pretty hand-wavy.

-Peff
