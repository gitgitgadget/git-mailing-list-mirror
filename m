Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3173202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 21:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbcGTVA5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:00:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:23255 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbcGTVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:00:52 -0400
Received: from PhilipOakley ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PybpbXumOHGLwPybpbEmLl; Wed, 20 Jul 2016 22:00:50 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=DgMhcCrtMqUSzJn8dYMA:9 a=uQDI9j9MUd42Pdii:21 a=EccxM8yJ2gAZc5ah:21
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <D239BC78A8EB47DD8397F93ABB3D35B0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>,
	"David Lightle" <dlightle@gmail.com>,
	"Stefan Haller" <lists@haller-berlin.de>
Cc:	<git@vger.kernel.org>
References: <1mqa4a5.1ykwh5b8vc9q7M%lists@haller-berlin.de>
Subject: Re: Fast-forward able commit, otherwise fail
Date:	Wed, 20 Jul 2016 17:47:56 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNlnOk/K+4caaq291/0VCMINngut61a9z3Z1L08QUw/6KVkKvsvBURzm9JGFa5gE+v5U+DqOOe1hSds7lE0ig1VzkmucVIxC8kE+6A2eNnEamGOv8HAe
 bL6xJF/Pr2PvBcUWKHpEW6Vy2lPSBuAyplJ0SFVic7me0g6MdBxE93bZ2DpK/xbOxjEPVJZRoVssDEocSr2aoATP0BO05asBTWDDtv/VattIY4po6894iN3S
 UtjVb0otl3lyaI6JdkduMQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Stefan Haller" <lists@haller-berlin.de>
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Another thing to consider is that the proposed workflow would not
>> scale if your team becomes larger.  Requiring each and every commit
>> on the trunk to be a merge commit, whose second parent (i.e. the tip
>> of the feature branch) fast-forwards to the first parent of the
>> merge (i.e. you require the feature to be up-to-date), would mean
>> that Alice and Bob collaborating on this project would end up
>> working like this:
>>
>>  A:    git pull --ff-only origin ;# starts working
>>  A:    git checkout -b topic-a
>>  A:    git commit; git commit; git commit
>>  B:    git pull --ff-only origin ;# starts working
>>  B:    git checkout -b topic-b
>>  B:    git commit; git commit
>>
>>  A:    git checkout master && git merge --ff-only --no-ff topic-a
>>  A:    git push origin ;# happy
>>
>>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>>  B:    git push origin ;# fails!
>>
>>  B:    git fetch origin ;# starts recovering
>>  B:    git reset --hard origin/master
>>  B:    git merge --ff-only --no-ff topic-b ;# fails!
>>  B:    git rebase origin/master topic-b
>>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>>  B:    git push origin ;# hopefully nobody pushed in the meantime
>>
>> The first push by Bob fails because his 'master', even though it is
>> a merge between the once-at-the-tip-of-public-master and topic-b
>> which was forked from that once-at-the-tip, it no longer fast-forwards
>> because Alice pushed her changes to the upstream.
>>
>> And it is not sufficient to redo the previous merge after fetching
>> the updated upstream, because your additional "feature branch must
>> be up-to-date" requirement is now broken for topic-b.  Bob needs to
>> rebuild it on top of the latest, which includes what Alice pushed,
>> using rebase, do that merge again, and hope that nobody else pushed
>> to update the upstream in the meantime.  As you have more people
>> working simultanously on more features, Bob will have to spend more
>> time doing steps between "starts recovering" and "hopefully nobody
>> pushed in the meantime", because the probability is higher that
>> somebody other than Alice has pushed while Bob is trying to recover.
>>
>> The time spend on recovery is not particularly productive, and this
>> workflow gives him a (wrong) incentive to do that recovery procedure
>> quickly to beat the other participants to become the first to push.
>
> I have read and re-read this thread a hundred times now, but I still
> don't understand why it makes much of a difference whether or not Bob
> rebases his branch onto master before pushing his merge. In both cases,
> Alice and Bob have this race as to whose push succeeds, and in both
> cases you end up with merge commits on master that are not well tested.

I'd like to put in comment from a different perspective.

You didn't say how often you expected these merge commits to be made 
(daily/hourly/2-minutes), and also didn't mention how long it's taking to do 
the tests - 5-mins/one hour/3 hours/all day, and in particular the values 
for the difficult cases.

For example it maybe: team size means typical small feature merge commits 
are ~twice/day, needing only 30 mins test time, however there are difficult 
(big feature) commits are every 1-3 weeks, and take all day (or more) to 
test, leaving an open window for small feature merges to sneak in and break 
the 'clean-test' process.

In the above case you have a management issue, where someone needs to 
(actively) manage the process so that there are no commits to master during 
that window, and rather they are put to 'next' (using Git' branch 
convention) and once the big feature has landed the 'next-features' can be 
rebased & tested and added on top of master.

Should the case be more that there is just some occasional overlaps from the 
30mins test, during the two per day window, then that should be more 
manageable by social and procedural convention.

The thing to notice is that the upstream is always good and well formed 
(because it rejects, or should reject, commits that 
aren't --ff-only --no-ff). So before any merge (either way) [i.e. just after 
rebase & test] master should be pulled to be locally up to date.

If there were no extra commits on top, then a quick --ff-only --no-ff merge 
and push, taking only a few seconds, will complete the feature. Otherwise, 
if there were extra commits on top, then it's a moderately quick rebase & 
re-test (an annoyance but handleable because its infrequent) should mean the 
updated commit will now pass the 'pull master' check cleanly - remember the 
commit/push rate means it's unlikely that a second clash happens, otherwise 
its back to the 'management' approach.


>
> First of all, let me say that at my company we do use the workflow that
> David suggests; we rebase topic branches onto master before merging them
> (with --no-ff), and we like the resulting shape of the history. Even the
> more experienced git users like it for its simplicity; it simply saves
> us time and mental energy when digging through the history.
>
> Second, we did indeed run into the scalability problems that you
> describe [*1*]. However, we ran into this way before starting to require
> the rebase-before-merge; in my experience, rebasing or not makes no
> difference here. After all, the resulting tree state of the merge commit
> is identical in both cases; it's just the individual commits on the
> merged topic branch that have not been tested in the rebased case. But
> if the merge commit is green, it is pretty unlikely in my experience
> that one of the individual commits is not. It's theoretically possible
> of course, just very, very unlikely.
>
> So what am I missing?
>
>
> [Footnote]
> *1* These problems were so annoying for us that we invented technical
> measures to solve them. We now have a web interface where developers can
> grab a lock on the repo, or put themselves into a queue for the lock
> when it's taken. There's a push hook that only allows pushing when you
> hold the lock. This solves it nicely, because once you have the lock,
> you can take all the time you need to make sure your merge compiles, and
> run the test suite locally.
> --

Philip 

