Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760E720286
	for <e@80x24.org>; Fri, 15 Sep 2017 09:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdIOJ7J (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 05:59:09 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10269 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOJ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 05:59:08 -0400
Received: from [192.168.2.201] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id snOqd8GGo3CyHsnOrdWLma; Fri, 15 Sep 2017 10:59:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1505469546; bh=bBBCaJH+8GuWG2Drcv0AsIRCfWNX2TFENpjXmwADgGU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YBrqFfMXrejQjwWAdULep9uOfa21p7hKj5/nl62MQ3upa6a9F0HQx43Yb+MS34gK0
         Ost0k7OjyZVljt+15W7OMUXAbEJgwkINRxL5Q6yh7OwxVcsTF5pqw6IueEDp76+F7g
         vOQvL2cxQRCQTVH3UMM8VpTqTnhRKOkYzOA4EdKE=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=igRvKs3pAAAA:8
 a=X23Nkwdfs1xJaiFApU8A:9 a=QEXdDO2ut3YA:10 a=TvETph7qJS3LYjDAKe5U:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
To:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
 <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
 <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2fe2aae7-49cf-6ad5-1635-bdeab6e60b99@talktalk.net>
Date:   Fri, 15 Sep 2017 10:59:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKLAobElcrOeXINP3Lab/dJlGeB1xIfZAgIJ5fM/WucdmJOi+vwt1ZXsfD1CCTveiP3WO8AHgBojFv5FI2Fy2dtw3eJ96jMJuKmS45MGHHP8gWCr5/hb
 KdeU7y6KftdGrqb90DACzTNtdIBTPPIP9MGzXY1yiNqGT8qompEFwKCoNvPDu/ID7NzkxUu69QLNf+4Ze44KkLHGJrn5K2FlWDGwQ+IC2OG0MspY9TBMlzwH
 8wJdtu2oWJIv1AreTmZAoU80Hq0DEYrY4MPo2eoviDb1rj4vJDS1NsSqQ2F9QRYP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/17 03:48, Junio C Hamano wrote:
> 
> Michael J Gruber <git@grubix.eu> writes:
> 
>> In fact, per documentation "--fork-point" looks at the reflog in
>> addition to doing the usual walk from the tip. The original design
>> description in d96855ff51 ("merge-base: teach "--fork-point" mode",
>> 2013-10-23) describes this as computing from a virtual merge-base of all
>> the historical tips of refname. They may or may not all be present in
>> the reflog (think pruning, non-ff fetching, fast forwarding etc.),
>> so filtering by the current contents of the reflog is potentially
>> harmful, and it does not seem to fulfill any purpose in the original
>> design.
> 
> Let me think aloud, using the picture from the log message from that
> commit.
> 
>                          o---B1
>                         /
>         ---o---o---B2--o---o---o---Base
>                 \
>                  B3
>                   \
>                    Derived
>     
>     where the current tip of the "base" branch is at Base, but earlier
>     fetch observed that its tip used to be B3 and then B2 and then B1
>     before getting to the current commit, and the branch being rebased
>     on top of the latest "base" is based on commit B3.
> 
> So the logic tries to find a merge base between "Derived" and a
> virtual merge commit across Base, B1, B2 and B3.  And it finds B3.


Thanks for this explanation, I've never been sure exactly what
--fork-point did, after reading this I think I understand it.

> If for some reason we didn't have B3 in the reflog, then wouldn't
> the merge base computation between Derived and a virtual merge
> commit across Base, B2 and B2 (but not B3 because we no longer know
> about it due to its lack in the reflog) find 'o' that is the parent
> of B2 and B3?  Wouldn't that lead to both B3 and Derived replayed
> when the user of the fork-point potion rebases the history of
> Derived?
> 
> Perhaps that is the best we could do with a pruned reflog that lacks
> B3, but if that is the case, I wonder if it may be better to fail
> the request saying that we cannot find the fork-point (because,
> well, your reflog no longer has sufficient information), than
> silently give a wrong result, and in this case, we can tell between
> a correct result (i.e. the merge base is one of the commits we still
> know was at the tip) and a wrong one (i.e. the merge base is not any
> of the commits in the reflog).
> 
> If we declare --fork-point is the best effort option and may give an
> answer that is not better than without the option, then I think this
> patch is OK, but that diminishes the value of the option as a
> building block, I am afraid.

I'd tend to agree with you that it would be better to fail rather than
give a best effort. I've got a script that I use to sync the branch I'm
working on between my desktop and laptop. When it pulls it checks the
local head and the compares it to the remote head before pulling. If
they match then it does 'git reset --hard $new_remote', if the local
head is descended from the old remote head then it does 'git rebase
--onto $new_remote $old_remote', otherwise it refuses to update the
local head. If I've understood --fork-point correctly then I could use
'git rebase --fork-point $remote_branch' if it failed when it couldn't
find a merge base in the reflog of the remote branch.

> 
> Callers that are more careful could ask merge-base with --fork-point
> (and happily use it knowing that the result is indeed a commit that
> used to be at the tip), or fall back to the result merge-base
> without --fork-point gives (because you could do no better) and deal
> with duplicates that may happen due to the imprecise determination.
> With this change, these callers will get result from a call to
> "merge-base --fork-point" that may or may not be definite, and they
> cannot tell.  For lazy users, making the option itself to fall back
> may be simpler to use, and certainly is a valid stance to take when
> implementing a convenience option to a Porcelain command, but I do
> not know if it is a good idea to throw "merge-base --fork-point"
> into that category.
> 

Best Wishes

Phillip
