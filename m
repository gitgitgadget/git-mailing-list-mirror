Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC01C25B0F
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHLU0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHLU0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:26:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99793535
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:26:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E13701B1AB2;
        Fri, 12 Aug 2022 16:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XpOMkY2TvKa2/19LJ6O4+WrU+iIj9UmedZvGBL
        ymMA4=; b=C5SWkbd4y5bBCprRL/V05CIb746TcHT/C4hmePH/YlRvRl2ioLiAIz
        cURfurJLPGi8Yg4fnDYdEr17nEEKQWQS/5OQk2nTIG6l3QlrnNeoHwCtOrkY6W/l
        G6GHiWahNvalJ25aar3qsEtdNus9kF6eNf4rXMj/oBEytBvSx54zs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D921F1B1AB1;
        Fri, 12 Aug 2022 16:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 893BB1B1AB0;
        Fri, 12 Aug 2022 16:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 05/11] scalar-diagnose: move functionality to common
 location
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
        <c19f3632d4f2f966517a276e7096742c8477125c.1660335019.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 13:26:24 -0700
In-Reply-To: <c19f3632d4f2f966517a276e7096742c8477125c.1660335019.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 12 Aug 2022 20:10:13
        +0000")
Message-ID: <xmqq7d3db43z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09C95772-1A7D-11ED-8593-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
> +			    the_repository, NULL, 0);
> +	if (res) {
> +		error(_("failed to write archive"));
> +		goto diagnose_cleanup;
> +	}
> +
> +	fprintf(stderr, "\n"
> +		"Diagnostics complete.\n"
> +		"All of the gathered info is captured in '%s'\n",
> +		zip_path->buf);
> +
> +diagnose_cleanup:
> +	if (archiver_fd >= 0) {
> +		dup2(stdout_fd, STDOUT_FILENO);
> +		close(stdout_fd);
> +		close(archiver_fd);
> +	}

Hmph, after reading 

https://lore.kernel.org/git/32f2cadc-556e-1cd5-a238-c8f1cdaaf470@github.com/

I would have expected to see the above part more like:

                res = write_archive(...);

        diagnose_cleanup:
                if (res)
                        error(...);
                else
                        fprintf(stderr, "Diag complete");

                if (archiver_fd >= 0) {
                        ...

