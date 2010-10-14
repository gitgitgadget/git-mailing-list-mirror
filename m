From: ebik <ebik@ucw.cz>
Subject: Re: [PATCH] git-svn.perl: Fix glob matching on svn paths
Date: Thu, 14 Oct 2010 11:34:59 +0200
Message-ID: <20101014113459.47bfa959@Chewbacca.cub>
References: <1286615236-29732-1-git-send-email-ebik@ucw.cz>
	<1286615236-29732-2-git-send-email-ebik@ucw.cz>
	<20101010061534.GB23100@burratino>
Reply-To: ebik@ucw.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/mK.MVlauCvRiipCgL2btTmu"; protocol="application/pgp-signature"
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KDW-0006j4-3P
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0JNJfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 05:35:03 -0400
Received: from drak.ucw.cz ([212.71.128.78]:58629 "EHLO drak.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab0JNJfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 05:35:01 -0400
Received: from Chewbacca.cub (localhost [127.0.0.1])
	by drak.ucw.cz (Postfix) with ESMTP id 45B8B2B;
	Thu, 14 Oct 2010 11:35:00 +0200 (CEST)
In-Reply-To: <20101010061534.GB23100@burratino>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159037>

--Sig_/mK.MVlauCvRiipCgL2btTmu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

(once again and "reply-to-all" this time)

On Sun, 10 Oct 2010 01:15:35 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi Tom=C3=A1=C5=A1,
>=20
> Tom=C3=A1=C5=A1 Ebenlendr wrote:
>=20
> > I tried to convert our repositories to git. Our repositories have
> > only branches (no tags, and no branch is so special to be called
> > trunk). The directory of each individual branch live in the root of
> > the repository (i.e., not in directory 'branches' as in standard
> > layout).
>=20
> Okay, so I am imagining:
>=20
> 	1.0.x/
> 	1.1.x/
> 	1.2.x/
> 	2.0.x/
> 	...
>=20
> > I init the repository by: git svn init path_to_repo -b *
> > This triggers first bogus match in match_globs(): the pattern
> > matches an empty string - the place before first slash in any path.
>=20
> A branches refspec of
>=20
> 	*:refs/remotes/*
>=20
> results in
>=20
> 	$self{left} =3D ''
> 	$self{glob} =3D '*'
> 	$self{left_regex} =3D qr'^/(/|$)'
> 	$self{regex} =3D qr'([^/]*)'.
>=20
> Does get_dir_globbed cope correctly?  Will get_dir cope correctly with
> the spurious / (from $left/$de) inserted at the beginning of paths?
>=20

Hmm, I don't know. The code is undocummented, thus I don't know what is
any function supposed to return. I just guess. With the patch my
"git svn clone" works, taking 48 hours to convert the repository.
The only problem is that many merges are probably mis-recognized
as cherrypicking, but we can live with that.

Both parts of the patch individually fix the error triggered by
'*:refs/remotes/*', but both parts are about what I think there should
be. The second part also fixes the bug with not recognised branches.

> The regex always matches, even for empty $p, but it is not immediately
> obvious to me how that pans out.  Could you describe the symptoms?
>=20
The symptom of '*:refs/remotes/*' bug is following: 'clone' or 'fetch'
fails with following message:

  ref: 'refs/remotes/' ends with a trailing slash, this is not
  permitted by git nor Subversion

This is die() in Git::SVN::refname(). Here is the backtrace for
fetch. $VAR1 being the only argument passed to refname().
Note that the line numbers my be off by small number, as I added
two lines for the backtrace to happen.

$VAR1 =3D bless( {
                 'index' =3D> '.git/svn/refs/remotes//index',
                 'map_root' =3D> '.git/svn/refs/remotes//.rev_map',
                 'repo_id' =3D> 'svn',
                 'config' =3D> '.git/svn/config',
                 'path' =3D> '',
                 'dir' =3D> '.git/svn/refs/remotes/',
                 'ref_id' =3D> 'refs/remotes/'
               }, 'Git::SVN' );
 at ../git-svn.perl line 2075
        Git::SVN::refname('Git::SVN=3DHASH(0x93df4b4)') called
at ../git-svn.perl line 1954
Git::SVN::init_remote_config('Git::SVN=3DHASH(0x93df4b4)',
'file:///afs/ms/u/t/tebe7122/devel/pokussvn', 1) called
at ../git-svn.perl line 2023 Git::SVN::init('Git::SVN',
'file:///afs/ms/u/t/tebe7122/devel/pokussvn', '', 'undef',
'refs/remotes/', 1) called at ../git-svn.perl line 5365
Git::SVN::Ra::match_globs('Git::SVN::Ra=3DHASH(0x9673f54)',
'HASH(0x910ec7c)', 'HASH(0x9674608)', 'ARRAY(0x8f845c4)', 1) called
at ../git-svn.perl line 5257
Git::SVN::Ra::gs_fetch_loop_common('Git::SVN::Ra=3DHASH(0x9673f54)', 0,
2, 'ARRAY(0x8f845ac)', 'ARRAY(0x8f845c4)') called at ../git-svn.perl
line 1809 Git::SVN::fetch_all('svn', 'HASH(0x92998f4)') called
at ../git-svn.perl line 992 main::cmd_multi_fetch() called
at ../git-svn.perl line 442 main::cmd_fetch() called at ../git-svn.perl
line 314 eval {...} called at ../git-svn.perl line 312

> > We have created some branch names just by adding some suffix to
> > another branch name. Imagine branch "devel" and "devel2". Then
> > there is bogus match on path '/devel2' as it outputs 'devel'.
>=20
> Is this problem reproducible without the other change?  If so, would
> it makes sense to split off this fix as a separate patch?

I cannot reproduce the second bug without '*:/refs/remotes/*',
thus I'm not sure if I'm fixing the origin of the problem.

>=20
> Also, if Eric likes your patches, can he forge your sign-off?  See
> Documentation/SubmittingPatches for what this means.
>=20

Yes I'm fine with it. Although I'm not yet sure that I fix the problems
at their origin, and I have no time to read the whole source now.
I'll resubmit the patch(es) in any suggested shape, after someone
confirms, that it cannot break other things.

> Thanks,
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
                                 Tom=C3=A1=C5=A1 'eb=C3=ADk' Ebenlendr
                                 PF 2010.78487731481


--Sig_/mK.MVlauCvRiipCgL2btTmu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EAREIAAYFAky2zsMACgkQUYN+FqT7KZs+xQD6A9TFIouplg+HxA2WwDijaCXS
rbSQy1u9vt1US0+DhJkA/jx/W+7V0Wm7Eum0bet+aZraZCQ8WOc1hWhYbn3/ppQz
=U5B7
-----END PGP SIGNATURE-----

--Sig_/mK.MVlauCvRiipCgL2btTmu--
