From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: don't check worktrees when not necessary
Date: Fri, 12 Jun 2015 15:24:37 -0700
Message-ID: <xmqqr3pgbm56.fsf@gitster.dls.corp.google.com>
References: <87zj47gyif.fsf@earth.i-did-not-set--mail-host-address--so-tickle-me>
	<1434106164-28699-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catern@catern.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:24:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XNf-0003cH-8B
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbFLWYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 18:24:40 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35151 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbFLWYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:24:39 -0400
Received: by igbzc4 with SMTP id zc4so20455556igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=LGgXTAYdrhA4HN45Og3KuJalCddfn0x8o/RUeKHfTvM=;
        b=PeT2ZhXKAc+13g5VUOT+xmisNrkiqhHip+r/xDgEF5CbmOEPXaDPGVWLE8DwJCTKTd
         tvYOSxNFFqQ0YPiVi548BHfXwFWP2JwlLwgFT6027Nn3rMZjoptSICvEyyXpSWIGYECO
         NR23aED9slXY8QB1lpxq9qWXu0dQy5Wg8Wo8onnK106QH5JtGHkC0k9Z5r69qTQM+iQT
         2lDwDkh0yGRoxsLozCD5mSLeJB+I0C3Va1y9A4xalJq7n4iUwGB1OXnaMj+vB4NDw5wp
         YLASowdwBEkKxYSyDNEhOeV3AbM2FuP9RI22d4tgacj7jHViPzRTNsAjUY3AIglYqlML
         UbnA==
X-Received: by 10.50.143.38 with SMTP id sb6mr7228727igb.44.1434147879175;
        Fri, 12 Jun 2015 15:24:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id c63sm3360400ioe.42.2015.06.12.15.24.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:24:38 -0700 (PDT)
In-Reply-To: <1434106164-28699-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 12
 Jun 2015 17:49:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271537>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When --patch or pathspecs are passed to git checkout, the working tre=
e
> will not be switching branch, so there's no need to check if the bran=
ch
> that we are running checkout on is already checked out.

Yeah, I agree that having this check in parse_branchname_arg() does
not make any sense, as that function is still trying to decide if we
are switching to a different branch or not.  The new location looks
much more sensible.

Will queue this on nd/multiple-work-trees (which has been in
'master' for about a month).  Good thing that we caught it before it
got in any tagged release.

Thanks.

>
> Original-patch-by: Spencer Baugh <sbaugh@catern.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c     | 23 +++++++++++------------
>  t/t2025-checkout-to.sh |  8 ++++++++
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 9b49f0e..e227f64 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1110,7 +1110,6 @@ static int parse_branchname_arg(int argc, const=
 char **argv,
>  {
>  	struct tree **source_tree =3D &opts->source_tree;
>  	const char **new_branch =3D &opts->new_branch;
> -	int force_detach =3D opts->force_detach;
>  	int argcount =3D 0;
>  	unsigned char branch_rev[20];
>  	const char *arg;
> @@ -1231,17 +1230,6 @@ static int parse_branchname_arg(int argc, cons=
t char **argv,
>  	else
>  		new->path =3D NULL; /* not an existing branch */
> =20
> -	if (new->path && !force_detach && !*new_branch) {
> -		unsigned char sha1[20];
> -		int flag;
> -		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
> -		if (head_ref &&
> -		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
> -		    !opts->ignore_other_worktrees)
> -			check_linked_checkouts(new);
> -		free(head_ref);
> -	}
> -
>  	new->commit =3D lookup_commit_reference_gently(rev, 1);
>  	if (!new->commit) {
>  		/* not a commit */
> @@ -1321,6 +1309,17 @@ static int checkout_branch(struct checkout_opt=
s *opts,
>  		die(_("Cannot switch branch to a non-commit '%s'"),
>  		    new->name);
> =20
> +	if (new->path && !opts->force_detach && !opts->new_branch) {
> +		unsigned char sha1[20];
> +		int flag;
> +		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
> +		if (head_ref &&
> +		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
> +		    !opts->ignore_other_worktrees)
> +			check_linked_checkouts(new);
> +		free(head_ref);
> +	}
> +
>  	if (opts->new_worktree)
>  		return prepare_linked_checkout(opts, new);
> =20
> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> index f8e4df4..a8d9336 100755
> --- a/t/t2025-checkout-to.sh
> +++ b/t/t2025-checkout-to.sh
> @@ -28,6 +28,14 @@ test_expect_success 'checkout --to refuses to chec=
kout locked branch' '
>  	! test -d .git/worktrees/zere
>  '
> =20
> +test_expect_success 'checking out paths not complaining about linked=
 checkouts' '
> +	(
> +	cd existing_empty &&
> +	echo dirty >>init.t &&
> +	git checkout master -- init.t
> +	)
> +'
> +
>  test_expect_success 'checkout --to a new worktree' '
>  	git rev-parse HEAD >expect &&
>  	git checkout --detach --to here master &&
