Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDF4F880
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ku7XB0nT"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 439E618C5E;
	Tue, 26 Dec 2023 12:26:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M9UIswBM43GcOkq6VRjziRtMcqffJMyhUNkbIN
	vq0ME=; b=Ku7XB0nTSEgFSCXWKS7rP1n5CEUWlWOdmCAlH9YBfK+yaJ68TSaLbT
	wgorqhx2cNgBNU78x/udyKEvJlCP6fEuSOFFD8c15C7lK+0zZnbQ2T7Vqugnnk7q
	1JyrcBR2PTuuBmYL8/YcD9cIU71X+b3WslGj3tU4CUN80Xs/0DnGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B8A218C5D;
	Tue, 26 Dec 2023 12:26:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC90018C5B;
	Tue, 26 Dec 2023 12:26:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  Jeff King <peff@peff.net>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout: be consistent with end of options markers
In-Reply-To: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sun, 24 Dec 2023 01:00:11
	+0000")
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 09:26:20 -0800
Message-ID: <xmqq8r5gj2o3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E342B7B6-A413-11EE-AB14-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> 93851746 (parse-options: decouple "--end-of-options" and "--",
> 2023-12-06) updated the world order to make callers of parse-options
> that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
> do with "--end-of-options" they may see after parse_options() returns.
>
> This made a previous bug in sparse-checkout more visible; namely,
> that
>
>   git sparse-checkout [add|set] --[no-]cone --end-of-options ...
>
> would simply treat "--end-of-options" as one of the paths to include in
> the sparse-checkout.  But this was already problematic before; namely,
>
>   git sparse-checkout [add|set| --[no-]cone --sikp-checks ...
>
> would not give an error on the mis-typed "--skip-checks" but instead
> simply treat "--sikp-checks" as a path or pattern to include in the
> sparse-checkout, which is highly unfriendly.
>
> This behavior begain when the command was converted to parse-options in
> 7bffca95ea (sparse-checkout: add '--stdin' option to set subcommand,
> 2019-11-21).  Back then it was just called KEEP_UNKNOWN. Later it was
> renamed to KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options:
> PARSE_OPT_KEEP_UNKNOWN only applies to --options, 2022-08-19) to clarify
> that it was only about dashed options; we always keep non-option
> arguments.  Looking at that original patch, both Peff and I think that
> the author was simply confused about the mis-named option, and really
> just wanted to keep the non-option arguments.  We never should have used
> the flag all along (and the other cases were cargo-culted within the
> file).
>
> Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
> bug.  Note that this does mean that anyone who might have been using
>
>   git sparse-checkout [add|set] [--[no-]cone] --foo --bar
>
> to request paths or patterns '--foo' and '--bar' will now have to use
>
>   git sparse-checkout [add|set] [--[no-]cone] -- --foo --bar
>
> That makes sparse-checkout more consistent with other git commands,
> provides users much friendlier error messages and behavior, and is
> consistent with the all-capps warning in git-sparse-checkout.txt that
> this command "is experimental...its behavior...will likely change".  :-)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Nicely described.

Apparently we do not have an existing test to cover the case of
"misspelt options becoming a pattern" that this bugfix corrects;
otherwise we would have a s/failure/success/ to update such an older
expectation, and have to wonder if the existing behaviour is
intentional.  Since there is no such test, we can feel a bit safer
in "fixing" this odd behaviour.

Also, this corrects "--end-of-options" that becomes one of the
patterns.  Such a bug was not detected in our test suite.

So we should at least have two new tests.

 (1) Pass "--foo" without the end of options marker and make sure we
     error out, instead of making it as one of the patterns.

 (2) Pass "--end-of-options foo" and make sure the command succeeds,
     an d"--end-of-options" does not become on eof the patterns.

Thanks.
