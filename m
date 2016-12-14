Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB051FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 23:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbcLNXso (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 18:48:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752959AbcLNXsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 18:48:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37D7E59D81;
        Wed, 14 Dec 2016 18:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HXQisJM0hQp7/eARPMDh24Fir2Y=; b=M+GH+a
        avKLcl7UnZeo7upE7Hz55ozJ3n5XK6V1wAguW7H8zHOXNq3Ndo5TZ/+IrsOfIeCE
        NQ8W7C+wvRkBp96f2KMtBpJo/ek2RBcTVhSMGhszXDA6XECrYCBvGCpFGWJgxKxV
        iCpr9zkLuIpd3kScTwBqOfrqaMY2f/oYoKAQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aGMNcWF7h9n+r5dXOYX1eCL9V/56+ln+
        iLG5TP4zyoBdRmQ1276lyUxW/sroTjMXNj3PcxbmBQResDnYREpTmnv19LZXex1C
        hfmiulvvkpA7muz8Sc4jF31TAIz5EOVl4mZKzBwWkrYlqj9ptBlF7JDr6LGVt+9j
        CvJHYi6tUr4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E1E059D80;
        Wed, 14 Dec 2016 18:48:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A703359D7F;
        Wed, 14 Dec 2016 18:48:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv3 3/4] submodule: add flags to ok_to_remove_submodule
References: <20161214224101.6211-1-sbeller@google.com>
        <20161214224101.6211-4-sbeller@google.com>
Date:   Wed, 14 Dec 2016 15:48:40 -0800
In-Reply-To: <20161214224101.6211-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 14 Dec 2016 14:41:00 -0800")
Message-ID: <xmqqpokuvzqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7A103CC-C257-11E6-BD6C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 9f0b544ebe..2d13744b06 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1019,7 +1019,7 @@ int submodule_uses_gitfile(const char *path)
>  	return 1;
>  }
>  
> -int ok_to_remove_submodule(const char *path)
> +int ok_to_remove_submodule(const char *path, unsigned flags)
>  {
>  	ssize_t len;
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1032,15 +1032,27 @@ int ok_to_remove_submodule(const char *path)
>  	if (!submodule_uses_gitfile(path))
>  		return 0;
>  
> -	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
> +	argv_array_pushl(&cp.args, "status", "--porcelain",
>  				   "--ignore-submodules=none", NULL);
> +
> +	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
> +		argv_array_push(&cp.args, "-uno");
> +	else
> +		argv_array_push(&cp.args, "-uall");
> +
> +	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
> +		argv_array_push(&cp.args, "--ignored");
> +

These "internal values to assemble command line" operations we
cannot avoid.  But things like this ...

>  	if (start_command(&cp))
> -		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
> +		die(_("could not run 'git status --porcelain --ignore-submodules=none %s %s' in submodule '%s'"),
> +			(flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED) ? "-uno" : "-uall",
> +			(!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)) ? "--ignored" : "",
> +			path);

and this ...

>  	if (finish_command(&cp))
> -		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
> +		die(_("'git status --porcelain --ignore-submodules=none %s %s' failed in submodule '%s'"),
> +			(flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED) ? "-uno" : "-uall",
> +			(!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)) ? "--ignored" : "",
> +			path);

makes me wonder if we want a helper that builds the string out of an
already assembled cp.args[] array, so that we won't have to do the
same thing twice/thrice and more importantly we won't have to worry
about these three going out of sync.

