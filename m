Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED8C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEB960E78
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 01:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGZAyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 20:54:00 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:61388 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhGZAx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 20:53:58 -0400
Received: from [87.152.157.21] (helo=[192.168.2.202])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m7pWB-0005xf-A4; Mon, 26 Jul 2021 03:34:55 +0200
Subject: Re: Files modified, even after: git reset --hard
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
From:   Martin <git@mfriebe.de>
Message-ID: <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
Date:   Mon, 26 Jul 2021 03:34:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 02:33, Chris Torek wrote:
> On Sun, Jul 25, 2021 at 11:43 AM Martin <git@mfriebe.de> wrote:
>>>>> [Files show up as every-line-modified]
>>> [and] git replace has a weird effect.
>> Ok, it seem that
>>     git switch
>> simple did not update the file.
> 
...
> Let's suppose, just for convenience for now, that the files in the
> repository right now actually do have CRLF line endings.
> 
> Let's suppose further that you ask that Git ensure that your
> *working tree* copies of each file contain CRLF line endings.
> 
Yes, I accept that decision.
I figured that is the reason why they show modified.

Not a problem. Until I am in the middle of a rebase, and i cannot run 
(after a conflict)
   git rebase --continue

The modified files are not part of the original series of commits. they 
are just random files from somewhere else in the tree.
I can not reset/restore them.
So I must now "git add" files entirely unrelated to continue rebasing.
Well or apparently change my config for the duration of the rebase.


> As for "git replace", you've figured the rest out already: if
> you use git replace to make Git use new, LF-only line ending
> objects (file data), Git is now happy about the internal storage.
> It just takes some shuffling-about to cause these replaced objects
> to wind up in Git's *index* AKA *staging area*.

Actually there is something else.

If a file has line-endings that will change, then
    git add --renormalize .
    git commit -m foo
will commit those files.

But I am now also getting files, that show modified, but that can not be 
committed renormalized (0 lines changed).

And that happens with or without refs/replaces.

Any idea how to find out why git thinks they are modified?
    git status --porcelain=v2
shows that the file mode is not modified. Only the file in the working tree.
But "git diff" shows nothing (no summary neither). And renormalizing has 
no effect.



In fact I started running the following
   git rev-list --reverse main | xargs -L 1 sh -c 'git switch --detach 
-q -f $0 ; a=$( git status -uno --porcelain=v1 ) ; if [ "$a" != "" ]; 
then git log --oneline -n1 $0 ; echo $a; fi '

That is, switch to each revision in main (or master). And check if any 
file is reported modified.

I just tried that on the gdb git. Plenty of files.
Also other repros have shown modified files.
(I have not yet tried the "git sources" git...

If I then manually switch to some of the commits that had modified files 
shown, and I do not switch to all the commits before, then sometimes 
there are no modified files.

git fsck has a few dangling commits
git gc made no difference.

