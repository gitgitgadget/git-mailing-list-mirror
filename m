Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD6C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 18:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EAB60F13
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 18:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhGYR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 13:58:54 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:26853 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhGYR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 13:58:53 -0400
Received: from [87.152.157.21] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m7izx-0006yc-GA
        for git@vger.kernel.org; Sun, 25 Jul 2021 20:37:13 +0200
Subject: Re: Files modified, even after: git reset --hard
From:   Martin <git@mfriebe.de>
To:     git@vger.kernel.org
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
Message-ID: <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
Date:   Sun, 25 Jul 2021 20:39:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/2021 19:48, Martin wrote:
>
> Actually, git replace has a weird effect.
>
> so I have "commit A" introducing the problem. Then many commits until 
> "commit Y" fixing it.
>
> If I do
> switch -f --detach A
> git add --renormalize the_file
> git commit -m foo
> git show   // get the new blob for the file
> git show A  // get the old blob for the file
> git replace  old_blob  new_blob
>
> switch -f --detach A
>
> Then "the_file" is still shown as modified.
> Only
>   git diff the_file
> now returns empty
> (where as before it returned the entire file)
>
> On the plus side
>   switch -f --detach B
> has the same change, still modified, but no diff.
> So one replace would solve the entire 1000 commits that are currently 
> affected
>
> Any idea, what causes the "modified" after the replace?
>

Ok, it seem that
   git switch
simple did not update the file.

- After the commit I am on a dangling commit, which is a direct child of 
"A".
- I insert the reprace
- I switch from that dangling to "A"

-> diff is empty
-> but status is not ok

If I now switch to a far away commit. And then switch back to "A". Then 
git status is also ok.



