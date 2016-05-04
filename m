From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 04 May 2016 01:17:21 -0700
Message-ID: <xmqqwpnai6em.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 10:17:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrzy-0005sr-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637AbcEDIR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:17:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757571AbcEDIRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:17:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0AF11197B;
	Wed,  4 May 2016 04:17:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v4ONix8m5gMGUhB5TxZrKP8/JTc=; b=jQUgXm
	uuJgexxDzzJFhybEVFMgzzZqmL0FwGAse7D3xXKrp2LTrY8EnDfNZzyjgFLbc9rg
	w1u+ilN79kKY80LX6Np6sz4i7kVoczAXVKroYxOeZXAuOoJnIdzmDbVsEE8aO/fI
	TKmjq4UuO3ThNCpV3nssLCYSdO9VAQ3SKiWJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0pFOl1pZ/j2YycdFTEGHuThUylwjXBa
	3fpSDoz7hSHjDD4vFJGdBK7rXQLzTKfrKUuNzvjrP76ccsnQ2QeY6JQF7EI8ajMC
	EKY28ufBBAWBMPu0A2Q+QDfXYEG3H2CzxdmvN1kUKhhjusi3CAFW4VTGQHjgYqN3
	nGf/OUn993A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEF9E1197A;
	Wed,  4 May 2016 04:17:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11D9C11979;
	Wed,  4 May 2016 04:17:23 -0400 (EDT)
In-Reply-To: <20160504080047.GA2436@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 04:00:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0D9D6C6-11D0-11E6-82EB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293513>

Jeff King <peff@peff.net> writes:

> [+cc Stefan and Jacob since this is really resuming that earlier thread]
> ...
>> 
>> So I think we'd actually want my series as a preliminary fix, followed
>> by dropping the whitelist entirely on top of that, and then probably
>> simplifying the shell sanitize_submodule_env() on top of that (it would
>> be correct without the whitelist, but you can also trivially implement
>> it without having to call submodule--helper at all).
>
> I think we'd actually do it all in one, and that patch looks something
> like the one below (on top of jk/submodule-config-sanitize-fix).
>
> I don't feel that strongly about going either direction with this, but I
> figure it doesn't hurt to make the patch so we know what the actual
> option looks like.

I do not feel strongly either, but I suspect "we do not filter"
would be a lot easier to explain than "we pass these selected
things, each with such and such justification why it has to be
passed down".

Nice code reduction is very attractive, too, but that is secondary.

> -- >8 --
> Subject: [PATCH] submodule: stop sanitizing config options
>
> The point of having a whitelist of command-line config
> options to pass to submodules was two-fold:
>
>   1. It prevented obvious nonsense like using core.worktree
>      for multiple repos.
>
>   2. It could prevent surprise when the user did not mean
>      for the options to leak to the submodules (e.g.,
>      http.sslverify=false).
>
> For case 1, the answer is mostly "if it hurts, don't do
> that". For case 2, we can note that any such example has a
> matching inverted surprise (e.g., a user who meant
> http.sslverify=true to apply everywhere, but it didn't).
>
> So this whitelist is probably not giving us any benefit, and
> is already creating a hassle as people propose things to put
> on it. Let's just drop it entirely.
>
> Note that we still need to keep a special code path for
> "prepare the submodule environment", because we still have
> to take care to pass through $GIT_CONFIG_PARAMETERS (and
> block the rest of the repo-specific environment variables).
>
> We can do this easily from within the submodule shell
> script, which lets us drop the submodule--helper option
> entirely (and it's OK to do so because as a "--" program, it
> is entirely a private implementation detail).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c  | 17 -----------------
>  git-submodule.sh             |  4 ++--
>  submodule.c                  | 40 +---------------------------------------
>  t/t7412-submodule--helper.sh | 26 --------------------------
>  4 files changed, 3 insertions(+), 84 deletions(-)
>  delete mode 100755 t/t7412-submodule--helper.sh
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index de3ad5b..48cfc48 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -246,22 +246,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static int module_sanitize_config(int argc, const char **argv, const char *prefix)
> -{
> -	struct strbuf sanitized_config = STRBUF_INIT;
> -
> -	if (argc > 1)
> -		usage(_("git submodule--helper sanitize-config"));
> -
> -	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
> -	if (sanitized_config.len)
> -		printf("%s\n", sanitized_config.buf);
> -
> -	strbuf_release(&sanitized_config);
> -
> -	return 0;
> -}
> -
>  struct submodule_update_clone {
>  	/* index into 'list', the list of submodules to look into for cloning */
>  	int current;
> @@ -522,7 +506,6 @@ static struct cmd_struct commands[] = {
>  	{"list", module_list},
>  	{"name", module_name},
>  	{"clone", module_clone},
> -	{"sanitize-config", module_sanitize_config},
>  	{"update-clone", update_clone}
>  };
>  
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3a40d4b..c9d53e1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -197,9 +197,9 @@ isnumber()
>  # of the settings from GIT_CONFIG_PARAMETERS.
>  sanitize_submodule_env()
>  {
> -	sanitized_config=$(git submodule--helper sanitize-config)
> +	save_config=$GIT_CONFIG_PARAMETERS
>  	clear_local_git_env
> -	GIT_CONFIG_PARAMETERS=$sanitized_config
> +	GIT_CONFIG_PARAMETERS=$save_config
>  	export GIT_CONFIG_PARAMETERS
>  }
>  
> diff --git a/submodule.c b/submodule.c
> index 4e76b98..072ea82 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1131,50 +1131,12 @@ int parallel_submodules(void)
>  	return parallel_jobs;
>  }
>  
> -/*
> - * Rules to sanitize configuration variables that are Ok to be passed into
> - * submodule operations from the parent project using "-c". Should only
> - * include keys which are both (a) safe and (b) necessary for proper
> - * operation.
> - */
> -static int submodule_config_ok(const char *var)
> -{
> -	if (starts_with(var, "credential."))
> -		return 1;
> -	return 0;
> -}
> -
> -int sanitize_submodule_config(const char *var, const char *value, void *data)
> -{
> -	struct strbuf *out = data;
> -
> -	if (submodule_config_ok(var)) {
> -		if (out->len)
> -			strbuf_addch(out, ' ');
> -
> -		if (value)
> -			sq_quotef(out, "%s=%s", var, value);
> -		else
> -			sq_quote_buf(out, var);
> -	}
> -
> -	return 0;
> -}
> -
>  void prepare_submodule_repo_env(struct argv_array *out)
>  {
>  	const char * const *var;
>  
>  	for (var = local_repo_env; *var; var++) {
> -		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> -			struct strbuf sanitized_config = STRBUF_INIT;
> -			git_config_from_parameters(sanitize_submodule_config,
> -						   &sanitized_config);
> -			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> -			strbuf_release(&sanitized_config);
> -		} else {
> +		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>  			argv_array_push(out, *var);
> -		}
>  	}
> -
>  }
> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> deleted file mode 100755
> index 149d428..0000000
> --- a/t/t7412-submodule--helper.sh
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2016 Jacob Keller
> -#
> -
> -test_description='Basic plumbing support of submodule--helper
> -
> -This test verifies the submodule--helper plumbing command used to implement
> -git-submodule.
> -'
> -
> -. ./test-lib.sh
> -
> -test_expect_success 'sanitize-config clears configuration' '
> -	git -c user.name="Some User" submodule--helper sanitize-config >actual &&
> -	test_must_be_empty actual
> -'
> -
> -sq="'"
> -test_expect_success 'sanitize-config keeps credential.helper' '
> -	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
> -	echo "${sq}credential.helper=helper${sq}" >expect &&
> -	test_cmp expect actual
> -'
> -
> -test_done
