Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECAEC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJGRt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGRtz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:49:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983672A434
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:49:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92C8C145C39;
        Fri,  7 Oct 2022 13:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LZSzFymrp93G
        ThiHR6cXjkAF10CmVZ0ChS+p2O1wKnQ=; b=sBzPDKF1IMg2DmcXEvzxOMaC6NLv
        fskXx8UfkSTenzvFjfMrWsOXBmDZM1AvTjjT9HBbvHBFxKSZT8ZRmbYuVICuh+nf
        sX2FmyiV+jTrgq3CbKJuIk1zaz47p1TEKR6sqcFooRJ462Hrx3GUNAIV7lkPuo7Q
        G8pFEVNL7g7nrug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AFCB145C38;
        Fri,  7 Oct 2022 13:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF89C145C37;
        Fri,  7 Oct 2022 13:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
Date:   Fri, 07 Oct 2022 10:49:50 -0700
In-Reply-To: <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 7 Oct 2022 11:19:19 -0400")
Message-ID: <xmqqpmf3frr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 71E9084A-4668-11ED-8DF2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I didn't realize that these variable initialization fixes would
> spawn such a large response here [1].  Nor that it had been already
> discussed in great length in [2] in July.
>
> I'm not sure how to best proceed here.
>
> * I'm not sure these fixes are important enough to warrant the
>   engineering time to hack up the Makefile or config.mak.uname
>   to conditionally turn off -Wno-missing-braces based on some
>   {platform-os-version, gcc/clang-version} combination.

Developers are expected to be able to cope, but if this something a
few easy lines in config.mak.uname can help, we'd better do so,
instead of having dozens of folks on the macOS add the same line to
their config.mak file.

> * While -Wno-missing-braces option may prevent the warning/error
>   (depending on -Werror) for these "{0}" should be "{{0}}"
>   errors, do we know that this won't hide real problems.  (I mean
>   we tend to only see it for these {0} / {{0}} false alarms, but
>   I'd hate to lose the protection for non-false alarms.)

It may find real problems, but folks on other platforms are running
without the check disabled, so we should be OK.  More importantly,
folks with a more recent compilers on macOS are running with the
check, so we should be able to give a reasonable coverage to
platform specific code, too.

> * The suggestion to use a <type>_INIT macro to hide the {0} or
>   {{0}} may help in the:
>         xmparam_t xmp =3D XMPARAM_INIT;
>   case, but in the `mmfile_t mmfs[3]` case, we have an array of
>   that type, so we'd need something like:
>      mmfile_t mmfs[3] =3D { MMFILE_INIT }; or
>      mmfile_t mmfs[3] =3D MMFILE_INIT_ARRAY;
>   for the macros to make sense.
>   I'm not sure either of these two is better than just writing "{{0}}".

I do not like that suggestion at all.  I think it is the right
approach to use -Wno-missing-braces with older and buggy compilers
until they die out.

> * I wasn't sure which compiler versions we *want* to support or
>   want to drop support for.
>   * I've only thought about it in the context of clang on MacOS.

I think that is OK.  IIRC, we have more or less good grasp on the
cut-off version of clang as the upstream calls it, but the problem
is clang shipped with macOS lies and gives a version number more
recent than it actually is.

> * I'm not the first one who has stumbled over this and had to
>   rediscover the solution.  So I'd hate to just kick this down
>   the road some more, but then again I'd hate to waste a lot of
>   time on it -- for very little actual functional value.

Exactly.

> * Is "{{0}}" really that ugly ???

Ugly is not the issue.  Folks on more recent platforms not being
able to tell when to use the extra parentheses is, because their
compilers do not have this bug.

My preference is to flip the -Wno-missing-braces bit in
config.mak.uname only for folks who use the version of clang on
macOS when that clang claims to be clang11 (my understanding of
Ren=C3=A9's experiment[*] is that versions of (real) clang 9 or newer
perfectly well understand that {0} is an accpetable way to specify
zero initialization for any structure, with possible nesting).

[Reference]

* https://lore.kernel.org/git/36cd156b-edb2-062c-9422-bf39aad39a6d@web.de=
/
