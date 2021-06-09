Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D4C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1FF61351
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFIE0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:26:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58273 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhFIE0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:26:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6F69BD6D1;
        Wed,  9 Jun 2021 00:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h9uKZKFR8NcyrPVmBZI0FBk3k96VJCp3wZDjk6
        YlU/Q=; b=wHiaA0HMYpnA80BkA/hXl3KJUiqMB9TPfCep40hU6sYEj6VOGmvZbz
        sLFWcdF19Y24xWEKwRjLsy9Rj3LUOup/Bt8eND+luzsPn2Dkel5J2e3YY1VJfFaS
        hTtTkwedqDUG+ERsMnaicg5UyT2QO3Vfk9kcEzG4tO4oaPEu5A1uE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AED7CBD6D0;
        Wed,  9 Jun 2021 00:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38310BD6CE;
        Wed,  9 Jun 2021 00:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone
 subcommand
References: <20210605113913.29005-1-raykar.ath@gmail.com>
        <20210608095655.47324-1-raykar.ath@gmail.com>
        <20210608095655.47324-2-raykar.ath@gmail.com>
Date:   Wed, 09 Jun 2021 13:24:38 +0900
In-Reply-To: <20210608095655.47324-2-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Tue, 8 Jun 2021 15:26:54 +0530")
Message-ID: <xmqqh7i7ll6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AEBB808-C8DA-11EB-8530-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a bit of random comments, leaving the full review to mentors.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..c9cb535312 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2745,6 +2745,204 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>  	return !!ret;
>  }
>  
> +struct add_data {
> +	const char *prefix;
> +	const char *branch;
> +	const char *reference_path;
> +	const char *sm_path;
> +	const char *sm_name;
> +	const char *repo;
> +	const char *realrepo;
> +	int depth;
> +	unsigned int force: 1;
> +	unsigned int quiet: 1;
> +	unsigned int progress: 1;
> +	unsigned int dissociate: 1;
> +};
> +#define ADD_DATA_INIT { .depth = -1 }
> +
> +static char *parse_token(char **begin, const char *end, int *tok_len)
> +{
> +	char *tok_start, *pos = *begin;

Make it a habit to have a blank line between the initial block
of declarations and the first statement.

> +	while (pos != end && (*pos != ' ' && *pos != '\t' && *pos != '\n'))
> +		pos++;
> +	tok_start = *begin;
> +	*tok_len = pos - *begin;
> +	*begin = pos + 1;
> +	return tok_start;
> +}
> +static char *get_next_line(char *const begin, const char *const end)
> +{
> +	char *pos = begin;
> +	while (pos != end && *pos++ != '\n');

Write an empty loop on two lines, like this:

	while (... condition ...)
		; /* keep scanning */

If there is a NUL byte between begin and end, this keeps going and
the resulting string will contain one.  Is that a problem?

> +	return pos;
> +}

In general, this project is mature enough that we should question
ourselves if there is already a suitable line parser we can reuse
when tempted to write another one.

> +static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> +{
> +	struct child_process cp_remote = CHILD_PROCESS_INIT;
> +	struct strbuf sb_remote_out = STRBUF_INIT;
> +
> +	cp_remote.git_cmd = 1;
> +	strvec_pushf(&cp_remote.env_array,
> +		     "GIT_DIR=%s", git_dir_path);
> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> +		char *line;
> +		char *begin = sb_remote_out.buf;
> +		char *end = sb_remote_out.buf + sb_remote_out.len;
> +		while (begin != end && (line = get_next_line(begin, end))) {

OK, so this tries to parse output from "git remote -v", so NUL will
not be an issue at all.  We will get a string that is NUL terminated
and has zero or more lines, terminated with LFs.

If that is the case, I think it is far easier to read without
a custom get-next-line wrapper, e.g.

	for (this_line = begin;
	     *this_line;
	     this_line = next_line) {
		next_line = strchrnul(this_line, '\n');
		... process bytes between this_line..next_line ...
	}                

> +			int namelen = 0, urllen = 0, taillen = 0;
> +			char *name = parse_token(&begin, line, &namelen);

Similarly, consider if strcspn() is useful in implementing
parse_token().  See how existing code uses the standard system
function with

	$ git grep strcspn \*.c

> +			char *url = parse_token(&begin, line, &urllen);
> +			char *tail = parse_token(&begin, line, &taillen);
> +			if (!memcmp(tail, "(fetch)", 7))

At this point do we know there are enough number of bytes after
tail[0] to allow us to do this comparison safely?  Otherwise,

			if (starts_with(tail, "(fetch)")

may be preferrable.
