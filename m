Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989D8200B9
	for <e@80x24.org>; Sun,  6 May 2018 15:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEFPyQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 11:54:16 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55548 "EHLO
        homiemail-a39.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751407AbeEFPyQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 11:54:16 -0400
Received: from homiemail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTP id AE17D15006D;
        Sun,  6 May 2018 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=DtlKt
        6JFblTXSeWLHNUIvSSIMD0=; b=mvAxES/cGMOIjAbmWXzJJod8JSCckXTdM2FvE
        +1sQP7Z8Yyhf6Q7lKtWOGHp9Zfyq0SBxigglyhyNLRp+gAvm66rdcrA1bCa4fbsM
        n6uUsHXKED/080p2NXUGxaZcn0uCDLM5hCLRUXdqqk3BYA0GAoTfaODB+/PXQQTI
        uEZHVM=
Received: from corey (unknown [74.213.195.68])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTPSA id 8A8DD150069;
        Sun,  6 May 2018 08:54:15 -0700 (PDT)
Message-ID: <1525622054.16035.12.camel@novalis.org>
Subject: Re: [PATCH 3/5] refs.c: drop dead code checking lock status in
 `delete_pseudoref()`
From:   David Turner <novalis@novalis.org>
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Date:   Sun, 06 May 2018 11:54:14 -0400
In-Reply-To: <20180506141031.30204-4-martin.agren@gmail.com>
References: <20180506141031.30204-4-martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Same concern here about staticness.

On Sun, 2018-05-06 at 16:10 +0200, Martin =C3=85gren wrote:
> After taking the lock we check whether we got it and die otherwise.
> But
> since we take the lock using `LOCK_DIE_ON_ERROR`, we would already
> have
> died.
>=20
> Unlike in the previous patch, this function is not prepared for
> indicating errors via a `strbuf err`, so let's just drop the dead
> code.
> Any improved error-handling can be added later.
>=20
> While at it, make the lock non-static and reduce its scope.
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  refs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/refs.c b/refs.c
> index 8c50b8b139..7abd30dfe1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -689,20 +689,17 @@ static int write_pseudoref(const char
> *pseudoref, const struct object_id *oid,
> =20
>  static int delete_pseudoref(const char *pseudoref, const struct
> object_id *old_oid)
>  {
> -	static struct lock_file lock;
>  	const char *filename;
> =20
>  	filename =3D git_path("%s", pseudoref);
> =20
>  	if (old_oid && !is_null_oid(old_oid)) {
> -		int fd;
> +		struct lock_file lock =3D LOCK_INIT;
>  		struct object_id actual_old_oid;
> =20
> -		fd =3D hold_lock_file_for_update_timeout(
> +		hold_lock_file_for_update_timeout(
>  				&lock, filename, LOCK_DIE_ON_ERROR,
>  				get_files_ref_lock_timeout_ms());
> -		if (fd < 0)
> -			die_errno(_("Could not open '%s' for
> writing"), filename);
>  		if (read_ref(pseudoref, &actual_old_oid))
>  			die("could not read ref '%s'", pseudoref);
>  		if (oidcmp(&actual_old_oid, old_oid)) {
