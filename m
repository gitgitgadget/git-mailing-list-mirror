Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D4FC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F2F64E30
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhBJUjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:39:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51261 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhBJUjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:39:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F4065105E88;
        Wed, 10 Feb 2021 15:38:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xAYP7VXp1UmpJ3QLuQ9jgn3XD6Q=; b=iynHyG
        xMBNdLqXyrrc3xqgqiGn7pWODO1capQcLewKezhS+0nUXTr66jbmJXfvf4hI1e90
        d1v/p97vrEg47YvoeMEWFz/pfJGvNAP7nCWP/lTnw+HqVEoonsPE8o0p6mnqHVPi
        lgiNy84OCHxH3kgtNvaXOien19F3TpBdh08UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xa684YIO0w1O4TxoO1iHOwjrxnaAbN15
        ieKCvTUFNXGbVhd8Qdrzu651iMgjbEmltkOq6EniYkojxQ4ev+ERePHT9NRk1RtF
        tbGqafv1pUspn/qU5AAZHrBHhnubioVikR5hQSnrLv2P6H7SRloUhRua/RThr0kN
        yWpdcvELvN8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7C6A105E87;
        Wed, 10 Feb 2021 15:38:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 628DE105E80;
        Wed, 10 Feb 2021 15:38:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck --name-objects: be more careful parsing
 generation numbers
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
        <03efb76b31e46ffe340fe0c6ab5fc4d804b2c273.1612980090.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 12:38:16 -0800
In-Reply-To: <03efb76b31e46ffe340fe0c6ab5fc4d804b2c273.1612980090.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Feb 2021
        18:01:30 +0000")
Message-ID: <xmqqpn171ww7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E84CCE28-6BDF-11EB-B51A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 7b35efd734e (fsck_walk(): optionally name objects on the go,
> 2016-07-17), the `fsck` machinery learned to optionally name the
> objects, so that it is easier to see what part of the repository is in a
> bad shape, say, when objects are missing.
>
> To save on complexity, this machinery uses a parser to determine the
> name of a parent given a commit's name: any `~<n>` suffix is parsed and
> the parent's name is formed from the prefix together with `~<n+1>`.
>
> However, this parser has a bug: if it finds a suffix `<n>` that is _not_
> `~<n>`, it will mistake the empty string for the prefix and `<n>` for
> the generation number. In other words, it will generate a name of the
> form `~<bogus-number>`.
>
> Let's fix this.

Thanks; will queue.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c          |  5 +++++
>  t/t1450-fsck.sh | 10 ++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 73f30773f28a..83d727c6fe33 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -461,6 +461,11 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
>  				generation += power * (name[--len] - '0');
>  			if (power > 1 && len && name[len - 1] == '~')
>  				name_prefix_len = len - 1;
> +			else {
> +				/* Maybe a non-first parent, e.g. HEAD^2 */
> +				generation = 0;
> +				name_prefix_len = len;
> +			}
>  		}
>  	}
>  
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 779f700ac4a0..bfa3588f37ab 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -607,13 +607,15 @@ test_expect_success 'fsck --name-objects' '
>  	git init name-objects &&
>  	(
>  		cd name-objects &&
> +		git config core.logAllRefUpdates false &&
>  		test_commit julius caesar.t &&
> -		test_commit augustus &&
> -		test_commit caesar &&
> +		test_commit augustus44 &&
> +		test_commit caesar  &&
>  		remove_object $(git rev-parse julius:caesar.t) &&
> -		test_must_fail git fsck --name-objects >out &&
>  		tree=$(git rev-parse --verify julius:) &&
> -		test_i18ngrep "$tree (refs/tags/julius:" out
> +		git tag -d julius &&
> +		test_must_fail git fsck --name-objects >out &&
> +		test_i18ngrep "$tree (refs/tags/augustus44\\^:" out
>  	)
>  '
