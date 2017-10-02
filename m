Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB60202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 06:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbdJBGPd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:15:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBGPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:15:32 -0400
Received: (qmail 8625 invoked by uid 109); 2 Oct 2017 06:15:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:15:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26085 invoked by uid 111); 2 Oct 2017 06:16:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:16:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:15:30 -0400
Date:   Mon, 2 Oct 2017 02:15:30 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/11] read-cache: don't leave dangling pointer in
 `do_write_index()`
Message-ID: <20171002061529.xaiqccwjrthc74gf@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <6d36f0a8e3c7b81e8c815782fb67fc69f86f2837.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d36f0a8e3c7b81e8c815782fb67fc69f86f2837.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:11PM +0200, Martin Ågren wrote:

> If `do_write_index(..., struct tempfile *, ...)` fails to close the
> temporary file, it deletes it. This resets the pointer to NULL, but only
> the pointer which is local to `do_write_index()`, not the pointer that
> the caller holds. If the caller ever dereferences its pointer, we have
> undefined behavior (most likely a crash). One of the two callers tries
> to delete the temporary file on error, so it will dereference it.

Hrm. I think this was introduced by my lockfile series, since before
that the memory would have remained valid (but with its "active" flag
unset, which is enough for delete_tempfile() to happily return early).

Part of my reason for switching delete_tempfile() to take a
pointer-to-pointer was so that we had to investigate each such call. But
obviously I failed to analyze this case correctly. :(

> We could change the function to take a `struct tempfile **` instead. But
> we have another problem here. The other caller, `write_locked_index()`,
> passes in `lock->tempfile`. So if we close the temporary file and reset
> `lock->tempfile` to NULL, we have effectively rolled back the lock. That
> caller is `write_locked_index()` and if it is used with the
> `CLOSE_LOCK`-file, it means the lock is being rolled back against the
> wishes of the caller. (`write_locked_index()` used to call
> `close_lockfile()`, which would have rolled back on error. Commit
> 83a3069a3 (lockfile: do not rollback lock on failed close, 2017-09-05)
> changed to not rolling back.)

I'm not sure I follow here. It seems like write_locked_index() has three
outcomes:

  - if there was an error, the lock is rolled back

  - if we were successful and the caller asked for CLOSE_LOCK, we remain
    locked

  - if we were successful and the caller asked for COMMIT_LOCK, we
    commit the lock

It sounds like you are considering the first outcome a bug, but I think
it is intentional. Without that, every caller of write_locked_index()
would need to release the lock themselves. That's especially cumbersome
if they called with COMMIT_LOCK, as they otherwise can assume that
write_locked_index() has released the lock one way or another.

So I actually think that just switching to a "struct tempfile **" here
is a reasonable solution (I'd also be fine with doing this and then
having do_write_locked_index() rollback the lock itself on error).

Or am I missing something?

-Peff
