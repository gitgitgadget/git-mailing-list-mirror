Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F7920C11
	for <e@80x24.org>; Wed, 29 Nov 2017 08:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdK2Icq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 29 Nov 2017 03:32:46 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:40371 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdK2Icq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 03:32:46 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id C2AA25D462
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:32:44 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 9D7615B3F5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:32:44 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 29 Nov 2017 09:32:44 +0100
Message-Id: <5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Wed, 29 Nov 2017 09:32:42 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
 (Ulrich Windl's message of "Tue, 28 Nov 2017 15:21:49 +0100")
 <xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
> 
>> I think if more than one branches are pointing to the same commit,
>> one should be allowed to delete all but the last one without
>> warning. Do you agree?
> 
> That comes from a viewpoint that the only purpose "branch -d" exists
> in addition to "branch -D" is to protect objects from "gc".  Those
> who added the safety feature may have shared that view originally,
> but it turns out that it protects another important thing you are
> forgetting.
> 
> Imagine that two topics, 'topicA' and 'topicB', were independently
> forked from 'master', and then later we wanted to add a feature that
> depends on these two topics.  Since the 'feature' forked, there may
> have been other developments, and we ended up in this topology:
> 
>     ---o---o---o---o---o---M
>         \   \          
>          \   o---A---o---F
>           \         /  
>            o---o---o---o---B
> 
> where A, B and F are the tips of 'topicA', 'topicB' and 'feature'
> branches right now [*1*].
> 
> Now imagine we are on 'master' and just made 'topicB' graduate.  We
> would have this topology.
> 
>     ---o---o---o---o---o---o---M
>         \   \                 /
>          \   o---A---o---F   /
>           \         /       /
>            o---o---o---o---B
> 
> While we do have 'topicA' and 'feature' branches still in flight,
> we are done with 'topicB'.  Even though the tip of 'topicA' is
> reachable from the tip of 'feature', the fact that the branch points
> at 'A' is still relevant.  If we lose that information right now,
> we'd have to go find it when we (1) want to further enhance the
> topic by checking out and building on 'topicA', and (2) want to
> finally get 'topicA' graduate to 'master'.
> 
> Because removal of a topic (in this case 'topicB') is often done
> after a merge of that topic is made into an integration branch,
> "branch -d" that protects branches that are yet to be merged to the
> current branch catches you if you said "branch -d topic{A,B}" (or
> other equivalent forms, most likely you'd have a script that spits
> out list of branches and feed it to "xargs branch -d").
> 
> So, no, I do not agree.

Hi!

I can follow your argumentation, but I fail to see that your branches A and B point to the same commit (which is what I was talking about). So my situation would be:

o---oA,B

I still think I could safely remove either A or B, even when the branch (identified by the commit, not by the name) is unmerged. What did I miss?

Regards,
Ulrich

> 
> 
> [Footnotes]
> 
> *1* Since the 'feature' started developing, there were a few commits
>     added to 'topicB' but because the feature does not depend on
>     these enhancements to that topic, B is ahead of the commit that
>     was originally merged with the tip of 'topicA' to form the
>     'feature' branch.

