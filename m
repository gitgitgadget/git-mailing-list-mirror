From: smurf@smurf.noris.de
Subject: [PATCH] cvsimport: Remove master-updating code
Date: Tue, 7 Mar 2006 10:08:34 +0100
Message-ID: <20060307090834.GX13888@smurf.noris.de>
References: <44094618.6070404@asianetindia.com> <46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com> <46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com> <440C68B9.9030305@asianetindia.com> <7vek1e6cnk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Cc: Rajkumar S <rajkumars@asianetindia.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 10:15:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYHy-0005ep-NE
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbWCGJPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWCGJPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:15:16 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:26817 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1752014AbWCGJPP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 04:15:15 -0500
Received: from smurf by smurf.noris.de with local (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1FGYBG-0005v2-Pq; Tue, 07 Mar 2006 10:08:34 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek1e6cnk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17324>


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code which tried to update the master branch was somewhat broken.
=3D> People should do that manually, with "git merge".

Signed-off-by: Matthias Urlichs <smurf@smurf.noris.de>
---

Junio C Hamano:
> I do not understand what cvsimport is trying to do here; I
> _suspect_ the part that updates the "master" branch head might
> be a bug.
>=20
This should fix it.

---

 Documentation/git-cvsimport.txt |    6 ++++++
 git-cvsimport.perl              |   27 ++-------------------------
 2 files changed, 8 insertions(+), 25 deletions(-)

4c28ef8000d68a0736084022a047019dca96c823
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.=
txt
index dfe86ce..57027b4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -22,6 +22,12 @@ repository, or incrementally import into
 Splitting the CVS log into patch sets is done by 'cvsps'.
 At least version 2.1 is required.
=20
+You should *never* do any work of your own on the branches that are
+created by git-cvsimport. The initial import will create and populate a
+"master" branch from the CVS repository's main branch which you're free
+to work with; after that, you need to 'git merge' incremental imports, or
+any CVS branches, yourself.
+
 OPTIONS
 -------
 -d <CVSROOT>::
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b46469a..02d1928 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -452,7 +452,6 @@ chdir($git_tree);
=20
 my $last_branch =3D "";
 my $orig_branch =3D "";
-my $forward_master =3D 0;
 my %branch_date;
=20
 my $git_dir =3D $ENV{"GIT_DIR"} || ".git";
@@ -488,21 +487,6 @@ unless(-d $git_dir) {
 		$last_branch =3D "master";
 	}
 	$orig_branch =3D $last_branch;
-	if (-f "$git_dir/CVS2GIT_HEAD") {
-		die <<EOM;
-CVS2GIT_HEAD exists.
-Make sure your working directory corresponds to HEAD and remove CVS2GIT_HE=
AD.
-You may need to run
-
-    git read-tree -m -u CVS2GIT_HEAD HEAD
-EOM
-	}
-	system('cp', "$git_dir/HEAD", "$git_dir/CVS2GIT_HEAD");
-
-	$forward_master =3D
-	    $opt_o ne 'master' && -f "$git_dir/refs/heads/master" &&
-	    system('cmp', '-s', "$git_dir/refs/heads/master",=20
-				"$git_dir/refs/heads/$opt_o") =3D=3D 0;
=20
 	# populate index
 	system('git-read-tree', $last_branch);
@@ -889,17 +873,11 @@ if (defined $orig_git_index) {
=20
 # Now switch back to the branch we were in before all of this happened
 if($orig_branch) {
-	print "DONE\n" if $opt_v;
-	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
-		if $forward_master;
-	unless ($opt_i) {
-		system('git-read-tree', '-m', '-u', 'CVS2GIT_HEAD', 'HEAD');
-		die "read-tree failed: $?\n" if $?;
-	}
+	print "DONE; you may need to merge manually.\n" if $opt_v;
 } else {
 	$orig_branch =3D "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
+	system("git-update-ref", "refs/heads/master", "refs/heads/$opt_o")
 		unless -f "$git_dir/refs/heads/master";
 	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
@@ -907,4 +885,3 @@ if($orig_branch) {
 		die "checkout failed: $?\n" if $?;
 	}
 }
-unlink("$git_dir/CVS2GIT_HEAD");
--=20
1.2.GIT


--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You will be run over by a bus.

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEDU2S8+hUANcKr/kRAqKVAJwLmI8fSDTfvMxvQ9WfKETY7oO2uwCeOMHN
ai0TwL2Mcvw0607HKWTITyM=
=nv2I
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
