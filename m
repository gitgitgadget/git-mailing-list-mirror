Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137EC83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 20:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjH3UqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbjH3UqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 16:46:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39147E42
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 13:45:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45CFF1B9332;
        Wed, 30 Aug 2023 15:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3xXpoR8s5Jnsg3lUJlp6NyuGFHG575o/JBGpX3
        MaZNw=; b=xWnsDiresZUK9eqlju5/MfbJs3zDh+6Zzg+mIggJYtsmhj1Ti3l3lz
        abnIuKzevdENMr5XfwQELctV/CD5Km4JqWiUNPltitCpscdM6w4QAoNbXajTXEzX
        aeBvYnpSJZ4yzzc1SbhwBwP9RCUc9oe7mgVqlNEMzEm32S/z3ABgk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C0C71B9331;
        Wed, 30 Aug 2023 15:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 966A21B9330;
        Wed, 30 Aug 2023 15:28:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
References: <20230830064646.30904-1-sir@cmpwn.com>
Date:   Wed, 30 Aug 2023 12:28:15 -0700
In-Reply-To: <20230830064646.30904-1-sir@cmpwn.com> (Drew DeVault's message of
        "Wed, 30 Aug 2023 08:43:33 +0200")
Message-ID: <xmqqsf808h4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E6CBD20-476B-11EE-8558-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Minor correction to the documentation is also included, and a second
> test just for good measure which demonstrates that the order of
> arguments no longer important.

Perfect.

>  Documentation/git-format-patch.txt | 18 +++++++++++------
>  builtin/log.c                      | 31 +++++++++++++++---------------
>  t/t4014-format-patch.sh            | 22 ++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 373b46fc0d..b96e142a8d 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -217,9 +217,15 @@ populated with placeholder text.
>  
>  --subject-prefix=<subject prefix>::
>  	Instead of the standard '[PATCH]' prefix in the subject
> -	line, instead use '[<subject prefix>]'. This
> -	allows for useful naming of a patch series, and can be
> -	combined with the `--numbered` option.
> +	line, instead use '[<subject prefix>]'. This can be used
> +	to name a patch series, and can be combined with the
> +	`--numbered` option.
> ++
> +The configuration variable `format.subjectPrefix` may also be used
> +to to configure a subject prefix to apply to a given repository for
> +all patches. This is often useful on mailing lists which receive
> +patches for several repositories and can be used to disambiguate
> +the patches (with a value of e.g. "PATCH my-project").

Nice.

I'll locally fix "to to" -> "to" while queuing; no need to reroll
only to fix this.

> diff --git a/builtin/log.c b/builtin/log.c
> index db3a88bfe9..29c86dc798 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1468,19 +1468,16 @@ static int subject_prefix = 0;
>  static int subject_prefix_callback(const struct option *opt, const char *arg,
>  			    int unset)
>  {
> +	struct strbuf *sprefix;
> +
>  	BUG_ON_OPT_NEG(unset);
> +	sprefix = (struct strbuf *)opt->value;
>  	subject_prefix = 1;
> -	((struct rev_info *)opt->value)->subject_prefix = arg;
> +	strbuf_reset(sprefix);
> +	strbuf_addstr(sprefix, arg);
>  	return 0;
>  }

OK.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 3cf2b7a7fb..9fa1f3bc7a 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1373,7 +1373,27 @@ test_expect_success '--rfc' '
>  	Subject: [RFC PATCH 1/1] header with . in it
>  	EOF
>  	git format-patch -n -1 --stdout --rfc >patch &&
> -	grep ^Subject: patch >actual &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--rfc does not overwrite prefix' '
> +	cat >expect <<-\EOF &&
> +	Subject: [RFC PATCH foobar 1/1] header with . in it
> +	EOF
> +	git -c format.subjectPrefix="PATCH foobar" \
> +		format-patch -n -1 --stdout --rfc >patch &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--rfc is argument order independent' '
> +	cat >expect <<-\EOF &&
> +	Subject: [RFC PATCH foobar 1/1] header with . in it
> +	EOF
> +	git format-patch -n -1 --stdout --rfc \
> +		--subject-prefix="PATCH foobar" >patch &&
> +	grep "^Subject:" patch >actual &&
>  	test_cmp expect actual
>  '

Nice.

Will queue.  Let's wait to see if others find something fishy for a
day or two and then merge it down to 'next'.

Thanks.
