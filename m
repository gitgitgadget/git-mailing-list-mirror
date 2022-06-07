Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7FCC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbiFGRcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348252AbiFGRbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:31:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8F118017
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:29:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DCD6198766;
        Tue,  7 Jun 2022 13:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yKxt/T31Sc0+
        cBdzC5WvUr/U+aZblxjhWFyU2UMTLwA=; b=voMMkbtSa6s97oLTSASwuKEnsud/
        69rgXWFsqz+L1cG5wHAZSJETrP9oOL6iwnckXgaPaO2o2W+FtNVC8aAg/NrKTCet
        +x2lC5RLbAEiF9C3S9O7XPuGuuwM9YW7q/V4aJKGwKcdCMgCZgoujN+imGA5c55z
        j2bXD9cGm3uwPvY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57FFD198765;
        Tue,  7 Jun 2022 13:29:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08F18198764;
        Tue,  7 Jun 2022 13:29:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 3/3] remote API: don't buggily FREE_AND_NULL(), free()
 instead
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
        <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
Date:   Tue, 07 Jun 2022 10:29:43 -0700
In-Reply-To: <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Jun
 2022 17:50:05 +0200")
Message-ID: <xmqqee00xtyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C1D9778-E687-11EC-9580-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the buggy "remote_clear()" function to stop pretending to to be

"buggy" -> ""; "to to" -> "to".

Over-using FREE_AND_NULL() is indeed irritating, but as long as we
are not reusing the struct whose member are getting freed, there is
no "bug" per-se, no?

> able to zero out a "struct remote". Setting "url" and "pushurl" to
> NULL results in an invalid state unless the corresponding "url_nr" and
> "pushurl_nr" are also set to zero.
>
> In this case however we do not use the "struct remote", so the

"use" -> "reuse", with comma around "however" on both sides, probably.

> FREE_AND_NULL() pattern added in fd3cb0501e1 (remote: move static
> variables into per-repository struct, 2021-11-17) can be replaced with
> free().

Yay.

> The API was also odd in that remote_state_new() would xmalloc() for us,
> but the user had to free() it themselves, let's instead change the
> behavior to have the destructor free() what we malloc() in the
> constructer.

I am not sure if remote_clear() that does not free the remote goes
well with remote_state_clear() that does free remote_state.  As long
as it is clear whose responsibility to release resources is, we can
go either way, but helper functions with similar names having quite
different resource maintainance semantics looks like a potential
source of confusion to me.

> In this case this appears to have been done for consistency with
> repo_clear(), let's instead have repo_clear() handle the NULL-ing of
> its "remote_state", and not attempt to reset the structure in remote.c
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  remote.c     | 14 +++++++-------
>  remote.h     | 10 +++++++++-
>  repository.c |  2 +-
>  3 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 0b243b090d9..c6ce04dacb7 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -147,15 +147,15 @@ static void remote_clear(struct remote *remote)
> =20
>  	for (i =3D 0; i < remote->url_nr; i++)
>  		free((char *)remote->url[i]);
> -	FREE_AND_NULL(remote->url);
> +	free(remote->url);
> =20
>  	for (i =3D 0; i < remote->pushurl_nr; i++)
>  		free((char *)remote->pushurl[i]);
> -	FREE_AND_NULL(remote->pushurl);
> +	free(remote->pushurl);
>  	free((char *)remote->receivepack);
>  	free((char *)remote->uploadpack);
> -	FREE_AND_NULL(remote->http_proxy);
> -	FREE_AND_NULL(remote->http_proxy_authmethod);
> +	free(remote->http_proxy);
> +	free(remote->http_proxy_authmethod);
>  }
> =20
>  static void add_merge(struct branch *branch, const char *name)
> @@ -2720,12 +2720,12 @@ void remote_state_clear(struct remote_state *re=
mote_state)
> =20
>  	for (i =3D 0; i < remote_state->remotes_nr; i++)
>  		remote_clear(remote_state->remotes[i]);
> -	FREE_AND_NULL(remote_state->remotes);
> -	remote_state->remotes_alloc =3D 0;
> -	remote_state->remotes_nr =3D 0;
> +	free(remote_state->remotes);
> =20
>  	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, en=
t);
>  	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, e=
nt);
> +
> +	free(remote_state);
>  }
> =20
>  /*
> diff --git a/remote.h b/remote.h
> index dd4402436f1..d91b2b29373 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -54,9 +54,17 @@ struct remote_state {
>  	int initialized;
>  };
> =20
> -void remote_state_clear(struct remote_state *remote_state);
> +/**
> + * xmalloc() a "struct remote_state" and initialize it. The resulting
> + * data should be free'd with remote_state_clear().
> + */
>  struct remote_state *remote_state_new(void);
> =20
> +/**
> + * free() the structure returned by remote_state_new().
> + */
> +void remote_state_clear(struct remote_state *remote_state);
> +
>  struct remote {
>  	struct hashmap_entry ent;
> =20
> diff --git a/repository.c b/repository.c
> index 5d166b692c8..0a6df6937e4 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -292,7 +292,7 @@ void repo_clear(struct repository *repo)
> =20
>  	if (repo->remote_state) {
>  		remote_state_clear(repo->remote_state);
> -		FREE_AND_NULL(repo->remote_state);
> +		repo->remote_state =3D NULL;
>  	}
> =20
>  	repo_clear_path_cache(&repo->cached_paths);
