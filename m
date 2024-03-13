Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110647F46
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345599; cv=none; b=bIvpbGaBzdCRNYI1Ybx4bu49F4ktShlDxp+BnXXDVfUGW6WfN+4i/VlC5K34p0QJfzp3xW88IvMDTGqv2Wv676XVgNSexUXRGYe/gvVtYvX9qiTWxFYaPD+0UB+BQ7tNN0PgC+XFWw3g9R98+3uBKEmHIb8l+psHUS4ZFzah6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345599; c=relaxed/simple;
	bh=vUrZzK6NFta1AfeWc1tUnY2KwkmqGM+BTFhf1rK+UqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMjBxv+fYV+dip72bZElK9ZSmzAXj2y1b+7mDtpvFr6IxqUsqwHB+CeGwIamw1AZihaEiVnHljPuGlxCV8GXyY+31tF7zwANigN9sXfwIKZ0EbT965ylEWK0c6VffaQLe+ax6Dp7qlj3DSUiF7Rk4V58UA2y2GjwFNVCwZqemlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AA3TBW5t; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AA3TBW5t"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F25BF1FA61;
	Wed, 13 Mar 2024 11:59:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vUrZzK6NFta1AfeWc1tUnY2KwkmqGM+BTFhf1r
	K+UqI=; b=AA3TBW5tiLLtsu/CiZjcHCkEAkwl6JktuVpX6lFaLrreY6ZN8fxZEj
	NU+YKhVmYXEF9j7yVDvhFVg+tT4/LhPAnOudHLpbCMBj3XW2YnBJ3kFwB4190Bth
	qz+p+5hGMbGs//i+4ToQ4V7DI7Ud3Mg0OB4ndvJh2ILnlpI77HwD4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA67A1FA60;
	Wed, 13 Mar 2024 11:59:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90D2A1FA5E;
	Wed, 13 Mar 2024 11:59:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  barroit <barroit@linux.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
In-Reply-To: <pull.1693.git.1710260812280.gitgitgadget@gmail.com> (barroit via
	GitGitGadget's message of "Tue, 12 Mar 2024 16:26:52 +0000")
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
Date: Wed, 13 Mar 2024 08:59:52 -0700
Message-ID: <xmqqle6mdsw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB0212A2-E152-11EE-97DA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"barroit via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jiamu Sun <barroit@linux.com>
>
> executing `git bugreport --no-suffix` led to a segmentation fault
> due to strbuf_addftime() being called with a NULL option_suffix
> variable. This occurs because negating the "--[no-]suffix" option
> causes the parser to set option_suffix to NULL, which is not
> handled prior to calling strbuf_addftime().
>
> Signed-off-by: Jiamu Sun <barroit@linux.com>
> ---

"git blame" points at 238b439d (bugreport: add tool to generate
debugging info, 2020-04-16) that is the very beginning of this tool,
and the bug survived 4f6460df (builtin/bugreport.c: use thread-safe
localtime_r(), 2020-11-30).  Apparently neither commit considered
"--suffix=<string>" would invite users to say "--no-suffix" (authors
of them CC'ed for their input).

Perhaps we should update the documentation a bit while at it?  Here
is what I can find in its documentation.

    SYNOPSIS
    --------
    [verse]
    'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
                    [--diagnose[=<mode>]]

    -s <format>::
    --suffix <format>::
            Specify an alternate suffix for the bugreport name, to create a file
            named 'git-bugreport-<formatted-suffix>'. This should take the form of a
            strftime(3) format string; the current local time will be used.

The above does not say that it is possible to ask the code not to
use suffix at all with "--no-suffix".  If we want it to happen and
behave sensibly (which I think the code with your patch does, from
my cursory read), we probably should document it.  At least two
developers, considered to be expert Git developers and consider
themselves to be expert Git users, did not even anticipate that
"--no-suffix" will hit their code.

Another approach (with devil's advocate hat on) is obviously to use
the PARSE_OPT_NONEG bit so that people won't do what hurts them ;-),
but the fix is so trivial that it may be better to formally accept
"--no-suffix" in this case.

An aside #leftoverbits is to find OPTION_STRING that is used without
NONEG bit and make sure negating them with the "--no-" prefix will
not trigger a similar issue.  All uses of OPT_STRING() that use a
variable that is initialized to a non-NULL string are suspect.  Of
course, this is #leftoverbits and must be kept outside the topic to
fix this bug (i.e. this patch).

>     bugreport.c: fix a crash in git bugreport with --no-suffix option
>     
>     executing git bugreport --no-suffix led to a segmentation fault due to
>     strbuf_addftime() being called with a NULL option_suffix variable. This
>     occurs because negating the "--[no-]suffix" option causes the parser to
>     set option_suffix to NULL, which is not handled prior to calling
>     strbuf_addftime().
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1693%2Fbarroit%2Ffix-bugreport-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1693/barroit/fix-bugreport-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1693
>
>  builtin/bugreport.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 3106e56a130..32281815b77 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -138,8 +138,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  	strbuf_complete(&report_path, '/');
>  	output_path_len = report_path.len;
>  
> -	strbuf_addstr(&report_path, "git-bugreport-");
> -	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> +	strbuf_addstr(&report_path, "git-bugreport");
> +	if (option_suffix) {
> +		strbuf_addch(&report_path, '-');
> +		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> +	}
>  	strbuf_addstr(&report_path, ".txt");
>  
>  	switch (safe_create_leading_directories(report_path.buf)) {
>
> base-commit: 945115026aa63df4ab849ab14a04da31623abece
