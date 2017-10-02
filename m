Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E2F202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdJBFel (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:34:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750752AbdJBFek (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:34:40 -0400
Received: (qmail 6851 invoked by uid 109); 2 Oct 2017 05:34:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:34:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25758 invoked by uid 111); 2 Oct 2017 05:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:35:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:34:38 -0400
Date:   Mon, 2 Oct 2017 01:34:38 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/11] treewide: prefer lockfiles on the stack
Message-ID: <20171002053438.kpi3bhycqkgkg2o5@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <f241038eeed0f5f8bb346b394495356c20884a39.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f241038eeed0f5f8bb346b394495356c20884a39.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:03PM +0200, Martin Ågren wrote:

> There is no longer any need to allocate and leak a `struct lock_file`.
> The previous patch addressed an instance where we needed a minor tweak
> alongside the trivial changes.
> 
> Deal with the remaining instances where we allocate and leak a struct
> within a single function. Change them to have the `struct lock_file` on
> the stack instead.
> 
> These instances were identified by running `git grep "^\s*struct
> lock_file\s*\*"`.

Thanks. These all look pretty straightforward, and as a general rule
this _should_ be a safe conversion with respect to dangling references,
since:

  - the tempfile pointers copied onto the global cleanup list are always
    allocated, so there's no danger of our stack variables going out of
    scope and leaving cruft in the global list.

  - when the lock is committed or rolled back, we NULL the pointer after
    freeing the tempfile. Nobody should be looking at the lock after
    that, but if there is such a bug, we should reliably hit an assert
    (if they use the accessors which check for validity) or a segfault
    (if somebody tries to dereference it directly).

    So it's possible that this subtly introduces a new segfault or
    assertion failure, but in that case it would be finding an
    _existing_ bug which was previously just reading cruft from the
    inactive tempfile struct.

-Peff
