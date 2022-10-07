Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F29EC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGVaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJGVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:30:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6342D77
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:30:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAF4315D0F7;
        Fri,  7 Oct 2022 17:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3vYAeWpFjhr4
        vO3hHqEr/n6e8ShsBeOiazbNSW8yHfo=; b=NZA/NHSqC7NXe5fcR96KUFsFu3nc
        c1ThW1EwwjIP0rASyVVL5k0Ps8yHop0FGKKt9bNuDX72MScGOZgqn9Tjzk8302k9
        4c3CJwyHWSpz02qeCAzG7mu7sR6UFhF5ZMeFmqrixtxBMmIV0uxnLqt+gZ7fRfbP
        k3hita2H5Jk6q2Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02B215D0F6;
        Fri,  7 Oct 2022 17:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EAC315D0F5;
        Fri,  7 Oct 2022 17:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
        <xmqqpmf3frr5.fsf@gitster.g>
        <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
Date:   Fri, 07 Oct 2022 14:30:10 -0700
In-Reply-To: <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Oct 2022 22:28:27 +0200")
Message-ID: <xmqqy1trcof1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39BBE522-4687-11ED-9748-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Perhaps like this?  (No sign-off because I'm not comfortable with that
> make function syntax, but feel free to steal salvageable parts.)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 4fa19d361b..4d59c9044f 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -69,6 +69,14 @@ DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>  endif
>  endif
>
> +# LLVM clang older than 9 and Apple clang older than 12 complain
> +# about initializing a struct-within-a-struct using just "{ 0 }"
> +ifneq ($(filter clang1,$(COMPILER_FEATURES)),)

If it is any version of clang, detect-compiler script should give us
at last "clang1" in $(COMPILER_FEATURES), and filtering the latter
with "clang1" should become "clang1" which should be neq.  We fail
the ifneq if the compiler is not llvm and do not come into this part.

> +ifeq ($(filter $(if $(filter Darwin,$(uname_S)),clang12,clang9),$(COMP=
ILER_FEATURES)),)

On Darwin, $(uname_S) is Darwin and filtering the $(uname_S) with
Darwin will leave Darwin as the "condition" parameter to $(if).
So $(if) evaluates to clang12 on Darwin and clang9 everywhere else.
If $(COMPILER_FEATURES) lacks that cut-off version, that means we
are using clang older than 12 (on macOS) or 9 (everywhere else) and
we come inside this block ...

> +DEVELOPER_CFLAGS +=3D -Wno-missing-braces

... which adds this workaround.

> +endif
> +endif

OK. That is dense, but sounds correct.

