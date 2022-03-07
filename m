Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E689C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 05:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiCGF5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 00:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiCGF5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 00:57:06 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F55D67F
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 21:56:12 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 992F8174135;
        Mon,  7 Mar 2022 00:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9k9zWkCgh4mAjN41yayyLrN9krcJ8ysvNptNN
        ZxAzg=; b=RWMYRy7Jo69XN6XylTgVAcskDx03qxTqaAup53eYT67unfPV8Q7EdK
        xQv8ya+mievwZ98hLLDlD/8Egsit4yUyS6r7Xicm+Bii2ZaXlf7LTX++aHtN73ZO
        63zKWkMTWytxRj+rWnn/P19OamYx71oA/rg4nNza0wA+GzGU43UIY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84A97174134;
        Mon,  7 Mar 2022 00:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1BE0174132;
        Mon,  7 Mar 2022 00:56:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] cat-file: skip expanding default format
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
Date:   Sun, 06 Mar 2022 21:56:08 -0800
In-Reply-To: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 04 Mar 2022 21:37:25 +0000")
Message-ID: <xmqqmti2uwzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4903E318-9DDB-11EC-933B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> When format is passed into --batch, --batch-check, --batch-command,
> the format gets expanded. When nothing is passed in, the default format
> is set and the expand_format() gets called.
>
> We can save on these cycles by hardcoding how to print the
> information when nothing is passed as the format, or when the default
> format is passed. There is no need for the fully expanded format with
> the default. Since batch_object_write() happens on every object provided
> in batch mode, we get a nice performance improvement.

That is OK in principle, but ...

> +	if (!opt->format && !opt->print_contents) {
> +		char buf[1024];
> +
> +		print_default_format(buf, 1024, data);
> +		batch_write(opt, buf, strlen(buf));
> +		goto cleanup;
> +	}
> +
> +	fmt = opt->format ? opt->format : default_format;

... instead of doing this, wouldn't it be nicer to base the decision
to call print_default_format() on purely the contents of the format,
i.e.

	fmt = opt->format ? opt->format : default_format;
	if (!strcmp(fmt, DEFAULT_FORMAT) && !opt->print_contents) {
		... the above print_default_format() call block here ...
		goto cleanup;
	}

where DEFAULT_FORMAT is 

#define DEFAULT_FORMAT = "%(objectname) %(objecttype) %(objectsize)"

and

> @@ -515,9 +543,7 @@ static int batch_objects(struct batch_options *opt)
>  	struct expand_data data;
>  	int save_warning;
>  	int retval = 0;
> -
> -	if (!opt->format)
> -		opt->format = "%(objectname) %(objecttype) %(objectsize)";

retain the defaulting with

	if (!opt->format)
		opt->format = DEFAULT_FORMAT;

instead of making opt->format == NULL to mean something special?

That way, even if the user-input happens to name the format that is
identical to DEFAULT_FORMAT, because we only care what the format
is, and not where the format comes from, we will get the same
optimization.  Wouldn't it make more sense?

