Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C88BC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5716B610CE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhIMT0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:26:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61863 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhIMT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:26:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AF8DD50C1;
        Mon, 13 Sep 2021 15:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/ZfAQm1YJD7Y
        Xle7i42zO4Gi2aHALb+qpcVUQeCBs0k=; b=JS4wyrjB7ZuKNRiF5erZFqmhE0Py
        y8uA0Pv1c+fm5MfPFqJGo35QQrZLmGdX9/id0rG453zxFKhPH/3Faz4YOTf7nV+U
        XHhb2TYj2uFbXmxRjoGgw0Guw7lnYC98tciWBCzddDwg8rkGmPNNqj5chSxgxI6T
        DxLzHBKZKl6U324=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11734D50C0;
        Mon, 13 Sep 2021 15:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12ED5D50BF;
        Mon, 13 Sep 2021 15:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH 1/2] help: make sure local html page exists before
 calling external processes
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
        <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 12:25:11 -0700
In-Reply-To: <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Mon, 13
 Sep 2021
        11:06:57 +0000")
Message-ID: <xmqqa6kgffc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50A9F9B4-14C8-11EC-839C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/help.c b/builtin/help.c
> index b7eec06c3de..77b1b926f60 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -467,11 +467,18 @@ static void get_html_page_path(struct strbuf *pag=
e_path, const char *page)
>  	if (!html_path)
>  		html_path =3D to_free =3D system_path(GIT_HTML_PATH);
> =20
> -	/* Check that we have a git documentation directory. */
> +	/*
> +	 * Check that we have a git documentation directory and the page we'r=
e
> +	 * looking for exists.
> +	 */
>  	if (!strstr(html_path, "://")) {
>  		if (stat(mkpath("%s/git.html", html_path), &st)
>  		    || !S_ISREG(st.st_mode))
>  			die("'%s': not a documentation directory.", html_path);
> +		if (stat(mkpath("%s/%s.html", html_path, page), &st)
> +		    || !S_ISREG(st.st_mode))
> +			die("'%s/%s.html': documentation file not found.",
> +				html_path, page);

I do not remember why we did not originally use the "page"
information and only checked "git.html", but because the "page" is
ultimately what the end-user will see, I wonder if it even makes
sense to still check "git.html" anymore.

If the request were "git help -w git", the new check added here
would catch the missing page, and for "git help -w log", it is
unfair to call the directory that we successfully found the
"git-log.html" in as "not a doc directory" only because it is for
whatever reason is missing "git.html" next to it.

It seems that this check dates back to 482cce82 (help: make
'git-help--browse' usable outside 'git-help'., 2008-02-02); even in
the context of that commit, I think it would have been better to
check for the generated page_path instead of git.html, so I actually
prefer to see the existing hardcoded check for git.html replaced with
the new check.

Thanks.


>  	}
> =20
>  	strbuf_init(page_path, 0);
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 5679e29c624..a83a59d44d9 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -77,6 +77,13 @@ test_expect_success 'generate builtin list' '
>  	git --list-cmds=3Dbuiltins >builtins
>  '
> =20
> +test_expect_success 'git help fails for non-existing html pages' '
> +	configure_help &&
> +	mkdir html-doc &&
> +	touch html-doc/git.html &&
> +	test_must_fail git -c help.htmlpath=3Dhtml-doc help status
> +'
> +
>  while read builtin
>  do
>  	test_expect_success "$builtin can handle -h" '
