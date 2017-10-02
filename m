Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F22202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdJBFsE (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:48:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750760AbdJBFsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:48:03 -0400
Received: (qmail 7464 invoked by uid 109); 2 Oct 2017 05:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25876 invoked by uid 111); 2 Oct 2017 05:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:48:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:48:01 -0400
Date:   Mon, 2 Oct 2017 01:48:01 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 06/11] apply: move lockfile into `apply_state`
Message-ID: <20171002054801.ak4dxg2d7mrnqo66@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <e8b32d47ccc6c3fe3aadd70fdc280fad13f46fd8.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8b32d47ccc6c3fe3aadd70fdc280fad13f46fd8.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:07PM +0200, Martin Ågren wrote:

> We have two users of `struct apply_state` and the related functionality
> in apply.c. Each user sets up its `apply_state` by handing over a
> pointer to its static `lock_file`. (Before 076aa2cbd (tempfile:
> auto-allocate tempfiles on heap, 2017-09-05), we could never free
> lockfiles, so making them static was a reasonable approach.)
> 
> Other than that, they never directly access their `lock_file`s, which
> are instead handled by the functionality in apply.c.
> 
> To make life easier for the caller and to make it less tempting for a
> future caller to mess with the lock, make apply.c fully responsible for
> setting up the `lock_file`. As mentioned above, it is now safe to free a
> `lock_file`, so we can make the `struct apply_state` contain an actual
> `struct lock_file` instead of a pointer to one.
> 
> The user in builtin/apply.c is rather simple. For builtin/am.c, we might
> worry that the lock state is actually meant to be inherited across
> calls. But the lock is only taken as `apply_all_patches()` executes, and
> code inspection shows that it will always be released.
> 
> Alternatively, we can observe that the lock itself is never queried
> directly. When we decide whether we should lock, we check a related
> variable `newfd`. That variable is not inherited, so from the point of
> view of apply.c, the state machine really is reset with each call to
> `init_apply_state()`. (It would be a bug if `newfd` and the lock status
> were not in sync. The duplication of information in `newfd` and the lock
> will be addressed in the next patch.)

Nicely explained. I didn't re-verify your inspection of
apply_all_patches(), but I think it would be fine regardless. We don't
init_apply_state() again, so both before and after your patch we are
always looking at the "same" lock struct (and so if somebody forgot to
unlock, in either case we'd hit the "this tempfile is already active"
assertion).

-Peff
