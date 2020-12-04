Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA01C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1988522A85
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLDUL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:11:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:11:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31F5A98124;
        Fri,  4 Dec 2020 15:10:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GICwyLuehtxMbqx5wfOGmrqaqDo=; b=LY8H5j
        FfYTXIi5N9Vcmo0CXALPpu8vxijXcsu9GpAmk+HjUmK06kyUKYVFAsBQR5aCvBPZ
        y8GH0lTTo5OPN8gccSDhYVays2NEBHlyismBnASZiykMqomtaYAdAzh/DnRuO658
        sjpH5kVIYjKP5HZuHw/AOKJXisS8UZNRNnmOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cIhGb8wJqKB0zdj3Zaqbp80i2E6oe38e
        GOS6z/UZ3csh4/EgoLCUR7PyFQeZAOivdk5um0Zdlb1kKjytmY1p4uA8gke9oge/
        G6XeIsKJiTNaPQzgJHrlFZJAPOZzeCMdsPpVLW8pdwvHY6M33P9mqzhwQi0qzu2M
        rEj9OXgeZtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A18598123;
        Fri,  4 Dec 2020 15:10:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B212498122;
        Fri,  4 Dec 2020 15:10:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: determine list of extra built-ins dynamically
References: <pull.807.git.1607110436367.gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 12:10:41 -0800
In-Reply-To: <pull.807.git.1607110436367.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 04 Dec 2020 19:33:56
        +0000")
Message-ID: <xmqqczzpe3i6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C95A881E-366C-11EB-AAC0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 0a21d0e08902 (Makefile: mark git-maintenance as a builtin,
> 2020-12-01), we marked git-maintenance as a builtin in the Makefile, but
> forgot to do the same in `CMakeLists.txt`.
>
> Rather than always play catch-up and adjust `git_builtin_extra`
> manually, use the `BUILT_INS` definitions in the Makefile as
> authoritative source and generate `git_builtin_extra` dynamically.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: fix the vs-build job after adding git maintenance
>     
>     Together with https://github.com/gitgitgadget/git/pull/805, this should
>     fix the vs-build job in the CI build of seen.

I suspect that the breakage 805 addresses affects even 'master'; is
the breakage this patch fixes limited to 'seen', or affect everybody?

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-807%2Fdscho%2Fcmake-and-extra-builtins-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-807/dscho/cmake-and-extra-builtins-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/807
>
>  contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index df539a44fa..c151dd7257 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -114,6 +114,16 @@ macro(parse_makefile_for_scripts list_var regex lang)
>  	endif()
>  endmacro()
>  
> +macro(parse_makefile_for_executables list_var regex)
> +	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+= git-(.*)")
> +	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
> +	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
> +	string(REPLACE "git-" "" ${list_var} ${${list_var}}) #strip `git-` prefix
> +	string(REPLACE "\$X" ";" ${list_var} ${${list_var}}) #strip $X, ; is for converting the string into a list
> +	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
> +	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
> +endmacro()
> +
>  include(CheckTypeSize)
>  include(CheckCSourceRuns)
>  include(CheckCSourceCompiles)
> @@ -673,10 +683,7 @@ if(CURL_FOUND)
>  	endif()
>  endif()
>  
> -set(git_builtin_extra
> -	cherry cherry-pick format-patch fsck-objects
> -	init merge-subtree restore show
> -	stage status switch whatchanged)
> +parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
>  
>  #Creating hardlinks
>  foreach(s ${git_SOURCES} ${git_builtin_extra})
>
> base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
