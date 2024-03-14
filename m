Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFD6F524
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435176; cv=none; b=spKHmCxOzvQZixBOw0XTRh11aBw0wKBhkdcKqibgXlIdniMltfebqg75DDyG2KFv1YvKxy0V8/fOBtbug1g2lolftPUxTDyWhr+s4QOLZMF2d5orcve6YWDf0fze1qIudAR4xsnWIhxAge3Pf5BL2bJH+dXMcrmD8vKZ6bKwtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435176; c=relaxed/simple;
	bh=1SgwT8poLWsSdQg0kJOl8KH9+J3grRw2tANOCkIXLww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eooLo44fWKOLtaSp/8XzsBaQBKsRluxdDyot9I4CG578/AqL09yR4NXiVa+Owta/C9rjfJ3+P+1/8kfIVdPbyIfx0dXSogXpVy7393Lvr9kBF9XzHmVlntr1zQN19qhEdQy7BbKRfFmxPwBr+EQI8uCHZAuBgmKbw8hqRd5s2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DNrTaolU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNrTaolU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B1AE12305A;
	Thu, 14 Mar 2024 12:52:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1SgwT8poLWsSdQg0kJOl8KH9+J3grRw2tANOCk
	IXLww=; b=DNrTaolUKN8f6vCA7/EYhOLiklGJgyZhtKx1qNsgWY4pKAorautT/w
	o3GHyO7DzHKIYeeZKAVwIY7yr2PzQVem36F8/0Y6Q9Rs3gM1AUt5VpsQjjOLfvhu
	QO5TT6MbzjvmB8LQUO57jYvu56ZQDdgifzdf1WqK29g7ANur8/dmk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A8EC323059;
	Thu, 14 Mar 2024 12:52:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3152D23056;
	Thu, 14 Mar 2024 12:52:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Tracy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Josh Steadmon <steadmon@google.com>,  Arthur Chan
 <arthur.chan@adalogics.com>,  Brian Tracy <brian.tracy33@gmail.com>
Subject: Re: [PATCH] fuzz: add fuzzer for config parsing
In-Reply-To: <pull.1692.git.1710398478718.gitgitgadget@gmail.com> (Brian Tracy
	via GitGitGadget's message of "Thu, 14 Mar 2024 06:41:18 +0000")
References: <pull.1692.git.1710398478718.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 09:52:43 -0700
Message-ID: <xmqq34sswyas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 47D8C15A-E223-11EE-9988-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Brian Tracy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 4e255c81f22..aa6c852548c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -760,6 +760,7 @@ FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
>  FUZZ_OBJS += oss-fuzz/fuzz-date.o
>  FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
>  FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
> +FUZZ_OBJS += oss-fuzz/fuzz-config.o

Keep the similar things alphabetically ordered, i.e. "config" comes
after "commit-graph" before "date".

> -for fuzzer in commit-graph date pack-headers pack-idx ; do
> +for fuzzer in commit-graph date pack-headers pack-idx config ; do

Ditto.

> diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
> index 5b954088254..892fb09a95d 100644
> --- a/oss-fuzz/.gitignore
> +++ b/oss-fuzz/.gitignore
> @@ -2,3 +2,4 @@ fuzz-commit-graph
>  fuzz-date
>  fuzz-pack-headers
>  fuzz-pack-idx
> +fuzz-config

Ditto.

> diff --git a/oss-fuzz/fuzz-config.c b/oss-fuzz/fuzz-config.c
> new file mode 100644
> index 00000000000..5a1b39aa1e7
> --- /dev/null
> +++ b/oss-fuzz/fuzz-config.c
> @@ -0,0 +1,32 @@
> +#include "git-compat-util.h"
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <string.h>

You shouldn't have to include system header files yourself.

"git-compat-util.h" is there exactly for insulating yor code from
details such as which system headers in what order need to be
included and which CPP feature macros need to be defined before
their inclusion, and including it as the first header file should
be sufficient.

> +
> +int LLVMFuzzerTestOneInput(const uint8_t *, size_t);
> +static int config_parser_callback(const char *, const char *,
> +					const struct config_context *, void *);
> +
> +static int config_parser_callback(const char *key, const char *value,
> +					const struct config_context *ctx UNUSED,
> +					void *data UNUSED)
> +{
> +	/* Visit every byte of memory we are given to make sure the parser
> +	 * gave it to us appropriately. Ensure a return of 0 to indicate
> +	 * success so the parsing continues. */

	/*
         * Our multi-line comments are formatted with
	 * the slash-asterisk at the beginning and
	 * the asterisk-slash at the end on their
	 * own lines.
	 */

> +	int c = strlen(key);

Isn't the type of return value from strlen() size_t?  It should be
available by inclusing "git-compat-util.h" to you for free.

> +	if (value)
> +		c += strlen(value);
> +	return c < 0;

Is there a reason why this is not "return 0"?  Is it to fool a
clever compiler optimization that knows that omitting calls to
git_config_from_mem() is safe if its callback function does not have
externally observable side effects and always succeeds?

> +}
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, const size_t size)
> +{
> +	struct config_options config_opts = { 0 };

We still honor -Wdecl-after-statement and leave a blank line between
the decl and the first statement here.

> +	config_opts.error_action = CONFIG_ERROR_SILENT;
> +	git_config_from_mem(config_parser_callback, CONFIG_ORIGIN_BLOB,
> +				"fuzztest-config", (const char *)data, size, NULL,
> +				CONFIG_SCOPE_UNKNOWN, &config_opts);
> +	return 0;
> +}
>
> base-commit: 945115026aa63df4ab849ab14a04da31623abece

Thanks.
