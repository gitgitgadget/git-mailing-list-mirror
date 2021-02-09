Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689FC433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7173B64E5A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhBIWWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:22:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62646 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhBIWJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E28CB0F39;
        Tue,  9 Feb 2021 16:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W9UerNt6EBnrwe0vUfGuIgoe0J4=; b=UZs0MY
        s0S4nDXoupXouElAPqPTNBREn8Erd2s74av9mHuOwSwo0CMglagZj8uZirtrXMd2
        oDBqPIqTfTpgVFF7MD9c+3cMrhL1zoYz7s7zPg9P3FOaacGpovoJkYTDTVa8m1l5
        MoBMbORJFLZQiLsf6dRedgfOxoX8W+R6U29ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KqSuO5EfmIU4nMnnj9PujYbdNZUyFSj5
        gtyAU53vq8IbgNNMmRqIptdMWO6p3np0FIUeiFsJHdl+ZctpzvyquhNlAmRP3cg/
        542631zdI54lPidZPwpRq3wmTFOJx4OmLy1PW4nhp1yEL3ZXd+lRytSxy946eSYs
        KAWi02t2sYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 046DDB0F38;
        Tue,  9 Feb 2021 16:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FCD1B0F37;
        Tue,  9 Feb 2021 16:35:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] checkout-index: omit entries with no tempname from
 --temp output
References: <cover.1612812581.git.matheus.bernardino@usp.br>
        <1275701345b7e198ec83ad4fdcc2dda6d9775ef3.1612812581.git.matheus.bernardino@usp.br>
Date:   Tue, 09 Feb 2021 13:35:36 -0800
In-Reply-To: <1275701345b7e198ec83ad4fdcc2dda6d9775ef3.1612812581.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 8 Feb 2021 16:36:32 -0300")
Message-ID: <xmqqmtwczzyv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFBA4F74-6B1E-11EB-BE66-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> With --temp (or --stage=all, which implies --temp), checkout-index
> writes a list to stdout associating temporary file names to the entries'
> names. But if it fails to write an entry, and the failure happens before
> even assigning a temporary filename to that entry, we get an odd output
> line. This can be seen when trying to check out a symlink whose blob is
> missing:
>
> $ missing_blob=$(git hash-object --stdin </dev/null)
> $ git update-index --add --cacheinfo 120000,$missing_blob,foo
> $ git checkout-index --temp foo
> error: unable to read sha1 file of foo (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
>         foo
>
> The 'TAB foo' line is not much useful and it might break scripts that
> expect the 'tempname TAB foo' output. So let's omit such entries from
> the stdout list (but leaving the error message on stderr).

Makes quite a lot of sense.

>  	if (CHECKOUT_ALL == checkout_stage) {
> -		for (i = 1; i < 4; i++) {
> -			if (i > 1)
> -				putchar(' ');
> -			if (topath[i][0])
> -				fputs(topath[i], stdout);
> -			else
> -				putchar('.');
> +		for (i = 1; i < 4; i++)
> +			if (topath[i][0]) {
> +				have_tempname = 1;
> +				break;
> +			}
> +
> +		if (have_tempname) {
> +			for (i = 1; i < 4; i++) {
> +				if (i > 1)
> +					putchar(' ');
> +				if (topath[i][0])
> +					fputs(topath[i], stdout);
> +				else
> +					putchar('.');
> +			}
>  		}
> -	} else
> +	} else if (topath[checkout_stage][0]) {
> +		have_tempname = 1;
>  		fputs(topath[checkout_stage], stdout);
> +	}
>  
> -	putchar('\t');
> -	write_name_quoted_relative(name, prefix, stdout,
> -				   nul_term_line ? '\0' : '\n');
> +	if (have_tempname) {
> +		putchar('\t');
> +		write_name_quoted_relative(name, prefix, stdout,
> +					   nul_term_line ? '\0' : '\n');
>  
> -	for (i = 0; i < 4; i++) {
> -		topath[i][0] = 0;
> +		for (i = 0; i < 4; i++) {
> +			topath[i][0] = 0;
> +		}
>  	}

Hmph, is topath[][] array used after this function gets called and
in what way?  Whether have_tempname is true or not, wouldn't we want
to clear it?

Thanks.

