Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856C1203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755648AbdGXVll (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:41:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61159 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755221AbdGXVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:41:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E22AC9B837;
        Mon, 24 Jul 2017 17:41:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IiuOf9rameh5
        kuLjAANG/PWHxhE=; b=C9TMauHd25HLwtvaWypt+9TGfn4/FgQQf9+aRiXeQGsQ
        xGAA3YwHSiAWhViDrHzvm06KenNb9IJ0C5Q18GKMZcnHsOPLMonKPWaztlJ18YL6
        0CAMDJi0sUlU1aSUyH8oufZU9oR7SUV7gg17Elplly0OWLm11cJi12p+dO+HHDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Oh5KQE
        l8WAaTI7VBDzA3EcCQgAfDBXjI6Hs8YPgZBoiZdt+umo3T1PL+s98L4s7wo8MZXy
        LMWG98Gl65IUHqqqp+Mrj4UTnJKjjvkrIPy/fo646R3HK15TdcemklA01bBfar32
        BJG1lZjX2Ocj8spE5lkBU9ZKMHssppGc2Nlbg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAEBE9B836;
        Mon, 24 Jul 2017 17:41:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 340329B835;
        Mon, 24 Jul 2017 17:41:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Smith <whydoubt@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv2] blame: fix memory corruption scrambling revision name in error message
References: <20170724211550.17224-1-szeder.dev@gmail.com>
Date:   Mon, 24 Jul 2017 14:41:05 -0700
In-Reply-To: <20170724211550.17224-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 24 Jul 2017 23:15:50 +0200")
Message-ID: <xmqq4lu1cy32.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCE9A78A-70B8-11E7-9D73-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> When attempting to blame a non-existing path, git should show an error
> message like this:
>
>   $ git blame e83c51633 -- nonexisting-file
>   fatal: no such path nonexisting-file in e83c51633
>
> Since the recent commit 835c49f7d (blame: rework methods that
> determine 'final' commit, 2017-05-24) the revision name is either
> missing or some scrambled characters are shown instead.  The reason is
> that the revision name must be duplicated, because it is invalidated
> when the pending objects array is cleared in the meantime, but this
> commit dropped the duplication.
>
> Restore the duplication of the revision name in the affected functions
> (find_single_final() and find_single_initial()).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---

Thanks. =20

I vaguely recall we had the same breakage in the code that was
already fixed long time ago; that's a strange coincidence if the
js/blame-lib topic reintroduced the same bug ;-).

Will queue.

>
> Use xstrdup_or_null() in the first hunk.
>
>  blame.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/blame.c b/blame.c
> index 91e26e93e..f575e9cbf 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1663,7 +1663,7 @@ static struct commit *find_single_final(struct re=
v_info *revs,
>  		name =3D revs->pending.objects[i].name;
>  	}
>  	if (name_p)
> -		*name_p =3D name;
> +		*name_p =3D xstrdup_or_null(name);
>  	return found;
>  }
> =20
> @@ -1735,7 +1735,7 @@ static struct commit *find_single_initial(struct =
rev_info *revs,
>  		die("No commit to dig up from?");
> =20
>  	if (name_p)
> -		*name_p =3D name;
> +		*name_p =3D xstrdup(name);
>  	return found;
>  }
> =20
> @@ -1843,6 +1843,8 @@ void setup_scoreboard(struct blame_scoreboard *sb=
, const char *path, struct blam
> =20
>  	if (orig)
>  		*orig =3D o;
> +
> +	free((char *)final_commit_name);
>  }
