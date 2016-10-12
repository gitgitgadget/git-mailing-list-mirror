Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F30207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbcJLQiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:38:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56536 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753712AbcJLQiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:38:52 -0400
Received: (qmail 13478 invoked by uid 109); 12 Oct 2016 16:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 16:32:11 +0000
Received: (qmail 22220 invoked by uid 111); 12 Oct 2016 16:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 12:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 12:32:09 -0400
Date:   Wed, 12 Oct 2016 12:32:09 -0400
From:   Jeff King <peff@peff.net>
To:     Stepan Kasal <kasal@ucw.cz>
Cc:     John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: Bug with git merge-base and a packed ref
Message-ID: <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
References: <20161012103716.GA31533@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161012103716.GA31533@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 12:37:16PM +0200, Stepan Kasal wrote:

> A reproducer would look like that
> 
> # in repo1:
> git checkout tmp
> cd ..
> git clone repo1 repo2
> cd repo1
> git rebase elsewhere tmp
> cd ../repo2
> # edit
> git commit -a -m 'Another commit'
> git pull -r
> 
> The last command performs something like
>    git rebase new-origin/tmp
> instead of
>    git rebase --onto new-origin/tmp old-origin/tmp
> 
> I'm using git version 2.10.1.windows.1
> 
> 
> I tried to debug the issue:
> I found that the bug happens only at the very first pull after clone.
> I was able to reproduce it with git-pull.sh
> 
> The problem seems to be that command
>   git merge-base --fork-point refs/remotes/origin/tmp refs/heads/tmp
> returns nothing, because the refs are packed.

The --fork-point option looks in the reflog to notice that the upstream
branch has been rebased. I don't think clone actually writes reflog
entries, though, which would explain why it happens only on the first
pull after clone.

I suspect the necessary information _is_ there, though. When we update
the tracking branch, the new reflog entry will show it going from sha1
X to sha1 Y. So my guess is that --fork-point is looking for the entry
where it became "X" (which doesn't exist, because clone did not write
it), but it _could_ find that we came from "X" in the very first reflog
entry.

That's all without looking at the code, though. I don't have time to
examine it now, but maybe that can point somebody in the right
direction.

> Could you please fix merge-base so that it understands packed refs?

I think the packed-refs thing is probably a red herring. If merge-base
didn't understand packed refs, a huge chunk of git would be horribly
broken.

-Peff
