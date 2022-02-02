Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487ADC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbiBBRuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:50:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55579 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiBBRuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 12:50:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A813D10DD90;
        Wed,  2 Feb 2022 12:50:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8lnwL/TV5Ncb4fsmHCGA3uzVM8oIW6kk2C0nzl
        cKukk=; b=Dc/dpTZeZuquHNNp0kuPcJTWCktMe7fkdvta+ttSBISo9SAHj1T1Vl
        fDtWC/xCod4JFDKkT4MWFnTJSW6b5blRDOJA3FRFYfeUiNnGYFlwGk5O1EqiS2IU
        SBHPRnwxjYn20Bvc7VUkiFPdgqPfbVgO/0yo7utls3DJKYQ+hhStk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CB1710DD8E;
        Wed,  2 Feb 2022 12:50:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB84D10DD8D;
        Wed,  2 Feb 2022 12:50:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] repo-settings: rename the traditional default
 fetch.negotiationAlgorithm
References: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
        <7500a4d2e44008b1d8df9cc8b24b67ff973a98ae.1643773361.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 09:50:11 -0800
In-Reply-To: <7500a4d2e44008b1d8df9cc8b24b67ff973a98ae.1643773361.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 02 Feb 2022
        03:42:40 +0000")
Message-ID: <xmqqk0ed17l8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92632A0E-8450-11EC-83E8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/repo-settings.c b/repo-settings.c
> index 41e1c30845f..b4fbd16cdcc 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -26,7 +26,7 @@ void prepare_repo_settings(struct repository *r)
>  	/* Defaults */
>  	r->settings.index_version = -1;
>  	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
> -	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
> +	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>  
>  	/* Booleans config or default, cascades to other settings */
>  	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> @@ -81,12 +81,15 @@ void prepare_repo_settings(struct repository *r)
>  	}
>  
>  	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
> +		int fetch_default = r->settings.fetch_negotiation_algorithm;
>  		if (!strcasecmp(strval, "skipping"))
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
>  		else if (!strcasecmp(strval, "noop"))
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
> +		else if (!strcasecmp(strval, "consecutive"))
> +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>  		else if (!strcasecmp(strval, "default"))
> -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
> +			r->settings.fetch_negotiation_algorithm = fetch_default;
>  		else
>  			die("unknown fetch negotiation algorithm '%s'", strval);
>  	}

This 

    - set the default to whatever experimental says
    - parse the configuration and set it 
      - to the specified value unless it is DEFAULT
      - to the value the experimental bit set as the default otherwise

certainly works, even though I find it a bit convoluted and
backwards.  I have slight preference to "if the user says 'default',
hold onto it as a symbolic 'default' setting, and resolve it to a
concrete value at the very end" pattern, which tends to handle the
"reverting to default" case better.

There is the "manyfiles" precedent that sets index.version and
core.untrackedCache irreversibly nearby, and I am sympathetic to
whoever added the fetch_negotiation_algorithm support (it probably
is not you, I am guessing) by mimicking it, so I am OK with the
version posted as-is.

Thanks.
