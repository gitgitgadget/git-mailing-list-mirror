From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already
 checked out
Date: Wed, 23 Jul 2014 15:48:26 +0200
Message-ID: <53CFBD2A.9030803@drmicha.warpmail.net>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com> <1406115795-24082-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 15:48:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9wua-0003RT-H7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 15:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbaGWNss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 09:48:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52241 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509AbaGWNss (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 09:48:48 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B3C2E21A2C;
	Wed, 23 Jul 2014 09:48:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 23 Jul 2014 09:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ihtSh0Sd9J1MK4DBkjj210
	H1tKI=; b=fMkOyblPnEZsfVglmqPUrQFkdIBnPoqVBWupLBodT1MgGeFbZRiNz1
	/KQLhETA92BhvZpe+PklDD83xzdgzfD1sGC8mRq9bE4wULMUO36usRhrcKayCAOk
	G0uhXpy8nzthKHmR+yy5wum6GINivrIwnQjtrj5CZPD37A83YDL3c=
X-Sasl-enc: rO4nbhAPhU09CPyHnUPdwQDc++m/c87tzUzTy8Oun71N 1406123323
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D9F9268010B;
	Wed, 23 Jul 2014 09:48:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1406115795-24082-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254077>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 23.07.201=
4 13:43:
> Give the user a choice in this case. If they want to detach, they can=
 go
> with '--detach --to ...', or they could switch branch of the checkout
> that's holding the ref in question. Or they could just create a new
> branch with '-b xxx --to yyy'
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  3 ++
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  builtin/checkout.c       | 73 ++++++++++++++++++++++++++++----------=
----------
>  t/t2025-checkout-to.sh   | 16 +++++------
>  5 files changed, 56 insertions(+), 39 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 57999fa..4a41202 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -201,6 +201,9 @@ advice.*::
>  	rmHints::
>  		In case of failure in the output of linkgit:git-rm[1],
>  		show directions on how to proceed from the current state.
> +	checkoutTo::
> +		In case of failure in the output of "git checkout --to",
> +		show directions on how to proceed from the current state.
>  --
> =20
>  core.fileMode::
> diff --git a/advice.c b/advice.c
> index 9b42033..b1fb524 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -15,6 +15,7 @@ int advice_detached_head =3D 1;
>  int advice_set_upstream_failure =3D 1;
>  int advice_object_name_warning =3D 1;
>  int advice_rm_hints =3D 1;
> +int advice_checkout_to =3D 1;
> =20
>  static struct {
>  	const char *name;
> @@ -35,6 +36,7 @@ static struct {
>  	{ "setupstreamfailure", &advice_set_upstream_failure },
>  	{ "objectnamewarning", &advice_object_name_warning },
>  	{ "rmhints", &advice_rm_hints },
> +	{ "checkoutto", &advice_checkout_to },
> =20
>  	/* make this an alias for backward compatibility */
>  	{ "pushnonfastforward", &advice_push_update_rejected }
> diff --git a/advice.h b/advice.h
> index 5ecc6c1..a288219 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -18,6 +18,7 @@ extern int advice_detached_head;
>  extern int advice_set_upstream_failure;
>  extern int advice_object_name_warning;
>  extern int advice_rm_hints;
> +extern int advice_checkout_to;
> =20
>  int git_default_advice_config(const char *var, const char *value);
>  __attribute__((format (printf, 1, 2)))
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c83f476..d35245a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1006,31 +1006,52 @@ static const char *unique_tracking_name(const=
 char *name, unsigned char *sha1)
>  	return NULL;
>  }
> =20
> -static int check_linked_checkout(struct branch_info *new,
> -				  const char *name, const char *path)
> +static void check_linked_checkout(struct branch_info *new, const cha=
r *id)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
> +	struct strbuf path =3D STRBUF_INIT;
> +	struct strbuf gitdir =3D STRBUF_INIT;
>  	const char *start, *end;
> -	if (strbuf_read_file(&sb, path, 0) < 0 ||
> -	    !skip_prefix(sb.buf, "ref:", &start)) {
> -		strbuf_release(&sb);
> -		return 0;
> -	}
> =20
> +	if (id)
> +		strbuf_addf(&path, "%s/repos/%s/HEAD", get_git_common_dir(), id);
> +	else
> +		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +
> +	if (strbuf_read_file(&sb, path.buf, 0) <=3D 0 ||
> +	    !skip_prefix(sb.buf, "ref:", &start))
> +		goto done;
>  	while (isspace(*start))
>  		start++;
>  	end =3D start;
>  	while (*end && !isspace(*end))
>  		end++;
> -	if (!strncmp(start, new->path, end - start) &&
> -	    new->path[end - start] =3D=3D '\0') {
> -		strbuf_release(&sb);
> -		new->path =3D NULL; /* detach */
> -		new->checkout =3D xstrdup(name); /* reason */
> -		return 1;
> -	}
> +	if (strncmp(start, new->path, end - start) ||
> +	    new->path[end - start] !=3D '\0')
> +		goto done;
> +	if (id) {
> +		strbuf_reset(&path);
> +		strbuf_addf(&path, "%s/repos/%s/gitdir",
> +			    get_git_common_dir(), id);
> +		if (strbuf_read_file(&gitdir, path.buf, 0) <=3D 0)
> +			goto done;
> +		while (gitdir.len && (gitdir.buf[gitdir.len - 1] =3D=3D '\n' ||
> +				      gitdir.buf[gitdir.len - 1] =3D=3D '\r'))
> +			gitdir.buf[--gitdir.len] =3D '\0';
> +	} else
> +		strbuf_addstr(&gitdir, get_git_common_dir());
> +	if (advice_checkout_to)
> +		die(_("%s is already checked out at %s.\n"
> +		      "Either use --detach or -b together with --to "
> +		      "or switch branch in the the other checkout."),

"or switch to a different branch in the other checkout". But maybe we
can be even more helpful, like:

"%s is already checked out at %s.\n"
"Either checkout the detached head of branch %s using\n"
"    git checkout --detach --to %s %s\n"
"or checkout a new branch based off %s using\n"
"    git checkout --to %s -b %s newbranch %s\n"
"or switch to a different branch in the other checkout."

if we can figure out the appropriate arguments at this point in the cod=
e.

> +		    new->path, gitdir.buf);
> +	else
> +		die(_("%s is already checked out at %s."),
> +		    new->path, gitdir.buf);
> +done:
> +	strbuf_release(&path);
>  	strbuf_release(&sb);
> -	return 0;
> +	strbuf_release(&gitdir);
>  }
> =20
>  static void check_linked_checkouts(struct branch_info *new)
> @@ -1045,27 +1066,17 @@ static void check_linked_checkouts(struct bra=
nch_info *new)
>  		return;
>  	}
> =20
> -	strbuf_reset(&path);
> -	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
>  	/*
>  	 * $GIT_COMMON_DIR/HEAD is practically outside
>  	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
>  	 * uses git_path). Parse the ref ourselves.
>  	 */
> -	if (check_linked_checkout(new, "", path.buf)) {
> -		strbuf_release(&path);
> -		closedir(dir);
> -		return;
> -	}
> +	check_linked_checkout(new, NULL);
> =20
>  	while ((d =3D readdir(dir)) !=3D NULL) {
>  		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>  			continue;
> -		strbuf_reset(&path);
> -		strbuf_addf(&path, "%s/repos/%s/HEAD",
> -			    get_git_common_dir(), d->d_name);
> -		if (check_linked_checkout(new, d->d_name, path.buf))
> -			break;
> +		check_linked_checkout(new, d->d_name);
>  	}
>  	strbuf_release(&path);
>  	closedir(dir);
> @@ -1076,7 +1087,8 @@ static int parse_branchname_arg(int argc, const=
 char **argv,
>  				struct branch_info *new,
>  				struct tree **source_tree,
>  				unsigned char rev[20],
> -				const char **new_branch)
> +				const char **new_branch,
> +				int force_detach)
>  {
>  	int argcount =3D 0;
>  	unsigned char branch_rev[20];
> @@ -1198,7 +1210,7 @@ static int parse_branchname_arg(int argc, const=
 char **argv,
>  	else
>  		new->path =3D NULL; /* not an existing branch */
> =20
> -	if (new->path) {
> +	if (new->path && !force_detach && !*new_branch) {
>  		unsigned char sha1[20];
>  		int flag;
>  		char *head_ref =3D resolve_refdup("HEAD", sha1, 0, &flag);
> @@ -1416,7 +1428,8 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
>  			!opts.new_branch;
>  		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
>  					     &new, &opts.source_tree,
> -					     rev, &opts.new_branch);
> +					     rev, &opts.new_branch,
> +					     opts.force_detach);
>  		argv +=3D n;
>  		argc -=3D n;
>  	}
> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> index b0d97a0..c6601a4 100755
> --- a/t/t2025-checkout-to.sh
> +++ b/t/t2025-checkout-to.sh
> @@ -14,7 +14,7 @@ test_expect_success 'checkout --to not updating pat=
hs' '
> =20
>  test_expect_success 'checkout --to a new worktree' '
>  	git rev-parse HEAD >expect &&
> -	git checkout --to here master &&
> +	git checkout --detach --to here master &&
>  	(
>  		cd here &&
>  		test_cmp ../init.t init.t &&
> @@ -28,7 +28,7 @@ test_expect_success 'checkout --to a new worktree' =
'
>  test_expect_success 'checkout --to from a linked checkout' '
>  	(
>  		cd here &&
> -		git checkout --to nested-here master
> +		git checkout --detach --to nested-here master
>  		cd nested-here &&
>  		git fsck
>  	)
> @@ -46,19 +46,17 @@ test_expect_success 'checkout --to a new worktree=
 creating new branch' '
>  	)
>  '
> =20
> -test_expect_success 'detach if the same branch is already checked ou=
t' '
> +test_expect_success 'die the same branch is already checked out' '
>  	(
>  		cd here &&
> -		git checkout newmaster &&
> -		test_must_fail git symbolic-ref HEAD
> +		test_must_fail git checkout newmaster
>  	)
>  '
> =20
> -test_expect_success 'not detach on re-checking out current branch' '
> +test_expect_success 'not die on re-checking out current branch' '
>  	(
>  		cd there &&
> -		git checkout newmaster &&
> -		git symbolic-ref HEAD
> +		git checkout newmaster
>  	)
>  '
> =20
> @@ -66,7 +64,7 @@ test_expect_success 'checkout --to from a bare repo=
' '
>  	(
>  		git clone --bare . bare &&
>  		cd bare &&
> -		git checkout --to ../there2 master
> +		git checkout --to ../there2 -b bare-master master
>  	)
>  '
> =20
>=20
