Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77691F461
	for <e@80x24.org>; Fri, 30 Aug 2019 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Q3H (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 12:29:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52409 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3Q3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 12:29:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EB4E16419C;
        Fri, 30 Aug 2019 12:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=etGR2uRzlfTn
        sjvS8Hc3Au+Wmzs=; b=sJX5EEhuLeqN97uFB1sP7VQBjpN613CBUAoy5cOeJ37c
        bTvm0LrCE9+9DcHXOuIgmozWOSv+uY4ZglJdyi84fUEJQlrDP5vWmFOSZcAsZeQ1
        KT6ftmrOSv7EqpNzoFonnPeGc9uBeo/PL8sQE/twg3qEvRR5B4sNPVlDe+ximqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W6ivSn
        SD6NS1WTudVU0zW59y8Unb61ynIzUn7oLob4tQoO8rTM7O4vYnZXgG2txy9F0aVM
        fBc2oh5aRmnBm5GM0pgh3ktURuza+SfIuCmgQsLcinVUqMxcwgmdMP+QMTenF5A/
        0lth2scyPoaQaX3ty56x3LrcafcBdq13cHvRU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8400D16419B;
        Fri, 30 Aug 2019 12:29:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3D12164199;
        Fri, 30 Aug 2019 12:29:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Sperling <stsp@stsp.name>, git@vger.kernel.org
Subject: Re: [PATCH] fix segv with corrupt tag object
References: <20190824230944.GA14132@jessup.stsp.name>
        <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
        <20190826115715.GB71935@jessup.stsp.name>
        <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
        <c6601cca-7de0-ba82-2e18-916a2e9048d3@web.de>
Date:   Fri, 30 Aug 2019 09:29:03 -0700
In-Reply-To: <c6601cca-7de0-ba82-2e18-916a2e9048d3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 29 Aug 2019 21:06:22 +0200")
Message-ID: <xmqqh85yzkfk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 485D66F4-CB43-11E9-A11D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] tree: simplify parse_tree_indirect()
>
> Reduce code duplication by turning parse_tree_indirect() into a wrapper
> of repo_peel_to_type().  This avoids a segfault when handling a broken
> tag where ->tagged is NULL.  The new version also checks the return
> value of parse_object() that was ignored by the old one.
>
> Initial-patch-by: Stefan Sperling <stsp@stsp.name>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  tree.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/tree.c b/tree.c
> index 4720945e6a..1466bcc6a8 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -244,19 +244,7 @@ void free_tree_buffer(struct tree *tree)
>
>  struct tree *parse_tree_indirect(const struct object_id *oid)
>  {
> -	struct object *obj =3D parse_object(the_repository, oid);
> -	do {
> -		if (!obj)
> -			return NULL;
> -		if (obj->type =3D=3D OBJ_TREE)
> -			return (struct tree *) obj;
> -		else if (obj->type =3D=3D OBJ_COMMIT)
> -			obj =3D &(get_commit_tree(((struct commit *)obj))->object);
> -		else if (obj->type =3D=3D OBJ_TAG)
> -			obj =3D ((struct tag *) obj)->tagged;
> -		else
> -			return NULL;
> -		if (!obj->parsed)
> -			parse_object(the_repository, &obj->oid);
> -	} while (1);
> +	struct repository *r =3D the_repository;
> +	struct object *obj =3D parse_object(r, oid);
> +	return (struct tree *)repo_peel_to_type(r, NULL, 0, obj, OBJ_TREE);
>  }

Looks quite sensible to me; it is too simple that it makes me
worried that I might be missing something huge.

