From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC PATCH] git-svn does not support intermediate directories?
Date: Mon, 9 Mar 2009 14:54:48 -0700
Message-ID: <20090309215447.GA25947@dcvr.yhbt.net>
References: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com> <20090304043019.GC20790@mail.rocksoft.com> <21fc26450903051612u1400b2b4gd71c3eafa4418e37@mail.gmail.com> <20090308044318.GA31205@untitled> <21fc26450903091402u60d6cfcepd67ba7510af8f4a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Lai <myllai@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgnSO-00063j-2z
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbZCIVyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZCIVyv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:54:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38694 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbZCIVyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 17:54:50 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978B01F604;
	Mon,  9 Mar 2009 21:54:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <21fc26450903091402u60d6cfcepd67ba7510af8f4a3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112749>

Michael Lai <myllai@gmail.com> wrote:
> > Your patch was whitespace damaged and lacked a proposed commit mess=
age.
> > Please read Documentation/SubmittingPatches next time.
> Hey Eric,
>=20
> Sorry, I didn't notice that; I've read through it and hopefully my
> patches should conform from now on.
>=20
> >
> > Anyhow, I fixed your patch up a bit. =A0Can you sign-off on it
> > if its right to you or let me know if it's broken? =A0Thanks.
>=20
> I looked through the patch and that would work, but at the same time =
I
> had another idea which may be a little cleaner.  Let me know what you
> think.

Thanks Michael, looks good to me,

Acked and pushed out to git://git.bogomips.org/git-svn

> From ae38acf85cfc86c075578c1c3f3c204d91d1d1f4 Mon Sep 17 00:00:00 200=
1
> From: Michael Lai <myllai@gmail.com>
> Date: Mon, 9 Mar 2009 11:45:47 -0700
> Subject: [PATCH] git-svn: support intermediate paths when matching ta=
gs/branches
>=20
> For repositories laid out like the following:
>=20
> [svn-remote "svn"]
>       url =3D http://foo.com/svn/repos/bar
>       fetch =3D myproject/trunk:refs/remotes/trunk
>       branches =3D bar/myproject/branches/*:refs/remotes/*
>       tags =3D bar/myproject/tags/*:refs/remotes/tags/*
>=20
> The "bar" component above is considered the intermediate path
> and was not handled correctly.
>=20
> Signed-off-by: Michael Lai <myllai@gmail.com>
> ---
>  git-svn.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 959eb52..8be6be0 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2351,7 +2351,10 @@ sub match_paths {
>  	if (my $path =3D $paths->{"/$self->{path}"}) {
>  		return ($path->{action} eq 'D') ? 0 : 1;
>  	}
> -	$self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
> +	my $repos_root =3D $self->ra->{repos_root};
> +	my $extended_path =3D $self->{url} . '/' . $self->{path};
> +	$extended_path =3D~ s#^\Q$repos_root\E(/|$)##;
> +	$self->{path_regex} ||=3D qr/^\/\Q$extended_path\E\//;
>  	if (grep /$self->{path_regex}/, keys %$paths) {
>  		return 1;
>  	}
> --=20
> 1.6.2
