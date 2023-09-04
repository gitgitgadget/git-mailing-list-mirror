Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82235C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjIDMsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIDMsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 08:48:20 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20ED1AD
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 05:48:14 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 22069240DE;
        Mon,  4 Sep 2023 08:48:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qd900-NfT-00; Mon, 04 Sep 2023 14:48:12 +0200
Date:   Mon, 4 Sep 2023 14:48:12 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Message-ID: <ZPXSDKTjK4k1LGjk@ugly>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
 <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com>
 <ZPTdmnHfDcTBqaSl@ugly>
 <fdf80c36-0e28-44f3-9cef-85d38d2d48f1@gmail.com>
 <ZPTqEIvW3zJ4eafT@ugly>
 <4e0628ab-c39c-410d-864b-b7c74f9e04b1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6hBKrcZd/viSU9Dw"
Content-Disposition: inline
In-Reply-To: <4e0628ab-c39c-410d-864b-b7c74f9e04b1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6hBKrcZd/viSU9Dw
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 04, 2023 at 11:05:22AM +0100, Phillip Wood wrote:
>On 03/09/2023 21:18, Oswald Buddenhagen wrote:
>> On Sun, Sep 03, 2023 at 08:48:14PM +0100, Phillip Wood wrote:
>>> On 03/09/2023 20:25, Oswald Buddenhagen wrote:
>>>> On Sun, Sep 03, 2023 at 07:40:00PM +0100, Phillip Wood wrote:
>>>>> it only matters for "cherry-pick --skip"
>>>>>
>>>> that doesn't seem right. a --skip is just a --continue with a prior 
>>>> reset, more or less.
>>>
>>> sequencer_skip() calls rollback_is_safe() which checks the abort 
>>> safety file.
>>>
>> that's weird. can you think of a good reason for doing that?
>
>I think it is clear from the code - so it does not reset changes after 
>the user has committed the conflict resolution.
>
yeah, i've researched that meanwhile.
the background is that the machinery that was originally introduced for 
abort safety was later (ab-)used for checking whether a --skip makes 
sense (de81ca3f36, "cherry-pick/revert: add --skip option", 2019-07-02).  
this made the state file a misnomer (not that "abort-safety" was a 
particularly good name to start with - i'd have used "latest-head" or 
some such).

but the implementation made no sense to me, so i read the mailing list 
archive. the result is the attached patch.
however, even so, it seems kinda wrong to me: going by HEAD means that 
dropping commits would also trigger it, which would make the given 
advice misleading.
in fact, the situation this code path is covering is fundamentally 
different from the normal merge conflict: rather than letting the user 
resolve it and us finishing the commit, we are rescheduling the pick.  
but that means that --skip needs to skip whatever the next command is?  
that doesn't sound right.
also, i just tried --continue after a path conflict, and it apparently 
did the same as --skip, so something is really wrong.
also, when we have no _HEAD, actually attempting to `reset --merge` is 
pointless, no?

oh, and i just noticed that the git-prompt is buggy: it doesn't tell me 
about the interrupted multi-pick nested into an interrupted rebase.

ugh, and rebase lets me continue despite still being in the multi-pick.

and the path conflict check is made ineffective by the file in question 
being in .gitignore?! (i force-added config.mak.autogen for testing, and 
cherry-picking over it goes through just fine.)

>> i think i'd aim for an object-oriented-ish design with an 
>> encapsulated state, lazy loading getters, lazy setters, and a commit 
>> entry point (or maybe several partial ones). no idea how that would 
>> play out.
>
>I've been working on something similar
>
awesome!
(well, except for the rebase nightmare in my own series i expect because 
of this.)

>to only write the state to disc when the sequencer stops for user 
>interaction.
>
note that this must cover ctrl-c as well, because the sequencer state 
must be consistent with HEAD. of course one could also delay updating 
HEAD, but that hinges on no relevant hooks being present, i think?  
git-replay has a huge advantage here ...

regards

--6hBKrcZd/viSU9Dw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-sequencer-improve-comment-in-sequencer_skip.patch"

From eb81dc1d5ecb7d9d3cf4608b93c30250392f6fc7 Mon Sep 17 00:00:00 2001
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Date: Mon, 4 Sep 2023 13:07:04 +0200
Subject: [PATCH] sequencer: improve comment in sequencer_skip()

It wasn't clear under which circumstances the described path would be
relevant.

Change-Id: Ie9fd8a619dad4daf163c5efdb2f9a9eccf17307d
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c0ff165b83..11d2368ab1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3359,12 +3359,13 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 	 * If the corresponding .git/<ACTION>_HEAD exists, we know that the
 	 * action is in progress and we can skip the commit.
 	 *
-	 * Otherwise we check that the last instruction was related to the
-	 * particular subcommand we're trying to execute and barf if that's not
-	 * the case.
-	 *
-	 * Finally we check that the rollback is "safe", i.e., has the HEAD
-	 * moved? In this case, it doesn't make sense to "reset the merge" and
+	 * But if the action would have overwritten an untracked file, no
+	 * corresponding _HEAD file exists.
+	 * In this case we fall back to checking that the last instruction was
+	 * related to the particular subcommand we're trying to execute and barf
+	 * if that's not the case.
+	 * We also check that the rollback is "safe", i.e., whether the HEAD
+	 * moved. If it did, it doesn't make sense to "reset the merge" and
 	 * "skip the commit" as the user already handled this by committing. But
 	 * we'd not want to barf here, instead give advice on how to proceed. We
 	 * only need to check that when .git/<ACTION>_HEAD doesn't exist because
-- 
2.42.0.324.gb1ea313d68


--6hBKrcZd/viSU9Dw--
