Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C4C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 19:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEPTON convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 May 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPTOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 15:14:12 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5795264
        for <git@vger.kernel.org>; Tue, 16 May 2023 12:14:10 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34GJCnPT2497732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 19:12:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>,
        "'Elijah Newren'" <newren@gmail.com>
References: <ZGO4LesPe4A2ftdm@nand.local>        <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com> <xmqqh6sct7jx.fsf@gitster.g>
In-Reply-To: <xmqqh6sct7jx.fsf@gitster.g>
Subject: RE: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
Date:   Tue, 16 May 2023 15:13:57 -0400
Organization: Nexbridge Inc.
Message-ID: <00a601d9882a$93c7a940$bb56fbc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHsJJn1ilZfYkryfQksEiQudd2gtgElbtoOAqjywXmvGZjBIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, May 16, 2023 3:12 PM, Junio C Hamano wrote:
>Taylor Blau <me@ttaylorr.com> writes:
>
>> When building git with `NO_PTHREADS=YesPlease`, we fail to build
>> run-command.o since we don't have a definition for ALLOC_GROW:
>>
>>     $ make NO_PTHREADS=1 DEVELOPER=1 run-command.o
>>     GIT_VERSION = 2.41.0.rc0.1.g787eb3beae.dirty
>>         CC run-command.o
>>     run-command.c: In function ‘git_atexit’:
>>     run-command.c:1103:9: error: implicit declaration of function ‘ALLOC_GROW’ [-
>Werror=implicit-function-declaration]
>>      1103 |         ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1,
>git_atexit_hdlrs.alloc);
>>           |         ^~~~~~~~~~
>>     cc1: all warnings being treated as errors
>>     make: *** [Makefile:2715: run-command.o] Error 1
>
>I am OK to give a reproduction recipe, i.e. the "$ make" command line, to make it
>easy for people, who cannot remember how to define make variables from the
>command line, to try out themselves, but I hate the "build transcript" in the log
>message, when a few lines of prose suffices.
>
>How about this?
>
>    Git 2.41-rc0 fails to compile run-command.c with NO_PTHREADS
>    defined, i.e.
>
>      $ make NO_PTHREADS=1 run-command.o
>
>    as ALLOC_GROW() macro is used in the atexit() emulation but the
>    macro definition is not available.
>
>> This bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
>> cache.h, 2023-02-24), which replaced includes of "cache.h" with
>> "alloc.h", which is the new home of `ALLOC_GROW()` (and
>> `ALLOC_GROW_BY()`).
>
>Good.
>Insert something like:
>
>    We can see that run-command.c is the only one that try to use
>    these macros without including <alloc.h>.
>
>      $ git grep -l -e '[^_]ALLOC_GROW(' -e 'ALLOC_GROW_BY(' \*.c | sort >/tmp/1
>      $ git grep -l 'alloc\.h' \*.c | sort >/tmp/2
>      $ comm -23 /tmp/[12]
>      compat/simple-ipc/ipc-unix-socket.c
>      run-command.c
>
>    The "compat/" file only talks about the macro in the comment,
>    and is not broken.
>
>here.  What I am aiming for is to tell readers what they do not have to spend their
>time on.  As we encourage people to make sure to look for other errors that come
>from the same root cause when making a fix, avoiding duplicated work by telling
>what they do not have to look at is rather important.
>
>> run-command.c compiles fine when `NO_PTHREADS` is undefined, since its
>> use of `ALLOC_GROW()` is behind a `#ifndef NO_PTHREADS`. (Everything
>> else compiles fine when NO_PTHREADS is defined, so this is the only
>> spot that needs fixing).
>
>I think we can say that, but is probably coered by the three-line summary I gave
>above.
>
>> We could fix this by conditionally including "alloc.h" when
>> `NO_PTHREADS` is defined.  But we have relatively few examples of
>> conditional includes throughout the tree[^1].
>>
>> Instead, include "alloc.h" unconditionally in run-command.c to allow
>> it to successfully compile even when NO_PTHREADS is defined.
>
>Good.
>
>> [^1]: With `git grep -E -A1 '#if(n)?def' -- **/*.c | grep '#include' -B1`.
>
>Good.

This all makes sense to me.

