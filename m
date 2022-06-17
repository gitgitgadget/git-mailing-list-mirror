Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39BC43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiFQVCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFQVCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 17:02:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161555B3D1
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 14:02:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 607CA1334E9;
        Fri, 17 Jun 2022 17:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wHtvAqtqKBlg
        SI84FPD/OiQXKRM/YdpR8dECbm19qV0=; b=oIOCR0JDUCkMb6OMk86Mg4NVENzR
        r9SOeaMK2BcN1y7I4XcnlPcieaLEhTlbq103ia60PDoiw9alKtwF59DBv9TV75kg
        Pm/v60wroxKP6jgCHaf/iii55/A+rijTm17A4vG0t+ngB0BBn0m+nLKHKSLM77u5
        j5kSUPBNZ0M7uFk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4704C1334E8;
        Fri, 17 Jun 2022 17:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4EF81334E7;
        Fri, 17 Jun 2022 17:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de, szeder.dev@gmail.com
Subject: Re: [PATCH v6] git-compat-util: allow root to access both SUDO_UID
 and root owned
References: <20220513010020.55361-5-carenas@gmail.com>
        <20220617202338.27984-1-carenas@gmail.com>
Date:   Fri, 17 Jun 2022 14:02:06 -0700
In-Reply-To: <20220617202338.27984-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 17 Jun 2022 13:23:38 -0700")
Message-ID: <xmqq8rpvngvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF8A914E-EE80-11EC-A50D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Previous changes introduced a regression which will prevent root for
> accessing repositories owned by thyself if using sudo because SUDO_UID
> takes precedence.
>
> Loosen that restriction by allowing root to access repositories owned
> by both uid by default and without having to add a safe.directory
> exception.
>
> A previous workaround that was documented in the tests is no longer
> needed so it has been removed together with its specially crafted
> prerequisite.
>
> Helped-by: Johanness Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> It is a little more involved than the proposed change just to make
> sure that it doesn't introduce any change on behavior (the code is
> still strictly only invoked after we confirm process is running as
> root) and keeps the documentation and test changes that were in the
> original proposal.
>
> A CI run (which is the only way to reliably test this, since the
> prerequisite only works in macOS agents like the ones provided by
> GitHub) with this patch merged into master is available[1]
>
> [1] https://github.com/carenas/git/actions/runs/2516394052
>
> Changes since v5:
> * simplify logic change to avoid additional refactoring
>
>  Documentation/config/safe.txt  |  5 +++--
>  git-compat-util.h              |  7 ++++++-
>  t/t0034-root-safe-directory.sh | 15 +--------------
>  3 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.=
txt
> index c6ebd1674d..3128b13271 100644
> --- a/Documentation/config/safe.txt
> +++ b/Documentation/config/safe.txt
> @@ -31,11 +31,12 @@ As explained, Git only allows you to access reposit=
ories owned by
>  yourself, i.e. the user who is running Git, by default.  When Git
>  is running as 'root' in a non Windows platform that provides sudo,
>   however, git checks the SUDO_UID environment variable that sudo creat=
es

Not a problem with this patch, but one extra space at the beginning
of this line looks funny.  I'd probably remove it while queueing if
I do not forget.

> -and will allow access to the uid recorded as its value instead.
> +and will allow access to the uid recorded as its value in addition to
> +the id from 'root'.

OK.  So the original user who invoked "sudo", plus root.  Does "the
id from root" refer to ROOT_UID?  I am just wondering if "from" is
the right preposition (what the sentence wants to say is perfectly
clear, so the patch is OK as-is, but "user id of 'root'" is probably
what I would have said).

>  This is to make it easy to perform a common sequence during installati=
on
>  "make && sudo make install".  A git process running under 'sudo' runs =
as
>  'root' but the 'sudo' command exports the environment variable to reco=
rd
>  which id the original user has.
>  If that is not what you would prefer and want git to only trust
> -repositories that are owned by root instead, then you must remove
> +repositories that are owned by root instead, then you can remove
>  the `SUDO_UID` variable from root's environment before invoking git.

OK.  The same escape hatch works, and the code change does not
contribut to any behaviour change in this area, so there is no
reason to change the phrasing here.  I guess they mean the same
thing anyway, so let's take it.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index e7cbfa65c9..f505f817d5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -447,7 +447,12 @@ static inline int is_path_owned_by_current_uid(con=
st char *path)
> =20
>  	euid =3D geteuid();
>  	if (euid =3D=3D ROOT_UID)
> -		extract_id_from_env("SUDO_UID", &euid);
> +	{

Style?

-	if (euid =3D=3D ROOT_UID)
-		extract_id_from_env("SUDO_UID", &euid);
+	if (euid =3D=3D ROOT_UID) {

> +		if (st.st_uid =3D=3D ROOT_UID)
> +			return 1;
> +		else
> +			extract_id_from_env("SUDO_UID", &euid);
> +	}
> =20
>  	return st.st_uid =3D=3D euid;
>  }

I would not call it clearer than what Dscho called "something like
this", and

	if (euid =3D=3D ROOT_UID && st.st_uid !=3D ROOT_UID)
		extract(...);
	return st.st_uid =3D=3D euid;

would be what I would have written, but they mean the same thing, so
let's take it as-is.

Thanks.
