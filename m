Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D650C18E5B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316D3206BE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgCOS5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:57:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14926 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgCOS5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:57:47 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jDYSG-0008Ya-52; Sun, 15 Mar 2020 18:57:46 +0000
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
 <66dc369f-cd83-e39c-1310-32a9c003d114@iee.email> <86ftec2ui8.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <076acb45-5360-6ee4-7c65-907488300ef3@iee.email>
Date:   Sun, 15 Mar 2020 18:57:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <86ftec2ui8.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,
some comments on potential misreading by being over-pedantic...

added Abhishek for GSoC comments

On 13/03/2020 14:34, Jakub Narebski wrote:
> Hello Philip,
>
> Philip Oakley <philipoakley@iee.email> writes:
>> On 10/03/2020 14:50, Jakub Narebski wrote:
> [...]
>>> ### Graph labelling for speeding up git commands
>>>
>>>  - Language: C
>>>  - Difficulty: hard / difficult
>>>  - Possible mentors: Jakub Narębski
>>>
>>> Git uses various clever methods for making operations on very large
>>> repositories faster, from bitmap indices for git-fetch[1], to generation
>>> numbers (also known as topological levels) in the commit-graph file for
>>> commit graph traversal operations like `git log --graph`[2].
>>>
>>> One possible improvement that can make Git even faster is using min-post
>>> intervals labelling.  The basis of this labelling is post-visit order of
>>> a depth-first search traversal tree of a commit graph, let's call it
>>> 'post(v)'.
So post(v) is the (increasing) number for the visited commits, starting
with 1 at the initial branch tip (not root!), as the graph is traversed,
depth first, with backtracking to the most recent commit that still has
unvisited parents when either the root commit, or an already visited
commit is found. (phew, that took a lot of words;-)

e.g. (with 'a' as a branch tip)

a - b - c - d - e - f - g
         \m/     \w - x/         (m spans c-d;  w-x spans e-g)

potential orderings, based on alternate parental choices.
abcdefgwxm
abcdewxgfm
abcmdefgwx
abcmdewxgf

All 4 orderings are equally valid implementations.(?)
>> This, the post(v) number, may need a bit more explanation for those not
>> familiar with graph theory terminology, so that they can get up to speed
>> easily about the method, and it's (hopeful) simplicity.
> All right, I see that it might be not clear for someone who is not
> familiar with graph theory terminology.  The post(v) order is the order
> you encounter commits, assuming that you mark commit 'v' as visited
> after all its parents have been visited.

The 'all' can be misunderstood as meaning 'skip' a commit if it has
multiple parents, until the last visit. I don't think that's what is
meant. (or is it?)

>
> The positive-cut labeling works also for pre(v) order, where we number
> commits from top, starting from heads, marking commit 'v' as visited
> before any of its parents (you just need to switch from min-post to
> pre-max interval).
I'm not sure I understood that. Is this the same as my comment above.

>
>>  It isn't clear to me if it is a count along a single string-of-pearls
>> between two branch - merge points, or depth from origin, or whether it
>> can span large chunks of the DAG? Ref 3. has the same problem of
>> starting from an assumed level of knowledge and understanding that may
>> put of non-academics (I'm thinking that the proposed method is this
>> PReaCH [3]).
> The basic method is something simpler, common to all those methods.
> It is described as
> - method from "3.3 Pruning Based on DFS Numbering" in PReaCH[3] paper
>   (only one of full intervals from Figure 3 there), with modifications
> - method from "Interval Indexing" paragraph in "I. Introduction"
>   in FERRARI[4] paper, but using only a single interval (strict or
>   approximate)
> - Fig. 4 Min-Post Labeling, in "GRAIL: A Scalable Index for Reachability
>   Queries in Very Large Graphs" (2012) paper
> - "3.4.1 Positive-Cut Filter" subsubsection in "3.4 Optimizations"
>   in FELINE paper i.e. "Reachability Queries in Very Large Graphs:
>   A Fast Refined Online Search Approach" (2014)
>
>> It's my understanding that 'v' is usually 1...n in the literature, but
>> in reality it just means 'unique label' (and ultimately able to be
>> indexed in a data table). In Git we use the object id as the unique
>> label, so the 1..n is just an abstraction/convenience. The other problem
>> that can happen is if the terminologies of Git doesn't quite match those
>> of the descriptions, such as which end is 'root', or being 'mutually
>> reachable' in a directed acyclic graph.
> Yes, when reading various graph papers, I need to translate 'root',
> 'leaf', 'child' from graph-theory terminology to git terminology.
>
> But 'v' being a node (a commit in a commit graph of revisions) is not
> one of them.
I'd agree that 'node' is ok, it's just the available values for 'v' that
can be presumptuous.
(i.e. the academics already labelling v->1..n, that often just happens
to be the order they end up with:: `Given <type of graph> with nodes
1..n, then <some assertions based on n>` The PReaCH paper does that.)

Plus our DAGs are, in a sense, backward (only children know who their
parents are!), so all the counting levels feel wrong (we count edges
from the wrong end)
>
>> The Wikipedia article on contraction hierarchies [6] did give some
>> useful clues for more lay readers.
> Ooops.  Actually in my opinion Reachability Contraction Hierarchies
> (RCH) reachability index from PReaCH[3] paper would not work for Git, as
> it assumes bidirectional BFS search.
>
> I have cited PReaCH[3] paper for its Pruning Based on DFS Numbering
> ideas.
>
>>> If for each commit 'v' we would compute and store in the commit-graph
>>> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
>>> reachable from 'v', let's call the latter 'min_graph(v)', then the
>>> following condition is true:
>>>
>>>   if 'v' can reach 'u', then min_graph(v) <= post(u) <= post(v)
>>>
>>> If for each commit 'v' we would compute and store in the commit-graph
>>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
>>> that were visited during the part of depth-first search that started
>>> from 'v' (which is the minimum of post-order number for subtree of a
>>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
>>> Then the following condition is true:
>>>
>>>   if min_tree(v) <= post(u) <= post(v), then 'v' can reach 'u'
>>>
>>> The task would be to implement computing such labelling (or a more
>>> involved variant of it[3][4]), storing it in commit-graph file, and
>>> using it for speeding up git commands (starting from a single chosen
>>> command) such as:
>>>
>>>  - git merge-base --is-ancestor A B
>>>  - git branch --contains A
>>>  - git tag --contains A
>>>  - git branch --merged A
>>>  - git tag --merged A
>>>  - git merge-base --all A B
>>>  - git log --topo-sort
>>>
>>> References:
>>>
>>> 1. <http://githubengineering.com/counting-objects/>
>>> 2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph-iii-generations/>
>>> 3. <https://arxiv.org/abs/1404.4465>
>>> 4. <https://github.com/steps/Ferrari>
>>>
>>> See also discussion in:
>>>
>>> <https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>  [5]
>> [6] https://en.wikipedia.org/wiki/Contraction_hierarchies
>>
>> [I've been off-list for 2+ ,months, so still catching up]
> Best,
Thanks for the feedback
Philip
