Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005C8C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF5E60FDA
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhIKRSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:18:20 -0400
Received: from mout.web.de ([212.227.15.4]:36197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRST (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631380612;
        bh=j+Rhtgf2WWWe8j4jHVrgLruzPqx3KOzyUbEG3+VeEqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KvJ3ihmPIiEw5HuZACUieK2aqH8GP5saJOX5grcTwaoBhIB9kcPT0xHCi4LOOI4qf
         dxvTQPdY/6HoZoLj7aInA9xpAvBiv+E9UY0GXe0WpyDdlS7oocpB9JI8075WcALLnC
         BFkv8jCZM4+jVz58IPbEEfAMIjlsMQhb5jVXz920=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M2qsI-1nF8yY07JG-00sgDd; Sat, 11 Sep 2021 19:16:52 +0200
Subject: Re: [PATCH 3/3] packfile: use oidset for bad objects
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
 <YTy8o3qXvyVv8fNr@coredump.intra.peff.net>
 <3d637be1-f89f-414c-19ef-65c3943457e9@web.de>
 <YTzhVfmObOf7DHqm@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <480dba11-e321-68f8-3983-1d918c24fbbc@web.de>
Date:   Sat, 11 Sep 2021 19:16:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTzhVfmObOf7DHqm@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jcybazG1IRnOiTIaU64g9Jc0JUDzei5KbuERkbgwBnoNoFTByLl
 74X60h9L1zd/A04a+PXnyGy7ApRdJXQmzt7PM8cCiuREfT9ys4rYdCRYt+5+tp4I9hMomCo
 J3qTREEdzmSj9sey6qLCFIOI2ZigfIRAyiMbPcvGKJ7aozPqT5iCN8HTPaAxbro9rXJmNHt
 YJzkMEh2at3A74VPUEHkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m1l/WgSgRzM=:9yTqr+mp7Qpf8NuyJxQEuW
 FfdPXRfanAwZIJCVYqNbW+Cs5grF/ymMWaizgWGJFzbocAvccCF4H9S9QUoxtupKTMtaar37i
 /PUF8dvOcOyk2LNq1lnM2zx/9Iyspow2lLxDUQRD0F0RjneKJ1obdY3/QxgMARI4L5SfPlEgv
 XBEoD0MbQlJwO0qoM5ujYF9AFm8Dfs3wY9pvSdyJqGQLJNbYmuwaHH16GHcQUutP5y+UocF3V
 CgzfPJmQoe7G9ATsMuIUu1BJeiUpcKNdF+2zi/u9eU5aR3oz7CHVO6CWO8xFGhKr9E9J47Pxm
 xUChD+x99Sa6rO4IcyTQgj4ejrUkluZa3l34S3aTj7IbCAZgEDl1UIKA1DyCsqQfFd7uGd49T
 1KyH+0ARlZzgoy7Zjw6PlxI0M9Pgjt41PV2Upo150wRRPGpP5atq5IiydRzejzeSvm3tABLcu
 f9v+UN3KYQx5xW2aw65ZpYcXIT72gYy5NrnnEkdAmHjdMVxWlS8biXtdwaL+AUwEPf7gel/Xj
 Qui3+cHsnFarc4YT/v/wmN1lIcSnnAPWITgx2TesZZexuIksVhWFDrTN+AwLvYL7pH2XAoM2J
 N/fc0WNvHh3ZXaQOB71Lhb34b+LUPMFjVeWkL9pWpoGo8Ca0VH3acGuHF8C3qoWmw5GQeMK0s
 h3Xs/Wm6wJoVmKAaLteYqOpTTZ7/SVUEXFOoInTSykRQZehzkNQATcHNsz/bLlpuIX/tynhIn
 uDf/XxxEokJZ5MKlE0I+q2Z4a+8mxKRL/29ro8elCMzGjX6Ze8uL74RGBimZ4nuaZyGZgOs5H
 sf7UODazmYVi9k65rf4kxmJzb6A7ShxYOeNLe2DLoS8tb8PTggFPBok40Fyjq7tsyH+Y3KDmu
 nLqtZtZLq2qXl+Mwz84oDTvzBHSXfRkfeYFO8GFavrmQBK+KZyS0Ut83F/aR/mm1wpj4LLOON
 UWUBCXbrazSTemcmGMRABL09+4ISt/mraNnI3HAXf1k1d3RJ7Fw6Mrs0GOFhBnucBmHVCkP9E
 krk9obxKYoCQm+JdTCQkseqCGDe0cf54C2hspBIPruuuHeqeSv6Ky4lWa4pufUbTElvxrOHMd
 8zMPnlwyPDITe8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 19:03 schrieb Jeff King:
> On Sat, Sep 11, 2021 at 06:08:38PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>>> +	nth_midxed_object_oid(&oid, m, pos);
>>>> +	if (oidset_contains(&p->bad_objects, &oid))
>>>> +		return 0;
>>>
>>> Calling nth_midxed_object_oid() implies a memcpy() under the hood. In
>>> the old code, we'd skip that in the common case that we had no corrupt
>>> objects, but now we'll pay the cost regardless. memcpy() isn't _that_
>>> expensive, but I'd expect this to be a relatively hot code path.
>>>
>>> Is it worth sticking all of this inside:
>>>
>>>   if (oidset_size(&p->bad_objects))
>>>
>>> ?
>>
>> Hard to say.  It would certainly match the old code more closely.  Is a
>> function call cheaper than copying 32 bytes?  Depends on the CPU and
>> whether the hash is cached, I guess.  And cached it probably is, becaus=
e
>> the caller did a binary search for it..
>
> You already have a function call for nth_midxed_object_oid(), so
> checking oidset_size() would be a strict improvement.

If I read the assembly correctly nth_midxed_object_oid() is inlined by the
compiler in my build, as is nth_midxed_pack_entry().  Both are defined in
the same file, so other compilers may easily do the same.

>> We can pass on the original oid to avoid the nth_midxed_object_oid()
>> call, but inlining the whole thing might even be nicer.
>
> Yeah, it occurs to me that oidset_size() would be a good candidate for
> inlining, if that's what you mean.

True, but I meant something else (see patch 4/3). :)

Ren=C3=A9
