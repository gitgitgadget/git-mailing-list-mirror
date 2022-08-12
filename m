Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A9C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHLUcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLUcD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:32:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61CCB07EE
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:32:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6010813D8E1;
        Fri, 12 Aug 2022 16:32:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2t4dP7SN0HrC2WSLAZtY/4kkS7TZHZ5oKqiNBE
        jL3CE=; b=Un8pAqouc2uEANUgsMlR/q7P/jbNWqM9Q2knH7VdF3MLiAUGD/jiH5
        26s/bCEPTSHw9L3g5RE+lCeH/jSQH2SKWpS4k5jbff4q5GpY4nTX3xMR9IdZ0crQ
        VcmvI4YrzUnVWOQrkeAgYLryx6OXW/DeXNbLmv1dFQY6iOgrlZMgE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52CB613D8E0;
        Fri, 12 Aug 2022 16:32:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B38D13D8DF;
        Fri, 12 Aug 2022 16:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 06/11] diagnose.c: add option to configure archive
 contents
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
        <710b67e5776363d199ed5043d019386819d44e7e.1660335019.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 13:31:58 -0700
In-Reply-To: <710b67e5776363d199ed5043d019386819d44e7e.1660335019.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 12 Aug 2022 20:10:14
        +0000")
Message-ID: <xmqq35e1b3up.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0E96482-1A7D-11ED-8D51-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -int create_diagnostics_archive(struct strbuf *zip_path)
> +int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
>  {
>  	struct strvec archiver_args = STRVEC_INIT;
>  	char **argv_copy = NULL;
>  	int stdout_fd = -1, archiver_fd = -1;
>  	struct strbuf buf = STRBUF_INIT;
> -	int res;
> +	int res, i;
> +	struct archive_dir archive_dirs[] = {
> +		{ ".git", 0 },
> +		{ ".git/hooks", 0 },
> +		{ ".git/info", 0 },
> +		{ ".git/logs", 1 },
> +		{ ".git/objects/info", 0 }
> +	};
> +
> +	if (mode == DIAGNOSE_NONE) {
> +		res = 0;
> +		goto diagnose_cleanup;
> +	}
>  
>  	stdout_fd = dup(STDOUT_FILENO);
>  	if (stdout_fd < 0) {
> @@ -177,12 +194,18 @@ int create_diagnostics_archive(struct strbuf *zip_path)
>  	loose_objs_stats(&buf, ".git/objects");
>  	strvec_push(&archiver_args, buf.buf);
>  
> -	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
> -		goto diagnose_cleanup;
> +	/* Only include this if explicitly requested */
> +	if (mode == DIAGNOSE_ALL) {
> +		for (i = 0; i < ARRAY_SIZE(archive_dirs); i++) {
> +			if (add_directory_to_archiver(&archiver_args,
> +						      archive_dirs[i].path,
> +						      archive_dirs[i].recursive)) {
> +				res = error_errno(_("could not add directory '%s' to archiver"),
> +						  archive_dirs[i].path);
> +				goto diagnose_cleanup;
> +			}
> +		}
> +	}

Even without the "only include under DIAGNOSE_ALL" support added by
this step, the table-driven organization is much nicer.  The earlier
"move to common" step aimed to be as close as pure move, so this
step is our first opportunity to make this clean-up, so I do not
mind too much about this step doing two unrelated things (one is to
clean-up the if (A||B||C) into a loop over A, B and C, the other is
to introduce the diagnose_mode) at once.

Thanks.


