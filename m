Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8DE1F462
	for <e@80x24.org>; Tue, 28 May 2019 05:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfE1F6I (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 01:58:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727641AbfE1F6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 01:58:08 -0400
Received: (qmail 27128 invoked by uid 109); 28 May 2019 05:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 05:58:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10275 invoked by uid 111); 28 May 2019 05:58:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 01:58:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 01:58:06 -0400
Date:   Tue, 28 May 2019 01:58:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190528055805.GB7946@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 25, 2019 at 03:26:53PM +0200, René Scharfe wrote:

> We could truncate symlink targets at the first NUL as well in git
> archive -- but that would be a bit sad, as the archive formats allow
> storing the "real" target from the repo, with NUL and all.  We could
> make git fsck report such symlinks.

This is a little tricky, because fsck generally looks at individual
objects, and the bad pattern is a combination of a tree and a blob
together. I think you could make it work by reusing some of the code and
patterns from 9e84a6d758 (Merge branch 'jk/submodule-fsck-loose' into
maint, 2018-05-22).

> Can Unicode symlink targets contain NULs?  We wouldn't want to damage
> them even if we decide to truncate.

On Windows, I suppose, where pathnames can be UTF-16? I don't know how
any of that works with Git. I guess we'd always have to assume the
filenames in Git are UTF-8 or at least some ASCII-superset, since we
cannot encode NULs; and presumably that would extend to link
destinations, too. So I doubt it's a problem in practice. Personally,
I'd wait until somebody with such a system cares enough to suggest a new
behavior, rather than trying to guess. :)

Likewise, I think at this point with Keegan's original report that Git
is doing something reasonable with a lousy input. Unless something
interesting comes out of the golang/go bug report discussion (thank you
for opening that!), it's probably not worth chasing hypotheticals.

-Peff
