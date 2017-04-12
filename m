Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3632520960
	for <e@80x24.org>; Wed, 12 Apr 2017 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbdDLJMC (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 05:12:02 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:59515 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbdDLJL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 05:11:58 -0400
Received: from [10.100.4.232] (nat2.ableton.net [217.110.199.118])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id B5E8B302DEC;
        Wed, 12 Apr 2017 11:11:51 +0200 (CEST)
To:     matt@mattmccutchen.net (Matt McCutchen), git@vger.kernel.org (git)
In-Reply-To: <1n468u6.1jrwr611bokgfiM%lists@haller-berlin.de>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Wed, 12 Apr 2017 11:11:51 +0200
Message-ID: <1n4d7d5.1b6xa1lkkp9p4M%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> wrote:

> Then, every command that either integrates the remote tracking branch
> into the local branch, or updates the remote tracking branch to the
> local branch, will update the value of the "lease" entry. The most
> obvious ones are "git pull" and "git push", or course;

I thought a bit more about what this means, concretely. The problem is
that only a *successful* pull must update the lease; an unsuccessful
pull must leave it alone. Pull is either fetch+merge or fetch+rebase,
and if the merge or rebase fails with conflicts, then we can only tell
much later whether the pull was successful; in the case of merge only
after the next commit (success) or after git merge --abort (failure),
and in the case of rebase after the next rebase --continue (success), or
rebase --abort (failure).

To implement this, git pull could set the value "branch.*.pending-lease"
after fetch was successful (but leave "branch.*.lease" alone); then git
merge and git rebase could look for that value, and if successful, set
branch.*.lease to the value of branch.*.pending-lease, and delete
pending-lease. If unsuccessful, they'd just delete the pending-lease
entry. Other command may also have to delete the pending-lease entry,
e.g. git reset.

I do realize that this is a lot of complexity, and it has the potential
of missing some cases. However, this complexity is also the reason why I
can't build my own wrappers around pull/push to implement the feature
outside of git; alias mypull='git pull && git tag -f lease @{u}' just
doesn't cut it.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
