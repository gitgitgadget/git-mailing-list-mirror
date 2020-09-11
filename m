Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475FC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20F2075A
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mULc/Wf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKUjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 16:39:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50587 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKUj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 16:39:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 079D778917;
        Fri, 11 Sep 2020 16:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3TKyURS+1cMulz3fEgyXq12scOQ=; b=mULc/W
        f3zfHIFrmBtSznv+u/FQAiUUVJa/V9izxMaC2qHa32XZ/yKy+0JCCUol5BU3nlyu
        4s2WXOSmAbqrNEflQn5JSnspmItSEQQ2Z2GAFWjgeoIlnm6TDnV9o6t9uljCseOT
        3xuWpKgnd0DjmtKnG0NOM+YMeN4qxs2GZOxBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KdXnDRwnOV+cuczrvpbi6CJgPx+5sOxV
        xMsWa5Zx+SUkuL+tIz9NljLCPtM6zOHj4ptTLJA6hW6eq3L//YkcTuARo7egDpAv
        aNwswEpHcSqLhP//nnP2JDbnad2JUa19Ej2YtusAHtbrhtx5/7zdpzOZerCw+kLT
        wz1WyUbTc20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1C4278916;
        Fri, 11 Sep 2020 16:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7330878915;
        Fri, 11 Sep 2020 16:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 3/4] clone: validate --origin option before use
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <0dff8cd66930130ffd5f0d7d068ad3ed47cd1c81.1599848727.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 13:39:20 -0700
In-Reply-To: <0dff8cd66930130ffd5f0d7d068ad3ed47cd1c81.1599848727.git.gitgitgadget@gmail.com>
        (Sean Barag via GitGitGadget's message of "Fri, 11 Sep 2020 18:25:26
        +0000")
Message-ID: <xmqq1rj8nj47.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF1B6226-F46E-11EA-A3C0-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Barag <sean@barag.org>
>
> Providing a bad origin name to `git clone` currently reports an
> 'invalid refspec' error instead of a more explicit message explaining
> that the `--origin` option was malformed.  Per Junio, it's been this way
> since 8434c2f1 (Build in clone, 2008-04-27).  

If you know it as a fact that it has been this way since the first
version of rewritten "git clone", don't blame others.

A micronit.  We describe the current status in present tense when
presenting the problem to be solved, so "currently" can be dropped.

> This patch reintroduces

When presenting the solution, we write as if we are giving an order
to a patch monkey to "make the code like so".

"This patch reintroduces" -> "Reintroduce".  

> validation for the provided `--origin` option, but notably _doesn't_
> include a multi-level check (e.g. "foo/bar") that was present in the
> original `git-clone.sh`.  It seems `git remote` allows multi-level
> remote names, so applying that same validation in `git clone` seems
> reasonable.

Even though I suspect "git remote" is being overly loose and
careless here, I am not sure if it is a good idea to tighten it
retroactively.  But if this is meant as a bugfix for misconversion
made in 8434c2f1, we should be as strict as the original.  I dunno.

> +	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
> +	if (!valid_fetch_refspec(resolved_refspec.buf))

If we reintroduce pre-8434c2f1 check, then we would want

	if (!valid_fetch_refspec(...) || strchr(option_origin, '/'))

or something like that?

> +		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
> +		die(_("'%s' is not a valid origin name"), option_origin);

I am not sure if this translator comment is helping.

The message makes it sound as if "%s" here is used to switch between
'-o' or '--origin'.  If it said "'%s' will be the value given to
--origin/-o option", it would become much less confusing.

> +	strbuf_release(&resolved_refspec);
> +
>  	repo_name = argv[0];
>  
>  	path = get_repo_path(repo_name, &is_bundle);
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index d20a78f84b..c865f96def 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -19,6 +19,14 @@ test_expect_success 'clone -o' '
>  
>  '
>  
> +test_expect_success 'rejects invalid -o/--origin' '
> +
> +	test_expect_code 128 git clone -o "bad...name" parent clone-bad-name 2>err &&
> +	test_debug "cat err" &&
> +	test_i18ngrep "'\''bad...name'\'' is not a valid origin name" err
> +
> +'

... and we can also test for "bad/name" here in another test.

>  test_expect_success 'disallows --bare with --origin' '
>  
>  	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&

Thanks.
