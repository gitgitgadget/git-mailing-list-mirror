Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C081F42D
	for <e@80x24.org>; Sun, 27 May 2018 17:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032837AbeE0Ry2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 13:54:28 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:56616 "EHLO
        5.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032821AbeE0Ry1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 13:54:27 -0400
Received: from player773.ha.ovh.net (unknown [10.109.120.101])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 383D4FB5C7
        for <git@vger.kernel.org>; Sun, 27 May 2018 19:37:13 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id 1291760009F;
        Sun, 27 May 2018 19:37:07 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
From:   Kevin Bracey <kevin@bracey.fi>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
Message-ID: <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
Date:   Sun, 27 May 2018 20:37:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 17061605716175458525
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrheeggdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/05/2018 23:26, Kevin Bracey wrote:
>
>>> On Wed, May 23, 2018 at 07:10:58PM +0200, SZEDER Gábor wrote:
>>>
>>>>    $ git log --oneline master..ba95710a3b -- ci/
>>>>    ea44c0a594 Merge branch 'bw/protocol-v2' into 
>>>> jt/partial-clone-proto-v2
>>>>
> In this case, we're hitting a merge commit which is not on master, but 
> it has two parents which both are. Which, IIRC, means the merge commit 
> is INTERESTING with two UNINTERESTING parents; and we are TREESAME to 
> only one of them.
>
> The commit changing the logic of TREESAME you identified believes that 
> those TREESAME changes for merges which were intended to improve 
> fuller history modes shouldn't affect the simple history "because 
> partially TREESAME merges are turned into normal commits". Clearly 
> that didn't happen here.
>
Haven't currently got a development environment set up here, but I've 
been looking at the code.Here's a proposal, untested, as a potential 
starting point if anyone wants to consider a proper patch.

The simplify_history first-scan logic never actually turned merges into 
simple commits unless they were TREESAME to a relevant/interesting 
parent.  Anything where the TREESAME parent was UNINTERESTING was 
retained as a merge, but had its TREESAME flag set, and that permitted 
later simplification.

With the redefinition of the TREESAME flag, this merge commit is no 
longer TREESAME, and as the decoration logic to refine TREESAME isn't 
active for simplify_history, it doesn't get cleaned up (even if it would 
be in full history?)

I think the answer may be to add an extra post-process step on the 
initial loop to handle this special case. Something like:

         case REV_TREE_SAME:
             if (!revs->simplify_history || !relevant_commit(p)) {
                 /* Even if a merge with an uninteresting
                  * side branch brought the entire change
                  * we are interested in, we do not want
                  * to lose the other branches of this
                  * merge, so we just keep going.
                  */
                 if (ts)
                     ts->treesame[nth_parent] = 1;
+               /* But we note it for potential later simplification */
+               if (!treesame_parent)
+                    treesame_parent = p;
                 continue;
              }

...

After loop:

+     if (relevant_parents == 0 && revs->simplify_history && 
treesame_parent) {
+           treesame_parent->next = NULL;// Repeats code from loop - 
share somehow?
+           commit->parents = treesame_parent;
+           commit->object.flags |= TREESAME;
+           return;
+    }

      /*
       * TREESAME is straightforward for single-parent commits. For merge

The other option would be to take off the " || !relevant_commit(p)" 
test, but I'm assuming that is still needed for other cases.

Kevin


