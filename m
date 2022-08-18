Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912DAC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiHRQtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345096AbiHRQsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:48:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAAB647C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:48:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93450139B90;
        Thu, 18 Aug 2022 12:48:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3X+uf/hm9pyBgacaIMchdv6gNHt1vVvyicqhu
        0wkCw=; b=WYZU05FCeuV3xeiWmnqjeAgkQgaG2IVyMuMS2yZei8R9huB/qp5CJa
        8s8eFKj5dttr5c7LRR3o4EwiXLY1TbI5c/SCuMR3msChbHm/PXsYpeBX1gexpwps
        XmuPptt9q5C84cbN4xfGO5aXZGQvbezwsDGjbij/SRqJ5R61kQxYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B618139B8F;
        Thu, 18 Aug 2022 12:48:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E46F0139B8E;
        Thu, 18 Aug 2022 12:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] trailer: allow spaces in tokens
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 09:48:23 -0700
In-Reply-To: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com> (Max
        Bernstein via GitGitGadget's message of "Thu, 18 Aug 2022 07:06:15
        +0000")
Message-ID: <xmqqo7whqyzs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 939ABA76-1F15-11ED-BF2A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: summoning an area expert and the developer whose commit is
blamed for the breakage by adding their addresses on Cc: list]

"Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Max Bernstein <max@bernsteinbear.com>
>
> The docs (for example, https://git-scm.com/docs/git-interpret-trailers)

Refer to "git help interpret-trailers" instead.

> say that whitespace should be allowed inside tokens:
>
>> There can also be whitespaces inside the token and the value.
>
> The code since e4319562bc2834096fade432fd90c985b96476db does not allow

Refer to an existing commit like so

	e4319562 (trailer: be stricter in parsing separators, 2016-11-02)

> that, so re-enable and add a test.

Jonathan, do you remember if the "be stricter" was in a response to
specific real world issues, or is this "we no longer allow whitespace"
an unintended side effect of the change?

If the former, an equally valid "fix" to what Max reports here would
be to add such a real world issue or two as new tests to demonostrate
why allowing whitespaces was a mistake that hurts real-world workflow,
and fix the documentation.

I actually am suspecting it is the latter, only because we would have
added a testcase to show why whitespaces in the trailer label is a
bad idea in e4319562 if this was triggered by a real-world issue.

I would say that it would be a disaster, if we took any random
line with colon : in it in the middle of the commit message and
mistook it as a trailer (like the line above), but since we do not
allow paragraph breaks in the trailer block, as long as the message
has a valid trailer block, it might not be a huge issue.  I dunno.

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 97f10905d23..47bf83003ef 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -1481,6 +1481,46 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'supports spaces inside token' '
> +	git config --unset trailer.sign.command &&
> +	cat >expected <<-\EOF &&
> +		Signed-off-by: nobody <nobody@nowhere>
> +		some other trailer: a value
> +		Signed-off-by: somebody <somebody@somewhere>
> +	EOF
> +	echo "wrote to expected" 1>&2 &&
> +	git interpret-trailers --only-trailers >actual <<-\EOF &&
> +		subject
> +
> +		it is important that the trailers below are signed-off-by

It also is important that if you add colon at the end of the above
line, it is *not* mistaken as a trailer with whitespace in token,
with an empty value.

> +		so that they meet the "25% trailers Git knows about" heuristic
> +
> +		Signed-off-by: nobody <nobody@nowhere>
> +		some other trailer: a value
> +		Signed-off-by: somebody <somebody@somewhere>
> +	EOF
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'does not support space at beginning of token' '
> +	cat >expected <<-\EOF &&
> +		Signed-off-by: nobody <nobody@nowhere> not a trailer: thing
> +		Signed-off-by: somebody <somebody@somewhere>
> +	EOF
> +	echo "wrote to expected" 1>&2 &&
> +	git interpret-trailers --only-trailers --unfold >actual <<-\EOF &&
> +		subject
> +
> +		it is important that the trailers below are signed-off-by
> +		so that they meet the "25% trailers Git knows about" heuristic
> +
> +		Signed-off-by: nobody <nobody@nowhere>
> +		 not a trailer: thing
> +		Signed-off-by: somebody <somebody@somewhere>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'only input' '
>  	git config trailer.sign.command "echo config-value" &&
>  	cat >expected <<-\EOF &&
> diff --git a/trailer.c b/trailer.c
> index d419c20735e..d02a9154512 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -618,17 +618,12 @@ static int token_matches_item(const char *tok, struct arg_item *item, size_t tok
>   */
>  static ssize_t find_separator(const char *line, const char *separators)
>  {
> -	int whitespace_found = 0;
>  	const char *c;
>  	for (c = line; *c; c++) {
>  		if (strchr(separators, *c))
>  			return c - line;
> -		if (!whitespace_found && (isalnum(*c) || *c == '-'))
> +		if (isalnum(*c) || *c == '-' || (c != line && (*c == ' ' || *c == '\t')))
>  			continue;
> -		if (c != line && (*c == ' ' || *c == '\t')) {
> -			whitespace_found = 1;
> -			continue;
> -		}
>  		break;
>  	}
>  	return -1;
>
> base-commit: ad60dddad72dfb8367bd695028b5b8dc6c33661b
