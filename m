Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EEA1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbcLNSsP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 13:48:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51963 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753523AbcLNSqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 13:46:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ABD55609D;
        Wed, 14 Dec 2016 13:46:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DMvT8aUYfxrtXVzCZXJotjsJxvo=; b=AmQ1en
        6JMAu2pph9dVgRmud2I4WJmW7t0wOgpUmdAdJxHo2/TLHb7uHiAI5jQkaenG7O4V
        N8dh14ZNKUZhq9sLSeD3Ts2r+l6iuOoodVBxzR1XkTvOrhJU8PcD24T/wAF9FrGs
        JEff9IfnaEyOg5FQJoWdLrHFelvUDEegEfuHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cASZJC/hekWPLmviVQdYZvAl685O/gtE
        k5rtOGjf6k3PpdS85GN29F+i2Fr1qWSkEpuEoTuAgJ88XaP3Z5Is7KtjhVFleKYo
        Yxw8ZngszH5GNXwCmlxOrlNx7yDP8YvHbqD9DZbobtM/y9pqubz8S1JE/yaEyogQ
        KoR2sMUuqZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 019145609C;
        Wed, 14 Dec 2016 13:46:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76C715609B;
        Wed, 14 Dec 2016 13:46:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv2 4/5] ok_to_remove_submodule: absorb the submodule git dir
References: <20161213205622.841-1-sbeller@google.com>
        <20161213205622.841-5-sbeller@google.com>
Date:   Wed, 14 Dec 2016 10:46:50 -0800
In-Reply-To: <20161213205622.841-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 13 Dec 2016 12:56:21 -0800")
Message-ID: <xmqqbmwexs9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD1C50D6-C22D-11E6-A097-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is a major reason to say no, when deciding if a submodule can be
> deleted, if the git directory of the submodule being contained in the
> submodule's working directory.
>
> Migrate the git directory into the superproject instead of failing,
> and proceed with the other checks.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 2d13744b06..e42efa2337 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1026,11 +1026,22 @@ int ok_to_remove_submodule(const char *path, unsigned flags)
>  	struct strbuf buf = STRBUF_INIT;
>  	int ok_to_remove = 1;
>  
> +	/* Is it there? */
>  	if (!file_exists(path) || is_empty_dir(path))
>  		return 1;
>  
> -	if (!submodule_uses_gitfile(path))
> -		return 0;
> +	/* Does it have a .git directory? */
> +	if (!submodule_uses_gitfile(path)) {
> +		absorb_git_dir_into_superproject("", path,
> +			ABSORB_GITDIR_RECURSE_SUBMODULES);
> +
> +		/*
> +		 * We should be using a gitfile by now. Let's double
> +		 * check as losing the git dir would be fatal.
> +		 */
> +		if (!submodule_uses_gitfile(path))
> +			return 0;
> +	}

It feels a bit funny for a function that answers yes/no question to
actually have a side effect, but probably it is OK.  It feels dirty,
but I dunno.

A brief reading of the above makes us wonder what should happen if
the absorb_git_dir_into_superproject() call fails, but a separate
"submodule_uses_gitfile()" is needed to see if it failed?  Perhaps
the function needs to tell the caller if it succeeded?

>  
>  	argv_array_pushl(&cp.args, "status", "--porcelain",
>  				   "--ignore-submodules=none", NULL);
