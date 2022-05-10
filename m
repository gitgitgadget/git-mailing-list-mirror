Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85120C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiEJV4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 17:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiEJV4l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 17:56:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE62A30BF
        for <git@vger.kernel.org>; Tue, 10 May 2022 14:56:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8507D18D65B;
        Tue, 10 May 2022 17:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8oH+i3Iij6iyONjYHzeoUGHCP/1owrNSXOxTu
        rZ7ZY=; b=GEQ06kuAqxOpk3gzlOLv1tM95msrn10gJtWSesPQ5O1RYwACXaO+54
        ot4TYQIMQGW0U2lUfzC6HKEMy3Gayuz8LPAn8c/63b/P8+XTWMIRr+oPdXC6Gwh6
        8DPndj658G//CC6Sdah43xyGs+VUxkf24tXFa7SGlJvpSdx+8PK7A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D4C418D65A;
        Tue, 10 May 2022 17:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 247CD18D657;
        Tue, 10 May 2022 17:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/7] archive --add-file-with-contents: allow paths
 containing colons
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 14:56:31 -0700
In-Reply-To: <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 10 May 2022
        19:26:59 +0000")
Message-ID: <xmqqmtfp6ohc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E216942-D0AC-11EC-B9EE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> By allowing the path to be enclosed in double-quotes, we can avoid
> the limitation that paths cannot contain colons.
> ...
> +		struct strbuf buf = STRBUF_INIT;
> +		const char *p = arg;
> +
> +		if (*p != '"')
> +			p = strchr(p, ':');
> +		else if (unquote_c_style(&buf, p, &p) < 0)
> +			die(_("unclosed quote: '%s'"), arg);

Even though I do not think people necessarily would want to use
colons in their pathnames (it has problems interoperating with other
systems), lifting the limitation is a good thing to do.  I totally
forgot that we designed unquote_c_style() to self terminate and
return the end pointer to the caller so the caller does not have to
worry, which is very nice. 

Even if this step weren't here in the series, I would have thought
the mode bits issue was more serious than "no colons in path"
limitation, but given that we address this unusual corner case
limitation, I would think we should address the hardcoded mode bits
at the same time.

> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 8ff1257f1a0..5b8bbfc2692 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -207,13 +207,21 @@ check_zip with_untracked
>  check_added with_untracked untracked untracked
>  
>  test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
> +	if test_have_prereq FUNNYNAMES
> +	then
> +		QUOTED=quoted:colon
> +	else
> +		QUOTED=quoted
> +	fi &&

;-)

>  	git archive --format=zip >with_file_with_content.zip \
> +		--add-file-with-content=\"$QUOTED\": \
>  		--add-file-with-content=hello:world $EMPTY_TREE &&
>  	test_when_finished "rm -rf tmp-unpack" &&
>  	mkdir tmp-unpack && (
>  		cd tmp-unpack &&
>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>  		test_path_is_file hello &&
> +		test_path_is_file $QUOTED &&

Looks OK, even though it probably is a good idea to have dq around
$QUOTED, so that future developers can easily insert SP into its
value to use a bit more common but still a bit more problematic
pathnames in the test.

Thanks.
