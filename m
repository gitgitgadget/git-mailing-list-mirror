Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F31B20954
	for <e@80x24.org>; Fri,  1 Dec 2017 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdLARXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 12:23:47 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61474 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdLARXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 12:23:45 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ypLhw24h5z5tlG;
        Fri,  1 Dec 2017 18:23:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C1EDC211E;
        Fri,  1 Dec 2017 18:23:43 +0100 (CET)
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
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
Date:   Fri, 1 Dec 2017 18:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.2017 um 00:10 schrieb Igor Djordjevic:
> On 29/11/2017 20:11, Johannes Sixt wrote:
>> With git-post, I make a fixup commit commit on the integration
>> branch, then `git post B && git merge B`:
>>
>>   ...A    ...C                  <- topics A, C
>>       \       \
>>     ---o---o---o---o---f---F    <- integration
>>           /       /       /
>>       ...B    ...D       /      <- topic D
>>           \             /
>>            f'----------'        <- topic B
>>
>> The merge F does not introduce any changes on the integration branch,
>> so I do not need it, but it helps keep topic B off radar when I ask
>> `git branch --no-merged` later.
> 
> But you`re not committing (posting) on your HEAD`s (direct) parent in
> the first place (topic B), so `commit --onto-parent` isn`t right tool
> for the job... yet :)

Ohh..kay.

> To work with `--onto-parent` and be able to commit on top of any of
> the topic branches, you would need a situation like this instead:
> 
>   (1)  ...C      <- topic C
>           |
>      ...A |      <- topic A
>          \|
>        ...o I    <- integration
>          /|
>      ...B |      <- topic B
>           |
>        ...D      <- topic D

This is a very, VERY exotic workflow, I would say. How would you 
construct commit I when three or more topics have conflicts? 
merge-octopus does not support this use-case.

> With `commit --onto-parent` you would skip `git post B && git merge
> B` steps, where "fixup commit" would be done with `--onto-parent B`,
> So you end up in situation like this:
> 
>   (2)      ...C      <- topic C
>               |
>          ...A |      <- topic A
>              \|
>            ...o I'   <- integration
>              /|
>      ...B---f |      <- topic B
>               |
>            ...D      <- topic D
> 
> State of index and working tree files in your F and my I' commit is
> exactly the same (I' = I + f), where in my case (2) history looks
> like "f" was part of topic B from the start, before integration
> merge happened.
> 
> BUT, all this said, I understand that your starting position, where
> not all topic branches are merged at the same time (possibly to keep
> conflict resolution sane), is probably more often to be encountered
> in real-life work... and as existing `--onto-parent` machinery should
> be able to support it already, I`m looking forward to make it happen :)
> 
> Once there, starting from your initial position:
> 
>>     ...A    ...C            <- topics A, C
>>         \       \ E
>>       ---o---o---o---o I    <- integration <- HEAD
>>             /       /
>>         ...B    ...D        <- topics B, D
> 
> ... and doing something like `git commit --onto B --merge` would yield:
>   
>   (3) ...A    ...C            <- topics A, C
>           \       \ E
>         ---o---o---o---o I'   <- integration
>               /       /|
>           ...B    ...D |      <- topic D
>               \        |
>                f-------'      <- topic B
> 
> ... where (I' = I + f) is still true.

I am not used to this picture. I would not think that it is totally 
unacceptable, but it still has a hmm-factor.

> If that`s preferred in some
> cases, it could even look like this instead:
> 
>   (4) ...A    ...C             <- topics A, C
>           \       \ E  I
>         ---o---o---o---o---F   <- integration
>               /       /   /
>           ...B    ...D   /     <- topic D
>               \         /
>                f-------'       <- topic B
> 
> ... where F(4) = I'(3), so similar situation, just that we don`t
> discard I but post F on top of it.

This is very acceptable.

Nevertheless, IMO, it is not the task of git-commit to re-compute a 
merge commit. It would be OK that it commits changes on top of a branch 
that is not checked out. Perhaps it would even be OK to remove the 
change from the current workspace (index and worktree), because it will 
return in the form of a merge later, but producing that merge is 
certainly not the task of git-commit.

-- Hannes
