Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3721F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 17:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeHTU50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:57:26 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:40103 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTU50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:57:26 -0400
Received: from [192.168.2.201] ([92.22.43.193])
        by smtp.talktalk.net with SMTP
        id roAcfrnPKdJAeroAcfaOFN; Mon, 20 Aug 2018 18:40:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534786851;
        bh=vDCJNKu8KWziK7EbEC2lVxewGJG1VTPncQYUO/kutUw=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=aOosBZLojqaw+gqWDKx1DKcpnYkHwOXNQBBDnhdigSxLvU1YATiPFAsiwBofdjD43
         nFGC2fCGJnWFsWxJpVwH5usX8Ar1/iAMqJIFKLISjxTIImV5VwK3Puv9xwsg1/2w08
         KjkDAMETca+2iG8noAN3Tq+wz6jgiZJ6/vjD4Mu8=
X-Originating-IP: [92.22.43.193]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=0uAVYj1wOgJByxYeJIV+0Q==:117
 a=0uAVYj1wOgJByxYeJIV+0Q==:17 a=IkcTkHD0fZMA:10 a=KvNWrlbbb0xIvD0w0PYA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Do not raise conflict when a code in a patch was already added
To:     Konstantin Kharlamov <hi-angel@yandex.ru>, git@vger.kernel.org
References: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ab5021a9-6980-b96c-9d51-cc301844f2af@talktalk.net>
Date:   Mon, 20 Aug 2018 18:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLDK6s4Uf/BSdAj8qkXJTZXXysxWf5eNIcbEHDxdsYIb4KRqjbu9GpqZcnj+eyymzbQxdZeGLXGQv2j75qsnrgFIfBAg4pFzgbGCi5cfCXyiV+Vry1Fd
 bqZRH/1m7flrK1O8AiM+8uzyDg/qNQLPPsj5KlxPTR152Xdi395cuigM2a9ecSA1DkzPRCMxzdFaSYY/LDT/Wzjm/YG8bDP0Vuc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2018 11:22, Konstantin Kharlamov wrote:
> So, steps-to-reproduce below rather full of trivia like setting up a
> repo, but the TL;DR is:
> 
> Upon using `git rebase -i HEAD~1` and then `git add -p` to add part of a
> "hunk" as one commit, and then using `git rebase --continue` so the
> other part of hunk would be left in top commit; git raises a conflict.

I think this is a misleading error message as in your example below
there are no conflicts, just unstaged changes. git-rebase.sh has the
following code


git update-index --ignore-submodules --refresh &&
        git diff-files --quiet --ignore-submodules || {
                echo "$(gettext "You must edit all merge conflicts and then
mark them as resolved using git add")"
                exit 1

I think this pre-dates interactive rebases when the only unstaged
changes could be conflicts.

> 
> It's spectacular, that content of one of inserted conflict markers is
> empty, so all you have to do is to remove the markers, and use `git add`
> on the file, and then `git rebase --continue`
> 
> Its a lot of unncessary actions, git could just figure that the code it
> sees in the patch is already there, being a part of another commit.

If there are conflict markers where one side is empty it means that some
lines from the merge base (which for a rebase is the parent of the
commit being picked) have been deleted on one side and modified on the
other. Git cannot know if you want to use the deleted version or the
modified version. You can use 'git diff --cc' to see the combined diff
which should show the lines being deleted on both sides and an addition
on the side with the modified lines. You can also set the
merge.conflictStyle config variable to diff3 to see the original text as
well as the text from the merge heads.

Best Wishes

Phillip

> 
> Maybe git could issue a warning, or to question a user interactively
> (y/n); but raising a conflict IMO is unnecessary.
> 
> # Steps to reproduce
> 
> In empty dir execute:
> 
>     $ git init
>     $ touch test
>     Initialized empty Git repository in /tmp/test/.git/
>     $ git add test
>     $ git commit
>     [master (root-commit) a7ce543] 1st commit
>      1 file changed, 2 insertions(+)
>      create mode 100644 test
>     $ echo -e "foo\nbar" > test             # content you'll want to break
>     $ git add -u && git commit
>     [detached HEAD 9e28331] 2-nd commit
>      1 file changed, 2 insertions(+)
>     $ git rebase -i --root
>     Stopped at a7ce543...  1st commit
>     You can amend the commit now, with
> 
>       git commit --amend
> 
>     Once you are satisfied with your changes, run
> 
>       git rebase --continue
> 
> Put "edit" for the 2-nd commit
> 
>     $ git reset HEAD^
>     Unstaged changes after reset:
>     M       test
>     $ git add -p
>     diff --git a/test b/test
>     index e69de29..3bd1f0e 100644
>     --- a/test
>     +++ b/test
>     @@ -0,0 +1,2 @@
>     +foo
>     +bar
>     Stage this hunk [y,n,q,a,d,e,?]? e
> 
>     ╭─constantine@constantine-N61Ja  /tmp/test ‹node-›  ‹› (e721fa3*)
>     ╰─$ git commit
>     [detached HEAD 27b2f63] add foo
>      1 file changed, 1 insertion(+)
>     ╭─constantine@constantine-N61Ja  /tmp/test ‹node-›  ‹› (27b2f63*)
>     ╰─$ git rebase --continue
>     test: needs update
>     You must edit all merge conflicts and then
>     mark them as resolved using git add
> 
> What happened is that it's obvious that the hunk was broken to multiple
> commits, and git should figure that out, and not to raise a conflict.
> 
> Side note: for some reason in the test git didn't insert conflict
> markers. It did in real-world usecase though, and there was simply no
> content inside one of them.
> 

