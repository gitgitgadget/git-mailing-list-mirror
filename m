Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E36C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 06:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhLUGzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 01:55:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64402 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhLUGzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 01:55:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B37F1738BD;
        Tue, 21 Dec 2021 01:55:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aupofapTmr1ERHurnyk7h574YrSshIkM1nKigl
        bc11o=; b=wsFuQ7CTXEv5/sW77Qa70jkba+ld4tsxEd4n6SVTT/cjBoOJJDAcS+
        OQFrUyxVJOiQMgKb6QvgYB5A4Dl49a7KZch44tAOVPkw4BX/tPJPPMEZNSCCoeAf
        ZBVyumDFPnV1RgSzU4Z7FrL9qHjleRt9/MWGOSty11HJ+jvPFWnu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 733BC1738BC;
        Tue, 21 Dec 2021 01:55:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C40251738B8;
        Tue, 21 Dec 2021 01:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com
Subject: Re: [PATCH v8 1/3] branch: accept multiple upstream branches for
 tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1640039978.git.steadmon@google.com>
        <a5265e1c7f4dc1a69e85511d2cc3f659cc46788f.1640039978.git.steadmon@google.com>
Date:   Mon, 20 Dec 2021 22:55:35 -0800
In-Reply-To: <a5265e1c7f4dc1a69e85511d2cc3f659cc46788f.1640039978.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 20 Dec 2021 19:30:22 -0800")
Message-ID: <xmqq1r26sazc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0033EEF8-622B-11EC-950C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +/**
> + * Install upstream tracking configuration for a branch; specifically, add
> + * `branch.<name>.remote` and `branch.<name>.merge` entries.
> + *
> + * `flag` contains integer flags for options; currently only
> + * BRANCH_CONFIG_VERBOSE is checked.
> + *
> + * `local` is the name of the branch whose configuration we're installing.
> + *
> + * `origin` is the name of the remote owning the upstream branches. NULL means
> + * the upstream branches are local to this repo.
> + *
> + * `remotes` is a list of refs that are upstream of local
> + */
> +static int install_branch_config_multiple_remotes(int flag, const char *local,
> +		const char *origin, struct string_list *remotes)
>  {
>  	const char *shortname = NULL;
>  	struct strbuf key = STRBUF_INIT;
> +	struct string_list_item *item;
>  	int rebasing = should_setup_rebase(origin);
>  
> +	if (!remotes->nr)
> +		BUG("must provide at least one remote for branch config");
> +	if (rebasing && remotes->nr > 1)
> +		die(_("cannot inherit upstream tracking configuration of "
> +		      "multiple refs when rebasing is requested"));
> +
> +	/*
> +	 * If the new branch is trying to track itself, something has gone
> +	 * wrong. Warn the user and don't proceed any further.
> +	 */
> +	if (!origin)
> +		for_each_string_list_item(item, remotes)
> +			if (skip_prefix(item->string, "refs/heads/", &shortname)
> +			    && !strcmp(local, shortname)) {
> +				warning(_("not setting branch '%s' as its own upstream."),
> +					local);
> +				return 0;
> +			}

Added comments make it easier to follow what is going on and more
importantly why.  I very much like it ;-)

> @@ -75,8 +96,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config, then write our branches. If
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */

Sorry, but I do not quite get this comment in two ways.

 - It talks about "if more than one" but the code seems to use
   regex-none even when there is only one.

 - I agree that use of set-multivar with regex-none is the right way
   to append new values to multi valued configuration, but wouldn't
   the sequence be (1) first clear everything and then (2) set new
   ones one by one?

Ahh, OK, the "config-set" we do first is the "clear everything"
step.

	We want to overwrite any existing config.  First clear any
	existing config, and then write our branches one-by-one.
	Use of CONFIG_REGEX_NONE ensures that the multiple values
	are appended to the same variable.

perhaps?

> +	if (git_config_set_gently(key.buf, NULL) < 0)
>  		goto out_err;
> +	for_each_string_list_item(item, remotes)
> +		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;

> @@ -87,29 +117,40 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	strbuf_release(&key);
>  
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
> +		struct strbuf tmp_ref_name = STRBUF_INIT;
> +		struct string_list friendly_ref_names = STRING_LIST_INIT_DUP;
> +
> +		for_each_string_list_item(item, remotes) {
> +			shortname = item->string;
> +			skip_prefix(shortname, "refs/heads/", &shortname);
> +			if (origin) {
> +				strbuf_addf(&tmp_ref_name, "%s/%s",
> +					    origin, shortname);
> +				string_list_append_nodup(
> +					&friendly_ref_names,
> +					strbuf_detach(&tmp_ref_name, NULL));
> +			} else {
> +				string_list_append(
> +					&friendly_ref_names, shortname);
> +			}
> +		}
> +
> +		if (remotes->nr == 1) {
> +			/*
> +			 * Rebasing is only allowed in the case of a single
> +			 * upstream branch.
> +			 */

There does not seem to be any code to forbid "rebasing" when
remotes->nr != 1, though.  Did I miss a call to die() earlier?

> +			printf_ln(rebasing ?
> +				_("branch '%s' set up to track '%s' by rebasing.") :
> +				_("branch '%s' set up to track '%s'."),
> +				local, friendly_ref_names.items[0].string);
>  		} else {
> +			printf_ln(_("branch '%s' set up to track:"), local);
> +			for_each_string_list_item(item, &friendly_ref_names)
> +				printf_ln("  %s", item->string);

In other words, I would have expected something in this else clause.

>  		}

Thanks.
