Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3976C1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfBUL2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:28:53 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:39385 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUL2x (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Feb 2019 06:28:53 -0500
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 294E95F81D6B;
        Thu, 21 Feb 2019 14:28:47 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LO2V0nfRxD-Sku8bxZt;
        Thu, 21 Feb 2019 14:28:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550748527;
        bh=RtX/xjV8UXfIH/KaJ/XzPmCMAuZiqjScT9jug8xw3Dg=;
        h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References;
        b=Ao5CW3dnVhd6cTsdl6uaJhgOsZoO9hkA7UKOtkFUZlDld9KbWYSn1YHp+w+wR1mfM
         j3Z9OnHPvXNbYcWwx9MCYI4Z2ogyib7ePeJ+cDAz0Ab8D+PW2m01bedp9mWtontJx4
         OEXAi+usG3IkFtg9BUt6lNjnYhcpdmpYxXZB/yC4=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0M588LjUUT-SjGCtDI0;
        Thu, 21 Feb 2019 14:28:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Thu, 21 Feb 2019 14:28:45 +0300
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH] worktree add: sanitize worktree names
To:     =?UTF-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Message-Id: <1550748525.30307.1@yandex.ru>
In-Reply-To: <20190221110026.23135-1-pclouds@gmail.com>
References: <1550500586.2865.0@yandex.ru>
        <20190221110026.23135-1-pclouds@gmail.com>
X-Mailer: geary/remotes/upstream/master-0-gfbf2f307
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On =D0=A7=D1=82, Feb 21, 2019 at 2:00 PM,=20
=3D?UTF-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?=3D Duy <pclouds@gmail.com> wrote:
> Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
> significant until 3a3b9d8cde (refs: new ref types to make per-worktree
> refs visible to all worktrees - 2018-10-21), where worktree name could
> be part of a refname and must follow refname rules.
>=20
> Update 'worktree add' code to remove special characters to follow
> these rules. The code could replace chars with '-' more than
> necessary, but it keeps the code simple. In the future the user will
> be able to specify the worktree name by themselves if they're not
> happy with this dumb character substitution.
>=20
> Reported-by: hi-angel@yandex.ru
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/worktree.c      | 47=20
> ++++++++++++++++++++++++++++++++++++++++-
>  t/t2025-worktree-add.sh |  5 +++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 3f9907fcc9..ff36838a33 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -262,6 +262,46 @@ static void validate_worktree_add(const char=20
> *path, const struct add_opts *opts)
>  	free_worktrees(worktrees);
>  }
>=20
> +/*
> + * worktree name is part of refname and has to pass
> + * check_refname_component(). Remove unallowed characters to make it
> + * valid.
> + */
> +static void sanitize_worktree_name(struct strbuf *name)
> +{
> +	int i;
> +
> +	/* no ending with .lock */
> +	if (ends_with(name->buf, ".lock"))
> +		strbuf_remove(name, name->len - strlen(".lock"),
> +			      strlen(".lock"));
> +
> +	/*
> +	 * All special chars replaced with dashes. See
> +	 * check_refname_component() for reference.
> +	 */
> +	for (i =3D 0; i < name->len; i++) {
> +		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
> +			name->buf[i] =3D '-';
> +	}
> +
> +	/* remove consecutive dashes, leading or trailing dashes */
> +	for (i =3D 0; i < name->len; i++) {
> +		while (name->buf[i] =3D=3D '-' &&
> +		       (i =3D=3D 0 ||
> +			i =3D=3D name->len - 1 ||
> +			(i < name->len - 1 && name->buf[i + 1] =3D=3D '-')))
> +			strbuf_remove(name, i, 1);
> +	}
> +
> +	/* last resort, should never ever happen in practice */
> +	if (name->len =3D=3D 0)
> +		strbuf_addstr(name, "worktree");

I assume this means a user have passed a zero-sized worktree name? But=20
zero-sized file/directory names are not possible anyway, would it make=20
sense to just return an error in this case?

> +
> +	if (check_refname_format(name->buf, REFNAME_ALLOW_ONELEVEL))
> +		BUG("worktree name '%s' is not a valid refname", name->buf);
> +}
> +
>  static int add_worktree(const char *path, const char *refname,
>  			const struct add_opts *opts)
>  {
> @@ -275,6 +315,7 @@ static int add_worktree(const char *path, const=20
> char *refname,
>  	struct strbuf symref =3D STRBUF_INIT;
>  	struct commit *commit =3D NULL;
>  	int is_branch =3D 0;
> +	struct strbuf sb_name =3D STRBUF_INIT;
>=20
>  	validate_worktree_add(path, opts);
>=20
> @@ -290,7 +331,10 @@ static int add_worktree(const char *path, const=20
> char *refname,
>  		die(_("invalid reference: %s"), refname);
>=20
>  	name =3D worktree_basename(path, &len);
> -	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name),=20
> name);
> +	strbuf_add(&sb_name, name, path + len - name);
> +	sanitize_worktree_name(&sb_name);
> +	name =3D sb_name.buf;
> +	git_path_buf(&sb_repo, "worktrees/%s", name);
>  	len =3D sb_repo.len;
>  	if (safe_create_leading_directories_const(sb_repo.buf))
>  		die_errno(_("could not create leading directories of '%s'"),
> @@ -415,6 +459,7 @@ static int add_worktree(const char *path, const=20
> char *refname,
>  	strbuf_release(&symref);
>  	strbuf_release(&sb_repo);
>  	strbuf_release(&sb_git);
> +	strbuf_release(&sb_name);
>  	return ret;
>  }
>=20
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 286bba35d8..0d465adb54 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -570,4 +570,9 @@ test_expect_success '"add" an existing locked but=20
> missing worktree' '
>  	git worktree add --force --force --detach gnoo
>  '
>=20
> +test_expect_success 'sanitize generated worktree name' '
> +	git worktree add --detach ".  weird*..?.lock" &&
> +	test -d .git/worktrees/weird
> +'
> +
>  test_done
> --
> 2.21.0.rc1.337.gdf7f8d0522
>=20

=

