Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EB220C11
	for <e@80x24.org>; Mon, 27 Nov 2017 21:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbdK0VyH (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 16:54:07 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:37915 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbdK0VyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 16:54:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ym0tg54tsz5tlB;
        Mon, 27 Nov 2017 22:54:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 32F7A29D8;
        Mon, 27 Nov 2017 22:54:03 +0100 (CET)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org, Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
Date:   Mon, 27 Nov 2017 22:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.2017 um 23:35 schrieb Igor Djordjevic:
> Approach discussed here could have a few more useful applications,
> but one seems to be standing out the most - in case where multiple
> topic branches are temporarily merged for integration testing, it
> could be very useful to be able to post "hotfix" commits to merged
> branches directly, _without actually switching to them_ (and thus
> without touching working tree files), and still keeping everything
> merged, in one go.
> 
> Example starting point is "master" branch with 3 topic branches (A,
> B, C), to be (throwaway) merged for integration testing inside
> temporary "test" branch:
> 
> (1)        o---o---A (topicA)
>            /
>           /
>          /
>      ---o---o---M (master, test, HEAD)
>          \   \
>           \   o---B (topicB)
>            \
>             o---o---C (topicC)
> 
> 
> This is what we end up with once "master" and topic branches are
> merged in merge commit M1 inside temporary "test" branch for further
> integration testing:
> 
> (2)        o---o---A (topicA)
>            /         \
>           /           M1 (test, HEAD)
>          /           /||
>      ---o---o---M---/ || (master)
>          \   \       / |
>           \   o---B-/  | (topicB)
>            \           |
>             o---o---C--/ (topicC)
> 
> 
> Upon discovery of a fix needed inside "topicA", hotfix changes X
> should be committed to "topicA" branch and re-merged inside merge
> commit M2 on temporary integration "test" branch (previous temporary
> merge commit M1 is thrown away as uninteresting):
> 
> (3)        o---o---A---X (topicA)
>            /             \
>           /               M2 (test, HEAD)
>          /               /||
>      ---o---o---M-------/ || (master)
>          \   \           / |
>           \   o---B-----/  | (topicB)
>            \              /
>             o---o---C----/ (topicC)

I my opinion, putting the focus on integration merge commits and the 
desire to automate the re-merge step brings in a LOT of complexity in 
the implementation for a very specific use-case that does not 
necessarily help other cases.

For example, in my daily work, I have encountered situations where, 
while working on one topic, I made a hot-fix for a different topic. 
There is no demand for a merge step in this scenario.

In your scenario above, it would certainly not be too bad if you forgo 
the automatic merge and have the user issue a merge command manually. 
The resulting history could look like this:

(3)         o---o---A---X    (topicA)
            /         \   \
           /           M1--M2 (test, HEAD)
          /           /||
      ---o---o---M---' ||     (master)
          \   \       / |
           \   o-----B /      (topicB)
            \         /
             o---o---C        (topicC)

I.e., commit --onto-parent A produced commit X, but M2 was then a 
regular manual merge. (Of course, I am assuming that the merge commits 
are dispensible, and only the resulting tree is of interest.)

Moreover, you seem to assume that an integration branch is an octopus 
merge, that can be re-created easily. I would say that this a very, very 
exceptional situation.

----

At this point, I spent five minutes thinking of how I would use commit 
--onto-parent if I did not have git-post.

While on the integration branch, I typically make separate commits for 
each fix, mostly because the bugs are discovered and fixed not 
simultaneously, but over time. So, I have a small number of commits that 
I distribute later using my git-post script. But that does not have to 
be so. I think I could work with a git commit --onto-parent feature as 
long as it does not attempt to make a merge commit for me. (I would hate 
that.)

Sometimes, however I have two bug fixes in the worktree, ready to be 
committed. Then the ability to pass pathspec to git commit is useful. 
Does your implementation support this use case (partially staged 
worktree changes)?

Thanks,
-- Hannes
