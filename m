Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA69CC433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B72F20706
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbhABPc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 10:32:57 -0500
Received: from mout.web.de ([212.227.17.11]:55569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbhABPc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 10:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609601462;
        bh=UnZkaTWru5uaS8oTITtE3LH09dj87tHk2Bz2ijN0FLI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DzorrTpR+A5pRuRXysaf6t5qKpY7aQdE+Tpg+eSbsk97ON9PilCXsBKA3MVpk6Y14
         I1J5rAzk0cZlMM9eIr2/ve3ua4kmxOW1YsNMPoL1Xebk9E3g9N7V1Ib2EEOZqR3TjW
         jj9OXLb/GmFSPC2NqP4OQC9EH+AL3aF0Xhs3wz0o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.159.90]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfOx-1jui2n1vsB-017ARr; Sat, 02
 Jan 2021 16:31:02 +0100
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
 <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <30ddf1bd-b315-a399-3016-dcc4f9d7d3b5@web.de>
Date:   Sat, 2 Jan 2021 16:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f009w5Qm0jnsOXlw4nCFtkKODvDpcQU/c+cIcCP4u9gDAQaLbcE
 MdK/FMLsV2gQKDmjq/gAW4nPZ22aqreS7BTRr41kI9KZuDoy9nZbyizkq0HfN46uhX2m2pT
 aZouu3UUNb4If1pY1I7BBPiuO6xvOmMPii61BA9/iGiBkUVcjvdZVK1XeKnQsAzaAWWJPOe
 8jCG7nObg8tD1VEVgxPZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y607RVYsk+o=:RQP4M0z2lW2B8Pzs01m42m
 7NnJnnN5BvZJfaApR3/ngt60iFtWjMjpRJjoQnSNlgmvhOvoh/T/An7CNM8DbEfdFm2Um3bXC
 FVoCkVbuJtphkI35Fxo5ECqPjNFbtlBc6yszBYt+DaukWvEv8RICfmHAFkSVkXv5NOrL3/XvW
 jWJ0l+TEJdlW/n/e0FrZ4DKNkCm7E/MD4N8lbrBM6/Nmf4yEQbQfV6cnxlH5IloltIZ+WxSsC
 auUnJoevt5XBAKQXGpgXnaQlJAQb4mJ6P2Bvp8I+QPGaIKKAnHR0V95MfDoeJb2HE2jAxPVN9
 jFN0esU9erc8Z2lY5Q0JnumzZwVxc38jk4xVwiZ9PskPjZ5ZvFjoHG+Ds6HTvw/HKM5du+JzK
 5W/ZjFC3+OVm0JHczK3/ELS9BPFnx5IGkHhjo4Xwd7qnQnHq6saG/aJG6O9qskQm0dnecGvyJ
 hUZWwkkkgQtTvXQE8x7agBaaWPCxM4O7k1Ntr/x7CabCCdonAxnSVuDrym4wHwP5AWOTQ2c+f
 ezPVJxcTpvrbEMWx1BbY9Xfy28lmsY4kG1uTiqyKMv0eLDv9FD0jUGe7sfgiOIPnq3Vx5CrmG
 xYmzgsRbSkRwL3DsH947Wuw5QJSiYCpwqAxltUuRVn8/VpfzBdri2qAZIOVe5SSh7UtF9QkPE
 OGTvme4RmRK61IcltDacbk0c8qI9Dj64dIH44uJwAU9NZvUfxY3cZxLa7YGEkC4OEXhjQGfbU
 hvGa2vxGmSpVRfTmhQywuYVlOKW1HcUCBVdwDYbNIXiyNUAfFy3jRiDt/YxSmQ8oaewaxcMXe
 oYPpJhokbWHB2eQiHk1/RHo6sAC6cB+cxV/F+WlHj/+8lKK2Fh9XNX3XnQwEma/DrfI8Y0UA0
 OWGRjhtc5JY/CAryYopg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.12.20 um 17:46 schrieb Derrick Stolee:
> To wrap up, I'm going to eject this patch from my v2 since more investig=
ation
> must be done to see if this second loop _can_ be dropped. At minimum, it=
 isn't
> properly silent when requested and there _is_ a performance boost possib=
le,
> even if we keep the check.

OK.  It *is* suspicious that the test suite doesn't exercise the check don=
e by
that second loop.  Removing it completely would rob us of so many ways to
optimize it, though. ;-)

Ren=C3=A9
