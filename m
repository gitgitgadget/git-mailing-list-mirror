Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D8A1F462
	for <e@80x24.org>; Wed, 29 May 2019 01:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfE2BRs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 21:17:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:40792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725805AbfE2BRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 21:17:48 -0400
Received: (qmail 12651 invoked by uid 109); 29 May 2019 01:17:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 May 2019 01:17:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20928 invoked by uid 111); 29 May 2019 01:18:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 21:18:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 21:17:44 -0400
Date:   Tue, 28 May 2019 21:17:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190529011744.GA22340@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
 <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 01:34:32AM +0200, René Scharfe wrote:

> It figures.
> 
> So something like the patch below?
> 
> Parsing trees with symlinks twice is not ideal, but keeps the set
> structure simple -- a standard oidset suffices.

If blobs comes after trees (and they usually do in a pack), you can do
it in a single pass by marking the blob as a symlink target, and then
when we actually see that blob's contents, marking it as either OK or
problematic. And then the finish() step just correlates those with the
tree.

It does require O(n) storage in the number of symlinked blobs, but also
O(n) in the number of symlinked tree entries (number of trees with
symlinks times the number of entries in each such tree, _even if they're
the same entry/blob as another tree).

That makes it a lot worse than the existing gitmodules check. There we
only care about finding the .gitmodules blobs. So even though you have a
ton of trees that mention .gitmodules (basically every root tree), the
the .gitmodules file itself doesn't change much. So we only end up with
a small oidset (and a small worst case for looking at objects twice).

But here the problem is in the tree, not the blob. So we're not finding
suspect blobs, but rather re-checking each tree. And no matter what we
do (whether it's visiting the object again, or creating a set or mapping
with the object names) is going to be linear there. And a repository
with a symlink in the root tree is going to revisit or put in our
mapping every single root tree.

TBH, I'm not sure this fsck check was worth it even without the
implementation complexity.

> The global variables are ugly.  Moving them into struct fsck_option
> would be possible, but not much better, as they aren't really
> options.

Yeah, we use the name "context" elsewhere for this, which is a bit
clearer. In a real object-oriented design, I guess people would make an
"Fscker" object, and it would carry the options and context forward.
That's basically what our "context" objects are.

> FSCK_MSG_MISSING_TREE_OBJECT has never been used before, it seems.

Yeah, this is leftover cruft from my gitmodules series. I double-checked
the early iterations to be sure, and it is definitely the case. I didn't
dig down to find out the reason it went away, but I think it is probably
that the original version tried harder to find .gitmodules only in root
trees, and later we decided to just complain about it in any tree.

-Peff
