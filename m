Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECAC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiEYQ6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbiEYQ6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:58:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FC9D07A
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:58:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8B52134295;
        Wed, 25 May 2022 12:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=PeYoLzj2FxbdcMVDpboZlTsrd
        UMem7NwtKzyf9ekU4w=; b=BtsquTWQG/tTSfGF1afW8DCkXeRX+p8nmC1wCKR25
        DwKpIoJWjjITs1D2UvqoQsc4qpwRImzs01HSIHT9Hp5gtI0ggncepuMKkvgeS6b8
        H2IgYM5CIFWJQGfdtZBkDNMXqn5u7AV16A8VeEOoQV1RrADxr8mH/rum+gJSG8I6
        3k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA16134293;
        Wed, 25 May 2022 12:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D587134292;
        Wed, 25 May 2022 12:58:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
Date:   Wed, 25 May 2022 09:57:59 -0700
Message-ID: <xmqqbkvl8s88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5FF4736-DC4B-11EC-A9B5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Keeping in mind that the intention is to fix a regression that was
> introduced by way of refactoring (most of our recent regressions seem t=
o
> share that trait [*2*]), I strongly advise against another round of
> refactoring [*3*], especially against tying it to fix a regression.

I share this sentiment.

> In this instance, it would be very easy to fix the bug without any
> refactoring. In a nutshell, the manifestation of the bug amplifies this
> part of the commit message of 96e7225b310 (hook: add 'run' subcommand,
> 2021-12-22):
>
>     Some of the implementation here, such as a function being named
>     run_hooks_opt() when it's tasked with running one hook, to using th=
e
>     run_processes_parallel_tr2() API to run with jobs=3D1 is somewhere
>     between a bit odd and and an overkill for the current features of t=
his
>     "hook run" command and the hook.[ch] API.
>
> It is this switch to `run_processes_parallel()` that is the root cause =
of
> the regression.
>
> The current iteration of the patch series does not fix that.

True.

> In the commit message from which I quoted, the plan is laid out to
> eventually run more than one hook. If that is still the plan, we will b=
e
> presented with the unfortunate choice to either never running them in
> parallel, or alternatively reintroducing the regression where the hooks
> run detached from stdin/stdout/stderr.

I had a similar impression before I reviewed the code after the
regression report, but if I read the code before the breakage
correctly, I think we didn't change the handling of the standard
input stream with the series from Emily/=C3=86var that broke the hooks.

The regression is the output streams are no longer _directly_
connected to the outside world, and instead to our internal relay
that buffers.  The run_hook_ve() helper did set .no_stdin to 1
before doing run_command() in Git 2.35.  The series with regression
does the same in pick_next_hook() callback in hook.c.  Both also set
.stdout_to_stderr to 1, so the apparent output should not change.

> It is pretty clear that there is no actual choice, and the hooks will
> never be able to run in parallel. Therefore, the fix should move
> `run_hooks_opt()` away from calling `run_processes_parallel()`.

My take on it is slightly different.

I personally do not think we should run hooks in parallel ourselves,
but if hook-like things, which Emily and =C3=86var want, want run in
parallel, we can safely allow them to do so.  No current users have
ever seen such hook-like things specified in their configuration
files---as long as it is clearly documented that these hook-like
things are not connected to the original standard output or error,
and they may run in parallel and whatever inter-process coordination
is their responsibility, there is no regression.  It is a brand new
feature.

The mechanism that supports that hook-like things should have a
compatibility mode, if it ever wants to take responsibility of
running the traditional hooks as part of its offering.  I think the
right way to do so is follows:

 - Unless each hook-like thing explicitly asks, it does not run in
   parallel with other hook-like things, and its output stream is
   connected directly to the original output stream.  They can run
   without involving the run_processes_parallel() at all.

 - When the traditional on-disk hooks are treated as if it is one of
   these hook-like things, the compatibility mode should be set to
   on for them without any user interaction.

 - Only the new stuff written specifically to be used as these shiny
   new hook-like things would explicitly ask to run in parallel and
   emit to the output multiplexer.

Doing things that way would pave the way forward to allow new stuff
to work differently, without breaking existing stuff people have,
wouldn't it?

> In any case, regression fixes should not be mixed with refactorings unl=
ess
> the latter make the former easier, which is not the case here.

Absolutely.  I wonder how involved is would be to revert the merge
of the whole thing from 'master'.  It may give us a clean slate to
rethink the whole mess and redo it without breaking the existing
users' hooks.
