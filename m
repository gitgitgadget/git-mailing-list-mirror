Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B999C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1D963219
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhKPFwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:52:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63165 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbhKPFwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:52:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BB23106D91;
        Tue, 16 Nov 2021 00:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=0pRKD7sklcpnKm9VR/LWQAHaM
        nqColS7MyF6Xrh4xNw=; b=dK3OhDqIR4Fhz1e6vwlHdmvQwGxjO22MtygeI37bW
        kXE0HyGmFhvuLVdBY2KkD3tN3Mx099E0eLtCcP8Uth0fBpg2iZNCxBw4UDqTxV2b
        Ss7AMGnNVUQGpBlYaiilkmGqnKW9dFFbhgeie2VUTNebnn0tfSWtjyE3jMvhQTm8
        48=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 219E8106D90;
        Tue, 16 Nov 2021 00:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77B29106D8F;
        Tue, 16 Nov 2021 00:49:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 6/8] receive-pack: clean dead code from
 update_worktree()
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-7-andersk@mit.edu>
Date:   Mon, 15 Nov 2021 21:49:10 -0800
Message-ID: <xmqqv90sbqg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC509FF8-46A0-11EC-BC47-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> update_worktree() can only be called with a non-NULL worktree parameter=
,
> because that=E2=80=99s the only case where we set do_update_worktree =3D=
 1.
> worktree->path is always initialized to non-NULL.

Yup.  I remember seeing this analysed in earlier rounds' reviews.
Nice lossage of lines ;-)

>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/receive-pack.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 5d7c4832c1..b04d4ad268 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1444,29 +1444,22 @@ static const char *push_to_checkout(unsigned ch=
ar *hash,
> =20
>  static const char *update_worktree(unsigned char *sha1, const struct w=
orktree *worktree)
>  {
> -	const char *retval, *work_tree, *git_dir =3D NULL;
> +	const char *retval, *git_dir;
>  	struct strvec env =3D STRVEC_INIT;
> =20
> -	if (worktree && worktree->path)
> -		work_tree =3D worktree->path;
> -	else if (git_work_tree_cfg)
> -		work_tree =3D git_work_tree_cfg;
> -	else
> -		work_tree =3D "..";
> +	if (!worktree || !worktree->path)
> +		BUG("worktree->path must be non-NULL");
> =20
>  	if (is_bare_repository())
>  		return "denyCurrentBranch =3D updateInstead needs a worktree";
> -	if (worktree)
> -		git_dir =3D get_worktree_git_dir(worktree);
> -	if (!git_dir)
> -		git_dir =3D get_git_dir();
> +	git_dir =3D get_worktree_git_dir(worktree);
> =20
>  	strvec_pushf(&env, "GIT_DIR=3D%s", absolute_path(git_dir));
> =20
>  	if (!find_hook(push_to_checkout_hook))
> -		retval =3D push_to_deploy(sha1, &env, work_tree);
> +		retval =3D push_to_deploy(sha1, &env, worktree->path);
>  	else
> -		retval =3D push_to_checkout(sha1, &env, work_tree);
> +		retval =3D push_to_checkout(sha1, &env, worktree->path);
> =20
>  	strvec_clear(&env);
>  	return retval;
> @@ -1587,9 +1580,7 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
>  	}
> =20
>  	if (do_update_worktree) {
> -		ret =3D update_worktree(new_oid->hash,
> -				      find_shared_symref(worktrees, "HEAD",
> -							 name));
> +		ret =3D update_worktree(new_oid->hash, worktree);
>  		if (ret)
>  			goto out;
>  	}
