Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2196BC4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB71461131
	for <git@archiver.kernel.org>; Sat, 29 May 2021 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhE2UdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 16:33:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60632 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhE2UdI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 16:33:08 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ln5cH-0008GR-80; Sat, 29 May 2021 21:31:29 +0100
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Matt Rogers <mattr94@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
 <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
Date:   Sat, 29 May 2021 21:31:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/2021 19:33, Sibi Siddharthan wrote:
> On Sat, May 29, 2021 at 9:55 PM Philip Oakley <philipoakley@iee.email> wrote:
>> On 29/05/2021 16:49, Matt Rogers wrote:
>>> I have some experience at my job with CMake, but some quick testing
>>> has found that adding a check like:
>>>
>>> message("MSVC = ${MSVC} , WIN32 = ${WIN32})
>>>
>>> shows that the MSVC is uninitialized and WIN322 is initialized.  so the
>>> issue is that the MSVC variable isn't being set which is causing
>>> vcpkg_install.bat to not run, rather than the WIN32 variable.
>> Thanks for confirming what I'm seeing. It's good to have.
>>> The msvc variable is intended to be set whenever the compiler is a Visual C/C++
>>> compiler [1].  And it seems like visual studio should be setting that itself
>>> either via a toolchain or some other mechanism.
> CMake sets this variable.
> Please see {CMAKE_INSTALLATION}/share/cmake-<version>/modules/Platform/Windows-MSVC.cmake.
> This happens after CMake is required to find a compiler.
> This happens in line:93 where we enable the C language.

Ahh, so it (MSVC) would be unset at that point no matter what at that
early point in the code, yes?

>
> To fix this I would suggest to change line:53
>
> -  if(MSVC AND NOT EXISTS ${VCPKG_DIR})
> + if(CMAKE_GENERATOR MATCHES "Visual Studio" AND NOT EXISTS ${VCPKG_DIR})

I'd seen this one recommended on a few StackOverflow answers but it no
longer works (for a new install of Visual Studio) because
CMAKE_GENERATOR is now set to "Ninja" as default (sigh).

Simply dropping the MSVC test may be one option - we are already guarded
by the earlier WIN32 test so were aren't on another OS, though I expect
there could be some who want to not use VS, and already have options..
> and

> add CMakeSettings.json to force Visual Studio to use MSBuild.

I was trying to avoid requiring VS users do any extra set up steps. Too
many steps often puts off new users, and forcing a change could be
annoying for established users - hence the caution.

> Please see https://docs.microsoft.com/en-us/cpp/build/cmakesettings-reference?view=msvc-160

I'll have a look.

Thanks.
