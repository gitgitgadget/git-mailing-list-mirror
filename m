Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D1C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B5420787
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SgXRwRoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgCaWXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:23:32 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:38591 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbgCaWXb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Mar 2020 18:23:31 -0400
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 354BD11C22D1;
        Wed,  1 Apr 2020 01:23:29 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id 0oaTUIxJoo-NSSm9C2j;
        Wed, 01 Apr 2020 01:23:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1585693408;
        bh=A0nnEiUN8AxOvq+61Mn9+r4T/D9LmJ9MEilh2dokjkc=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=SgXRwRoIIuRN1DJhO4ZUQutiIW+Za/GSbs1XBwVojGwnvI+E8yt6kp5BC8LijDBEa
         ak/nU+ZhHf00tZpA0FM+dcc8SGo49j/Qw+ByipqnCJDUATqlq9LgBbWgThTYy8zbjb
         XmIv9CXQe1oIzZJRIaPw31/GlT1MmIPtmLHR9Z6s=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-ac90c725e5c1.qloud-c.yandex.net with HTTP;
        Wed, 01 Apr 2020 01:23:28 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
                 <20200328144023.GB1198080@coredump.intra.peff.net> <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com> <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
Subject: Re: Inefficiency of partial shallow clone vs shallow clone + "old-style" sparse checkout
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 01 Apr 2020 01:23:28 +0300
Message-Id: <4872731585693023@vla5-c5051da8689e.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



01.04.2020, 01:10, "Konstantin Tokarev" <annulen@yandex.ru>:
> 28.03.2020, 19:58, "Derrick Stolee" <stolee@gmail.com>:
>>  On 3/28/2020 10:40 AM, Jeff King wrote:
>>>   On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:
>>>
>>>>   Is it a known thing that addition of --filter=blob:none to workflow
>>>>   with shalow clone (e.g. --depth=1) and following sparse checkout may
>>>>   significantly slow down process and result in much larger .git
>>>>   repository?
>>
>>  In general, I would recommend not using shallow clones in conjunction
>>  with partial clone. The blob:none filter will get you what you really
>>  want from shallow clone without any of the downsides of shallow clone.
>
> Is it really so?
>
> As you can see from my measurements [1], in my case simple shallow clone (1)
> runs faster than simple partial clone (2) and produces slightly smaller .git,
> from which I can infer that (2) downloads some data which is not downloaded
> in (1).

Actually, as I have full git logs for all these cases, there is no need to be guessing:
    (1) downloads 295085 git objects of total size 1.00 GiB
    (2) downloads 1949129 git objects of total size 1.01 GiB
Total sizes are very close, but (2) downloads much more objects, and also it uses
3 passes to download them which leads to less efficient use of network bandwidth.

>
> To be clear, use case which I'm interested right now is checking out sources in
> cloud CI system like GitHub Actions for one shot build. Right now checkout usually
> takes 1-2 minutes and my hope was that someday in the future it would be possible\
> to make it faster.
>
> [1] https://gist.github.com/annulen/835ac561e22bedd7138d13392a7a53be
>
> --
> Regards,
> Konstantin

-- 
Regards,
Konstantin

