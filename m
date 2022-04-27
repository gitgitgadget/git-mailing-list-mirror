Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBAC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiD0Qia (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiD0Qi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:38:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A0606D8
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:35:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28E6F192192;
        Wed, 27 Apr 2022 12:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A/z1vQzq1NVi
        +lhOO0mBi4YauXIycM0BoR/B5fPjXk4=; b=fVKFIiOEidGT0xuG7FRFA+eOlAmu
        AhB4HzoizeMj3WSSdyjQmUFQvlBsaPzOsrKVzzAW1UcTtaiteMZ7kwLRKmNMvUg/
        GUdih8DWzDONamNJep7ey1lXjIHPIh4oHveFAazmyzxAYDBtVhB6aH+T9UQQEENd
        e1LR73oKcgn5SpA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21206192191;
        Wed, 27 Apr 2022 12:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A32F119218F;
        Wed, 27 Apr 2022 12:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, me@m28.io, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] setup: avoid uninitialized use of is_safe in
 ensure_valid_ownership
References: <20220427080412.37766-1-carenas@gmail.com>
Date:   Wed, 27 Apr 2022 09:35:10 -0700
In-Reply-To: <20220427080412.37766-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 27 Apr 2022 01:04:12 -0700")
Message-ID: <xmqq8rrqo56p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 021A4ABA-C648-11EC-86C5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 8959555cee7 (setup_git_directory(): add an owner check for the top-leve=
l
> directory, 2022-03-02) adds this member as part of a newly created
> structure that then gets initialized during the callback, but bb50ec3cc=
30
> (setup: fix safe.directory key not being checked, 2022-04-13) add a
> quick exit from the callback that avoids this initialization unless the
> callback is called with the relevant key.
>
> This leads to this variable not being initialized UNLESS the global con=
fig
> has at least one key for safe.directory, so instead initialize it in th=
e
> caller.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index a7b36f3ffbf..17c7f5fc1dc 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1122,7 +1122,7 @@ static int safe_directory_cb(const char *key, con=
st char *value, void *d)
> =20
>  static int ensure_valid_ownership(const char *path)
>  {
> -	struct safe_directory_data data =3D { .path =3D path };
> +	struct safe_directory_data data =3D { .path =3D path, .is_safe =3D 0 =
};

This is not wrong per-se but is not necessary.  Once you have an
initializer, the struct is zero initialized except for members whose
initial values are explicitly mentioned in the initializer.

Sometimes an explicit initialization is a good way to make the
intention of the code clear, and because setting of the .is_safe
member is done inside a callback function, out of sight from the
reader of this function, while the return value does depend on
having a valid value in the .is_safe member, I do not think we mind
this change, though.

But if we were to take it, the justification must be rewritten.  It
is an OK change to clarify the code to human readers.  It is not a
fix to a bug that left a struct member uninitialized.

> =20
>  	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
>  	    is_path_owned_by_current_user(path))
