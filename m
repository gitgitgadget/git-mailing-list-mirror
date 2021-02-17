Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBFC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E9364E5B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 10:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBQKcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 05:32:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58932 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhBQKcL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 05:32:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62EEE11CA6F;
        Wed, 17 Feb 2021 05:31:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rtdFoAnHY2VuO7A3/sEUedEiQuo=; b=P8T0s36VPOOaJUC8JPDz
        JyYd0prMkKpIBcZ6Op0BHZUh8E/qNV2b98BuwD1/vR2yQQujzvqFKStr6NqgaPXy
        jvEHjAFU+a/av6gvzPFGtGERI+P0oMthTgi58/3Cj0WSrirwlYnnEHe07aQLouD+
        QHEsYoilCEB9n+6x5XQCfy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=uG2Od7yuYPd4rLeafE0Os2SPbmkAiViFKi93JbSfEMbaKq
        3M0XBDkaMp41764+pYWEz94YIKzSp1jEvNTWZov4tEGdj2KHN3wjlB1V5UQPuC5p
        jUp8apQXrHw/3X1cguYlyEN3mDWNrUy28JTlYE9ig6zRCqLYBVxexntFRg3D4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B29011CA6E;
        Wed, 17 Feb 2021 05:31:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6C7B11CA6D;
        Wed, 17 Feb 2021 05:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v5 2/2] difftool.c: learn a new way start at specified file
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
        <98e2707ee2faf653e972b0706311ddd099765ce5.1613480198.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 02:31:24 -0800
Message-ID: <xmqq8s7nm1dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A1DEB8E-710B-11EB-9182-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> `git difftool` only allow us to select file to view in turn.
> If there is a commit with many files and we exit in the search,

I am not sure what "in the search" refers to.  "in the middle" I
would understand, though.

> We will have to traverse list again to get the file diff which

Let's downcase this "We".

> we want to see. Therefore, here is a new method: user can use
> `git difftool --rotate-to=<filename>` or `git difftool --skip-to=<filename>`
> to start viewing from the specified file, This will improve the
> user experience.

Do we need both?  I'd rather not to give end-user-facing commands
too many knobs that would do similar things.  Too many choices to
choose from without clear answer to "which one should I prefer to
use?" is a bad combination for end-users.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7c5b3cf42bcc..aa2b5c11f20b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -701,7 +701,7 @@ components matches the pattern.  For example, the pattern "`foo*bar`"
>  matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
>  
>  --skip-to=<file>::
> ---rotate-to=<file::
> +--rotate-to=<file>::
>  	Discard the files before the named <file> from the output
>  	(i.e. 'skip to'), or move them to the end of the output
>  	(i.e. 'rotate to').  These were invented primarily for use

Thanks for correcting, but this change should not be a part of this
patch.  Instead, you help the other's topic by giving a review (and
you could just have said "there there is closing '>' missing").

> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 484c485fd06c..c64dff69c976 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -34,6 +34,16 @@ OPTIONS
>  	This is the default behaviour; the option is provided to
>  	override any configuration settings.
>  
> +--rotate-to=<file>::
> +	Internally call `git diff --rotate-to=<file>`,
> +	show the change in the specified path first.
> +	Files before the specified path will be moved to the last output.
> +
> +--skip-to=<file>::
> +	Internally call `git diff --skip-to=<file>`,
> +	skip the output to the specified path.
> +	Files before the specified path will not output.
> +

This, unlike the "diffcore" stuff, is end-user facing, and it is
better not to force the readers even know what --skip-to option
to the diff does (after all, difftool users are using 'git difftool'
and they are not necessarily 'git diff' users).

    --skip-to=<file>::
            Start showing the diff for the given path, skipping all
            the paths before it.

or something, perhaps.

> +test_expect_success 'difftool --skip-to' '
> +	difftool_test_setup &&
> +	test_when_finished git reset --hard &&
> +	git difftool --no-prompt --extcmd=cat --skip-to="2" HEAD^ >output &&
> +	cat >expect <<-\EOF &&
> +	2
> +	4
> +	EOF
> +	test_cmp output expect &&
> +	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
> +'

This probably should be split into two independent tests.  One to
check that the non-failing case works as expected, the other to
check that a bogus command line option errors out as expected.

Thanks.
