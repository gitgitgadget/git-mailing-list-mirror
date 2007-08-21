From: Stefan Sperling <stsp@elego.de>
Subject: [PATCH] Allow multiple tag and branch directories in git-svnimport
Date: Tue, 21 Aug 2007 19:08:58 +0200
Message-ID: <20070821170858.GA1721@jack.stsp.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Cc: subversion@elego.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 19:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXLK-0005Oh-6T
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761142AbXHURQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761152AbXHURQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:16:09 -0400
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:60392 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760438AbXHURQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:16:02 -0400
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7LHFxEP012357
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 19:15:59 +0200
X-Envelope-From: stsp@elego.de
Received: from stsp.lan (stsp2.in-vpn.de [217.197.85.95])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7LHEX3t008708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Aug 2007 19:14:34 +0200
Received: from jack.stsp.lan (stsp@localhost.stsp.lan [127.0.0.1])
	by stsp.lan (8.14.1/8.14.0) with ESMTP id l7LH8wEG023265;
	Tue, 21 Aug 2007 19:08:58 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.lan (8.14.1/8.14.0/Submit) id l7LH8wlH014136;
	Tue, 21 Aug 2007 19:08:58 +0200 (CEST)
X-Authentication-Warning: jack.stsp.lan: stsp set sender to stsp@elego.de using -f
Mail-Followup-To: git@vger.kernel.org, subversion@elego.de
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56307>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With this patch, users can specify colon-seperated lists of
directories containing tags and branches, respectively.

This makes git-svnimport much more usable in the real world
because there are Subversion repositories that use a deeper
tag and branch hierarchy than the recommended hierarchy of

	trunk/
	tags/
	branches/

The patch assumes my memleak fix patch from
http://marc.info/?l=3Dgit&m=3D118554191513822&w=3D2
but applies cleanly to current vanilla git head as well.

I'm not subscribed to the list so please Cc me in replies, thanks.


diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.=
txt
index e97d15e..2cfc407 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -12,11 +12,11 @@ SYNOPSIS
 [verse]
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
-		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
-		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
-		[ -I <ignorefile_name> ] [ -A <author_file> ]
-		[ -R <repack_each_revs>] [ -P <path_from_trunk> ]
-		<SVN_repository_URL> [ <path> ]
+		[ -b branch_subdir[:branch_subdir:...] ] [ -T trunk_subdir ]
+		[ -t tag_subdir[:tag_subdir:...] ] [ -s start_chg ] [ -m ]
+		[ -r ] [ -M regex ] [ -I <ignorefile_name> ]
+		[ -A <author_file> ] [ -R <repack_each_revs>]
+		[ -P <path_from_trunk> ] <SVN_repository_URL> [ <path> ]
=20
=20
 DESCRIPTION
@@ -26,11 +26,6 @@ repository, or incrementally import into an existing one.
=20
 SVN access is done by the SVN::Perl module.
=20
-git-svnimport assumes that SVN repositories are organized into one
-"trunk" directory where the main development happens, "branches/FOO"
-directories for branches, and "/tags/FOO" directories for tags.
-Other subdirectories are ignored.
-
 git-svnimport creates a file ".git/svn2git", which is required for
 incremental SVN imports.
=20
@@ -53,11 +48,13 @@ When importing incrementally, you might need to edit th=
e .git/svn2git file.
 -T <trunk_subdir>::
 	Name the SVN trunk. Default "trunk".
=20
--t <tag_subdir>::
-	Name the SVN subdirectory for tags. Default "tags".
+-t <tag_subdir[:tag_subdir:..]>::
+	Colon-seperated list of names of subdirectories containing tags.
+	Default "tags".
=20
--b <branch_subdir>::
-	Name the SVN subdirectory for branches. Default "branches".
+-b <branch_subdir[:branch_subdir:...]>::
+	Colon-seperated list of names of subdirectories containing branches.
+	Default "branches".
=20
 -o <branch-for-HEAD>::
 	The 'trunk' branch from SVN is imported to the 'origin' branch within
diff --git a/git-svnimport.perl b/git-svnimport.perl
index fc9ea71..96f0926 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -38,9 +38,10 @@ sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
-       [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
-       [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_U=
RL]
+       [-C GIT_repository] [-t tag_subdir[:tag_subdir:...]] [-T trunk_subd=
ir]
+       [-b branch_subdir[:branch_subdir:...]] [-d|-D] [-i] [-u] [-r]
+       [-I ignorefilename] [-s start_chg] [-m] [-M regex]
+       [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
 END
 	exit(1);
 }
@@ -48,9 +49,9 @@ END
 getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
=20
-my $tag_name =3D $opt_t || "tags";
-my $trunk_name =3D defined $opt_T ? $opt_T : "trunk";
-my $branch_name =3D $opt_b || "branches";
+my @tag_dirs =3D defined $opt_t ? split /:/,$opt_t : "tags";
+my $trunk_dir =3D defined $opt_T ? $opt_T : "trunk";
+my @branch_dirs =3D defined $opt_b ? split /:/,$opt_b : "branches";
 my $project_name =3D $opt_P || "";
 $project_name =3D "/" . $project_name if ($project_name);
 my $repack_after =3D $opt_R || 1000;
@@ -68,14 +69,18 @@ my $svn_dir =3D $ARGV[1];
=20
 our @mergerx =3D ();
 if ($opt_m) {
-	my $branch_esc =3D quotemeta ($branch_name);
-	my $trunk_esc  =3D quotemeta ($trunk_name);
-	@mergerx =3D
-	(
-		qr!\b(?:merg(?:ed?|ing))\b.*?\b((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$tru=
nk_esc))\b!i,
-		qr!\b(?:from|of)\W+((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$trunk_esc))\b!i,
-		qr!\b(?:from|of)\W+(?:the )?([\w\.\-]+)[-\s]branch\b!i
-	);
+	my @branch_escs;
+	foreach (@branch_dirs) { push @branch_escs, quotemeta ($_); }
+	my $trunk_esc  =3D quotemeta ($trunk_dir);
+
+	foreach my $branch_esc (@branch_escs) {
+		push (@mergerx,
+		(
+			qr!\b(?:merg(?:ed?|ing))\b.*?\b((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$tr=
unk_esc))\b!i,
+			qr!\b(?:from|of)\W+((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$trunk_esc))\b!=
i,
+			qr!\b(?:from|of)\W+(?:the )?([\w\.\-]+)[-\s]branch\b!i
+		));
+	}
 }
 if ($opt_M) {
 	unshift (@mergerx, qr/$opt_M/);
@@ -452,29 +457,39 @@ sub project_path($$)
=20
 sub split_path($$) {
 	my($rev,$path) =3D @_;
-	my $branch;
+	my $dir; # tag or branch dir
+
+	OUTER: foreach my $tag_dir (@tag_dirs) {
+		foreach my $branch_dir (@branch_dirs) {
+			if ($path =3D~ s#^/\Q$tag_dir\E/([^/]+)/?##) {
+				$dir =3D "/$1";
+			} elsif ($path =3D~ s#^/\Q$trunk_dir\E/?##) {
+				$dir =3D "/";
+			} elsif ($path =3D~ s#^/\Q$branch_dir\E/([^/]+)/?##) {
+				$dir =3D $1;
+			}
+			last OUTER if $dir;
+		}
+	}
=20
-	if($path =3D~ s#^/\Q$tag_name\E/([^/]+)/?##) {
-		$branch =3D "/$1";
-	} elsif($path =3D~ s#^/\Q$trunk_name\E/?##) {
-		$branch =3D "/";
-	} elsif($path =3D~ s#^/\Q$branch_name\E/([^/]+)/?##) {
-		$branch =3D $1;
-	} else {
-		my %no_error =3D (
-			"/" =3D> 1,
-			"/$tag_name" =3D> 1,
-			"/$branch_name" =3D> 1
-		);
-		print STDERR "$rev: Unrecognized path: $path\n" unless (defined $no_erro=
r{$path});
-		return ()
+	if (! $dir) {
+		my %no_error =3D ( "/" =3D> 1, "/tags" =3D> 1, "/branches" =3D> 1 );
+		foreach (@tag_dirs) {
+			$no_error{"/$_"} =3D 1;
+		}
+		foreach (@branch_dirs) {
+			$no_error{"/$_"} =3D 1;
+		}
+		print STDERR "$rev: Could not determine tag or branch ",
+			"directory for path '$path'\n",
+			unless (defined $no_error{$path});
 	}
 	if ($path eq "") {
 		$path =3D "/";
 	} elsif ($project_name) {
 		$path =3D project_path($path, $project_name);
 	}
-	return ($branch,$path);
+	return ($dir,$path);
 }
=20
 sub branch_rev($$) {
@@ -874,9 +889,32 @@ sub commit {
=20
 		$dest =3D~ tr/_/\./ if $opt_u;
=20
-		system('git-tag', $dest, $cid) =3D=3D 0
-			or die "Cannot create tag $dest: $!\n";
-
+		# Since we support multiple directories that host tags we
+		# must support repositories that contain the same tag name
+		# in different tag directories for whatever reason,
+		# e.g. tags/jim/1.0-rc3 and tags/huck/1.0-rc3
+		#
+		# Also, because in Subversion a given tag directory could
+		# exist in revision A, be deleted in revision B and later
+		# recreated under the same name in revision C, we
+		# cannot guarantee that a tag is unique simply by
+		# looking at the tag's path.
+		#
+		# So if we fail to create the tag the first time, we try
+		# to create the tag with the same name except with the
+		# revision number of the current commit appended.
+		# Users can rename tags again later after the repository
+		# has been converted if they don't like this.
+		# It's still much better than failing to convert the
+		# repository alltogether.
+		if (system('git-tag', $dest, $cid) !=3D 0) {
+			print STDERR "Could not create tag $dest, ",
+				"trying to create tag $dest-r$revision ",
+				"instead\n";
+			$dest =3D "$dest-r$revision";
+			system('git-tag', $dest, $cid) =3D=3D 0
+				or die "Cannot create tag $dest: $? $!\n";
+		}
 		print "Created tag '$dest' on '$branch'\n" if $opt_v;
 	}
 	$branches{$branch}{"LAST"} =3D $cid;

--=20
Stefan Sperling <stsp@elego.de>                 Software Developer
elego Software Solutions GmbH                            HRB 77719
Gustav-Meyer-Allee 25, Gebaeude 12        Tel:  +49 30 23 45 86 96=20
13355 Berlin                              Fax:  +49 30 23 45 86 95
http://www.elego.de                 Geschaeftsfuehrer: Olaf Wagner

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (OpenBSD)

iD8DBQFGyxwq5dMCc/WdJfARAp3MAJ9XEdnMWGtOFMUBOKcsIRlyIikvYQCgy5wL
9f07uj1aqRMBY9NJi3G6yUM=
=FcNa
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
