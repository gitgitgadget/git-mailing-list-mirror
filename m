Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A09C00140
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 00:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiHKAQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 20:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHKAQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 20:16:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707372EF7
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 17:16:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26C241A1331;
        Wed, 10 Aug 2022 20:16:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJgIQXZ3sgCzygdXihrYrm/q9E4SMQAUeN5UbZ
        pMCFY=; b=jTO1hILxSCfTW1ahIpfIFxRLIOwapWOQRGQCMzHyMHSmUopfaQmqlx
        m0Ba9xok/yf/1SISV9hwlj9paxxUyrSAZomTJr2wZ6pOsSktvKjh5MsBSwsbmTbm
        nlc9ulJv+lWA8/MZ416b0rzvWz1wUXDIolD9J/PR20KLcYUN7IWB0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E8B31A1330;
        Wed, 10 Aug 2022 20:16:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A93EE1A132F;
        Wed, 10 Aug 2022 20:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 06/11] diagnose.c: add option to configure archive
 contents
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 17:16:24 -0700
In-Reply-To: <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Wed, 10 Aug 2022 23:34:28
        +0000")
Message-ID: <xmqq8rnviqhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D67B5140-190A-11ED-B451-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -177,11 +182,13 @@ int create_diagnostics_archive(struct strbuf *zip_path)
>  	loose_objs_stats(&buf, ".git/objects");
>  	strvec_push(&archiver_args, buf.buf);
>  
> -	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> -	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
> +	/* Only include this if explicitly requested */
> +	if (mode == DIAGNOSE_ALL &&
> +	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> +	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
>  		goto diagnose_cleanup;

At first glance, it looks as if this part fails silently, but
add_directory_to_archiver() states what failed there, so we show
necessary error messages and do not silently fail, which is good.

There is a "failed to write archive" message after write_archive()
call returns non-zero, but presumably write_archive() itself gives
diagnostics (like "oh, I was told to archive this file but I cannot
read it") when it does so, so in a sense, giving the concluding
"failed to write" only in that case might make the error messages
uneven.  If we fail to enlist ".git/hooks" directory, we may want to
say why we failed to do so, and then want to see the concluding
"failed to write" at the end, just like the case where write_archive()
failed.

It is a truely minor point, and if it turns out to be worth fixing,
it can be easily done by moving the diagnose_clean_up label a bit
higher, i.e.

	...
	res = write_archive(...);

diagnose_cleanup:
	if (res)
		error(_("failed to write archive"));
	else
        	fprintf(stderr, "\n"
			"Diagnostics complete.\n"
			"All of the gathered info is captured in '%s'\n",
			zip_path->buf);

	if (archiver_fd >= 0) {
		... restore FD#1 and close stdout_fd and archiver_fd
	}
	...


Other than that, this new patch looks good to me.

Thanks.
