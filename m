Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F7C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiEJW5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiEJW5L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:57:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003485F8C0
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:57:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4B7018B777;
        Tue, 10 May 2022 18:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yaN5p8NEu4ay
        Nonhh3M5b4DEPCIE3rFgFpYa4dINJIg=; b=xfLHc2JtXG9UEiAwN7SlVvDrndxm
        RlaAphKgPWm+7GM4iHPmzwi2PER9TsmXHbKoFehnElMopnsk9pkfvfOWjEzjwoM4
        Czor1l0GtWI8cb+mDRW3v+9vApssd+9UO65JwltDNHPgUXxXhq/MpUv/6SZnaCPv
        WZj2ZzmflIJiMHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCF2C18B775;
        Tue, 10 May 2022 18:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73A0618B771;
        Tue, 10 May 2022 18:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-3-carenas@gmail.com>
Date:   Tue, 10 May 2022 15:57:02 -0700
In-Reply-To: <20220510174616.18629-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 10 May 2022 10:46:15 -0700")
Message-ID: <xmqqv8ud5741.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81F8F79C-D0B4-11EC-A621-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> This assumes the environment the user is running on after going
> privileged can't be tampered with, and also adds code to restrict that
> the new behavior only applies if running as root, therefore keeping the
> most common case, which runs unprivileged, from changing, but because o=
f
> that, it will miss cases where sudo (or an equivalent) was used to chan=
ge
> to another unprivileged user or where the equivalent tool used to raise
> privileges didn't track the original id in a sudo compatible way.

Well written.

> Because of compatibility with sudo, the code assumes that uid_t is an
> unsigned integer type (which is not required by the standard) but is us=
ed
> that way in their codebase to generate SUDO_UID.

Heh, that is a good point.

> ++
> +When git tries to check for ownership of git repositories, it will
> +obviously do so with the uid of the user that is running git itself,

We do not need "obviously" here, but this has overlap with the
beginning part of the safe.directory explanation, so I would
probably suggest rewriting it altogether.

> +but if git is running as root, in a platform that provides sudo and is
> +not Windows, it will check first if it might have been started through

Does Windows provide sudo that leaves the original user in SUDO_UID
(I doubt it)?  If not, then "on a platform that provides sudo, it will"
would be sufficient.

> +it, and if that is the case, will use the uid of the user that invoked
> +sudo instead.

 =20
  As explained, Git only allows you to access repositories owned by
  yourself, i.e. the user who is running Git, by default.  When Git
  is running as 'root', however, instead of allowing accesses to
  repositories owned by 'root', it checks the SUDO_UID environment
  variable and if it is set, allows access to repositories owned by
  the uid recorded as its value.  This is to make it easy to perform
  a common sequence "make && sudo make install".  A process running
  under 'sudo' runs as 'root' but the 'sudo' command exports the
  environment variable to record who the original user was.

> +If that is not what you would prefer and want git to only trust
> +repositories that are owned by root instead, then you should remove
> +the `SUDO_UID` variable from root's environment.

s/should/can/.  But otherwise this is excellent.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 63ba89dd31..754cd90d43 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -393,12 +393,64 @@ static inline int git_offset_1st_component(const =
char *path)
>  #endif
> =20
>  #ifndef is_path_owned_by_current_user
> +
> +#ifdef __TANDEM
> +#define ROOT_UID 65535
> +#else
> +#define ROOT_UID 0
> +#endif
> +
> +/*
> + * This helper function overrides a ROOT_UID with the one provided by
> + * an environment variable, do not use unless the original user is
> + * root or could be used as means to escalate to root privileges.

I do not understand the "or could be used ..." at all.  If the
original user obtained from geteuid() is not root, then no matter
what we do to *id here in this function, we won't let you gain the
root privilege.  The system won't let us give you the root privilege
because we (Git) are running as a normal user.

Or do you mean

	Do not use this function when

	 (1) geteuid() did not say we are running as 'root', or=20
	 (2) using this function will compromise the system.=20

Then I can sort-of understand it, but (2) is a too obvious thing to
say.

> + * PORTABILITY WARNING:
> + * This code assumes uid_t is unsigned because that is what sudo does.
> + * If your uid_t type is signed and all your ids are positive then it
> + * should all work fine, but need to make sure sudo never generates a
> + * value higher than what can be represented by your uid_t type or a
> + * negative value or it will trigger wraparound bugs.

"sudo" generating a value higher than what uid_t can represent in
SUDO_UID *is* a bug that we shouldn't have to worry about.
Otherwise "sudo" as a tool would be unusable by folks with higher
UID on their system.

In their implementation of "sudo", they must have done getuid(),
stored the value in uid_t and formatted it into a string.  If they
lost precision there by wrapping around or truncating, we can do
nothing about it, but the thing is, we cannot even tell.

> + * If that happens the uid used might be incorrect and then trigger
> + * an access error from the filesystem itself.

If uid we are extracting is incorrect, Git will fail to refuse
access, the access is done as 'root', and filesystem level safety
will not trigger.  The end result is that I run "sudo git describe"
in your repository and instead of getting refused, because our "sudo"
was broken and SUDO_UID had your numeric uid, I execute "git" as root
in your repository.

IOW, this change is meant to make it slightly convenient to allow
access to one's own stuff, but it got a bit more convenient by
allowing me access to my own stuff plus yours ;-)

> + * In the unlikely scenario this happened to you, and that is how you
> + * got to this message, we would like to know about it by letting us
> + * now with an email to git@vger.kernel.org indicating which platform,
> + * you are running on and which version of sudo you used to see if we
> + * can provide you a patch that would prevent this issue in the future=
.

Nice.  What message does the reporter see?

> + */
> +static inline void extract_id_from_env(const char *env, uid_t *id)
> +{
> +	const char *real_uid =3D getenv(env);
> +
> +	/* discard anything empty to avoid a more complex check below */
> +	if (real_uid && *real_uid) {
> +		char *endptr =3D NULL;
> +		unsigned long env_id;
> +
> +		errno =3D 0;
> +		/* silent overflow errors could trigger a bug below */

What "bug" are we referring to?

> +		env_id =3D strtoul(real_uid, &endptr, 10);
> +		if (!*endptr && !errno)
> +			*id =3D env_id;
> +	}
> +}
> +
>  static inline int is_path_owned_by_current_uid(const char *path)
>  {
>  	struct stat st;
> +	uid_t euid;
> +
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid =3D=3D geteuid();
> +
> +	euid =3D geteuid();
> +	if (euid =3D=3D ROOT_UID)
> +		extract_id_from_env("SUDO_UID", &euid);
> +
> +	return st.st_uid =3D=3D euid;
>  }
> =20
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directo=
ry.sh
> index 2e4492a66d..ecd9dca6b3 100755
> --- a/t/t0034-root-safe-directory.sh
> +++ b/t/t0034-root-safe-directory.sh
> @@ -29,7 +29,7 @@ test_expect_success SUDO 'setup' '
>  	)
>  '
> =20
> -test_expect_failure SUDO 'sudo git status as original owner' '
> +test_expect_success SUDO 'sudo git status as original owner' '
>  	(
>  		cd root/r &&
>  		git status &&

OK.

Thanks.
