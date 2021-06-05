Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8980C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA61613DF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEPfF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 5 Jun 2021 11:35:05 -0400
Received: from botech.co.uk ([81.187.226.106]:46476 "EHLO chimp.botech.co.uk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhFEPfF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 11:35:05 -0400
Received: from botech.co.uk ([81.187.226.106] helo=[192.168.4.5])
        by chimp.botech.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tpr.ll@botech.co.uk>)
        id 1lpYIO-0001jG-RQ; Sat, 05 Jun 2021 16:33:08 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
From:   "Tim Renouf (open source)" <tpr.ll@botech.co.uk>
In-Reply-To: <CABPp-BHT3ZrGrDVBcSTuzhSmy0EdtGUeHF_RAVohw=nemGhoOA@mail.gmail.com>
Date:   Sat, 5 Jun 2021 16:33:08 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <66290CC2-CC83-491F-84BD-3D9107B11EFB@botech.co.uk>
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
 <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com> <xmqqmts9q9m2.fsf@gitster.g>
 <CABPp-BHs0ACvkCJMB-tO8xkiidB12NrN1hOhLRvm3U_Q=r2YcQ@mail.gmail.com>
 <9BCB8981-09D5-4BF4-981B-2BF0AA0D6E5A@botech.co.uk>
 <CABPp-BHT3ZrGrDVBcSTuzhSmy0EdtGUeHF_RAVohw=nemGhoOA@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

> Can you expand on this use case a bit? 

Fundamentally, I wanted sparse-checkout to cause all git commands to completely ignore all files outside sparse-checkout patterns, even if they happen to correspond to paths in the index. I realize that that is difficult to achieve, but I was hoping that my patch would make it close enough to be workable. In particular, I would need to avoid doing a merge (cherry-pick, rebase) with conflicts outside the sparse-checkout patterns.

Here is the (maybe slightly specialized) use case:

Due to decisions out of my hands, I have a monorepo containing some shared code and some separate components in subdirectories. There is a “main” branch where the code is built and delivered from. Each component is developed separately and has its own dev branch, e.g. “dev-component1”, “dev-component2”. Many developers develop on just one component, so they check out its dev branch. The “dev-component1” branch still contains the “main” version of the shared code and the other components, so you can merge it up to the main branch.

But some people want to be able to develop on two components at the same time. So they want to check out component1 on its dev-component1 branch, and component2 on its dev-component2 branch. They would ideally want to do this at the same time as maintaining the overall monorepo directory layout. The monorepo does not give a good way to do that.

I was experimenting with an approach combining sparse-checkout, worktrees, and the core.worktree config item, as follows:

The monorepo has its main worktree at the root of the overall workspace, with sparse-checkout set to check out just the shared code not considered part of any separate component. Each component has its own worktree in its subdirectory, with sparse-checkout set to only check out that component. To get the monorepo-like directory structure, a component’s worktree has its core.worktree config item set to point back up to the root of the overall workspace.

So, with that somewhat hairy structure, anything that touches a file outside of the worktree’s sparse-checkout actually touches a file in a different worktree, giving some surprising results.

Even with my patch, there is still a risk of that happening. And having a component’s worktree rooted somewhere other than where you think it is rooted gave some other surprising results.

I think I am going to abandon that approach and go a different way.

Thanks for the attention.

-tpr
