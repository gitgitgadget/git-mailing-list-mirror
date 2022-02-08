Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF3C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 17:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiBHRoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBHRoe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 12:44:34 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A4C061578
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 09:44:33 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F100E119FFB;
        Tue,  8 Feb 2022 12:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=itXVXQpsI1qIpy4w3fNDflagNEnEf5Rd16eAeE
        72MGg=; b=nvw2U6OHmTCmtd3+ogV80PgzzYRQGteEF97G1S2y20f9oDUDKTqlCf
        iTiP6pVcRi9DQcWxMOiVYA/2oYt131J+14jT9w5PuQkayEU8JyCQ+yHgXPgHD7Ij
        5kvQCrey5ufHG7BCvA1j7CffmcxRaH6HPiy+KEqQkJd3cLhaj3A0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E679B119FFA;
        Tue,  8 Feb 2022 12:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CDB7119FF9;
        Tue,  8 Feb 2022 12:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
        <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
        <xmqqbkzigspr.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Feb 2022 09:44:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 8 Feb 2022 14:12:21 +0100 (CET)")
Message-ID: <xmqqbkzhdzib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4A1B5B6-8906-11EC-BDFC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > We could use that option in Git's own Makefile to add the file named
>> > "version", which contains $GIT_VERSION.  Hmm, but it also contains a
>> > terminating newline, which would be a bit tricky (but not impossible) to
>> > add.  Would it make sense to add one automatically if it's missing (e.g.
>> > with strbuf_complete_line)?  Not sure.
>>
>> I do not think it is a good UI to give raw file content from the
>> command line, which will be usable only for trivial, even single
>> liner files, and forces people to learn two parallel option, one
>> for trivial ones and the other for contents with meaningful size.
>
> Nevertheless, it is still the most elegant way that I can think of to
> generate a diagnostic `.zip` file without messing up the very things that
> are to be diagnosed: the repository and the worktree.

Puzzled.  Are you feeding contents of a .zip file from the command
line?

I was mostly worried about busting command line argument limit by
trying to feed too many bytes, as the ceiling is fairly low on some
platforms.  Another worry was that when <contents> can have
arbitrary bytes, with --opt=<path>:<contents> syntax, the input
becomes ambiguous (i.e. "which colon is the <path> separator?"),
without some way to escape a colon in the payload.

For a single-liner, --add-file-with-contents=<path>:<contents> would
be an OK way, and my comment was not a strong objection against this
new option existing.  It was primarily an objection against changing
the way to add the 'version' file in our "make dist" procedure to
use it anyway.

But now I think about it more, I am becoming less happy about it
existing in the first place.

This will throw another monkey wrench to Konstantin's plan [*] to
make "git archive" output verifiable with the signature on original
Git objects, but it is not a new problem ;-)


[Reference]

* https://lore.kernel.org/git/20220207213449.ljqjhdx4f45a3lx5@meerkat.local/
