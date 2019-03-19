Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5613120248
	for <e@80x24.org>; Tue, 19 Mar 2019 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfCSGrO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:47:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:56094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725862AbfCSGrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:47:14 -0400
Received: (qmail 8477 invoked by uid 109); 19 Mar 2019 06:47:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 06:47:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27209 invoked by uid 111); 19 Mar 2019 06:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Mar 2019 02:47:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2019 02:47:12 -0400
Date:   Tue, 19 Mar 2019 02:47:12 -0400
From:   Jeff King <peff@peff.net>
To:     Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc:     git@vger.kernel.org
Subject: Re: Improve support for 'git config gc.reflogExpire never'
Message-ID: <20190319064711.GD31801@sigill.intra.peff.net>
References: <39a0796a-7220-1e81-e7fe-3bf7329ed7de@peda.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39a0796a-7220-1e81-e7fe-3bf7329ed7de@peda.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 10:27:11AM +0200, Mikko Rantalainen wrote:

> If I configure bare repo with
> 
> git config gc.pruneExpire never
> git config gc.reflogExpire never
> 
> then git will never garbage collect any commit ever stored in the repo.
> This is what I want.
> 
> However, all commits referenced only via reflog are kept as loose
> objects and will not be included in packs. In long run this will cause
> 
> warning: There are too many unreachable loose objects; run 'git prune'
> to remove them.
> 
> and the performance of the repository will slowly decrease.

That's not what's supposed to happen. A normal git-gc (or directly
running the "git repack" it spawns) should consider objects in reflogs
reachable, and pack them as it would an object reachable from a ref.
This has been the case since 63049292e0 (Teach git-repack to preserve
objects referred to by reflog entries., 2006-12-18).

Just to double check: are you sure you have reflogs? They're not enabled
by default in bare repos.

Another thing that may surprise you is that deleting a branch will
delete its reflog (and then the objects are unreachable, and may be
exploded loose).

> If I have understood correctly, git should notice that reflog will keep
> referenced commits forever and include all those commits in packs
> instead of keeping those as loose forever.

Yes, that's what's supposed to happen. If you have a recipe for
reproducing a case where it doesn't, I'd be curious to see it.

> A more generic behavior might be to always compress all loose commits in
> (one?) special pack so the performance would stay good even if
> gc.reflogExpire is very long instead of "never".

You can do "git repack -adk", which will keep all packed objects packed,
and will suck up loose objects into the pack (and delete their loose
counterparts). I don't think there's a convenient way to convince git-gc
to do this when it runs "git repack", though. I think it would be a
reasonable feature for it to have.

-Peff
