Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0674C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEED61157
	for <git@archiver.kernel.org>; Sat, 29 May 2021 16:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhE2Q0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 12:26:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63121 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhE2Q0u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 12:26:50 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ln1lw-000A17-A4; Sat, 29 May 2021 17:25:12 +0100
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
Date:   Sat, 29 May 2021 17:25:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/2021 16:49, Matt Rogers wrote:
> I have some experience at my job with CMake, but some quick testing
> has found that adding a check like:
>
> message("MSVC = ${MSVC} , WIN32 = ${WIN32})
>
> shows that the MSVC is uninitialized and WIN322 is initialized.  so the
> issue is that the MSVC variable isn't being set which is causing
> vcpkg_install.bat to not run, rather than the WIN32 variable.

Thanks for confirming what I'm seeing. It's good to have.
>
> The msvc variable is intended to be set whenever the compiler is a Visual C/C++
> compiler [1].  And it seems like visual studio should be setting that itself
> either via a toolchain or some other mechanism.

That is what VS used to do (as best I understand it)

>   As you noted the
> Ninja generator
> is os-agnostic and doesn't imply a compiler unlike the Visual Studio family of
> generators.

Which (Ninja) is the new VS default - classic latest and greatest
breaking backward compatible ;-)

>
> running CMake with -DMSVC=1 should resolve the issue (Assuming you're
> actually using
> an MSVC based compiler).

The CMake is being run automatically by VS when it opens the folder,
fails to find the .sln, so searches for the CMakeList.txt file, so can't
add in the flag (with the current approach)..

>   If the CMake is intended to support non-MSVC
> compilers like
> clang, etc. and vcpkg is required to do that build then the MSVC
> portion of the check
> should be removed, 
Id agree about removal, but I'm not sure what should be in it's place to
ensure we have localised to being built within VS..
> otherwise I am not sure if it's a Visual Studio
> issue for not correctly
> configuring with MSVC=1 when using an MSVC-based compiler or on the
> CMakeList.txt file
> for not correctly specifying when vcpk_install.bat needs to be
> installed.  
It's sort of both. It's that change of default generator that's tripped
up everything.

I think I may need to look into Ninja to see if there is anything there
that will help.

Ultimately the goal is to get the .sln to support other [Sourcetrail]
tools (which needs an actual build)

> I don't really
> know what vcpkg does in the build to be sure though.
Basically, the .bat file gets all our library dependencies in a nice
packaged manner  (~Visual C Packager - vcpkg)
>
> 1: https://cmake.org/cmake/help/latest/variable/MSVC.html
Philip
