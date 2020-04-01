Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6856C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 01:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BE620776
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 01:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OYvuaaiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgDABt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:49:26 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:37718 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731506AbgDABt0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Mar 2020 21:49:26 -0400
Received: from mxback29j.mail.yandex.net (mxback29j.mail.yandex.net [IPv6:2a02:6b8:0:1619::229])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 618A89400E5;
        Wed,  1 Apr 2020 04:49:21 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback29j.mail.yandex.net (mxback/Yandex) with ESMTP id OtWNnQfYIV-nKombW8k;
        Wed, 01 Apr 2020 04:49:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1585705760;
        bh=umnoFZA3wOOr/HYCWwj/X6h3JyMvHU/0ATYdnWKdrqc=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=OYvuaaiz0/HHOKpk0dBxCQI8tF+zKddBa6YIEZVWucaAjegGO/wYhDOC3IvkHR8jD
         4eLHoQU+O+GpcFoKK/rEhSpzOkxQSd9k1tQLmF/RBq80tFaSjata9DmS8SfdfTWRKB
         RJdD9exYBOGtPdqbKHfrg/rQ8tjIGrhtEKN166Z4=
Authentication-Results: mxback29j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva2-5f9649d2845f.qloud-c.yandex.net with HTTP;
        Wed, 01 Apr 2020 04:49:20 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <0bf763ad-5f1d-65e2-bf3a-a4b7d5a7b3e3@gmail.com>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
         <20200328144023.GB1198080@coredump.intra.peff.net>
         <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
         <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
         <4872731585693023@vla5-c5051da8689e.qloud-c.yandex.net> <0bf763ad-5f1d-65e2-bf3a-a4b7d5a7b3e3@gmail.com>
Subject: Re: Inefficiency of partial shallow clone vs shallow clone + "old-style" sparse checkout
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 01 Apr 2020 04:49:20 +0300
Message-Id: <8268671585700012@iva3-58091f505f14.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



01.04.2020, 03:09, "Derrick Stolee" <stolee@gmail.com>:
> On 3/31/2020 6:23 PM, Konstantin Tokarev wrote:
>>  01.04.2020, 01:10, "Konstantin Tokarev" <annulen@yandex.ru>:
>>>  28.03.2020, 19:58, "Derrick Stolee" <stolee@gmail.com>:
>>>>   On 3/28/2020 10:40 AM, Jeff King wrote:
>>>>>    On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:
>>>>>
>>>>>>    Is it a known thing that addition of --filter=blob:none to workflow
>>>>>>    with shalow clone (e.g. --depth=1) and following sparse checkout may
>>>>>>    significantly slow down process and result in much larger .git
>>>>>>    repository?
>>>>
>>>>   In general, I would recommend not using shallow clones in conjunction
>>>>   with partial clone. The blob:none filter will get you what you really
>>>>   want from shallow clone without any of the downsides of shallow clone.
>>>
>>>  Is it really so?
>>>
>>>  As you can see from my measurements [1], in my case simple shallow clone (1)
>>>  runs faster than simple partial clone (2) and produces slightly smaller .git,
>>>  from which I can infer that (2) downloads some data which is not downloaded
>>>  in (1).
>>
>>  Actually, as I have full git logs for all these cases, there is no need to be guessing:
>>      (1) downloads 295085 git objects of total size 1.00 GiB
>>      (2) downloads 1949129 git objects of total size 1.01 GiB
>
> It is worth pointing out that these sizes are very close. The number of objects
> may be part of why the timing is so different as the client needs to parse all
> deltas to verify the object contents.
>
> Re-running the test with GIT_TRACE2_PERF=1 might reveal some interesting info
> about which regions are slower than others.

Here are trace results for (1) with fix discussed below:
https://gist.github.com/annulen/58b868e35e992105e7028946a8370795

Here are trace results for (2) with fix discussed below:
https://gist.github.com/annulen/fa1ef1b5d1056e6dede815e9ebf85c03

>
>>  Total sizes are very close, but (2) downloads much more objects, and also it uses
>>  3 passes to download them which leads to less efficient use of network bandwidth.
>
> Three passes, being:
>
> 1. Download commits and trees.
> 2. Initialize sparse-checkout with blobs at root.
> 3. Expand sparse-checkout.
>
> Is that right? You could group 1 & 2 by setting your sparse-checkout patterns
> before initializing a checkout (if you clone with --no-checkout). Your link
> says you did this:
>
>         git clone <mode> --no-checkout <url> <dir>
>         git sparse-checkout init
>         git sparse-checkout set '/*' '!LayoutTests'
>
> Try doing it this way instead:
>
>         git clone <mode> --no-checkout <url> <dir>
>         git config core.sparseCheckout true
>         git sparse-checkout set '/*' '!LayoutTests'
>
> By doing it this way, you skip the step where the 'init' subcommand looks
> for all blobs at root and does a network call for them. Should remove some
> overhead.

Thanks, that helped. Now git downloads object only two times.

From reading man page I assumed that `git sparse-checkout init` should do
the same as `git config core.sparseCheckout true`, unless `--cone` argument
is specified.

>
> Less efficient use of network bandwidth is one thing, but shallow clones are
> also more CPU-intensive with the "counting objects" phase on the server. Your
> link shares the following end-to-end timings:
>
> * Shallow-clone: 234s
> * Partial clone: 286s
> * Both(???): 1023s
>
> The data implies that by asking for both you actually got a full clone (4.1 GB).

No, this is still a partial clone, full clone takes more than 6 GB

>
> The 234s to 286s difference is meaningful. Almost a minute.
>
>>>  To be clear, use case which I'm interested right now is checking out sources in
>>>  cloud CI system like GitHub Actions for one shot build. Right now checkout usually
>>>  takes 1-2 minutes and my hope was that someday in the future it would be possible\
>>>  to make it faster.
>
> As long as you delete the shallow clone every time, then you also remove the
> downsides of a shallow clone related to a later fetch or attempts to push.
>
> If possible, a repo this size would benefit from persistent build agents that
> you control. They can keep a copy of the repo around and do incremental fetches
> that are much faster. It's a larger investment to run your own build lab, though.
> But sometimes making builds faster is expensive. It depends on how "expensive" those
> four minute clones per build are in terms of your team waiting.

No, current checkout times for shallow clone + sparseCheckout are quite acceptable.
(FWIW, initially I used shallow clone without sparseCheckout, as the latter is not supported
by GitHub Actions out of the box, and those times were NOT acceptable, as depending on
server load checkout could take 16 minutes or even more)

For now it's just my curioisty and desire to provide info which could make Git better.
It just seemed logical to me initially that if we limit both required paths in worktree and history
depth on object download stage, it should be more efficient than limiting only  history depth
(or, at least, have the same efficiency).

BTW, I did more measurements and results seem to be highly dependent on server side.
Once partial clone (2) even worked faster than shallow clone + sparseCheckout (1). Still, most of
the time (1) is faster than (2).

-- 
Regards,
Konstantin

