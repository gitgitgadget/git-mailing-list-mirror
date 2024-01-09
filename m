Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864E3DB82
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UEh0ht2w"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 685F7384BC;
	Tue,  9 Jan 2024 16:38:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S9lwr58gtBVflAxXJJVWcOjEYE3W0nwFzZfV6E
	Subko=; b=UEh0ht2wiVS5pGRZkDycLmiMfHB4ZZ8MVrd7GRZBeEusrIRixFnjOb
	wi/gRLZbvi+BAo2p7kJq1tvyyZZ+EX6KS9J4F0spx79RA4rllHfb9YXlKi8mOH78
	HfEsEvfbCNWUuGwnv2gu2Tqq94+HSYJF1q0ueA/wvAffq+d51kLPY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 60DCF384BB;
	Tue,  9 Jan 2024 16:38:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C58F384B8;
	Tue,  9 Jan 2024 16:38:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/3] t7450: test submodule urls
In-Reply-To: <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 09 Jan 2024 17:53:36
	+0000")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 13:38:05 -0800
Message-ID: <xmqqttnmfarm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6069952E-AF37-11EE-8642-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#define TEST_TOOL_CHECK_URL_USAGE \
> +	"test-tool submodule check-url <url>"
> +static const char *submodule_check_url_usage[] = {
> +	TEST_TOOL_CHECK_URL_USAGE,
> +	NULL
> +};

Granted, the entry that follows this new one already uses the same
pattern, but TEST_TOOL_CHECK_URL_USAGE being used only once here and
nowhere else, with its name almost as long as the value it expands to,
I found it unnecessarily verbose and confusing.

>  #define TEST_TOOL_IS_ACTIVE_USAGE \
>  	"test-tool submodule is-active <name>"
>  static const char *submodule_is_active_usage[] = {


> +typedef int (*check_fn_t)(const char *);
> +
>  /*
>   * Exit non-zero if any of the submodule names given on the command line is
>   * invalid. If no names are given, filter stdin to print only valid names
>   * (which is primarily intended for testing).
>   */

OK.  As long as each of the input lines are unique, we can use the
usual "does the actual output match the expected?" to test many of
them at once, and notice if there is an extra one in the output that
shouldn't have been emitted, or there is a missing one that should
have.

> -static int check_name(int argc, const char **argv)
> +static int check_submodule(int argc, const char **argv, check_fn_t check_fn)
>  {
>  	if (argc > 1) {
>  		while (*++argv) {
> -			if (check_submodule_name(*argv) < 0)
> +			if (check_fn(*argv) < 0)

Quite nice way to reuse what we already have, thanks to [1/3].
