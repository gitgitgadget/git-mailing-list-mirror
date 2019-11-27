Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA578C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A767207DD
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0R46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:56:58 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:49215 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfK0R46 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:56:58 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ia1Yd-00034Z-6l; Wed, 27 Nov 2019 17:56:55 +0000
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
References: <pull.348.git.gitgitgadget@gmail.com>
 <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
Date:   Wed, 27 Nov 2019 17:56:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/09/2019 09:28, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Even though Debug configuration builds, the resulting build is incorrect
> in a subtle way: it mixes up Debug and Release binaries, which in turn
> causes hard-to-predict bugs.
>
> In my case, when git calls iconv library, iconv sets 'errno' and git
> then tests it, but in Debug and Release CRT those 'errno' are different
> memory locations.
>
> This patch addresses 3 connected bugs:
> 1) Typo in '\(Configuration)'. As a result, Debug configuration
>     condition is always false and Release path is taken instead.
> 2) Regexp that replaced 'zlib.lib' with 'zlibd.lib' was only affecting
>     the first occurrence. However, some projects have it listed twice.
>     Previously this bug was hidden, because Debug path was never taken.
>     I decided that avoiding double -lz in makefile is fragile and I'd
>     better replace all occurrences instead.
> 3) In Debug, 'libcurl-d.lib' should be used instead of 'libcurl.lib'.
>     Previously this bug was hidden, because Debug path was never taken.
I just bumped against a potential issue like this. I was test compiling 
[1a,b] the `vs/master` branch from Git-For-Windows and got the LINK 
error that the 'libcurl-d.lib' was not found (4 places).

Error    LNK1104    cannot open file 'libcurl-d.lib' git-imap-send    
C:\git-sdk-64\usr\src\git\git-imap-send\ LINK    1

Having just located this email, I changed the build type to 'Release' 
and the errors disappeared.

Do we also need to identify where the libcurl-d.lib will be found? i.e. 
is it something that needs including via the sdk pacman list (I think 
I'm up to date but maybe not..)

A quick web search didn't show any hits for `libcurl-d.lib` (with the 
dash `-`), though did find a few for `libcurld.lib`.

Philip

Why compiling:
[1a] https://www.sourcetrail.com is a cross-platform source explorer 
that helps you get productive on unfamiliar source code.
[1b] Sourcetrail is now free and open-source 
https://www.sourcetrail.com/blog/open_source/
>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>   contrib/buildsystems/Generators/Vcxproj.pm | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
> index 576ccabe1d..7b1e277eca 100644
> --- a/contrib/buildsystems/Generators/Vcxproj.pm
> +++ b/contrib/buildsystems/Generators/Vcxproj.pm
> @@ -79,7 +79,8 @@ sub createProject {
>       if (!$static_library) {
>         $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
>         $libs_debug = $libs_release;
> -      $libs_debug =~ s/zlib\.lib/zlibd\.lib/;
> +      $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
> +      $libs_debug =~ s/libcurl\.lib/libcurl-d\.lib/g;
>       }
>   
>       $defines =~ s/-D//g;
> @@ -119,13 +120,13 @@ sub createProject {
>       <VCPKGArch Condition="'\$(Platform)'=='Win32'">x86-windows</VCPKGArch>
>       <VCPKGArch Condition="'\$(Platform)'!='Win32'">x64-windows</VCPKGArch>
>       <VCPKGArchDirectory>$cdup\\compat\\vcbuild\\vcpkg\\installed\\\$(VCPKGArch)</VCPKGArchDirectory>
> -    <VCPKGBinDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
> -    <VCPKGLibDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
> -    <VCPKGBinDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
> -    <VCPKGLibDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
> +    <VCPKGBinDirectory Condition="'\$(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
> +    <VCPKGLibDirectory Condition="'\$(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
> +    <VCPKGBinDirectory Condition="'\$(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
> +    <VCPKGLibDirectory Condition="'\$(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
>       <VCPKGIncludeDirectory>\$(VCPKGArchDirectory)\\include</VCPKGIncludeDirectory>
> -    <VCPKGLibs Condition="'\(Configuration)'=='Debug'">$libs_debug</VCPKGLibs>
> -    <VCPKGLibs Condition="'\(Configuration)'!='Debug'">$libs_release</VCPKGLibs>
> +    <VCPKGLibs Condition="'\$(Configuration)'=='Debug'">$libs_debug</VCPKGLibs>
> +    <VCPKGLibs Condition="'\$(Configuration)'!='Debug'">$libs_release</VCPKGLibs>
>     </PropertyGroup>
>     <Import Project="\$(VCTargetsPath)\\Microsoft.Cpp.Default.props" />
>     <PropertyGroup Condition="'\$(Configuration)'=='Debug'" Label="Configuration">

