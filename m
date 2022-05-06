Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B6C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443043AbiEFUhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiEFUhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:37:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8F6D3AB
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:33:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D45111A089;
        Fri,  6 May 2022 16:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZqoJyc6EMh8N8wpTKf/ntoMcfV7RaBT+XXWoo
        FnsMM=; b=kt1FU3WQP3SFXeGuxKdOM71MvzUSyjo7AU6DVcWfBhD7rY8cDRQfSg
        AjrLcUN6lZ6WAZb2fm0R1MS9A1ugDrd8eBrw6+bYz005KoATZCn+uTOaPI6pD8Xr
        0iInv7m2xXiMbA/JOLgcdXAUKemvHs2d6hf+VG0WVMX62I5UyDaEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04D5511A088;
        Fri,  6 May 2022 16:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DCDC11A084;
        Fri,  6 May 2022 16:33:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
Date:   Fri, 06 May 2022 13:33:30 -0700
In-Reply-To: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Fri, 06 May 2022 18:30:10 +0000")
Message-ID: <xmqqmtfujt9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB1D6430-CD7B-11EC-86BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Add a config variable, `safe.barerepository`, that tells Git whether or
> not to recognize bare repositories when it is trying to discover the
> repository. This only affects repository discovery, thus it has no
> effect if discovery was not done (e.g. `--git-dir` was passed).

> +safe.barerepository::
> +	This config entry specifies directories that Git can recognize as
> +	a bare repository when looking for the repository (aka repository
> +	discovery). This has no effect if repository discovery is not
> +	performed e.g. the path to the repository is set via `--git-dir`
> +	(see linkgit:git[1]).
> ++
> +It is recommended that you set this value so that Git will only use the bare
> +repositories you intend it to. This prevents certain types of security and
> +non-security problems, such as:
> +
> +* `git clone`-ing a repository containing a maliciously bare repository
> +  inside it.

"maliciously bare"? "malicious bare" probably.

> +* Git recognizing a directory that isn't mean to be a bare repository,

"mean to be" -> "meant to be".

> +  but happens to look like one.

> diff --git a/setup.c b/setup.c
> index a7b36f3ffbf..9b5dd877273 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1133,6 +1133,40 @@ static int ensure_valid_ownership(const char *path)
>  	return data.is_safe;
>  }
>  
> +/*
> + * This is similar to safe_directory_data, but only supports true/false.
> + */
> +struct safe_bare_repository_data {
> +	int is_safe;
> +};
> +
> +static int safe_bare_repository_cb(const char *key, const char *value, void *d)
> +{
> +	struct safe_bare_repository_data *data = d;
> +
> +	if (strcmp(key, "safe.barerepository"))
> +		return 0;
> +
> +	if (!value || !strcmp(value, "*")) {
> +		data->is_safe = 1;
> +		return 0;
> +	}
> +	if (!*value) {
> +		data->is_safe = 0;
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +static int should_detect_bare(void)
> +{
> +	struct safe_bare_repository_data data;
> +
> +	read_very_early_config(safe_bare_repository_cb, &data);
> +
> +	return data.is_safe;
> +}
> +
>  enum discovery_result {
>  	GIT_DIR_NONE = 0,
>  	GIT_DIR_EXPLICIT,
> @@ -1238,7 +1272,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  			return GIT_DIR_DISCOVERED;
>  		}
>  
> -		if (is_git_directory(dir->buf)) {
> +		if (should_detect_bare() && is_git_directory(dir->buf)) {
>  			if (!ensure_valid_ownership(dir->buf))
>  				return GIT_DIR_INVALID_OWNERSHIP;
>  			strbuf_addstr(gitdir, ".");

This is in a loop, which will go up and try the parent directory if
the body of this block is not entered, so it is calling the new
should_detect_bare() helper over and over if it returns false.

Not a very good idea.

Perhaps this would help?  I dunno.

static int should_detect_bare(void)
{
	static int should = -1; /* unknown yet */

	if (should < 0) {
		struct safe_bare_repository_data data = { 0 };
		read_very_early_config(safe_bare_repository_cb, &data);
		should = data.is_safe;
	}
	return should;
}

In any case, I very much appreciate the fact that this touches the
setup_git_directory_gently_1() codepath only minimally, as we have
other plans to update the code further soonish.

Thanks.
