From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: git-svn and subversion 1.7: testcase failures due to SVN 1.7 changes
Date: Sun, 5 Feb 2012 22:00:23 +0000
Message-ID: <20120205220023.GB8104@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:00:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuA8M-0005DA-8I
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab2BEWAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:00:25 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55210 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2BEWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:00:24 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 44FD91B4012
	for <git@vger.kernel.org>; Sun,  5 Feb 2012 22:00:24 +0000 (UTC)
Received: (qmail 8764 invoked by uid 10000); 5 Feb 2012 22:00:23 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189974>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Newer versions of SVN hate a whitespace in any of the URLs (repo, branches,
tags), and this sinks all of the git-svn tests. I've tried to trace and fix=
 it,
changing the canonicalize_path and canonicalize_url calls, but this ends up
making Git-svn very unhappy when it converts back to filenames.

I've seen some prior mentions on this list, but nobody seems to have really
solved it.

I've got a testcase partial workaround we avoid that by replaced the space =
in
the testcase working dir with an underscore.

Example failure:
Initialized empty Git repository in /dev/shm/portage/dev-vcs/git-9999/work/=
git-9999/t/trash directory.t9155/git_project/.git/
svn: E235000: In file 'subversion/libsvn_subr/dirent_uri.c' line 2291: asse=
rtion failed (svn_uri_is_canonical(url, pool))
  =20
With this workaround the following tests still fail: t9100 t9118 t9120
Without it, MOST of t91* fails, due to the space tripping up the
svn_uri_is_canonical internal call: t9100 t9101 t9102 t9103 t9104 t9105 t91=
06
t9107 t9108 t9109 t9110 t9111 t9112 t9114 t9115 t9116 t9117 t9118 t9120 t91=
21
t9122 t9123 t9124 t9125 t9127 t9128 t9129 t9130 t9131 t9132 t9133 t9134 t91=
35
t9136 t9137 t9138 t9139 t9140 t9141 t9142 t9143 t9144 t9145 t9146 t9150 t91=
51
t9152 t9153 t9154 t9155 t9156 t9157 t9158 t9159 t9160 t9161 t9162
  =20
git-svn actually needs to be fixed here, but this change is useful for
testing it.

workaround:  =20
sed -i \
   -e 's/trash directory/trash_directory/g' \
   test-lib.sh t0000-basic.sh Makefile

Failures with the workaround:
t9100-git-svn-basic.sh:
- not ok - 11 executable file becomes a symlink to bar/zzz (file)
=3D=3D=3D
r5 =3D a74fcb37aadb2afb532b100932220f7b59108ca4 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
Updating '.git/svn/refs/remotes/git-svn/svn-tree':
svn: E235000: In file 'subversion/libsvn_wc/update_editor.c' line 1582: ass=
ertion failed (action =3D=3D svn_wc_conflict_action_edit || action =3D=3D s=
vn_wc_conflict_action_delete || action =3D=3D svn_wc_conflict_action_replac=
e)
=2E/lib-git-svn.sh: line 61:  1922 Aborted                 svn "$orig_svncm=
d" --config-dir "$svnconf" "$@"
not ok - 11 executable file becomes a symlink to bar/zzz (file)
=3D=3D=3D

- not ok - 12 new symlink is added to a file that was also just made execut=
able
- not ok - 13 modify a symlink to become a file
Both of these fail as a side effect of the one above.
=3D=3D=3D
r6 =3D 880d9fc9b4ffda5e3851e86b587af36d6c3ddaf8 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
svn: E155004: Working copy '/dev/shm/portage/dev-vcs/git-1.7.9/work/git-1.7=
=2E9/t/trash_directory.t9100-git-svn-basic/.git/svn/refs/remotes/git-svn/sv=
n-tree' locked.
svn: E155004: '/dev/shm/portage/dev-vcs/git-1.7.9/work/git-1.7.9/t/trash_di=
rectory.t9100-git-svn-basic/.git/svn/refs/remotes/git-svn/svn-tree' is alre=
ady locked.
svn: run 'svn cleanup' to remove locks (type 'svn help cleanup' for details)
not ok - 12 new symlink is added to a file that was also just made executab=
le
=3D=3D=3D

All of t9118/t9120 are a direct result of not having it happy with the esca=
ping.

t9118-git-svn-funky-branch-names.sh:
- not ok - 2 test clone with funky branch names
- not ok - 3 test dcommit to funky branch
- not ok - 4 test dcommit to scary branch
- not ok - 5 test dcommit to trailing_dotlock branch

t9120-git-svn-clone-with-percent-escapes.sh
- not ok - 7 test clone --stdlayout with percent escapes
=3D=3D=3D
r1 =3D 60417f2d87410b4775fdd2a04e85d8d468e05e04 (refs/remotes/trunk)
Found possible branch point: file:///dev/shm/portage/dev-vcs/git-1.7.9/work=
/git-1.7.9/t/trash_directory.t9120-git-svn-clone-with-percent-escapes/svnre=
po/pr ject/trunk =3D> file:///dev/shm/portage/dev-vcs/git-1.7.9/work/git-1.=
7.9/t/trash_directory.t9120-git-svn-clone-with-percent-escapes/svnrepo/pr j=
ect/branches/b, 1
Found branch parent: (refs/remotes/b) 60417f2d87410b4775fdd2a04e85d8d468e05=
e04
Following parent with do_switch
perl: subversion/libsvn_subr/dirent_uri.c:1519: uri_skip_ancestor: Assertio=
n `svn_uri_is_canonical(child_uri, ((void *)0))' failed.
error: git-svn died of signal 6
not ok - 7 test clone --stdlayout with percent escapes
=3D=3D=3D

- not ok - 8 test clone -s with unescaped space
=3D=3D=3D
Initialized empty Git repository in /dev/shm/portage/dev-vcs/git-1.7.9/work=
/git-1.7.9/t/trash_directory.t9120-git-svn-clone-with-percent-escapes/space=
/.git/
svn: E235000: In file 'subversion/libsvn_subr/dirent_uri.c' line 2291: asse=
rtion failed (svn_uri_is_canonical(url, pool))
error: git-svn died of signal 6
not ok - 8 test clone -s with unescaped space
=3D=3D=3D



--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk8u+/cACgkQPpIsIjIzwixzpACgkOZioXj01uWYY76B0W7gUj4M
GJYAoOXQy8as6kQ6zrlyVR4sZPnPzFqA
=Duye
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
