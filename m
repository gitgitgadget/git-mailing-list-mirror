Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DFD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 08:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfFSIgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 04:36:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSIgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 04:36:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so2392557wrr.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjlD5/SWgIxe7Mt+E6UJOIXnGhzs7pSLbEB0JZClHnQ=;
        b=sEJo215fM9sSelN/Trp918E6dCf+aLlIQkSaJQpP6MsFnIpFN7u36bE08j9mV4AjP5
         qwdMdtdYlTtnT+P1HBMDI47QG/DuA0k/XN4r5OHKcZkstoQeTwweY0gz38FH6Qv2NkqO
         KkCAF2fvNnwpvJvGLXl3950pxXZadIqSSPrC76tXWu/915grXyixOGmh5fZQGFHZrbTd
         d+JFmEjhXy9JVahMydN929y2+dGE+p7PIfSHzl06KefKivqcN0GVcxKNa6kXHMrzvfQS
         CHl0Y0mROWjMIqff4DyB8Gu331hYtFJADzVv9lf0U/PsTQJ4shOW/6glbwaqQp+RtluM
         a6Qw==
X-Gm-Message-State: APjAAAV25hyN5h3zZDs9VIxrdYKjjoKh0R68Ss+p5GHYm8O0TmuUW7Uw
        SYjaRTVJuh89Hyri7T9HoviJruGEH6L4UuEv+qE=
X-Google-Smtp-Source: APXvYqxJkqdb/ETykI3bUzShxonWr1PBLdHZ1GYsMboP60hnwyiJVe6ev6Eq4aBlOlVUpJbw3TYvaNEK9RDyXKHrawc=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr80240557wra.278.1560933365505;
 Wed, 19 Jun 2019 01:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Jun 2019 04:35:54 -0400
Message-ID: <CAPig+cTgmvwg_LV5zonQAR3c0et2p1Nm4YuAfAkYDF=2jY9YeQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] msvc: support building Git using MS Visual C++
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> With this patch, Git can be built using the Microsoft toolchain, via:
>
>         make MSVC=1 [DEBUG=1]
>
> Third party libraries are built from source using the open source
> "vcpkg" tool set. See https://github.com/Microsoft/vcpkg
> [...]
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Makefile b/Makefile
> @@ -1240,7 +1240,7 @@ endif
> -BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
> +BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'

This seems like a distinct bug fix which should live in its own patch.

> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -2388,6 +2388,12 @@ static void maybe_redirect_std_handles(void)
> +#ifdef _MSC_VER
> +#ifdef _DEBUG
> +#include <crtdbg.h>
> +#endif
> +#endif
> @@ -2405,6 +2411,12 @@ int wmain(int argc, const wchar_t **wargv)
> +#ifdef _MSC_VER
> +#ifdef USE_MSVC_CRTDBG
> +       _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
> +#endif
> +#endif

Shouldn't these changes be squashed into 16/17 (with the commit
message of 16/17 adjusted accordingly), rather than being included in
this patch?

> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> @@ -1,3 +1,54 @@
> +Alternatively, run `make MSVC=1 vcxproj` and then load the generated
> +git.sln in Visual Studio. The initial build will install the vcpkg
> +system and build the dependencies automatically. This will take a while.

Is this bit implemented yet, or will it be introduced by a subsequent
patch series mentioned in the cover letter? If the latter, perhaps
this README snippet belongs to that future patch series.

> +Note that this will automatically add and commit the generated
> +.sln and .vcxproj files to the repo.  You may want to drop this
> +commit before submitting a Pull Request....

Yuck. An automatic commit as part of the build process has high
surprise-factor, and it seems like it's creating extra work (and
possibility for error) if the user needs to remember to drop it before
submitting.

> +Or maybe we should put the .sln/.vcxproj files in the .gitignore file
> +and not do this.  I'm not sure.

Seems like a better choice.

> diff --git a/compat/vcbuild/find_vs_env.bat b/compat/vcbuild/find_vs_env.bat
> @@ -0,0 +1,169 @@
> +:not_2015
> +   REM TODO....
> +   echo TODO support older versions of VS. >&2
> +   EXIT /B 1

As this is a user-facing error message, perhaps it could be worded
differently. Maybe:

    ERROR: unsupported VS version (older than VS2015)

or something.
