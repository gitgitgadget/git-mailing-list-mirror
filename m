Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF831FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941767AbcLVRtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:49:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941110AbcLVRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3391E59090;
        Thu, 22 Dec 2016 12:49:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rWrA88DjDSC6iPDRZBmRKL4sY8g=; b=rXg3Tj
        qHmpRepm9uN2IAeULvsldXw3Tt5ggFuqoo9AqYSzqm56d2JAneWXyACaDWm2JEj2
        DmsUblfBJPyMSgpvEOjFWrmX0Y5M5gtNl2pehBKsLFa07Efca7IikijuKuFMnbA9
        YO9aknLHTHL25vzRAZrk45LDV/G4BYQ+fftAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RUTMhCQj7mTJm0l8W7zNuYOYAeYELXSd
        s8OD5jTN38tUg6kNJpVrN5ueQFrosTKT+GCKQO8alxwdJe5HiC5OPw7Vwmf/WWcP
        uvLcHG6G8z1bYYGDQVHzoGY2Uis9Ln+L2tY0U1MVc+ldBqcsKzwUhbr/8d7mIkCz
        r2WDRMKOh8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B6135908E;
        Thu, 22 Dec 2016 12:49:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83D665908C;
        Thu, 22 Dec 2016 12:49:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] Really fix the isatty() problem on Windows
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <cover.1482426497.git.johannes.schindelin@gmx.de>
Date:   Thu, 22 Dec 2016 09:49:37 -0800
In-Reply-To: <cover.1482426497.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 22 Dec 2016 18:08:51 +0100 (CET)")
Message-ID: <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0238E538-C86F-11E6-9D17-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> My previous fix may have fixed running the new
> t/t6030-bisect-porcelain.sh script that tested the new bisect--helper,
> which in turn used isatty() to determine whether it was running
> interactively and was fooled by being redirected to /dev/null.
>
> But it not only broke paging when running in a CMD window, due to
> testing in the wrong worktree I also missed that it broke paging in Git
> for Windows 2.x' Git Bash (i.e. a MinTTY terminal emulator).
>
> Let's use this opportunity to actually clean up the entire isatty() mess
> once and for all, as part of the problem was introduced by a clever hack
> that messes with internals of the Microsoft C runtime, and which changed
> recently, so it was not such a clever hack to begin with.
>
> Happily, one of my colleagues had to address that latter problem
> recently when he was tasked to make Git compile with Microsoft Visual C
> (the rationale: debugging facilities of Visual Studio are really
> outstanding, try them if you get a chance).
>
> And incidentally, replacing the previous hack with the clean, new
> solution, which specifies explicitly for the file descriptors 0, 1 and 2
> whether we detected an MSYS2 pseudo-tty, whether we detected a real
> Win32 Console, and whether we had to swap out a real Win32 Console for a
> pipe to allow child processes to inherit it.
>
> While at it (or, actually, more like: as I already made this part of v1
> by mistake), upstream the patch carried in Git for Windows that supports
> color when running Git for Windows in Cygwin terminals.
>
> Changes since v1:
>
> - rebased onto master
>
> - unsquashed 2/3 which was improperly snuck in before,

As Windows specific changes, I didn't notice these two were independent.

> - noted that Beat Bolli tested this (see
>   https://github.com/git-for-windows/git/issues/997#issuecomment-268764693)
>
> - fixed the confusing commit message by using Junio's suggested
>   replacement

Sorry, but I didn't mean to "suggest replacement".  I was just
testing my understanding by attempt to rephrase the gist of it.

There was one thing I still wasn't clear in my "summary of my
understanding".  Is the "replacement originally done for compiling
with VC++" a solution that still peeks into MSVC runtime internals
but is usable with both old and more recent one?  Or is it a more
kosher approach that does not play with the internals to make it
unlikely that it would have to change again in the future?

Your "use this opportunity to actually clean up" above suggests that
the answer is the latter, but if you took my "summary of my
understanding", it is likely that that fact is not captured in the
resulting log message.

The interdiff obviously looks good.  Let's move this series forward.
I'll see if it can be merged down to 'maint', too, but it probably
would not matter that much.

Thanks.


