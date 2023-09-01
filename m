Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504ECA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 17:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348541AbjIAROF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 Sep 2023 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjIAROE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 13:14:04 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8961703
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 10:13:47 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 07BEF29E64;
        Fri,  1 Sep 2023 19:13:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 730072A0CC;
        Fri,  1 Sep 2023 19:13:44 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xU0ClsVlbXBj; Fri,  1 Sep 2023 19:13:44 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 26DBF29D77;
        Fri,  1 Sep 2023 19:13:40 +0200 (CEST)
Message-ID: <a168fe69-f305-4280-b0e6-9406fbac796f@opperschaap.net>
Date:   Fri, 1 Sep 2023 13:13:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without
 a forkpoint
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20230819203528.562156-1-wesleys@opperschaap.net>
 <20230819203528.562156-2-wesleys@opperschaap.net>
 <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=CYgsSoeuAAAA:8
        a=GZCdG0GqVlVF3VdQSh8A:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
        a=68G3qwCGnWmdVc7y5XIm:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello Phillip,


On 9/1/23 09:19, Phillip Wood wrote:
> Hi Wesley
> 
> On 19/08/2023 21:34, Wesley Schwengle wrote:
>> When commit d1e894c6d7 (Document `rebase.forkpoint` in rebase man page,
>> 2021-09-16) was submitted there was a discussion on if the forkpoint
>> behaviour of `git rebase' was sane. In my experience this wasn't sane.
>> Git rebase doesn't work if you don't have an upstream branch configured
>> (or something that says `merge = refs/heads/master' in the git config).
>> The behaviour of `git rebase' was that if you supply an upstream on the
>> command line that it behaves as if `--no-forkpoint' was supplied and if
>> you don't supply an upstream, it behaves as if `--forkpoint' was
>> supplied. This can result in a loss of commits if you don't know that
>> and if you don't know about `git reflog' or have other copies of your
>> changes. This can be seen with the following reproduction path:
>>
>>      mkdir reproduction
>>      cd reproduction
>>      git init .
>>      echo "commit a" > file.txt
>>      git add file.txt
>>      git commit -m "First commit" file.txt
>>      echo "commit b" >> file.txt
>>      git commit -m "Second commit" file.txt
>>
>>      git switch -c foo
>>      echo "commit c" >> file.txt"
>>      git commit -m "Third commit" file.txt
>>      git branch --set-upstream-to=master
>>
>>      git status
>>      On branch foo
>>      Your branch is ahead of 'master' by 1 commit.
>>
>>      git switch master
>>      git merge foo
> 
> Here "git merge" fast-forwards I think, if instead it created a merge 
> commit there would be no problem as the tip of branch "foo" would not 
> end up in master's reflog.

If you do

git merge foo --no-ff
git reset --hard HEAD^
git switch foo
git rebase

You'll end up with just the commits that are in master. You'll lose all 
commits from foo.

>>      git log --format='%C(yellow)%h%Creset %Cgreen%s%Creset'
> 
> For a reproduction recipe I think "git log --oneline" would suffice.

Will update, thanks.

 >> [snip]
> 
> Thanks for the detailed reproduction recipe, I think it would be helpful 
> to summarize what's happening in the commit message, especially as it 
> seems to depend on "git merge" fast-forwarding. Do you often merge a 
> branch into it's upstream and then reset the upstream branch?

Tricky question. When I encountered this behavior I was working on an 
epic/topic branch that I had locally. And I made a commit that I thought 
should have been in another branch. I moved the commit to another branch 
and than later on rebased it.

I didn't reply to Juno yet, but he refers to the discussion about 
--fork-point and --root command line options. This discussion links to a 
blogpost [*1*] where the same behavior is experienced.

The quirk is this: --fork-point looks at the reflog and reflog is local. 
Meaning, having an remote upstream branch will make --fork-point a noop. 
Only where you have an upstream which is local and your reflog has seen 
dropped commits it does something. In all other cases (including 
supplying the upstream) it behaves as if --no-fork-point was set. If you 
do the same action in two different clones, you get a different result, 
depending on what is in your reflog. I find this very tricky behavior 
for a default. I've set it to false myself, to get a more consistent 
behavior.

I usually have a remote upstream (gitlab/github) and work with that, so 
the --fork-point behaviour isn't present because there is no reflog for 
that, so it behaves as --no-fork-point.

Cheers,
Wesley


[1]: https://commaok.xyz/post/fork-point/
-- 
Wesley

Why not both?

