From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v7 25/31] prune: strategies for linked checkouts
Date: Fri, 18 Jul 2014 20:17:01 +0200
Message-ID: <87r41i352a.fsf@thomasrast.ch>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-26-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Cig-0002Wm-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 20:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbaGRSRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 14:17:16 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:45116 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422734AbaGRSRP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 14:17:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1F4C24D65EA;
	Fri, 18 Jul 2014 20:17:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7oFyNXwqXQ-E; Fri, 18 Jul 2014 20:17:03 +0200 (CEST)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id C81D94D6572;
	Fri, 18 Jul 2014 20:17:02 +0200 (CEST)
In-Reply-To: <1405227068-25506-26-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13
 Jul 2014 11:51:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253834>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> (alias R=3D$GIT_COMMON_DIR/repos/<id>)
>
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>
>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>    $R/gitdir's mtime is older than a limit, and it points to nowhere,
>    repos/<id> is to be pruned.
>
>  - If $R/locked exists, repos/<id> is not supposed to be pruned. If
>    $R/locked exists and $R/gitdir's mtime is older than a really long
>    limit, warn about old unused repo.
>
>  - "git checkout --to" is supposed to make a hard link named $R/link
>    pointing to the .git file on supported file systems to help detect
>    the user manually deleting the checkout. If $R/link exists and its
>    link count is greated than 1, the repo is kept.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-prune.txt                |  3 +
>  Documentation/gitrepository-layout.txt     | 19 ++++++
>  builtin/checkout.c                         | 14 +++++
>  builtin/prune.c                            | 99 ++++++++++++++++++++=
++++++++++
>  setup.c                                    | 13 ++++
>  t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++++=
+++++

I get this from t2026.2 under valgrind:

  =3D=3D21334=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
  =3D=3D21334=3D=3D    at 0x46D49B: prune_repos_dir (prune.c:182)
  =3D=3D21334=3D=3D    by 0x46D8C0: cmd_prune (prune.c:252)
  =3D=3D21334=3D=3D    by 0x405C2F: run_builtin (git.c:351)
  =3D=3D21334=3D=3D    by 0x405E47: handle_builtin (git.c:530)
  =3D=3D21334=3D=3D    by 0x405F6B: run_argv (git.c:576)
  =3D=3D21334=3D=3D    by 0x40610B: main (git.c:663)
  =3D=3D21334=3D=3D  Uninitialised value was created by a stack allocat=
ion
  =3D=3D21334=3D=3D    at 0x46D3BB: prune_repos_dir (prune.c:169)
  =3D=3D21334=3D=3D=20
  {
     <insert_a_suppression_name_here>
     Memcheck:Cond
     fun:prune_repos_dir
     fun:cmd_prune
     fun:run_builtin
     fun:handle_builtin
     fun:run_argv
     fun:main
  }
  not ok 2 - prune files inside $GIT_DIR/repos
  #
  #               mkdir .git/repos &&
  #               : >.git/repos/abc &&
  #               git prune --repos --verbose >actual &&
  #               cat >expect <<EOF &&
  #       Removing repos/abc: not a valid directory
  #       EOF
  #               test_i18ncmp expect actual &&
  #               ! test -f .git/repos/abc &&
  #               ! test -d .git/repos
  #

I think it's because of the early 'return 0' ...

> +static int prune_repo_dir(const char *id, struct stat *st, struct st=
rbuf *reason)
> +{
> +	char *path;
> +	int fd, len;
> +
> +	if (!is_directory(git_path("repos/%s", id))) {
> +		strbuf_addf(reason, _("Removing repos/%s: not a valid directory"),=
 id);
> +		return 1;
> +	}
> +	if (file_exists(git_path("repos/%s/locked", id)))
> +		return 0;

in this line, before the stat() actually runs, which then in the
condition ...

> +	if (stat(git_path("repos/%s/gitdir", id), st)) {
> +		st->st_mtime =3D expire;
> +		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exi=
st"), id);
> +		return 1;
> +	}
[...]
> +}
> +
> +static void prune_repos_dir(void)
> +{
[...]
> +	struct stat st;
[...]
> +		if (!prune_repo_dir(d->d_name, &st, &reason) ||
> +		    st.st_mtime > expire)

causes the second arm to be evaluated when st.st_mtime is not
initialized yet.  Can you look into this?

--=20
Thomas Rast
tr@thomasrast.ch
