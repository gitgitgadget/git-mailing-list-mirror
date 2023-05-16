Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D62C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 19:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEPTMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEPTMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 15:12:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABD171A
        for <git@vger.kernel.org>; Tue, 16 May 2023 12:12:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ECD519D24E;
        Tue, 16 May 2023 15:12:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=06GL3rpDUvuN
        AfCfZju/3q/0zCt2PSi/PzaRH+Qn6qM=; b=yJZR2XQi5LjKCJdxklhCA6grI/iF
        HxwlpxLxAzHkt+1/MbvocFpuw3ILj/Rl7gFyXVrvC61PhSrlOmD2yRoqU8kR+YJy
        BO9GIuvfXZ74rIM4J052tQ3g1F93AmyIgPd9xBXyUGfaLmVNXOixSk/sbf/xPn9L
        9Y6UifIxIqFOb7M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E81119D24D;
        Tue, 16 May 2023 15:12:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DED4C19D24C;
        Tue, 16 May 2023 15:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
References: <ZGO4LesPe4A2ftdm@nand.local>
        <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com>
Date:   Tue, 16 May 2023 12:12:02 -0700
In-Reply-To: <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 16 May 2023 13:56:21 -0400")
Message-ID: <xmqqh6sct7jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8ADC44A8-F41D-11ED-86E2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When building git with `NO_PTHREADS=3DYesPlease`, we fail to build
> run-command.o since we don't have a definition for ALLOC_GROW:
>
>     $ make NO_PTHREADS=3D1 DEVELOPER=3D1 run-command.o
>     GIT_VERSION =3D 2.41.0.rc0.1.g787eb3beae.dirty
>         CC run-command.o
>     run-command.c: In function =E2=80=98git_atexit=E2=80=99:
>     run-command.c:1103:9: error: implicit declaration of function =E2=80=
=98ALLOC_GROW=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>      1103 |         ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hd=
lrs.nr + 1, git_atexit_hdlrs.alloc);
>           |         ^~~~~~~~~~
>     cc1: all warnings being treated as errors
>     make: *** [Makefile:2715: run-command.o] Error 1

I am OK to give a reproduction recipe, i.e. the "$ make" command
line, to make it easy for people, who cannot remember how to define
make variables from the command line, to try out themselves, but I
hate the "build transcript" in the log message, when a few lines of
prose suffices.

How about this?

    Git 2.41-rc0 fails to compile run-command.c with NO_PTHREADS
    defined, i.e.

      $ make NO_PTHREADS=3D1 run-command.o

    as ALLOC_GROW() macro is used in the atexit() emulation but the
    macro definition is not available.

> This bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
> cache.h, 2023-02-24), which replaced includes of "cache.h" with
> "alloc.h", which is the new home of `ALLOC_GROW()` (and
> `ALLOC_GROW_BY()`).

Good.
Insert something like:

    We can see that run-command.c is the only one that try to use
    these macros without including <alloc.h>.

      $ git grep -l -e '[^_]ALLOC_GROW(' -e 'ALLOC_GROW_BY(' \*.c | sort =
>/tmp/1
      $ git grep -l 'alloc\.h' \*.c | sort >/tmp/2
      $ comm -23 /tmp/[12]
      compat/simple-ipc/ipc-unix-socket.c
      run-command.c

    The "compat/" file only talks about the macro in the comment,
    and is not broken.

here.  What I am aiming for is to tell readers what they do not have
to spend their time on.  As we encourage people to make sure to look
for other errors that come from the same root cause when making a
fix, avoiding duplicated work by telling what they do not have to
look at is rather important.

> run-command.c compiles fine when `NO_PTHREADS` is undefined, since its
> use of `ALLOC_GROW()` is behind a `#ifndef NO_PTHREADS`. (Everything
> else compiles fine when NO_PTHREADS is defined, so this is the only spo=
t
> that needs fixing).

I think we can say that, but is probably coered by the three-line
summary I gave above.

> We could fix this by conditionally including "alloc.h" when
> `NO_PTHREADS` is defined.  But we have relatively few examples of
> conditional includes throughout the tree[^1].
>
> Instead, include "alloc.h" unconditionally in run-command.c to allow it
> to successfully compile even when NO_PTHREADS is defined.

Good.

> [^1]: With `git grep -E -A1 '#if(n)?def' -- **/*.c | grep '#include' -B=
1`.

Good.
