Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A4C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5185D61430
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhEJFKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:10:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62029 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhEJFKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:10:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDD6E12E5B7;
        Mon, 10 May 2021 01:09:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wqoO9KzJki7jriqUYRELOo9eZB5TRSR6i4qe4S
        uj7i0=; b=Pwp619e3H/FEf2/gppwQkHgRhuvZmU7M+S1Ra750XL6qeirHe089+Q
        zrJrDw1pBF0PikBOs8m7ZJElEV3QQPZKMasZDYOR7xZnW3/+143QctRjFymayg1+
        vf/hcETmS3kEaGwpOGeMbB88FzmjVjkzYxSQPocOYoyBP2/AzdBX0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAF4D12E5B6;
        Mon, 10 May 2021 01:09:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D36F912E5B5;
        Mon, 10 May 2021 01:09:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/8] [RFC] ls-files: error out on -i unless -o or -c
 are specified
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <44a1322c44026e675ea254a00f3b50d4955ac56e.1620503945.git.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 14:09:20 +0900
In-Reply-To: <44a1322c44026e675ea254a00f3b50d4955ac56e.1620503945.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        19:58:59 +0000")
Message-ID: <xmqqbl9jrx8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E18071FE-B14D-11EB-A7F8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	if (pathspec.nr && error_unmatch)
>  		ps_matched = xcalloc(pathspec.nr, 1);
>  
> +	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
> +		die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
> +

So "git ls-files -i" would suddenly start erroring out and users are
to scramble and patch their scripts?

More importantly, the message does not make much sense.  "I is
usually used with O" is very true, but the mention of "usually" here
means it is not an error for "I" to be used without "O".  That part
is very understandable and correct.

But I do not know what "but --cached is the default" part wants to
say.  If it is the _default_, and (assuming that what I read in the
proposed log message is correct) the combination of "-i -c" is valid,
then I would understand the message if the code were more like this:

	if ((dir.flags & DIR_SHOW_IGNORED) &&
	    !show_others && !show_cached) {
		show_cached = 1; /* default */
		warning("ls-files -i given without -o/-c; defaulting to -i -c");
	}

If we are not defaulting to cached, then

	die("ls-files -i must be used with either -o or -c");

would also make sense.

The variant presented in the patch does not make sense to me.

> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> index dd87b43be1a6..40d3c42618c0 100755
> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -116,7 +116,7 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
>  test_expect_success 'Checking XDG ignore file when HOME is unset' '
>  	(sane_unset HOME &&
>  	 git config --unset core.excludesfile &&
> -	 git ls-files --exclude-standard --ignored >actual) &&
> +	 git ls-files --exclude-standard --ignored --others >actual) &&
>  	test_must_be_empty actual
>  '
>  
> diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
> index d5ec333131f9..c41c4f046abf 100755
> --- a/t/t3003-ls-files-exclude.sh
> +++ b/t/t3003-ls-files-exclude.sh
> @@ -29,11 +29,11 @@ test_expect_success 'add file to gitignore' '
>  '
>  check_all_output
>  
> -test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
> +test_expect_success 'ls-files -i -c lists only tracked-but-ignored files' '
>  	echo content >other-file &&
>  	git add other-file &&
>  	echo file >expect &&
> -	git ls-files -i --exclude-standard >output &&
> +	git ls-files -i -c --exclude-standard >output &&
>  	test_cmp expect output
>  '
