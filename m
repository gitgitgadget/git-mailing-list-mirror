Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380692AbiDTQoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiDTQoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 12:44:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42E1C931
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 09:42:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF69E182588;
        Wed, 20 Apr 2022 12:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FzEowdRJyhKclLugzFHdZ6dTfKvNEbDTYFGAi/
        N9Ut8=; b=wh4W26S4cZxLIO9YuC93yEIKT8jEhCxd4i0vAFWT7aU7dr2mCLG1df
        /T4k5WvJBjQrShh4djAZMsj0Mefck5eXWdSBpgU3x591jaoXRVEJiWHUEnljBSrE
        rglQ6noMvmTymKmPnFz1eUygcax7FQpLGQeHSfmXStge3CSweyWuw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7A6A182587;
        Wed, 20 Apr 2022 12:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E651182586;
        Wed, 20 Apr 2022 12:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <Yl9Hn0C0TwalASC0@google.com>
        <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
Date:   Wed, 20 Apr 2022 09:42:01 -0700
In-Reply-To: <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com> (Phillip Wood's
        message of "Wed, 20 Apr 2022 10:00:45 +0100")
Message-ID: <xmqqr15rr9k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE7EEA28-C0C8-11EC-BC76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> It *is* true that run-command.c:pp_start_one() sets child_process:err=-1
>> for the child and run-command.c:run_hook_ve() didn't do that; that -1
>> means that start_command() will create a new fd for the child's stderr.
>> Since run_hook_ve() didn't care about the child's stderr before, I
>> wonder if that is why? Could it be that now that we're processing the
>> child's stderr, the child no longer thinks stderr is in tty, because the
>> parent is consuming its output?
>
> Exactly, stderr is redirected to a pipe so that we can buffer the
> output from each process and then write it to the real stdout when the
> process has finished to avoid the output from different processes
> getting mixed together. Ideally in this case we'd see that stdout is a
> tty and create a pty rather than a pipe when buffering the output from
> the process.

Ah, thanks, and sigh.  That means this was an unintended regression
caused by use of parallel infrastructure, mixed with a bit of "the
original problem report wrote hook properly so that when it is not
connected to a terminal (such as in this new implementation) it
refrains to do terminal-y things like coloring, so everything is
working as intended" ;-).

IIRC, the parallel subprocess stuff was invented to spawn multiple
tasks we internally need (like "checkout these submodules") that are
not interactive (hence does not need access to stdin) en masse, and
the output buffering is there to avoid interleaving the output that
would make it unreadable.

Use of the parallel subprocess API means that we inherently cannot
give access to the standard input to the hooks.  The users of the
original run_hooks_ve() API would be OK with that, because it did
.no_stdin=1 before the problematic hooks API rewrite, but I wonder
what our plans should be for hooks that want to go interactive.
They could open /dev/tty themselves (and that would have been the
only way to go interactive even in the old world order, so it is
perfectly acceptable to keep it that way with .no_stdin=1), but if
they run in parallel, the end-user would not know whom they are
typing to (and which output lines are the prompts they are expected
to respond to).

In the longer term, there are multiple possible action items.

 * We probably would want to design a bit better anti-interleaving
   machinery than "buffer everything and show only after the process
   exists", if we want to keep using the parallel subprocess API.
   And that would help the original "do this thing in multiple
   submodules at the same time" use case, too.  

 * We should teach hooks API to make it _optional_ to use the
   parallel subprocess API.  If we are not spawning hooks in
   parallel today, there is no reason to incur this regression by
   using the parallel subprocess API---this was a needress bug, and
   I am angry.

 * the hooks API should learn a mechanism for multiple hooks to
   coordinate their executions.  Perhaps they indicate their
   preference if they are OK to be run in parallel, and those that
   want isolation will be run one-at-a-time before or after others
   run in parallel, or something.

 * The hooks API should learn a mechanism for us to tell what
   execution environment they are in.  Ideally, the hooks, if it is
   sane to run under the parallel subprocess API, shouldn't have
   been learning if they are talking to an interactive human user by
   looking at isatty(), but we should have been explicitly telling
   them that they are, perhaps by exporting an environment
   variable.  There may probably be more clue hooks writers want
   other than "am I talking to human user?" that we would want to
   enumerate before going this route.

Thanks for analyzing.
