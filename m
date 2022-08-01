Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E52C19F2D
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 22:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHAWbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiHAWba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 18:31:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43AB220F5
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 15:31:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E379315319E;
        Mon,  1 Aug 2022 18:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E2lfbdUwjNtJCffeibMX/HHr7d8MEo64Uqx+Rf
        7DYEw=; b=EzJ8OlRIkAReAP/dZG4LRZ0SBg77bXQsKcOaJJ2+dsZh/PkJV0IhUc
        jj270wdhdkdr11JfyaceYT4itQcligQx7BGcwn9liOlVdmbvVsAgakkcO1AEF2Yo
        COtcnqSt0tDHBcHF5I3VcniVTDivlP38MB+T+dp6IAYuzXAPpuk/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA66115319D;
        Mon,  1 Aug 2022 18:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C32815319C;
        Mon,  1 Aug 2022 18:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 5/7] builtin/bugreport.c: add '--no-report' option
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <d6527049a4f62f3b1f008706443a11a0e0816074.1659388498.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 15:31:27 -0700
In-Reply-To: <d6527049a4f62f3b1f008706443a11a0e0816074.1659388498.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:56
        +0000")
Message-ID: <xmqqbkt3mw8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF3B4CC0-11E9-11ED-BAFA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add a '--no-report' option to 'git bugreport' to avoid writing the
> 'git-bugreport-<suffix>.txt' file. This gives users the option of creating
> only the diagnostic archive with '--diagnose' and mirroring the behavior of
> the original 'scalar diagnose' as closely as possible.
>
> If a user specifies '--no-report' *without* also specifying '--diagnose',
> the 'git bugreport' operation is a no-op; a warning message is printed and
> the command returns with a non-error exit code.

I think this makes sense from scalar side, and I have no objection
against this "--no-report" feature existing, but I wonder if those
who want to send report may want to have a handy way to tell the
command to "include" the diag archive in their report (instead of
creating separate report and diagnose files, having to attach two
files to their message).  Perhaps that is unneeded, or perhaps that
comes in later patches in the series, I dunno.

> +--no-report::
> +	Do not write out a 'git-bugreport-<suffix>.txt' file. This option is
> +	intended for use with `--diagnose` when only the diagnostic archive is
> +	needed. If `--no-report` is used without `--diagnose`, `git bugreport`
> +	is a no-op.

I wonder if thinking it this way may make the UI simpler to explain.

The "git bugreport" is capable of showing report and diagnose with
these two orthogonal options, i.e.

	--report::	writes bugreport file
	--diagnose::	writes diagnostic archive

And for backward compatibility reasons, the command pretends as if
you gave it "--report" when you run it without either.

That way, "bugreport --diagnose" will just show diagnostic archive
without having to pass "--no-report".  There is no need for "nothing
to do", either.

