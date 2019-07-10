Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C141F4B6
	for <e@80x24.org>; Wed, 10 Jul 2019 20:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfGJUlY (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 16:41:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56177 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJUlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 16:41:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA7B715D8CC;
        Wed, 10 Jul 2019 16:41:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5tlGuuCY/rQS
        jAfc8k9ffRZpV60=; b=ElAHNODo8oWk++2G9bnD+wnO0034FINmsCWUER2zm848
        SM+eaHPSNvh09bBv0GgkNP97NYt7sbLroCn4JdEyGSVbxrg7Wd52TUk/COZXgb5x
        nHKXJoLgMEh27cSA2+lKXmht4vixvd2oEh7sDB65vLmnSt5XXVgzUL28rX8zrAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ok8l2+
        4mSRbTOdJ+ASF1uBW8dXSIdVgNQE6sLeULRxA6Jgf4JiiYVF+QHpCqkSvkonEMFQ
        N0sErrzigxgBF+uZ4bC+dIn3FuYtdcxcvMeF5rtdNTo3SyGSTCD9A9j4fPiaKIqj
        ZKcIhd4F4JJgjXE0ZDIHXPtKmzOcdqQNQCTZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFE8115D8CB;
        Wed, 10 Jul 2019 16:41:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20BED15D8CA;
        Wed, 10 Jul 2019 16:41:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: fix memory leak in `free_array_item()`
References: <20190710183639.4123992-1-martin.agren@gmail.com>
Date:   Wed, 10 Jul 2019 13:41:16 -0700
In-Reply-To: <20190710183639.4123992-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 10 Jul 2019 20:36:39 +0200")
Message-ID: <xmqqr26xsjv7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 116D318C-A353-11E9-9F73-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We treat the `value` pointer as a pointer to a struct and free its `s`
> field. But `value` is in fact an array of structs. As a result, we only
> free the first `s` out of `used_atom_cnt`-many and leak the rest. Make
> sure we free all items in `value`.

Thanks for spotting.  We do allocate an array of used_atom_cnt elements
in populate_value() and we need to free them all.

> In the caller, `ref_array_clear()`, this means we need to be careful no=
t
> to zero `used_atom_cnt` until after we've called `free_array_item()`. W=
e
> could move just a single line, but let's keep related things close
> together instead, by first handling `array`, then `used_atom`.

Yup.  Looking good.

Thanks.

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  ref-filter.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 791f0648a6..1c1a2af880 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2105,7 +2105,9 @@ static void free_array_item(struct ref_array_item=
 *item)
>  {
>  	free((char *)item->symref);
>  	if (item->value) {
> -		free((char *)item->value->s);
> +		int i;
> +		for (i =3D 0; i < used_atom_cnt; i++)
> +			free((char *)item->value[i].s);
>  		free(item->value);
>  	}
>  	free(item);
> @@ -2116,14 +2118,16 @@ void ref_array_clear(struct ref_array *array)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < used_atom_cnt; i++)
> -		free((char *)used_atom[i].name);
> -	FREE_AND_NULL(used_atom);
> -	used_atom_cnt =3D 0;
>  	for (i =3D 0; i < array->nr; i++)
>  		free_array_item(array->items[i]);
>  	FREE_AND_NULL(array->items);
>  	array->nr =3D array->alloc =3D 0;
> +
> +	for (i =3D 0; i < used_atom_cnt; i++)
> +		free((char *)used_atom[i].name);
> +	FREE_AND_NULL(used_atom);
> +	used_atom_cnt =3D 0;
> +
>  	if (ref_to_worktree_map.worktrees) {
>  		hashmap_free(&(ref_to_worktree_map.map), 1);
>  		free_worktrees(ref_to_worktree_map.worktrees);
