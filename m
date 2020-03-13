Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18370C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 13:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC8520724
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 13:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMNIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:08:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40322 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMNIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 09:08:36 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jCk3F-0001SD-8T; Fri, 13 Mar 2020 13:08:34 +0000
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <66dc369f-cd83-e39c-1310-32a9c003d114@iee.email>
Date:   Fri, 13 Mar 2020 13:08:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86mu8o8dsf.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On 10/03/2020 14:50, Jakub Narebski wrote:
> Hello,
>
> Here below is a possible proposal for a more difficult Google Summer of
> Code 2020 project.
>
> A few questions:
> - is it too late to propose a new project idea for GSoC 2020?
> - is it too difficult of a project for GSoC?
>
> Best,
>
>   Jakub Narębski
>
> --------------------------------------------------
>
> ### Graph labelling for speeding up git commands
>
>  - Language: C
>  - Difficulty: hard / difficult
>  - Possible mentors: Jakub Narębski
>
> Git uses various clever methods for making operations on very large
> repositories faster, from bitmap indices for git-fetch[1], to generation
> numbers (also known as topological levels) in the commit-graph file for
> commit graph traversal operations like `git log --graph`[2].
>
> One possible improvement that can make Git even faster is using min-post
> intervals labelling.  The basis of this labelling is post-visit order of
> a depth-first search traversal tree of a commit graph, let's call it
> 'post(v)'.
This, the post(v) number, may need a bit more explanation for those not
familiar with graph theory terminology, so that they can get up to speed
easily about the method, and it's (hopeful) simplicity.

 It isn't clear to me if it is a count along a single string-of-pearls
between two branch - merge points, or depth from origin, or whether it
can span large chunks of the DAG? Ref 3. has the same problem of
starting from an assumed level of knowledge and understanding that may
put of non-academics (I'm thinking that the proposed method is this
PReaCH [3]).

It's my understanding that 'v' is usually 1...n in the literature, but
in reality it just means 'unique label' (and ultimately able to be
indexed in a data table). In Git we use the object id as the unique
label, so the 1..n is just an abstraction/convenience. The other problem
that can happen is if the terminologies of Git doesn't quite match those
of the descriptions, such as which end is 'root', or being 'mutually
reachable' in a directed acyclic graph.

The Wikipedia article on contraction hierarchies [6] did give some
useful clues for more lay readers.

> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
> reachable from 'v', let's call the latter 'min_graph(v)', then the
> following condition is true:
>
>   if 'v' can reach 'u', then min_graph(v) <= post(u) <= post(v)
>
> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
> that were visited during the part of depth-first search that started
> from 'v' (which is the minimum of post-order number for subtree of a
> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
> Then the following condition is true:
>
>   if min_tree(v) <= post(u) <= post(v), then 'v' can reach 'u'
>
> The task would be to implement computing such labelling (or a more
> involved variant of it[3][4]), storing it in commit-graph file, and
> using it for speeding up git commands (starting from a single chosen
> command) such as:
>
>  - git merge-base --is-ancestor A B
>  - git branch --contains A
>  - git tag --contains A
>  - git branch --merged A
>  - git tag --merged A
>  - git merge-base --all A B
>  - git log --topo-sort
>
> References:
>
> 1. <http://githubengineering.com/counting-objects/>
> 2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph-iii-generations/>
> 3. <https://arxiv.org/abs/1404.4465>
> 4. <https://github.com/steps/Ferrari>
>
> See also discussion in:
>
> <https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>  [5]
Philip

[6] https://en.wikipedia.org/wiki/Contraction_hierarchies

[I've been off-list for 2+ ,months, so still catching up]
