Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F27BC4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656026101C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhHaGUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:20:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhHaGUK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:20:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC8C113B74D;
        Tue, 31 Aug 2021 02:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fWgotW4D5Qrpw5eWOLm2j5zuI6RGBS4rU//smt
        LXs2Q=; b=sc+KZwBD58/OYKS1Z6Pa9GOFyN3ccHF/jHPiXMPGleq0K5d/uhX+Zz
        E9X0+swiY2fq1LR20kzhUSDNWMKkezGsaFzhlGGiC1IhZOsSTKN5hQEpI6SgySjb
        QII45B87FM+KjSniSyn2k4V/pecuzxEuMmBdTCPooqsFSCLb+c0nc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A52C313B74C;
        Tue, 31 Aug 2021 02:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED74F13B74B;
        Tue, 31 Aug 2021 02:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH v2 2/3] diff --submodule=diff: do not fail on
 ever-initialied deleted submodules
References: <20210802170004.4103535-1-dturner@twosigma.com>
        <20210802170004.4103535-2-dturner@twosigma.com>
Date:   Mon, 30 Aug 2021 23:19:11 -0700
In-Reply-To: <20210802170004.4103535-2-dturner@twosigma.com> (David Turner's
        message of "Mon, 2 Aug 2021 13:00:03 -0400")
Message-ID: <xmqqsfyqxhk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C46135C-0A23-11EC-8FD1-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> If you have ever initialized a submodule, open_submodule will open it.
> If you then delete the submodule's worktree directory (but don't
> remove it from .gitmodules), git diff --submodule=diff would error out
> as it attempted to chdir into the now-deleted working tree directory.
>
> Instead, we chdir into the submodule's git directory and run the diff
> from there.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  submodule.c                                  |  10 ++
>  t/t4060-diff-submodule-option-diff-format.sh | 157 +++++++++++++++++++++++++--
>  2 files changed, 160 insertions(+), 7 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..d13d103975 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -710,6 +710,16 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>  		strvec_push(&cp.args, oid_to_hex(new_oid));
>  
>  	prepare_submodule_repo_env(&cp.env_array);
> +
> +	if (!is_directory(path)) {
> +		// fall back to absorbed git dir, if any

I'll locally amend this comment style.  If there is no other
comments, that would be sufficient.

> +		if (!sub)
> +			goto done;
> +		cp.dir = sub->gitdir;
> +		strvec_push(&cp.env_array, GIT_DIR_ENVIRONMENT "=.");
> +		strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT "=.");
> +	}
> +
>  	if (start_command(&cp))
>  		diff_emit_submodule_error(o, "(diff failed)\n");
