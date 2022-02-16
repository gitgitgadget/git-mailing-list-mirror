Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BCC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiBPSAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:00:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBPSAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 13:00:08 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2E29058A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:59:55 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ABB916415D;
        Wed, 16 Feb 2022 12:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rabg08y35ZWm
        ZrOc/ynz1pm5Z9GvI2eR27TAiBNxUvc=; b=FdTizwyzkbtHVe3Y7zq7Yqayz7NS
        xyK92DHaH+ztRXBY//0epW1kXJw3aF/BShForL6pe8HYM/eHmrhJwl4xJp4Qz6/0
        uNeSdT8xedfzXfkEA8g60dSvwBYRm1pfrdQNWwibx47T8lqjlio1g0E8Hn9X7L/G
        VdBkehYq+GPZPDg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1343E16415C;
        Wed, 16 Feb 2022 12:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 473A916415B;
        Wed, 16 Feb 2022 12:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit: fix "author_ident" leak
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
        <patch-1.2-25202a1d07f-20220216T081844Z-avarab@gmail.com>
Date:   Wed, 16 Feb 2022 09:59:50 -0800
In-Reply-To: <patch-1.2-25202a1d07f-20220216T081844Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 09:21:05 +0100")
Message-ID: <xmqqee42u1yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3CDFCA30-8F52-11EC-A511-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a leak in cmd_commit(), since 4c28e4ada03 (commit: die before
> asking to edit the log message, 2010-12-20) we have been freeing the
> "author_ident" "struct strbuf", but not in the case where

It took me an actual reading of the code to see that the above
refers to one and the same thing (i.e. "author_ident variable of
type struct strbuf").  I think it should be sufficient and clearer
to just mention "author_ident" here.

> prepare_to_commit() returns non-zero.

Good eyes. =20

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/commit.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6b99ac276d8..696b3527adf 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1689,6 +1689,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
>  	struct commit *current_head =3D NULL;
>  	struct commit_extra_header *extra =3D NULL;
>  	struct strbuf err =3D STRBUF_INIT;
> +	int ret =3D 0;
> =20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_commit_usage, builtin_commit_options);
> @@ -1723,8 +1724,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
>  	   running hooks, writing the trees, and interacting with the user.  =
*/
>  	if (!prepare_to_commit(index_file, prefix,
>  			       current_head, &s, &author_ident)) {
> +		ret =3D 1;
>  		rollback_index_files();
> -		return 1;
> +		goto cleanup;
>  	}
> =20
>  	/* Determine parents */
> @@ -1822,7 +1824,6 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
>  		rollback_index_files();
>  		die(_("failed to write commit object"));
>  	}
> -	strbuf_release(&author_ident);
>  	free_commit_extra_headers(extra);

Hmph, if we hit one of the two die() after this point before we
reach the "cleanup" label, author_ident will be left on the stack,
which we may want to UNLEAK()?

I am wondering if prepare_to_commit(), which is the one that is
responsible for allocating and using the information in the strbuf,
should be the one who is responsible for cleaning it when it failed
to do its thing, but I do not think it is a good idea, because the
caller MUST release it in the success case anyway.  So dealing with
the releasing here does make sense.

By jumping to the cleanup label, we not just release author_ident,
but we start unleak'ing err and sb as well, which shouldn't be a
problem, hopefully.

Will queue.

Thanks.

>  	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
> @@ -1863,7 +1864,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> =20
>  	apply_autostash(git_path_merge_autostash(the_repository));
> =20
> +cleanup:
> +	strbuf_release(&author_ident);
>  	UNLEAK(err);
>  	UNLEAK(sb);
> -	return 0;
> +	return ret;
>  }
