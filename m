Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6DA202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 06:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdJBGAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:00:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750806AbdJBGAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:00:21 -0400
Received: (qmail 7993 invoked by uid 109); 2 Oct 2017 06:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:00:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26057 invoked by uid 111); 2 Oct 2017 06:01:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:01:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:00:19 -0400
Date:   Mon, 2 Oct 2017 02:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/11] read-cache: require flags for
 `write_locked_index()`
Message-ID: <20171002060018.m5dvxt2qtgkeixc7@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:10PM +0200, Martin Ågren wrote:

> `write_locked_index()` takes two flags: `COMMIT_LOCK` and `CLOSE_LOCK`.
> At most one is allowed. But it is also possible to use no flag, i.e.,
> `0`. But when `write_locked_index()` calls `do_write_index()`, the
> temporary file, a.k.a. the lockfile, will be closed. So passing `0` is
> effectively the same as `CLOSE_LOCK`, which seems like a bug.
> 
> We might feel tempted to restructure the code in order to close the file
> later, or conditionally. It also feels a bit unfortunate that we simply
> "happen" to close the lock by way of an implementation detail of
> lockfiles. But note that we need to close the temporary file before
> `stat`-ing it, at least on Windows. See 9f41c7a6b (read-cache: close
> index.lock in do_write_index, 2017-04-26).

Interesting. So it seems like this is potentially a bug introduced by
9f41c7a6b, as before then passing "0" for the flags would neither commit
nor close the lockfile.

At the same time, I cannot imagine why one would want that behavior. The
only use would be if you planned to append more to the index. Which
seems kind of odd to do outside of write_locked_index() itself. And
certainly there aren't any callers in the existing codebase who pass 0.
Your assert() should help catch any that are added.

-Peff
