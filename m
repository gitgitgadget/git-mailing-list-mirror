Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D0C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbhK3UzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:55:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242493AbhK3UzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 15:55:22 -0500
Received: (qmail 13952 invoked by uid 109); 30 Nov 2021 20:52:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 20:52:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30136 invoked by uid 111); 30 Nov 2021 20:52:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 15:52:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 15:52:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Message-ID: <YaaO8dxOwi7YKbmZ@coredump.intra.peff.net>
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <xmqqtufu2pll.fsf@gitster.g>
 <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
 <YaXRd2YBQR+ifNTE@coredump.intra.peff.net>
 <211130.86sfvdd6eo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211130.86sfvdd6eo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 04:10:37PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Nov 30 2021, Jeff King wrote:
> 
> > On Tue, Nov 30, 2021 at 02:14:25AM -0500, Jeff King wrote:
> >
> >>   - flushing causes us to block. This implies our stdout is connected to
> >>     a pipe or socket, and the other side is not expecting to read. A
> >>     plausible case here is a client sending us a big input which we find
> >>     to be bogus (maybe index-pack checking an incoming pack). We call
> >>     die() to complain about the input, but the client is still writing.
> >>     In the current code, we'd write out our error and then exit; the
> >>     client would get SIGPIPE or a write() error and abort. But with a
> >>     flush here, we could block writing back to the client, and now we're
> >>     in a deadlock; they are trying to write to us but we are no longer
> >>     reading, and we are blocked trying to get out a little bit of
> >>     irrelevant stdout data.
> >> 
> >>     I _think_ we're probably OK here. The scenario above means that the
> >>     caller is already doing asynchronous I/O via stdio and is subject to
> >>     deadlock. Because the segment of buffer we try to flush here _could_
> >>     have been flushed already under the hood, which would have caused
> >>     the same blocking. A careful caller might be using select() or
> >>     similar to decide when it is OK to write, but I find it highly
> >>     unlikely they'd be using stdio in that case.
> >> 
> >> Of the two, the deadlock case worries me more, just because it would be
> >> quiet subtle and racy. As I said, I think we may be OK, but my reasoning
> >> there is pretty hand-wavy.
> >
> > Thinking on this a bit more: I guess as soon as we exit libc would call
> > the equivalent of fflush(NULL) anyway, and try that same flush. So in a
> > sense this is just ordering a bit differently, and not introducing any
> > new problems. (Unless libc is clever enough to avoid blocking, but that
> > doesn't seem like something we could or should rely on in general).
> 
> I think this change is probably OK too, but let's not forget about
> warning() and error(). I.e. we are not always on a path to a fatal error
> with vreportf(), that's just with die(), usage() and BUG().

My gut feeling is that warning() and error() would encounter a subset of
the problems that die() would. Because die() is actually changing the
program state in a much more drastic way (by exiting), whereas error and
warning would continue and eventually flush anyway. They might care more
about things like errno being touched if they continue on, but they
already must assume that vreportf() can affect errno (because of the
existing flush and write on stderr).

Likewise BUG() is an interesting one. It doesn't call exit(), but
instead abort(). So unlike die(), it doesn't actually flush, and the "we
would fflush(NULL) on exit anyway" caveat above does not apply.

I still suspect that any caller doing async I/O on stdio like this is
already flaky, though. It could have decided to flush and blocked during
any write.

-Peff
