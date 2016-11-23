Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9D01FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbcKWRGj (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:06:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63063 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750710AbcKWRGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:06:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3AB14B927;
        Wed, 23 Nov 2016 12:06:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0FrrsC9fzPvT
        GTmrkyWcl2K7IYk=; b=vFphinSBx2qIwl5PHgBiBWS8pmQtt+2Eiju+lA2bfANb
        3KOkl+nfbSe12eIhUOGwUzbTOYgNEvX8kV7Dx1DbFv1B+pq8JSBKNw0TR4x2Y2Fg
        2vTx5ucVklUQDxmdW0zFmmTxUkvWTCYT/mjmCU3noX7YId5xT0tjiVTvCczrQ/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dbUlpe
        vhYyPOchEIF+EpDAon0nCvA+Z7Jry5tdQMaiZlU54+ZXegRn82ED3sD1aXkSV8eT
        /QWg8UKTEWwFIyh0b9JaYvq4hgYVzdzvOvj2OjVWiPzo00XMu8TR+3ZvrznZDlFt
        H8irKZTs5X2UDhoqU1qwXC0uJqKtmoYc2Pt9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A3734B926;
        Wed, 23 Nov 2016 12:06:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12EEE4B925;
        Wed, 23 Nov 2016 12:06:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rappazzo@gmail.com
Subject: Re: [PATCH 2/3] get_worktrees() must return main worktree as first item even on error
References: <20161122100046.8341-1-pclouds@gmail.com>
        <20161122100046.8341-3-pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 09:06:35 -0800
In-Reply-To: <20161122100046.8341-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 22 Nov 2016 17:00:45 +0700")
Message-ID: <xmqq1sy2nn1g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31922AC4-B19F-11E6-942E-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5c4854d..b835b91 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -388,7 +388,7 @@ static void show_worktree_porcelain(struct worktree=
 *wt)
>  		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
>  		if (wt->is_detached)
>  			printf("detached\n");
> -		else
> +		else if (wt->head_ref)
>  			printf("branch %s\n", wt->head_ref);

This change looks somewhat unrelated to what the title and the log
message claims to do, but the fix is to indicate an error condition
by leaving wt->head_ref as NULL, so this is a necessary adjustment.

Good.

> @@ -406,10 +406,12 @@ static void show_worktree(struct worktree *wt, in=
t path_maxlen, int abbrev_len)
>  	else {
>  		strbuf_addf(&sb, "%-*s ", abbrev_len,
>  				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
> -		if (!wt->is_detached)
> +		if (wt->is_detached)
> +			strbuf_addstr(&sb, "(detached HEAD)");
> +		else if (wt->head_ref)
>  			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
>  		else
> -			strbuf_addstr(&sb, "(detached HEAD)");
> +			strbuf_addstr(&sb, "(error)");
>  	}

Likewise.

> diff --git a/worktree.c b/worktree.c
> index f7c1b5e..a674efa 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -89,7 +89,7 @@ static struct worktree *get_main_worktree(void)
>  	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> =20
>  	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
> -		goto done;
> +		strbuf_reset(&head_ref);
> =20
>  	worktree =3D xcalloc(1, sizeof(*worktree));
>  	worktree->path =3D strbuf_detach(&worktree_path, NULL);
> @@ -97,7 +97,6 @@ static struct worktree *get_main_worktree(void)
>  	worktree->is_detached =3D is_detached;
>  	add_head_info(&head_ref, worktree);

OK.  The earlier call to _reset() and add_head_info() function
itself may want to be clarified that a zero-length strbuf signals an
error condition with additional comment.  It is all too unclear in
the code with this patch as it stands.

> -done:
>  	strbuf_release(&path);
>  	strbuf_release(&worktree_path);
>  	strbuf_release(&head_ref);

After this there is "return worktree" which used to return NULL
because of the "goto", but we never return NULL from the function
after this change, which is the whole point of this change.  Good.

> @@ -173,8 +172,7 @@ struct worktree **get_worktrees(void)
> =20
>  	list =3D xmalloc(alloc * sizeof(struct worktree *));
> =20
> -	if ((list[counter] =3D get_main_worktree()))
> -		counter++;
> +	list[counter++] =3D get_main_worktree();

Hence the conditional, while it does not hurt, becomes unnecessary
and we can unconditionally throw the primary one to the list.

Good.

Other than the "these need in-code commenting", and also that this
should have a new test, the patch makes sense to me.

Thanks.
