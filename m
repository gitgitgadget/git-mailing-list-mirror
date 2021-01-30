Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8516AC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDFF64DE2
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhA3JQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:16:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57901 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhA3JO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:14:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 228CF9DE18;
        Sat, 30 Jan 2021 03:08:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=aBtviodje96nkazp1YqhGeFHUE8=; b=bi9rcVlBTNKd2aDYeBO+
        SxNDQFoMAGEWdLOfGygnO+x8APvGJdcND7DiRrVu5hoAxCKJkH4K4ehoOtU7k8GN
        OYSAEpUzjwRUexvvw0Mjo4WzBNhWhK+0FHATC8fK55L7MBwIfNX7UjyMN4FfZVlw
        D/o0b6uQeGR3Q+vOygcjHWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=EWW0DmxZbYMhvbifG30V7ZL+TO+l/NePLG51sdv9RiIu5s
        kYNUEnnV9pnbm7ZJnzIRJwUnpkzRNBba9RaqqiNuBtt/SqlS6hxYjmhpH1fJ9bBa
        usUtrEth+WwqM/Kr2T2s8VaGd09zLRSkmkgDjQVn6jWQRSOOisY8JwV+ASTjI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B3899DE17;
        Sat, 30 Jan 2021 03:08:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D1029DE16;
        Sat, 30 Jan 2021 03:08:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v10 1/3] mergetool: add hideResolved configuration
References: <20201228192919.1195211-1-seth@eseth.com>
        <20210130054655.48237-1-seth@eseth.com>
        <20210130054655.48237-2-seth@eseth.com>
Date:   Sat, 30 Jan 2021 00:08:10 -0800
Message-ID: <xmqqmtwqq239.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B0BE646-62D2-11EB-A118-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> +mergetool.hideResolved::
> +	During a merge Git will automatically resolve as many conflicts as
> +	possible and then wrap conflict markers around any conflicts that it
> +	cannot resolve. This flag writes the non-conflicting parts into the
> +	corresponding 'LOCAL' and 'REMOTE' files so that only the unresolved
> +	conflicts are presented to the merge tool. Can be overriden per-tool
> +	via the `mergetool.<tool>.hideResolved` configuration variable.
> +	Defaults to `true`.

This description makes the readers expect that the configuration
variable is a boolean, and setting it to 'no' would disable the
feature, but ...

> @@ -322,6 +331,11 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> +	if test "$(git config --get mergetool.hideResolved)" != "false"

... without --type=bool, any boolean 'false' value that is not
exactly spelled 'false' won't be normalized and fail this test.

I haven't read the remaining 2 patches, so I cannot yet tell if I
can just insert "--type=bool" here and everything would be fine,
or if there are other fallouts for doing so.

> +	then
> +		hide_resolved
> +	fi
> +
>  	if test -z "$local_mode" || test -z "$remote_mode"
>  	then
>  		echo "Deleted merge conflict for '$MERGED':"
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 70afdd06fa..0e34b87e37 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'mergetool hideResolved' '
> +	test_config mergetool.hideResolved true &&
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test${test_count}_b master &&

As a new feature, this should work with the tip of 'master', but I
think the t7610 test forces the initial branch name to be 'main'.

I'll tweak locally while queuing.

> +	test_write_lines >file1 base "" a &&
> +	git commit -a -m "base" &&
> +	test_write_lines >file1 base "" c &&
> +	git commit -a -m "remote update" &&
> +	git checkout -b test${test_count}_a HEAD~ &&
> +	test_write_lines >file1 local "" b &&
> +	git commit -a -m "local update" &&
> +	test_must_fail git merge test${test_count}_b &&
> +	yes "" | git mergetool file1 &&
> +	test_write_lines >expect local "" c &&
> +	test_cmp expect file1 &&
> +	git commit -m "test resolved with mergetool"
> +'
> +
>  test_done
