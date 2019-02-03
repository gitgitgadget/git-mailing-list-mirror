Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287981F453
	for <e@80x24.org>; Sun,  3 Feb 2019 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfBCXB6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 18:01:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:59602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726554AbfBCXB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 18:01:58 -0500
Received: (qmail 2527 invoked by uid 109); 3 Feb 2019 23:01:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Feb 2019 23:01:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16098 invoked by uid 111); 3 Feb 2019 23:02:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Feb 2019 18:02:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2019 00:01:53 +0100
Date:   Mon, 4 Feb 2019 00:01:53 +0100
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] doc-diff: don't `cd_to_toplevel` before calling
 `usage`
Message-ID: <20190203230152.GA25608@sigill.intra.peff.net>
References: <CAPig+cT32oi5HLe7tokghrCmaiECwAXxON8U7DrpMYb3GCSNyQ@mail.gmail.com>
 <20190203110817.17242-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190203110817.17242-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 03, 2019 at 12:08:17PM +0100, Martin Ågren wrote:

> `usage` tries to call $0, which might very well be "./doc-diff", so if
> we `cd_to_toplevel` before calling `usage`, we'll end with an error to
> the effect of "./doc-diff: not found" rather than a friendly `doc-diff
> -h` output. Granted, all of these `usage` calls are in error paths, so
> we're about to exit anyway, but the user experience of something like
> `(cd Documentation && ./doc-diff)` could be a bit better than
> "./doc-diff: not found".
> 
> This regressed in ad51743007 ("doc-diff: add --clean mode to remove
> temporary working gunk", 2018-08-31) where we moved the call to
> `cd_to_toplevel` to much earlier. Move it back to where it was, and
> teach the "--clean" code to cd on its own. This way, we only cd once
> we've verified the arguments.
> 
> A more general fix would be to teach git-sh-setup to save away the
> absolute path for $0 and then use that, instead. I'm not aware of any
> portable way of doing that, see, e.g., d2addc3b96 ("t7800: readlink
> may not be available", 2016-05-31), so let's just fix this user
> instead.

This (and the patch) seems quite reasonable as a fix.

I actually think we could go further and drop the cd_to_toplevel
entirely. IIRC, the only thing it accomplishes[1] is that we can
consistently refer to the tmp directory as Documentation/tmp-doc-diff.

It would probably be fine to:

  - use "$(git rev-parse --show-toplevel)/Documentation/tmp-doc-diff".
    In earlier iterations of the script, I think using an absolute path
    bled through to the resulting diff, but we later cleaned that up
    anyway.

  - just use a relative "tmp-doc-diff". I doubt anybody actually wants
    to do anything other than "cd Documentation && ./doc-diff" anyway.
    This breaks "./Documentation/doc-diff", but it is not like you can
    run "t/t0000-basic.sh" either.

-Peff

[1] I think also in early iterations I had some notion of using the cwd
    to build things, but that quickly went out the window in favor of
    worktrees.
