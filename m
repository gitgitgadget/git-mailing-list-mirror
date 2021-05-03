Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263CC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED74F613AC
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhECFKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:10:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64412 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhECFKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:10:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E73D13B690;
        Mon,  3 May 2021 01:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B/sZXLypXy1Bfi21GKuOjFk0dByb/Af8uaUS+o
        juTZs=; b=ln6uczbmQbas5fk3JA+kzhpqLk73ALtkOP2bfjhXaLcPqfSx/jJAJ8
        SG0aSFWQT4jNS95P7u+a+InhlN2FMLqGKbvuUe2xdTge2OXxHATylG93sW75l1P0
        NPEenhOTDpnmYHMdJSxWd7Su8HrtTEy5V2110JR1KqLUk33Abcyxg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 477F613B68F;
        Mon,  3 May 2021 01:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E8BD13B68D;
        Mon,  3 May 2021 01:09:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v4 5/5] fast-export, fast-import: add support for
 signed-commits
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210430232537.1131641-1-lukeshu@lukeshu.com>
        <20210430232537.1131641-6-lukeshu@lukeshu.com>
Date:   Mon, 03 May 2021 14:09:12 +0900
In-Reply-To: <20210430232537.1131641-6-lukeshu@lukeshu.com> (Luke Shumaker's
        message of "Fri, 30 Apr 2021 17:25:37 -0600")
Message-ID: <xmqq1rao9zev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B43B1382-ABCD-11EB-8894-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> fast-export has a --signed-tags= option that controls how to handle tag
> signatures.  However, there is no equivalent for commit signatures; it
> just silently strips the signature out of the commit (analogously to
> --signed-tags=strip).
>
> While signatures are generally problematic for fast-export/fast-import
> (because hashes are likely to change), if they're going to support tag
> signatures, there's no reason to not also support commit signatures.
>
> So, implement a --signed-commits= option that mirrors the --signed-tags=
> option.
>
> On the fast-export side, try to be as much like signed-tags as possible,
> in both implementation and in user-interface.  This will changes the

s/changes/change/;

> default behavior to '--signed-commits=abort' from what is now
> '--signed-commits=strip'.  In order to provide an escape hatch for users
> of third-party tools that call fast-export and do not yet know of the
> --signed-commits= option, add an environment variable
> 'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' that changes the default to
> '--signed-commits=warn-strip'.

Nicely explained.

> +static const char *find_commit_multiline_header(const char *msg,
> +						const char *key,
> +						const char **end)
> +{
> +	static struct strbuf val = STRBUF_INIT;
> +	const char *bol, *eol;
> +	size_t len;
> +
> +	strbuf_reset(&val);
> +
> +	bol = find_commit_header(msg, key, &len);
> +	if (!bol)
> +		return NULL;
> +	eol = bol + len;
> +	strbuf_add(&val, bol, len);
> +
> +	while (eol[0] == '\n' && eol[1] == ' ') {
> +		bol = eol + 2;
> +		eol = strchrnul(bol, '\n');
> +		strbuf_addch(&val, '\n');
> +		strbuf_add(&val, bol, eol - bol);
> +	}
> +
> +	*end = eol;
> +	return val.buf;

It is not exactly wrong per se, but using non-static (on stack)
strbuf would make it easier to follow.  You can then lose the
strbuf_reset() upfront, and then this will call strbuf_detach().

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 892737439b..cd51c78418 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -8,6 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
>  
>  test_expect_success 'setup' '
>  
> @@ -284,9 +285,94 @@ test_expect_success 'signed-tags=warn-strip' '
>  	test -s err
>  '
>  
> +test_expect_success GPG 'set up signed commit' '
> +
> +	# Generate a commit with both "gpgsig" and "encoding" set, so
> +	# that we can test that fast-import gets the ordering correct
> +	# between the two.
> +	test_config i18n.commitEncoding ISO-8859-1 &&
> +	git checkout -f -b commit-signing main &&
> +	echo Sign your name > file-sign &&

Style.  >file-sign (lose SP between the redirection operator and its
operand).

> +	git add file-sign &&
> +	git commit -S -m "signed commit" &&
> +	COMMIT_SIGNING=$(git rev-parse --verify commit-signing)
> +
> +'
> +
> +test_expect_success GPG 'signed-commits default' '
> +
> +	unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&

sane_unset would be safer here.

> +	test_must_fail git fast-export --reencode=no commit-signing &&
> +
> +	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
> +	! grep ^gpgsig output &&
> +	grep "^encoding ISO-8859-1" output &&
> +	test -s err &&
> +	sed "s/commit-signing/commit-strip-signing/" output |
> +		(cd new &&
> +		 git fast-import &&
> +		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))

Let's not force readers to match nested parentheses visually
(applies to multiple places in this patch):

	sed "s/commit-signing/commit-strip-signing/" output | (
		cd new &&
		git fast-import &&
		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
		test $COMMIT_SIGNING != $STRIPPED
	)

>  test_expect_success 'setup submodule' '
>  
>  	git checkout -f main &&
> +	{ git update-ref -d refs/heads/commit-signing || true; } &&

	test_might_fail git update-ref -d refs/heads/commit-signing &&

