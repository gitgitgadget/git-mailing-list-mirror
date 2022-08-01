Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAEEC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 22:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiHAWQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHAWQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 18:16:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A920F45
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 15:16:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94B6713B4F1;
        Mon,  1 Aug 2022 18:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VaiM5S85bHVFgnNHMXIhPPrulNm0pNmnHW14gH
        CfpcE=; b=KPGM5T9ICmsvl14Vjw4BiBjEprpMl5pTC2jxbg2LEbSv6VtWK/Yf/3
        511jJL44eSD6AkNgICgjmwnp+cb2TJZkq323ecPJP2NXqcCjVWj5LCgSJWR/3toG
        YQ2Yg7a4VB1pz/SpRqaVA8sG3QZbdIZH//j6B5XCF4m9+tgPRu6+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BF0C13B4F0;
        Mon,  1 Aug 2022 18:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5CC013B4EE;
        Mon,  1 Aug 2022 18:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/7] builtin/bugreport.c: create '--diagnose' option
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 15:16:48 -0700
In-Reply-To: <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:53
        +0000")
Message-ID: <xmqqtu6vmwxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3AEC9CE-11E7-11ED-9874-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Create a '--diagnose' option for 'git bugreport' to collect additional
> information about the repository and write it to a zipped archive.
>
> The "diagnose" functionality was originally implemented for Scalar in
> aa5c79a331 (scalar: implement `scalar diagnose`, 2022-05-28). However, the
> diagnostics gathered are not specific to Scalar-cloned repositories and
> could be useful when diagnosing issues in any Git repository.
>
> Note that, while this patch appears large, it is mostly copied directly out
> of 'scalar.c'. Specifically, the functions
>
> - dir_file_stats_objects()
> - dir_file_stats()
> - count_files()
> - loose_objs_stats()
> - add_directory_to_archiver()
> - get_disk_info()

Yup.  As this does not "move" code across from older place to the
new home, it takes a bit of processing to verify the above claim,
but

 $ git blame -C -C -C -s -b master.. -- builtin/bugreport.c

shows that these are largely verbatim copies.

> +#ifndef WIN32
> +#include <sys/statvfs.h>
> +#endif
> +
> +static int get_disk_info(struct strbuf *out)
> +{
> +#ifdef WIN32
> +	struct strbuf buf = STRBUF_INIT;
> +...
> +	strbuf_addf(out, "Available space on '%s': ", buf.buf);
> +	strbuf_humanise_bytes(out, avail2caller.QuadPart);
> +...
> +#else
> +...
> +	strbuf_addf(out, "Available space on '%s': ", buf.buf);
> +	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
> +...
> +#endif
> +	return 0;
> +}

As a proper part of Git, this part should probably be factored out
so that a platform specific helper function, implemented in compat/
layer, grabs "available disk space" number in off_t and the caller
of the above function becomes

	strbuf_realpath(&dir, ".", 1);
	strbuf_addf(out, "Available space on '%s:' ", dir.buf);
	strbuf_humanise_bytes(out, get_disk_size(dir.buf));

or something, without having to have #ifdef droppings.

> +static int create_diagnostics_archive(struct strbuf *zip_path)
> +{

Large part of this function is also lifted from scalar, and it looks
OK.  One thing I noticed is that "res" is explicitly initialized to
0, but given that the way the code is structured to use the "we
process sequencially in successful case, and branch out by 'goto'
immediately when we see a breakage" pattern, it may be better to
initialize it to -1 (i.e. assume error), or even better, leave it
uninitialized (i.e. let the compiler notice if a jump to cleanup is
made without setting res appropriately).

> +diagnose_cleanup:
> +	if (archiver_fd >= 0) {
> +		close(1);
> +		dup2(stdout_fd, 1);
> +	}
> +	free(argv_copy);
> +	strvec_clear(&archiver_args);
> +	strbuf_release(&buf);

Hmph, stdout_fd is a copy of the file descriptor 1 that was saved
away at the beginning.  Then archiver_fd was created to write into
the zip archive, and during the bulk of the function it was dup2'ed
to the file descriptor 1, to make anything written to the latter
appear in the zip output.

When we successfully opened archive_fd but failed to dup2(), we may
close a wrong file desciptor 1 here, but we recover from that by
using the saved-away stdout_fd, so we'd be OK.  If we did dup2(),
then we would be OK, too.

I am wondering if archiver_fd itself is leaking here, though.

Also, if we failed to open archiver_fd, then we have stdout_fd
leaking here, I suspect.

> +	return res;
> +}

Other than that, looks good to me.
