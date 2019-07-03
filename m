Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBA01F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGCRil (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:38:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63338 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfGCRil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:38:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E1A47AC97;
        Wed,  3 Jul 2019 13:38:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1mncxoxtZjLrneB5mSyofNHB4o=; b=m9YgfO
        lX3/mvL/q4CtuuGAEpQQlVhtxhFQND1+TARLDsLUMsc5tfhQUZwg5lgE7HHWAAjM
        CGS1kfLMW+JUTS8SWGYYAurvHplrLu6QSuUqHoWyxkW0LOzDExsUwXcPm7fPL+9Y
        k2Ta/nyZp/9JJvM6RJK1zKUAPIRaPTpYsx19U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UxuHIm8Qri05wMj0HYUica4SnUmLWy+G
        ZeRY618rdZXkmDb6sPjp9BtRhZM3llOfYB3rPpA1zpnpNqWNWZVRlLT/guRxE+Li
        rBoQHnge2p8a07pLimqmuDJHU9ppJvEgGOI5R7xxAkySJbXsOv2he/kudWDNUCXO
        fv7v61weyLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36EAC7AC96;
        Wed,  3 Jul 2019 13:38:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FAAF7AC93;
        Wed,  3 Jul 2019 13:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/14] test: completion: tests for __gitcomp regression
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <20190621223107.8022-12-felipe.contreras@gmail.com>
Date:   Wed, 03 Jul 2019 10:38:34 -0700
In-Reply-To: <20190621223107.8022-12-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 21 Jun 2019 17:31:04 -0500")
Message-ID: <xmqqo92b10it.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62E7A4F6-9DB9-11E9-9534-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +offgit ()
> +{

Style: opening brace comes on the same line, like

	offgit () {


> +	GIT_CEILING_DIRECTORIES="$ROOT" &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	test_when_finished "ROOT='$ROOT'; cd '$TRASH_DIRECTORY'; unset GIT_CEILING_DIRECTORIES" &&
> +	ROOT="$ROOT"/non-repo &&
> +	cd "$ROOT"
> +}

All of these means that anytime some test uses offgit outside a
subshell, all the subsequent test will start from outside a
repository, with nonstandard GIT_CEILING_DIRECTORIES settings.

The test should avoid using this outside a subshell when able (and
if it apparently cannot easily, we should try to find a way).

> @@ -358,10 +367,8 @@ test_expect_success SYMLINKS '__git_find_repo_path - resulting path avoids symli
>  '
>  
>  test_expect_success '__git_find_repo_path - not a git repository' '
> +	offgit &&
>  	(
> -		cd non-repo &&
> -		GIT_CEILING_DIRECTORIES="$ROOT" &&
> -		export GIT_CEILING_DIRECTORIES &&
>  		test_must_fail __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
> @@ -1388,6 +1395,7 @@ test_expect_success '__git_pretty_aliases' '
>  '
>  
>  test_expect_success 'basic' '
> +	offgit &&
>  	run_completion "git " &&

Adding "offgit" everywhere like this patch does means that this
"basic" test, for example, no longer is performed in the condition
we have been testing the completion script for, doesn't it?  If so,
the patch is trading test coverage outside repo with coverage inside
repo, which is not a very good tradeoff.


