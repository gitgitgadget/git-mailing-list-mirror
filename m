Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D55420958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbdCTTJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:09:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:47966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755199AbdCTTJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:09:23 -0400
Received: (qmail 17508 invoked by uid 109); 20 Mar 2017 19:08:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 19:08:47 +0000
Received: (qmail 4947 invoked by uid 111); 20 Mar 2017 19:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 15:09:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 15:08:43 -0400
Date:   Mon, 20 Mar 2017 15:08:43 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 3/3] stash: pass the pathspec argument to git reset
Message-ID: <20170320190843.aw3fsenjvcek7a44@sigill.intra.peff.net>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170319202351.8825-4-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 08:23:51PM +0000, Thomas Gummerer wrote:

> For "git stash -p --no-keep-index", the pathspec argument is currently
> not passed to "git reset".  This means that changed that are staged but
> that are excluded from the pathspec still get unstaged by git stash -p.

Yeah, I noticed this while playing around with patch 2. This seems
like an improvement to me. Unlike the other patches (which are just
tweaking quietness), I think this one really needs a test.

Also, s/changed/changes/ above.

> ---
> So this make things a bit inconsistent in for example the following
> situation:
> 
>     $ git status -s
>      M git-stash.sh
>     M  read-cache.c
> 
> where using git stash -p --no-keep-index, when only changes in
> git-stash.sh are added to the stash would reset read-cache.c, but with
> git stash -p --no-keep-index -- git-stash.sh, read-cache.c would not
> be reset.

I think it's OK. You can't select (or not select) changes from the index
anyway. TBH, I kind of wonder if "git stash -p --no-keep-index" makes
any sense at all.

> However it does bring things more in line with git stash --
> <pathspec>, so I think this is an improvement.

I did notice one other case while looking at this that I think is much
more serious. The "read-tree" call in the non-patch-mode case doesn't
use a pathspec either. So if we have our same setup where "one" and
"two" have unstaged changes and we do:

  git stash push -k one

Then we stash "one", but the change in "two" is wiped out completely!

I don't think read-tree takes pathspecs, so it would have to drop the
"-u" and replace it with checkout-index. I'm confused about why we would
need it in the first place, though. We should have already dealt with
the working tree files in the earlier block, so there should be nothing
to checkout.

The "-u" goes all the way back to 7bedebcaa (stash: introduce 'stash
save --keep-index' option, 2008-06-27). I wonder if it has always been
unnecessary, but we never noticed because it's just a noop.

-Peff
