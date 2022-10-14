Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29462C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJNSbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJNSbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:31:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DB181D95
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:31:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6A691C3A7C;
        Fri, 14 Oct 2022 14:31:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gZW9bL9iH3WV
        6TiYQBxFddz1wWe8vtRxM358gbh4k+0=; b=WtmilCZ2yQotqhukqdrRsXew2/FG
        PlGntiZ08P6lbI3xx1tNt0U7EvtavaMpruPjqFpFgXnX2YKmbwfkAZdszNR7TDMl
        rwIkIo6fAsMvzUdQyDCVNWA9bg/MlUXt+/6HL6iGVfvNuXtV0agmc1uxfODbwOzP
        sc76MC8b6AVh/xg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF8FF1C3A7B;
        Fri, 14 Oct 2022 14:31:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 199511C3A7A;
        Fri, 14 Oct 2022 14:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] merge: remove always-the-same "verbose" arguments
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <patch-02.10-543ccbb1ee1-20221014T153426Z-avarab@gmail.com>
Date:   Fri, 14 Oct 2022 11:31:12 -0700
In-Reply-To: <patch-02.10-543ccbb1ee1-20221014T153426Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 14 Oct
 2022 17:40:14
        +0200")
Message-ID: <xmqqzgdy8dfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61AA3C20-4BEE-11ED-A31F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Simplify the code that builds the arguments for the "read-tree"
> invocation in reset_hard() and read_empty() to remove the "verbose"
> parameter.
>
> Before 172b6428d06 (do not overwrite untracked during merge from
> unborn branch, 2010-11-14) there was a "reset_hard()" function that
> would be called in two places, one of those passed a "verbose=3D1", the
> other a "verbose=3D0".
>
> After 172b6428d06 when read_empty() was split off from reset_hard()
> both of these functions only had one caller. The "verbose" in
> read_empty() would always be false, and the one in reset_hard() would
> always be true.
>
> There was never a good reason for the code to act this way, it
> happened because the read_empty() function was a copy/pasted and
> adjusted version of reset_hard().
>
> Since we're no longer conditionally adding the "-v" parameter
> here (and we'd only add it for "reset_hard()" we'll be able to move to
> a simpler and safer run-command API in the subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/merge.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

I haven't checked the topics in flight that touch the same file, but
as these are file-scope static, it is easy to check the correctness,
and the change of function signature will mean that compilers will
notice after a merge if there is somebody else who still wants them
to be conditionally verbose.

I wonder if these were always unused, or we lost different callers
over time, though.

>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5900b81729d..3bb49d805b4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -345,14 +345,12 @@ static int save_state(struct object_id *stash)
>  	return rc;
>  }
> =20
> -static void read_empty(const struct object_id *oid, int verbose)
> +static void read_empty(const struct object_id *oid)
>  {
>  	int i =3D 0;
>  	const char *args[7];
> =20
>  	args[i++] =3D "read-tree";
> -	if (verbose)
> -		args[i++] =3D "-v";
>  	args[i++] =3D "-m";
>  	args[i++] =3D "-u";
>  	args[i++] =3D empty_tree_oid_hex();
> @@ -363,14 +361,13 @@ static void read_empty(const struct object_id *oi=
d, int verbose)
>  		die(_("read-tree failed"));
>  }
> =20
> -static void reset_hard(const struct object_id *oid, int verbose)
> +static void reset_hard(const struct object_id *oid)
>  {
>  	int i =3D 0;
>  	const char *args[6];
> =20
>  	args[i++] =3D "read-tree";
> -	if (verbose)
> -		args[i++] =3D "-v";
> +	args[i++] =3D "-v";
>  	args[i++] =3D "--reset";
>  	args[i++] =3D "-u";
>  	args[i++] =3D oid_to_hex(oid);
> @@ -385,7 +382,7 @@ static void restore_state(const struct object_id *h=
ead,
>  {
>  	struct strvec args =3D STRVEC_INIT;
> =20
> -	reset_hard(head, 1);
> +	reset_hard(head);
> =20
>  	if (is_null_oid(stash))
>  		goto refresh_cache;
> @@ -1470,7 +1467,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>  					       check_trust_level);
> =20
>  		remote_head_oid =3D &remoteheads->item->object.oid;
> -		read_empty(remote_head_oid, 0);
> +		read_empty(remote_head_oid);
>  		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
>  			   UPDATE_REFS_DIE_ON_ERR);
>  		goto done;
