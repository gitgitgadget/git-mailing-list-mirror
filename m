Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0B81F404
	for <e@80x24.org>; Sat, 11 Aug 2018 14:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHKQ7w (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 12:59:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727324AbeHKQ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 12:59:52 -0400
Received: (qmail 28509 invoked by uid 109); 11 Aug 2018 14:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 14:25:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27457 invoked by uid 111); 11 Aug 2018 14:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 10:25:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 10:25:28 -0400
Date:   Sat, 11 Aug 2018 10:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Help with "fatal: unable to read ...." error during GC?
Message-ID: <20180811142527.GB17605@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net>
 <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
 <20180808182436.GA19096@sigill.intra.peff.net>
 <be46349efde84f158b80e96f2fbbcf4304a71208.camel@mad-scientist.net>
 <20180811142341.GA17605@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180811142341.GA17605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 10:23:41AM -0400, Jeff King wrote:

> > I do still have these warnings and no amount of git gc/git fsck/etc.
> > has reduced them in any way:
> > 
> > $ git gc
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> 
> I think these would go away via "reflog expire" (I'd have thought "git
> gc" would do so, though). I wonder if this is yet another tool that
> needs to be taught about worktree heads.
> 
> > I've run git gc --prune=all then git fsck reports only these dangling
> > commits:
> > 
> > dangling commit cef0678a5e0765506e3fac41286696fd37a9b1e9
> > dangling commit 1729195f021a1b95ea8ca10b9c32e76bf2257e67
> > dangling commit 08385b9731291607a8c6d4bf10272002d8f31e1f
> > dangling commit c4ddfb2139eeb5a3c132dbfc84cc6e27fdeb46d1
> > dangling commit 1df8ebcc1cd5f59dd224ce1f3ba39f24370cf4e7
> > 
> > (this is down from probably 50 or so "dangling ..." commits, blobs, and
> > trees before).
> 
> I'd also expect "--prune=all" to drop all dangling heads. But I think
> this is the worktree thing, again. The code in fsck starts it
> connectivity check with this:
> 
>           if (head_points_at && !is_null_oid(&head_oid))
>                   fsck_handle_ref("HEAD", &head_oid, 0, NULL);
>           for_each_rawref(fsck_handle_ref, NULL);
>           if (include_reflogs)
>                   for_each_reflog(fsck_handle_reflog, NULL);
> 
> but looking at the similar code in revision.c that has been upgraded to
> handle worktrees (e.g., add_reflogs_to_pending()), I think that is not
> going to look at worktree HEADs nor reflogs.
> 
> I'd hoped to give you a one-liner to try out, but I think it will
> require some refactoring.

Responding myself and adding Duy to the cc to increase visibility among
worktree experts. :)

-Peff
