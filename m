Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DABCC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8220714
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCUR4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:56:18 -0400
Received: from mx.sdf.org ([205.166.94.20]:53552 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgCUR4R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 13:56:17 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02LHuDq7013742
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 21 Mar 2020 17:56:13 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02LHuCpl015610;
        Sat, 21 Mar 2020 17:56:12 GMT
Date:   Sat, 21 Mar 2020 17:56:12 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200321175612.GC19579@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 11:51:10AM +0100, Johannes Schindelin wrote:
> My biggest caveat is that I had to force-exit the rebase at some stage
> due to reasons I only vaguely remember. It had something to do with the
> replacement cache not being updated when an `exec` is executed that adds a
> replacement object via `git replace` [*1*]. This issue might have
> _nothing_ to do with nested rebases, but as I said, my recollection is
> vague.

This is the sort of internal implementation gotcha I worry about.

> There are a couple more concerns, of course, such as: what to do if the
> user deletes the entire todo list (which is traditionally the only way to
> abort a rebase)? My gut feeling is that it should go back to the
> _previous_ version of the todo list.

My assumption has been that, for simplicity, there would only be one 
commit in progress, and aborting it aborts everything.

> Another big concern is what to do about `rebase.missingCommitsCheck`: with
> nested rebases, this will get increasingly tricky. Like, imagine you are
> rebasing 5 commits, the third of them results in merge conflicts, you
> realize that it is obsolete and so is now the first, already rebased
> commit. You do a nested rebase of the latest two commits to drop them, but
> they don't have their original commit hashes any longer. So it gets a bit
> finicky to keep track of what commit has been dropped on purpose and what
> was forgotten to pick instead.

This doesn't *seem* difficult, but I don't know how the current mechanism
works.

It just checks that all commits that were on the to-do list when the 
editor started are still listed (possibly marked "drop") when it exits.

When you do a nested commit, additional commits are prepended to the to-do 
list, you're dropped into the editor, and the same check is made when the 
editor returns.

If rebase.missingCommitsCheck = error is triggered, you end up with the 
<upstream> tree state with nothing applied and may either --continue to 
ignore the error or --edit-todo to put back the missing commits.


Let me give an example.  Suppose I have commits a-b-c-d-e, and start
with rebase -i b.

My to-do list starts out as c-d-e, but suppose I decide to cherry-pick
z and add it to the list, so it's now z-c-d-e.

So I start rebasing, and it turns out that d creates a merge conflict
because I forgot a prerequisite patch y.  And I really want y and z before
b, anyway.

So the tree state is currently a-b-z'-c', with d in progress and e yet to 
do.  In my simple model, I have to resolve and commit d, so the tree
state is a-b-z'-c'-d'.  Then I can rebase -i a, and am presented with
a to-do list of b-z'-c'-d'-e.

If I delete any of those five commits, then rebase.missingCommitsCheck 
will trigger.  If I put y in the list, save it, then change my mind and
--edit-todo and delete y, it will also trigger.

Now, it sould be nice if there were a way to say "screw this mess; just
check out HEAD and put d back on the to-do list", but that could 
create a bit of a mess if I've split d and already committed half of 
it.  If I used that after doung that, I'd have a to-do list of 
b-z'-c'-d'-d-e which might be awkward, but maybe it wouldn't be too bad.
