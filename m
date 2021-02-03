Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B83C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207E064E0D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhBCTeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:34:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBCTdr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:33:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 368C111A271;
        Wed,  3 Feb 2021 14:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v3YXbiX1Tlot
        X3OpcM7suBVUYDU=; b=TjuFIZREjgQIOCRy+pomiknSoSjyAI4UX0y6XWTC8z27
        LkAZatNzqZC5gJDd/o2bgGfe0bZn/IXpWCzHmg+tM8lmzLFG6zs5PRAgaoM87JZA
        kj5zSsTrTG1P4rQNWcZTZonpPJVqPsYemWtOmtUv/LbuwLoAaSF697ky6S9Cul0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T+yGQs
        iQj6UKlPGFuDMYgQ0aMxPbozxaA8o5jBAUqByOa1K1cRyWy/XP8YUoKJNmtW8Q83
        0+7lVu77Hmcy2voRAUD8qUDYPrLVRAL0dvxxP5b1KIkYzidcepgKSFjJE4mjGYg0
        k/SNNGTssqZuBJJgKNv0cw5BgwSUWhfLcxG18=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3006211A270;
        Wed,  3 Feb 2021 14:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 735B211A26D;
        Wed,  3 Feb 2021 14:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4 1/1] MacOS: precompose_argv_prefix()
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210203162823.15756-1-tboegi@web.de>
Date:   Wed, 03 Feb 2021 11:33:00 -0800
In-Reply-To: <20210203162823.15756-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 3 Feb 2021 17:28:23 +0100")
Message-ID: <xmqq35ydc5g3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1557198-6656-11EB-BCF4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The following sequence leads to a "BUG" assertion running under MacOS:
>
>   DIR=3Dgit-test-restore-p
>   Adiarnfd=3D$(printf 'A\314\210')
>   DIRNAME=3Dxx${Adiarnfd}yy
>   mkdir $DIR &&
>   cd $DIR &&
>   git init &&
>   mkdir $DIRNAME &&
>   cd $DIRNAME &&
>   echo "Initial" >file &&
>   git add file &&
>   echo "One more line" >>file &&
>   echo y | git restore -p .
>
>  Initialized empty Git repository in /tmp/git-test-restore-p/.git/
>  BUG: pathspec.c:495: error initializing pathspec_item
>  Cannot close git diff-index --cached --numstat
>  [snip]
>
> The command `git restore` is run from a directory inside a Git repo.
> Git needs to split the $CWD into 2 parts:
> The path to the repo and "the rest", if any.
> "The rest" becomes a "prefix" later used inside the pathspec code.
>
> As an example, "/path/to/repo/dir-inside-rep=C3=A5" would determine
> "/path/to/repo" as the root of the repo, the place where the
> configuration file .git/config is found.
>
> The rest becomes the prefix ("dir-inside-rep=C3=A5"), from where the
> pathspec machinery expands the ".", more about this later.
> If there is a decomposed form, (making the decomposing visible like thi=
s),
> "dir-inside-rep=C2=B0a" doesn't match "dir-inside-rep=C3=A5".
>
> Git commands need to:
>
>  (a) read the configuration variable "core.precomposeunicode"
>  (b) precocompose argv[]
>  (c) precompose the prefix, if there was any
>
> The first commit,
> 76759c7dff53 "git on Mac OS and precomposed unicode"
> addressed (a) and (b).
>
> The call to precompose_argv() was added into parse-options.c,
> because that seemed to be a good place when the patch was written.
>
> Commands that don't use parse-options need to do (a) and (b) themselfs.
>
> The commands `diff-files`, `diff-index`, `diff-tree` and `diff`
> learned (a) and (b) in
> commit 90a78b83e0b8 "diff: run arguments through precompose_argv"
>
> Branch names (or refs in general) using decomposed code points
> resulting in decomposed file names had been fixed in
> commit 8e712ef6fc97 "Honor core.precomposeUnicode in more places"
>
> The bug report from above shows 2 things:
> - more commands need to handle precomposed unicode
> - (c) should be implemented for all commands using pathspecs
>
> Solution:
> precompose_argv() now handles the prefix (if needed), and is renamed in=
to
> precompose_argv_prefix().
>
> Inside this function the config variable core.precomposeunicode is read
> into the global variable precomposed_unicode, as before.
> This reading is skipped if precomposed_unicode had been read before.
>
> The original patch for preocomposed unicode, 76759c7dff53, placed
> precompose_argv() into parse-options.c
> Now add it into git.c (as well) for commands that don't use parse-optio=
ns.
> Note that precompose() may be called twice - it is idempotent.

Just as the prefix-less variant was idempotent and that was the
reason why cmd_diff_files() had its own precompose() even if the
incoming argv[] is supposed to be already precomposed because it
was processed in another call to precompose() in run_builtin(),
this patch keeps these seemingly redundant calls, because it is not
meant as a clean-up but as a bugfix for the prefix part.

OK. ... Ah, no, the call in run_builtin() is a new thing.  We didn't
have it, and the redundant call is what this patch introduced, so
we need to be a bit more careful about the analysis here.  It is one
thing to say "we leave the existing iffy code and address only a
single bug" and do so.  It is entirely different to say so and then
do "we introduce an iffy code and address only a single bug".  We
need to admit that what we added _is_ iffy but supposed to be safe.
Just saying "it is supposed to be safe" without saying why it is
iffy is dishonest and does not help future developers who may want
to jump in and clean the code.

Perhaps

	Now add it into git.c::run_builtin() as well.  Existing
	precompose calls in diff-files.c and others would become
	redundant but because we do not want to make sure that there
	is no way for the control to reach them without passing
	run_builtin(), we'll keep them in place just in case.  The
	calls to precompose() are idempotent so it should not hurt.

or something?

>  - And yes, there may be more work to be done. For the moment I would l=
ike to
>    get this merged into git.git, and address the rest later.

Sure.

Thanks.
