Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A681FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbcGLNcn (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:32:43 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:57584 "EHLO
	dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbcGLNcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 09:32:42 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2016 09:32:41 EDT
Received: from [10.1.0.149] (nat1.ableton.net [217.110.199.117])
	by dd28836.kasserver.com (Postfix) with ESMTPSA id EC978302343;
	Tue, 12 Jul 2016 15:24:48 +0200 (CEST)
To:	gitster@pobox.com (Junio C Hamano),
	dlightle@gmail.com (David Lightle)
Cc:	git@vger.kernel.org
In-Reply-To: <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
Subject: Re: Fast-forward able commit, otherwise fail
From:	lists@haller-berlin.de (Stefan Haller)
Date:	Tue, 12 Jul 2016 15:24:48 +0200
Message-ID: <1mqa4a5.1ykwh5b8vc9q7M%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.11.5 (x86))
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Another thing to consider is that the proposed workflow would not
> scale if your team becomes larger.  Requiring each and every commit
> on the trunk to be a merge commit, whose second parent (i.e. the tip
> of the feature branch) fast-forwards to the first parent of the
> merge (i.e. you require the feature to be up-to-date), would mean
> that Alice and Bob collaborating on this project would end up
> working like this:
> 
>  A:    git pull --ff-only origin ;# starts working
>  A:    git checkout -b topic-a
>  A:    git commit; git commit; git commit
>  B:    git pull --ff-only origin ;# starts working
>  B:    git checkout -b topic-b
>  B:    git commit; git commit
> 
>  A:    git checkout master && git merge --ff-only --no-ff topic-a
>  A:    git push origin ;# happy
> 
>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>  B:    git push origin ;# fails!
> 
>  B:    git fetch origin ;# starts recovering
>  B:    git reset --hard origin/master
>  B:    git merge --ff-only --no-ff topic-b ;# fails!
>  B:    git rebase origin/master topic-b
>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>  B:    git push origin ;# hopefully nobody pushed in the meantime
> 
> The first push by Bob fails because his 'master', even though it is
> a merge between the once-at-the-tip-of-public-master and topic-b
> which was forked from that once-at-the-tip, it no longer fast-forwards
> because Alice pushed her changes to the upstream.
> 
> And it is not sufficient to redo the previous merge after fetching
> the updated upstream, because your additional "feature branch must
> be up-to-date" requirement is now broken for topic-b.  Bob needs to
> rebuild it on top of the latest, which includes what Alice pushed,
> using rebase, do that merge again, and hope that nobody else pushed
> to update the upstream in the meantime.  As you have more people
> working simultanously on more features, Bob will have to spend more
> time doing steps between "starts recovering" and "hopefully nobody
> pushed in the meantime", because the probability is higher that
> somebody other than Alice has pushed while Bob is trying to recover.
> 
> The time spend on recovery is not particularly productive, and this
> workflow gives him a (wrong) incentive to do that recovery procedure
> quickly to beat the other participants to become the first to push.

I have read and re-read this thread a hundred times now, but I still
don't understand why it makes much of a difference whether or not Bob
rebases his branch onto master before pushing his merge. In both cases,
Alice and Bob have this race as to whose push succeeds, and in both
cases you end up with merge commits on master that are not well tested.

First of all, let me say that at my company we do use the workflow that
David suggests; we rebase topic branches onto master before merging them
(with --no-ff), and we like the resulting shape of the history. Even the
more experienced git users like it for its simplicity; it simply saves
us time and mental energy when digging through the history.

Second, we did indeed run into the scalability problems that you
describe [*1*]. However, we ran into this way before starting to require
the rebase-before-merge; in my experience, rebasing or not makes no
difference here. After all, the resulting tree state of the merge commit
is identical in both cases; it's just the individual commits on the
merged topic branch that have not been tested in the rebased case. But
if the merge commit is green, it is pretty unlikely in my experience
that one of the individual commits is not. It's theoretically possible
of course, just very, very unlikely.

So what am I missing?


[Footnote]
*1* These problems were so annoying for us that we invented technical
measures to solve them. We now have a web interface where developers can
grab a lock on the repo, or put themselves into a queue for the lock
when it's taken. There's a push hook that only allows pushing when you
hold the lock. This solves it nicely, because once you have the lock,
you can take all the time you need to make sure your merge compiles, and
run the test suite locally.
