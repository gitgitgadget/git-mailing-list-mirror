Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E536F6105A
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhJVAKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:10:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56271 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhJVAKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:10:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D139A16415D;
        Thu, 21 Oct 2021 20:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RobwP2I68vfD
        QJeSN6hhSJLVB6JHWTvJKCdLF1r16h4=; b=NO5VfQ5JCitaK0E92JGGVn4jismC
        Zl98mOI3gmkXa+YdTXu7iTnLhoF+NuxKeoFzWYCxfz3/5HL4lWaFiWuqvRCvxMtO
        d4fVd/nawD1MxwX+JAxg1oOO9kUCSF6igIX3lZUdCD/HMzcRv6/WVjrSgUyb+XTa
        /2xDgtVbE1BTQRA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C88BA16415C;
        Thu, 21 Oct 2021 20:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 102DB16415B;
        Thu, 21 Oct 2021 20:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/6] clone: fix a memory leak of the "git_dir" variable
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-3.6-86d928ae2f9-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 17:07:48 -0700
In-Reply-To: <patch-3.6-86d928ae2f9-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:34 +0200")
Message-ID: <xmqqilxpgbvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 181B6B4C-32CC-11EC-9D9E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> At this point in cmd_clone the "git_dir" is always either an
> xstrdup()'d string, or something we got from mkpathdup(). Let's free()
> it before we clobber it.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/clone.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 559acf9e036..fb377b27657 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1040,8 +1040,10 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NUL=
L,
>  		INIT_DB_QUIET);
> =20
> -	if (real_git_dir)
> +	if (real_git_dir) {
> +		free((char *)git_dir);
>  		git_dir =3D real_git_dir;
> +	}
> =20
>  	/*
>  	 * additional config can be injected with -c, make sure it's included

I had to wonder if the old git_dir can still be pointed at by
junk_git_dir.  Much earlier than this point there is this:

	if (real_git_dir) {
		if (real_dest_exists)
			junk_git_dir_flags |=3D REMOVE_DIR_KEEP_TOPLEVEL;
		junk_git_dir =3D real_git_dir;
	} else {
		if (dest_exists)
			junk_git_dir_flags |=3D REMOVE_DIR_KEEP_TOPLEVEL;
		junk_git_dir =3D git_dir;
	}
	if (safe_create_leading_directories_const(git_dir) < 0)
		die(_("could not create leading directories of '%s'"), git_dir);

Luckily, junk_git_dir gets git_dir only when !real_git_dir, so it is
safe.  real_git_dir can only be set via the --separate-git-dir
command line option, so we are safe here.

Thanks.
