From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/5] Disambiguate the term 'branch' in Arch vs git
Date: Sat, 12 Nov 2005 01:29:20 -0800
Message-ID: <20051112092920.GD16218@Muzzle>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle> <20051112092721.GC16218@Muzzle>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EarhN-0006Nw-58
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKLJ3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVKLJ3X
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:29:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:40589 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932265AbVKLJ3W (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:29:22 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 313AC2DC03B;
	Sat, 12 Nov 2005 01:29:21 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:29:20 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112092721.GC16218@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11665>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Disambiguate the term 'branch' in Arch vs git,
and start using fully-qualified names.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   65 ++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 54 insertions(+), 11 deletions(-)

applies-to: bbfe032e4900efc45bb94fb687af0140ccb0a858
ede672b4cd544b5e5418cc5088e92f2e0d2f7394
diff --git a/git-archimport.perl b/git-archimport.perl
index 699d5f6..f2bcbb4 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -30,6 +30,24 @@ See man (1) git-archimport for more deta
=20
 Add print in front of the shell commands invoked via backticks.=20
=20
+=3Dhead1 Devel Notes
+
+There are several places where Arch and git terminology are intermixed
+and potentially confused.
+
+The notion of a "branch" in git is approximately equivalent to
+a "archive/category--branch--version" in Arch.  Also, it should be noted
+that the "--branch" portion of "archive/category--branch--version" is real=
ly
+optional in Arch although not many people (nor tools!) seem to know this.
+This means that "archive/category--version" is also a valid "branch"
+in git terms.
+
+We always refer to Arch names by their fully qualified variant (which
+means the "archive" name is prefixed.
+
+For people unfamiliar with Arch, an "archive" is the term for "repository",
+and can contain multiple, unrelated branches.
+
 =3Dcut
=20
 use strict;
@@ -215,9 +233,41 @@ unless (-d $git_dir) { # initial import
 }
=20
 # process patchsets
-foreach my $ps (@psets) {
+# extract the Arch repository name (Arch "archive" in Arch-speak)
+sub extract_reponame {
+    my $fq_cvbr =3D shift; # archivename/[[[[category]branch]version]revis=
ion]
+    return (split(/\//, $fq_cvbr))[0];
+}
+=20
+sub extract_versionname {
+    my $name =3D shift;
+    $name =3D~ s/--(?:patch|version(?:fix)?|base)-\d+$//;
+    return $name;
+}
=20
-    $ps->{branch} =3D  branchname($ps->{id});
+# convert a fully-qualified revision or version to a unique dirname:
+#   normalperson@yhbt.net-05/mpd--uclinux--1--patch-2=20
+# becomes: normalperson@yhbt.net-05,mpd--uclinux--1
+#
+# the git notion of a branch is closer to
+# archive/category--branch--version than archive/category--branch, so we
+# use this to convert to git branch names.
+# Also, keep archive names but replace '/' with ',' since it won't require
+# subdirectories, and is safer than swapping '--' which could confuse
+# reverse-mapping when dealing with bastard branches that
+# are just archive/category--version  (no --branch)
+sub tree_dirname {
+    my $revision =3D shift;
+    my $name =3D extract_versionname($revision);
+    $name =3D~ s#/#,#;
+    return $name;
+}
+
+*git_branchname =3D *tree_dirname;
+
+# process patchsets
+foreach my $ps (@psets) {
+    $ps->{branch} =3D git_branchname($ps->{id});
=20
     #
     # ensure we have a clean state=20
@@ -429,16 +479,9 @@ foreach my $ps (@psets) {
     $opt_v && print "   + parents:  $par \n";
 }
=20
-sub branchname {
-    my $id =3D shift;
-    $id =3D~ s#^.+?/##;
-    my @parts =3D split(m/--/, $id);
-    return join('--', @parts[0..1]);
-}
-
 sub apply_import {
     my $ps =3D shift;
-    my $bname =3D branchname($ps->{id});
+    my $bname =3D git_branchname($ps->{id});
=20
     `mkdir -p $tmp`;
=20
@@ -669,7 +712,7 @@ sub find_parents {
     # simple loop to split the merges
     # per branch
     foreach my $merge (@{$ps->{merges}}) {
-	my $branch =3D branchname($merge);
+	my $branch =3D git_branchname($merge);
 	unless (defined $branches{$branch} ){
 	    $branches{$branch} =3D [];
 	}
---
0.99.9.GIT
--=20
Eric Wong

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdbXwcodMowuNYfcRAqoYAJ4y/usaYgX++NcB0Ltc22QVV9jPrACfVbjS
q+QsnofLWzvPiiyL7jY2WAI=
=Oopv
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
