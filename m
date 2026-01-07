Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615F39447A
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807207; cv=none; b=f41I5uz36AZaXJ1jl43yn45EBXrX0Pm1iX1uoWStGu/me202e0vplp6lhalG/slZDjH9Jqt3BfBplI+I6Tctks05N1AFmSLFMC5SyurTidSqmZYXb+mYzJ5GHCxfW4BSQd6nEeLNqyWBwVR1W+uSn4S8fSxGID4ThBPyiBcjyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807207; c=relaxed/simple;
	bh=8ZLWM2ARD0z70NGhlr02xNkNxdJX1Mx0+piHHleblWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmSMY/yui9NZm4nOo/fKjMlaOOfF7L5JFw+NMq7DT09uvB2mf7IG5lEadzXh89l0nV2zPPs0c5jXILltigQVKcnqcPBnw/wgl/1pV0MvpZO7hsfZmjRWbb++cI5CEvvp4+6WPymB4IxuKNqq8BMEDWXxbFVng5MFxhLejpF2gR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dmZrB6w8NzRpKJ;
	Wed,  7 Jan 2026 18:33:14 +0100 (CET)
Message-ID: <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
Date: Wed, 7 Jan 2026 18:33:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260107013051.312291-1-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.01.26 um 02:30 schrieb Adrian Ratiu:
> This adds a new check to detect HT in the middle of sentences that
> should have been a SP, as suggested by Junio in
> https://public-inbox.org/git/xmqqy0mwsedz.fsf@gitster.g/

Generally, please review the commit message to follow the project's
style: Use imperative mood in sentences the describe the changes ("Add a
new check to...", "Supoort highlighting for tools like...", "Enable the
new chaeck for...", etc.)

> The check is a bit complex because we want to detect places where
> a SP was intended (HT can expand to more than one display column),
> so we need to count both the display columns (col) and the string
> character columns (i) to determine if a HT looks identical to a SP
> or can cause confusion.
> 
> Highlighting support for tools like git diff/show/log is added, as
> well as git apply --whitespace=fix capability.
> 
> The middle section of the line used to be assumed non-highlighted,
> which is obviously not true anymore, so we split its logic into a
> separate function named emit_middle_section().
> 
> The new check is enabled for Documentation/**/*.adoc, where these
> kinds of mistakes were seen in practice. It can also be enabled in
> other locations where it can be useful, by adding to the relevant
> attributes file.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 3c8eb02e4f..f5b6ceeed9 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -2440,4 +2440,147 @@ test_expect_success 'combine --ignore-blank-lines with --function-context 2' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
> +	git config core.whitespace "-tab-between-non-ws" &&

It might be worthwhile using test_config here, because this setting does
not need to persist for the remaining tests.

> +
> +	printf "1234567\tb" >x &&

What if you made the test cases into

	# only the TAB in the middle must be diagnosed
	printf "\t1234567\t12\t90\n" >x &&

to test that only the second of the three TABs is diagnosed?

> +	git add x &&
> +	git diff --cached --check &&
> +
> +	git diff --cached --color >raw &&
> +	test_decode_color <raw >actual &&
> +	! test_grep "<GREEN>1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&

This must be

	test_grep ! "...

Furthermore, a negative test with a very tight pattern is often not
desired: The test could fail if any single character does not occur
(which could easily happen if the test text is changed, but not this
pattern). In this case, it would be sufficient to test only that "BLUE"
does not occur.

> +	test_grep "<GREEN>1234567	b<RESET>" actual &&
> +
> +	# should apply without error because tab-between-non-ws is off
> +	git diff --cached >patch.diff &&
> +	git checkout HEAD -- x &&
> +	git apply --whitespace=error patch.diff
> +'

There is t/t4124-apply-ws-rule.sh. Wouldn't the `git apply` tests be
better located there?

Please consider all comments on this test case repeated (and suitably
adusted) for all other test cases added by this patch.

> +
> +test_expect_success 'check tab between non-whitespace at tab stop (tab-between-non-ws: on)' '
> +	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&

I am curious why you set tabwidth=8 here even though 8 is the default.

> +test_expect_success 'check tab between non-whitespace not at tab stop (tab-between-non-ws: on)' '

With my suggested text above, this case does not need a separate test, I
think.

> diff --git a/ws.c b/ws.c
> index 6cc2466c0c..633bc69418 100644
> --- a/ws.c
> +++ b/ws.c
> @@ -26,6 +26,7 @@ static struct whitespace_rule {
>  	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>  	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>  	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
> +	{ "tab-between-non-ws", WS_TAB_BETWEEN_NON_WS, 0 },

How about "tab-is-1-space"? The documentation can clarify that not any
TAB expanding to width 1 is diagnosed, but only those that are between
non-space characters.

>  	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
>  };

I didn't look at the remaining code changes.

-- Hannes

