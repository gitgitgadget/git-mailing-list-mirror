Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D716C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA3B6127A
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhIPMJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:09:01 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:35502 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238955AbhIPMJB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 08:09:01 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 6C3B72851E;
        Thu, 16 Sep 2021 14:07:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 9D51A284BD;
        Thu, 16 Sep 2021 14:07:38 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PXhZOChyfLj5; Thu, 16 Sep 2021 14:07:38 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 0E46E28608;
        Thu, 16 Sep 2021 14:07:36 +0200 (CEST)
Subject: Re: Possible git bug
To:     Taylor Blau <me@ttaylorr.com>
References: <30651e4d-10fb-8bc7-7f52-8fbabf042f4a@schwengle.net>
 <YULYG970Ltnbshdn@nand.local>
From:   Wesley Schwengle <wesley@schwengle.net>
Cc:     git@vger.kernel.org
Message-ID: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
Date:   Thu, 16 Sep 2021 08:07:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YULYG970Ltnbshdn@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8
        a=0pbIWWURZXMnv18uIVoA:9 a=QEXdDO2ut3YA:10 a=5NxO59_FqQjEf5CpAN6O:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/21 1:37 AM, Taylor Blau wrote:

> FWIW, I had to tweak this script a little, since file.txt is untracked
> before it is added initially. (So a "git add file.txt" before this first
> commit is required.)

Oh sorry! I overlooked that part.

> But even after this, I got exactly what I expected from this script
> (which was that your "foo" branch had three commits before and after).
> Is there something else interesting going on with your setup that might
> explain why I can't reproduce this?

Oh, I found it.. Replace `git rebase master' with `git rebase' in the 
reproduction path.

Disregard my post, it seems this is documented behavior in the rebase 
man-page. When you have an upstream configured and you don't specify it 
on the command line, --fork-point is used, while if you specify the 
upstream --no-fork-point is used. `git rebase master --fork-point' 
exhibits the same as I was seeing. Although I'm now completely confused 
by this behavior. It doesn't make sense to me.

This happens:

We are on a branch, we merge it into another branch.
We undo the merge because reasons.
Now we git rebase, without the upstream, because we've set it.
Fork-point is used now, because we haven't specified an upstream, but we 
did set it and git merge-base decides, oh, we had those commits in 
master but these where dropped so we drop them in this branch as well.

New question, is there a way to tell rebase to NOT use fork-point via 
git-config in this situation?

Cheers,
Wesley

-- 
Wesley Schwengle
E: wesley@schwengle.net
