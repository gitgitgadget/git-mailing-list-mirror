Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA3F202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 03:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdJTDQd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 23:16:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751003AbdJTDQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 23:16:32 -0400
Received: (qmail 17834 invoked by uid 109); 20 Oct 2017 03:16:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 03:16:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14414 invoked by uid 111); 20 Oct 2017 03:16:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 23:16:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 23:16:30 -0400
Date:   Thu, 19 Oct 2017 23:16:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
Message-ID: <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 06:43:57PM -0700, Stefan Beller wrote:

> So I ran "git fetch --all" inside git.git that you are all familiar with.
> All fetches failed with a similar error as:
> Fetching kernelorg
> fatal: bad object HEAD
> error: https://kernel.googlesource.com/pub/scm/git/git did not send
> all necessary objects
> 
> error: Could not fetch kernelorg

I ran into this a while back with worktrees, too. In my case I had a
worktree which was "owned" by multiple repositories[1]. One would write
the HEAD, but the other did not necessarily have those objects.

I don't quite recall how I ended up there. Doing "git worktree add"
multiple times does seem to complain about the directory already
existing. My case did involve relative symlinks in both repositories, so
maybe that confused things. Anyway, I can't seem to replicate it now.

> And here we go, I do use worktrees nowadays!
> $ git worktree list
> /usr/local/google/home/sbeller/OSS/git                   117ddefdb4
> (detached HEAD)
> /u/git                                                   d0c39a49cc
> (detached HEAD)
> /usr/local/google/home/sbeller/OSS/git_origin_master     b14f27f917
> (detached HEAD)
> /usr/local/google/home/sbeller/OSS/submodule_remote_dot  3d9025bd69
> (detached HEAD)
> 
> $ git show 3d9025bd69
> fatal: ambiguous argument '3d9025bd69': unknown revision or path not
> in the working tree.

So maybe you've ended up in the same situation and somehow "reused"
submodule_remote_dot.

But I think until that commit you mentioned (d0c39a49cc), "gc" in the
parent repo could drop objects accessible only from the worktree. So if
that happened _before_ d0c39a49cc, then at that point your worktree was
corrupted. And now of course further operations will complain.

> ok, so I presume I just delete that working tree to "fix my copy of git"
> sbeller@sbeller:/u/git$ rm -rf
> /usr/local/google/home/sbeller/OSS/submodule_remote_dot
> sbeller@sbeller:/u/git$ git worktree prune
> sbeller@sbeller:/u/git$ git worktree list
> /usr/local/google/home/sbeller/OSS/git                117ddefdb4 (detached HEAD)
> /u/git                                                d0c39a49cc (detached HEAD)
> /usr/local/google/home/sbeller/OSS/git_origin_master  b14f27f917 (detached HEAD)

So that's the right immediate workaround (and hoping there was nothing
valuable in that worktree!).

> Any idea which direction we need to heading for a real fix?

If my analysis above is correct, then it's already fixed. You just had
leftover corruption.

-Peff
