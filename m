Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB2B1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755426AbdKNPjn (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:39:43 -0500
Received: from smtp66.iad3a.emailsrvr.com ([173.203.187.66]:48351 "EHLO
        smtp66.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753741AbdKNPjd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2017 10:39:33 -0500
Received: from smtp1.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5210162AA;
        Tue, 14 Nov 2017 10:39:32 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp1.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1E6405C35;
        Tue, 14 Nov 2017 10:39:32 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 14 Nov 2017 10:39:32 -0500
Subject: Re: Recovering from gc errors
To:     Jeff King <peff@peff.net>
References: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
 <20171114055306.3tfi726wzmkcfluk@sigill.intra.peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <3af0f8cc-09f3-bcf2-04c8-f076e0ddcea2@xiplink.com>
Date:   Tue, 14 Nov 2017 10:39:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171114055306.3tfi726wzmkcfluk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(It turned out that this problem is related to worktrees.  CCing some 
worktree folks.)

On 2017-11-14 12:53 AM, Jeff King wrote:
> On Mon, Nov 13, 2017 at 04:13:19PM -0500, Marc Branchaud wrote:
> 
>> Various incantations of "git show ... 9c355a7726e31" only fail with the same
>> error, so I can't determine much about the problematic commit. Luckily I'm
>> not particularly concerned with losing objects, as I push any important
>> progress to named refs in backup repos.
> 
> Doing "git show" will require looking at the parent commit to produce
> the diff. Probably "git show -s" would work. But in general for poking
> at corruption, something bare-bones like "git cat-file commit 9c355a77"
> is going to be your best bet.

Thanks, I'd forgotten about cat-file (show's -s did not work).

Only one or two of the bad commits could possibly belong in a submodule, 
so I don't think I'm seeing a worktree+submodule problem.

There are some definite "rebase -i" commits (e.g. "fixup!"), and a lot 
of what were probably cherry-picks.  I know I did these operations in a 
worktree (see below).

>> But I would like to clean this up in my local repo so that gc stops failing.
>> I tried simply removing this and other loose commits that trip up gc (i.e.
>> the objects/9c/355a7726e31b3033b8e714cf7edb4f0a41d8d4 file -- there are 49
>> such files, all of which are several months old), but now gc complains of a
>> bad tree object:
> 
> You can't generally fix corruption issues by deleting objects[1]. The
> "source" that makes Git want to have these objects is the refs and
> reflogs. So your best bet is to find which of those point to the
> problematic objects and delete them.
> 
> I'd start by seeing if the breakage is reachable from any refs:
> 
>    git rev-list --objects --all >/dev/null

That command does succeed.

> If that command succeeds, then all your refs are intact and the problem
> is in the reflogs. You can try to figure out which, but I'd probably
> just blow them all away:
> 
>    rm -rf .git/logs

Unfortunately, removing the logs directory does not fix "git gc".  So I 
restored it.

However I did find all of the bad SHAs in the HEAD logs of four of my 
worktrees.

All of those worktrees have directories in .git/worktrees/, but "git 
worktree list" does not show two of them.  "git worktree prune -v" 
displays and does nothing.  (I do not want to play with --expire, 
because I'd rather keep my other worktrees.)

I removed all of those worktrees' directories from .git/worktrees/, and 
now "git gc" succeeds.  I've also removed those worktrees' working 
directories, as I don't really need them anymore.

Thanks for your help!

I'm willing to chalk this up to bugs in the early worktree code, unless 
one of the CC'd worktree developers thinks otherwise.

An explicit "git worktree delete" command would be nice for manually 
cleaning things up.  It's easy to just delete the directory, but having 
a "delete" command gives the user assurance that they're not missing 
something.

		M.

> If the rev-list fails, then one or more branch is corrupted.
> Unfortunately the usual efficient tools for asking "which branch
> contains this object" are likely to be broken by the corruption. But you
> can brute-force it, like:
> 
>    git for-each-ref --format='%(refname)' |
>    while read ref; do
>      git rev-list --objects "$ref" >/dev/null 2>&1 ||
>      echo "$ref is broken"
>    done
> 
> Hopefully that turns up only branches with little value, and you can
> delete them:
> 
>    git update-ref -d $broken_ref
> 
> -Peff
> 
> [1] A note on my "you can't fix corruption by deleting objects".
> 
>      Since abcb86553d (pack-objects: match prune logic for discarding
>      objects, 2014-10-15) , git-gc also traverses the history graph of
>      unreachable but "recent" objects. This is to keep whole chunks of
>      the history graph intact during the gc grace period (which is 2
>      weeks by default). So object themselves _can_ be a source of
>      traversal for git-gc.
> 
>      We do that traversal with the ignore_missing_links flag, so
>      breakages in the unreachable objects _shouldn't_ cause what you're
>      seeing. IIRC we did turn up a bug or two with ignore_missing_links.
>      The only one I could find was a3ba6bf10a (revision.c: ignore broken
>      tags with ignore_missing_links, 2017-05-20), which I think wouldn't
>      generate the output you're seeing.
> 
