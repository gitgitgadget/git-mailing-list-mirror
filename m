Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D66C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbiHRR1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbiHRRZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:25:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDC62A99
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:25:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CBBE1BF5FB;
        Thu, 18 Aug 2022 13:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8QyAhkUMXyrc5Qe9sf1PcM38O9vS/W+uZPfizj
        /dyxc=; b=ux+RJEqAtui8nHOpXa7+IhqSm+cWahndm/smLKlVTMayzvXr0drxft
        TQAnobu6mCA7b4YnTJVIiDj6eGhWnvoYe4HvDHKRKv+f9i5KFrXXs2yCdeLrpm46
        TrwAOFpGIjv+lfyYV71N2fbia/SQIZowgPweGAaOpotvqiiNw3UFM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84D781BF5FA;
        Thu, 18 Aug 2022 13:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B47D51BF5ED;
        Thu, 18 Aug 2022 13:25:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sergio via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
Subject: Re: [PATCH 1/2] Make rebase.autostash default
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
        <c48fbf984ea42e7c13d56db015dc63c2495f5f5f.1660831231.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 10:25:01 -0700
In-Reply-To: <c48fbf984ea42e7c13d56db015dc63c2495f5f5f.1660831231.git.gitgitgadget@gmail.com>
        (Sergio via GitGitGadget's message of "Thu, 18 Aug 2022 14:00:30
        +0000")
Message-ID: <xmqqy1vlpiqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B198CC98-1F1A-11ED-83FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sergio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sergio <sergeikrivonos@gmail.com>

Neither the cover letter nor the proposed log message even attempt
to justify why this is a good change.

Probably that is because it is not justifiable.  I do not think it
is a good idea to change the default, either.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 403a24d7ca6..333d6a232a7 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -362,7 +362,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>  	int status;
>  
>  	if (!strcmp(var, "rebase.autostash")) {
> -		config_autostash = git_config_bool(var, value);
> +		config_autostash = git_config_bool_or_default(var, value, 1);

This is wrong.  What this says is "if the user has rebase.autostash,
attempt to interpret its value as a Boolean, and store it in this
variable.  If the value cannot be read as a Boolean, pretend as if
true was given".

That does not set the default to a configuration variable.  The
default is the value used when the user does *NOT* specify
rebase.autostash anywhere, but anything the code does inside the
block guarded by that strcmp() cannot affect that case.

If it were a good idea to make the variable default to true, the
place to do so would probably be

        diff --git i/builtin/pull.c w/builtin/pull.c
        index 403a24d7ca..0bb8421dfc 100644
        --- i/builtin/pull.c
        +++ w/builtin/pull.c
        @@ -87,7 +87,7 @@ static char *opt_ff;
         static char *opt_verify_signatures;
         static char *opt_verify;
         static int opt_autostash = -1;
        -static int config_autostash;
        +static int config_autostash = 1; /* default to true */
         static int check_trust_level = 1;
         static struct strvec opt_strategies = STRVEC_INIT;
         static struct strvec opt_strategy_opts = STRVEC_INIT;

> diff --git a/config.c b/config.c
> index e8ebef77d5c..c4f6da3547e 100644
> --- a/config.c
> +++ b/config.c
> @@ -1437,6 +1437,14 @@ int git_config_bool(const char *name, const char *value)
>  	return v;
>  }
>  
> +int git_config_bool_or_default(const char *name, const char *value, int default_value)
> +{
> +	int v = git_parse_maybe_bool(value);
> +	if (v < 0)
> +		v = default_value;
> +	return v;
> +}

And this is not a useful helper function.  At least, this is not
useful for this particular case.  We have tristate Booleans that
take yes/no/auto, and 

	git_config_bool_or_default(name, value, 2);

can take "name.value=auto" and turn it into 2 (instead of 0=no
1=yes), but because the helper takes *any* garbage that is not a
Boolean and gives the same default_value, the value does not have to
be "auto" here, which makes the helper pretty much useless.

The patch is incomplete.  It only changes "git pull" but does not
do anything to "git rebase".
