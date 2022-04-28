Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA063C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 05:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiD1FUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiD1FUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 01:20:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA711A0F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 22:17:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26DC8198B1A;
        Thu, 28 Apr 2022 01:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TjBnwGtuigXb
        FaeZpetzHPJYv28WIdpX7eM8K2sf7qc=; b=ulgJR9rk0kxdIh1jFmeTs77sbmwQ
        j7Wf0Xslx7Hs+BHE3swwQ9d89T+w5T90pfK0Mm/QJDadnVKzPUnnO/gsbFuuAUuJ
        PdfWX7qvNEaWVYaN5EC98srt0ntsFHHXnnsrz33CSkogNnDMyNSIY9Lc/brsQYCh
        2HEXteWNDva9cWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11341198B19;
        Thu, 28 Apr 2022 01:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E10E198B18;
        Thu, 28 Apr 2022 01:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 1/2] Documentation: explain how safe.directory works
 when running under sudo
References: <20220427222649.63516-1-carenas@gmail.com>
        <20220428033544.68188-1-carenas@gmail.com>
        <20220428033544.68188-2-carenas@gmail.com>
Date:   Wed, 27 Apr 2022 22:17:27 -0700
In-Reply-To: <20220428033544.68188-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 27 Apr 2022 20:35:43 -0700")
Message-ID: <xmqqlevphjmg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F634F66-C6B2-11EC-86B3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> In a previous patch, the behaviour of git was changed so it will be abl=
e
> to find the "effective uid" that is required when git was invoked with
> sudo to root, for example:
>
>   $ sudo make install
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Documentation/config/safe.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.=
txt
> index 6d764fe0ccf..67f8ef5d766 100644
> --- a/Documentation/config/safe.txt
> +++ b/Documentation/config/safe.txt
> @@ -26,3 +26,11 @@ directory was listed in the `safe.directory` list. I=
f `safe.directory=3D*`
>  is set in system config and you want to re-enable this protection, the=
n
>  initialize your list with an empty value before listing the repositori=
es
>  that you deem safe.
> ++
> +When git tries to check for ownership of git repositories it will obvi=
ously

Comma before "it will obviously".

> +use the user that is being used to run git itself, but if git is runni=
ng
> +as root, it will first check if it might had been started through `sud=
o`,
> +and if that is the case, will use the user id that invoked sudo instea=
d.

This raises a design question.  In a repository is owned by root,
shouldn't "sudo git describe" work?  IOW, I am wondering if the
"instead" at the end of the description is what we want, or if we
want to check both the original user and "root".

There is not much point in protecting against a malicious repository
a repository that is owned by "root"---an attacker that can create
such a repository and futz with its config or hooks can attack you
more directly, without social engineering you into using git on such
a repository.  So from that point of view, it may be reasonable to
say that we can trust repositories owned by=20

 - euid (both when euid is root and euid is not root)
 - SUDO_UID (when euid is root)

I think.  And even if we adopt such a tweak, ...

> +If that is not what you would prefer and want git to instead only trus=
t
> +repositories that are owned by root, then you should remove the `SUDO_=
UID`
> +variable from root's environment.

... this is still true.

I guess the necessary tweak to the code, if we were to take that
suggestion, would be quite small.  We are happy when euid owns the
path (regardless of who euid is), and in addition, only when euid
is root, we check with SUDO_UID, too.

 git-compat-util.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index dfdd3e4f81..18660553b3 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -401,13 +401,13 @@ static inline int git_offset_1st_component(const ch=
ar *path)
 #endif
=20
 /*
- * this helper function overrides a ROOT_UID with the one provided by
- * an environment variable, do not use unless the original user is
- * root
+ * The environment variable (e.g. SUDO_UID) gives an integer;
+ * is it the same as the given uid_t id?
  */
-static inline void extract_id_from_env(const char *env, uid_t *id)
+static inline int id_from_env_matches(const char *env, uid_t id)
 {
 	const char *real_uid =3D getenv(env);
+	int matches =3D 0;
=20
 	/* discard any empty values */
 	if (real_uid && *real_uid) {
@@ -417,11 +417,12 @@ static inline void extract_id_from_env(const char *=
env, uid_t *id)
=20
 		errno =3D 0;
 		env_id =3D strtoul(real_uid, &endptr, 10);
-		if (!errno && !*endptr && env_id <=3D (uid_t)-1)
-			*id =3D env_id;
-
+		if (!errno && !*endptr && env_id <=3D (uid_t)-1 &&
+		    (uid_t)env_id =3D=3D id)
+			matches =3D 1;
 		errno =3D saved_errno;
 	}
+	return matches;
 }
=20
 static inline int is_path_owned_by_current_uid(const char *path)
@@ -433,10 +434,11 @@ static inline int is_path_owned_by_current_uid(cons=
t char *path)
 		return 0;
=20
 	euid =3D geteuid();
+	if (st.st_uid =3D=3D euid)
+		return 1;
 	if (euid =3D=3D ROOT_UID)
-		extract_id_from_env("SUDO_UID", &euid);
-
-	return st.st_uid =3D=3D euid;
+		return id_from_env_matches("SUDO_UID", st.st_uid);
+	return 0;
 }
=20
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
