Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D0C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A620679
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 14:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgCPOrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:47:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13398 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbgCPOrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 10:47:39 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jDr1i-0009Vk-DI; Mon, 16 Mar 2020 14:47:34 +0000
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
 <076acb45-5360-6ee4-7c65-907488300ef3@iee.email> <86k13l722n.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b391e9e4-fdff-a2ee-df62-80f9adb9ff0f@iee.email>
Date:   Mon, 16 Mar 2020 14:47:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <86k13l722n.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,
Thanks for the explanations. Some comments in line.
On 15/03/2020 21:14, Jakub Narebski wrote:
> Hello, Philip
>
> Thank you for your continued interest in this topic.
>
> Philip Oakley <philipoakley@iee.email> writes:
>> On 13/03/2020 14:34, Jakub Narebski wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>> On 10/03/2020 14:50, Jakub Narebski wrote:
>>> [...]
>>>>> ### Graph labelling for speeding up git commands
>>>>>
>>>>>  - Language: C
>>>>>  - Difficulty: hard / difficult
>>>>>  - Possible mentors: Jakub Narębski
>>>>>
>>>>> Git uses various clever methods for making operations on very large
>>>>> repositories faster, from bitmap indices for git-fetch[1], to generation
>>>>> numbers (also known as topological levels) in the commit-graph file for
>>>>> commit graph traversal operations like `git log --graph`[2].
>>>>>
>>>>> One possible improvement that can make Git even faster is using min-post
>>>>> intervals labelling.  The basis of this labelling is post-visit order of
>>>>> a depth-first search traversal tree of a commit graph, let's call it
>>>>> 'post(v)'.
>> So post(v) is the (increasing) number for the visited commits, starting
>> with 1 at the initial branch tip (not root!), as the graph is traversed,
>> depth first, with backtracking to the most recent commit that still has
>> unvisited parents when either the root commit, or an already visited
>> commit is found. (phew, that took a lot of words;-)
> No, if we start at branch tip (source node), and number in the order of
> visiting during DFS traversal, with node numbered _before_ its out
> neighbours (parents in Git terms), that would be pre(v) numbering.
So I've described pre(v) numbering.
>
> For post(v) you number nodes (commits) in the order of backtracking,
> that is with 1 at some parentless root commit, not 1 at some branch
> tip.  This can be done e.g. during computing of generation numbers.
I didn't easily understand the wording.
>
> An example of such post(v) labeling can be found on slides 57-58/64 and
> 59/64 in v1.1 version of my slides:
>   https://drive.google.com/open?id=1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK
Ah, I had an older version (picked up from the other thread) that only
had 60 slides (84 pdf pages). I had got all the way to the end.
I've have a better read of that.

>> e.g. (with 'a' as a branch tip)
>>
>> a - b - c - d - e - f - g
>>          \m/     \w - x/         (m spans c-d;  w-x spans e-g)
> We usually order commits left-to-right, or bottom-to-top, with most
> recent commits and branch tips respectively on the far right, or on the
> top.  This is the reverse notation.
True. It was for the convenience of following the Git DAG linkage. It's
easy to make mistakes with right to left reading, especially for those
who aren't yet sure what they are looking at.
>
>> potential orderings, based on alternate parental choices.
>>
>> abcdefgwxm
>> abcdewxgfm
>> abcmdefgwx
>> abcmdewxgf
>>
>> All 4 orderings are equally valid implementations.(?)
> Yes, this is true.  There are various heuristics to select the best
> ordering, but as most of those require additional work to be done
> upfront (e.g. computing in-degrees, or topological sort, or generation
> numbers i.e. topological levels), we can start with simple rule: walk
> the graph in parents order.
Thanks for confirming.
>>>> This, the post(v) number, may need a bit more explanation for those not
>>>> familiar with graph theory terminology, so that they can get up to speed
>>>> easily about the method, and it's (hopeful) simplicity.
>>>>
>>> All right, I see that it might be not clear for someone who is not
>>> familiar with graph theory terminology.  The post(v) order is the order
>>> you encounter commits, assuming that you mark commit 'v' as visited
>>> after all its parents have been visited.
>> The 'all' can be misunderstood as meaning 'skip' a commit if it has
>> multiple parents, until the last visit. I don't think that's what is
>> meant. (or is it?)
> During the depth-first search (DFS) traversal of the commit graph we
> walk all reachable commits.  What I meant here is that the node (commit)
> gets it post(v) number only after all of its parents have been visited,
> and we backtracked to this commit.
>
> Again, I will refer to the frame 59/64 in v1.1 version of my slides:
>   https://drive.google.com/open?id=1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK
>
>>> The positive-cut labeling works also for pre(v) order, where we number
>>> commits from top, starting from heads, marking commit 'v' as visited
>>> before any of its parents (you just need to switch from min-post to
>>> pre-max interval).
>>>
>> I'm not sure I understood that. Is this the same as my comment above.
> What I wanted to say here, is that if you label commits with pre(v)
> number, that is number them in the order of visiting, commit before its
> parents, then we can use pre-max interval instead.  The interval would
> be [pre(v), max_{p \in parents(v)} pre(p)], and the positive-cut filter
> would work the same: if one interval is contained in the other, then
> there is path from one commit to the other.
>
>>>>  It isn't clear to me if it is a count along a single string-of-pearls
>>>> between two branch - merge points, or depth from origin, or whether it
>>>> can span large chunks of the DAG? Ref 3. has the same problem of
>>>> starting from an assumed level of knowledge and understanding that may
>>>> put of non-academics (I'm thinking that the proposed method is this
>>>> PReaCH [3]).
>>> The basic method is something simpler, common to all those methods.
>>> It is described as
>>> - method from "3.3 Pruning Based on DFS Numbering" in PReaCH[3] paper
>>>   (only one of full intervals from Figure 3 there), with modifications
>>> - method from "Interval Indexing" paragraph in "I. Introduction"
>>>   in FERRARI[4] paper, but using only a single interval (strict or
>>>   approximate)
>>> - Fig. 4 Min-Post Labeling, in "GRAIL: A Scalable Index for Reachability
>>>   Queries in Very Large Graphs" (2012) paper
>>> - "3.4.1 Positive-Cut Filter" subsubsection in "3.4 Optimizations"
>>>   in FELINE paper i.e. "Reachability Queries in Very Large Graphs:
>>>   A Fast Refined Online Search Approach" (2014)
>>>
>>>> It's my understanding that 'v' is usually 1...n in the literature, but
>>>> in reality it just means 'unique label' (and ultimately able to be
>>>> indexed in a data table). In Git we use the object id as the unique
>>>> label, so the 1..n is just an abstraction/convenience. The other problem
>>>> that can happen is if the terminologies of Git doesn't quite match those
>>>> of the descriptions, such as which end is 'root', or being 'mutually
>>>> reachable' in a directed acyclic graph.
>>> Yes, when reading various graph papers, I need to translate 'root',
>>> 'leaf', 'child' from graph-theory terminology to git terminology.
>>>
>>> But 'v' being a node (a commit in a commit graph of revisions) is not
>>> one of them.
>> I'd agree that 'node' is ok, it's just the available values for 'v' that
>> can be presumptuous.
>> (i.e. the academics already labelling v->1..n, that often just happens
>> to be the order they end up with:: `Given <type of graph> with nodes
>> 1..n, then <some assertions based on n>` The PReaCH paper does that.)
> No, in academics paper usually define graph as a set of vertices V and
> set of edges E.  Numbering vertices (nodes) is something extra.
Usually it is mid paper where they do this about some property of an
order (or at least _appear_ to do). I think they omit the "given an
order" in f->1.n with (order) properties x,y,z, then we see p,q,r
properties.
>> Plus our DAGs are, in a sense, backward (only children know who their
>> parents are!), so all the counting levels feel wrong (we count edges
>> from the wrong end)
> No, our DAGs are not backward, only our terminology is different.
> On the other hand we cannot assume that we can get reverse graph
> easily (many graph reachability algorithms do assume that).
>
>   graph theory        |  git documentation     |  meaning
>   ------------------------------------------------------------------
>   roots               |  branch tips, heads    |  no incoming edges
>   leaves              |  root commits          |  no outgoing edges
>   children            |  parents               |  [out] neighbours
Yes, I was surprised at the root-tip-root swap. It's a bit of a
pushmi-pullyu type of animal, but backwards;-).

> Best,
Thanks. Back to reading the updated slide deck
