From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: [PATCH] git-svn: Handle multi-branch setups even if repo root
 cannot be accessed
Date: Wed, 13 May 2009 00:41:15 +0200
Message-ID: <1242168075.4802.13.camel@kea>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uxYGb12iWmtN9YJSS7bF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:41:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40f9-0004qy-RL
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZELWlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZELWlS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:41:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:45157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751359AbZELWlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:41:17 -0400
Received: (qmail invoked by alias); 12 May 2009 22:41:16 -0000
Received: from d113116.adsl.hansenet.de (EHLO [192.168.1.50]) [80.171.113.116]
  by mail.gmx.net (mp059) with SMTP; 13 May 2009 00:41:16 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX19LRVIAW3dL6YR99G+1b4N5ZJLW9WYSxezN21G9CI
	GgOuTjtsFOeEBz
X-Mailer: Evolution 2.24.5 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118960>


--=-uxYGb12iWmtN9YJSS7bF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

For the case of multiple projects sharing a single SVN repository, it is
common practice to create the standard SVN directory layout within a
subdirectory for each project. In such setups, access control is often
used to limit what projects a given user may access. This results in
git-svn not being able to minimize the URL of the repository to the
repository root URL, which triggered problems since path handling for
multi-branch setups was not aware of the path prefix for the project
directory relative to the repository root. Fix this deficiency by
converting all paths received from get_log to a form relative to the URL
that is configured for the SVN remote. Also drop the hardcoded URL
minimization flag for the multi-branch case since it is not required
anymore and can be requested via a command line parameter if desired.

Signed-off-by: Mattias Nissler <mattias.nissler@gmx.de>
---

Hi,

I've successfully tested this patch against our SVN repo at work, which
is quite large in terms of number of files and disk usage. I hope I
didn't break anything, I tried to minimize the chance of doing so by
isolating the important changes to the handling of the results of the
get_log call. Still, I'd appreciate if someone could review the patch to
see whether I might have broken something I didn't think of.

Please CC me on replies, I'm not on the list.

Enjoy!

Mattias


 git-svn.perl |   83 +++++++++++++++++++++++++-----------------------------=
---
 1 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..ed95f05 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -798,10 +798,6 @@ sub cmd_multi_init {
 		usage(1);
 	}
=20
-	# there are currently some bugs that prevent multi-init/multi-fetch
-	# setups from working well without this.
-	$Git::SVN::_minimize_url =3D 1;
-
 	$_prefix =3D '' unless defined $_prefix;
 	if (defined $url) {
 		$url =3D~ s#/+$##;
@@ -1084,7 +1080,7 @@ sub complete_url_ls_init {
 		    "wanted to set to: $gs->{url}\n";
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path =3D "$ra->{svn_path}/$repo_path";
+	my $remote_path =3D "$gs->{path}/$repo_path";
 	$remote_path =3D~ s#/+#/#g;
 	$remote_path =3D~ s#^/##g;
 	$remote_path .=3D "/*" if $remote_path !~ /\*/;
@@ -2066,16 +2062,6 @@ sub ra {
 	$ra;
 }
=20
-sub rel_path {
-	my ($self) =3D @_;
-	my $repos_root =3D $self->ra->{repos_root};
-	return $self->{path} if ($self->{url} eq $repos_root);
-	my $url =3D $self->{url} .
-	          (length $self->{path} ? "/$self->{path}" : $self->{path});
-	$url =3D~ s!^\Q$repos_root\E(?:/+|$)!!g;
-	$url;
-}
-
 # prop_walk(PATH, REV, SUB)
 # -------------------------
 # Recursively traverse PATH at revision REV and invoke SUB for each
@@ -2401,10 +2387,7 @@ sub match_paths {
 	if (my $path =3D $paths->{"/$self->{path}"}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	my $repos_root =3D $self->ra->{repos_root};
-	my $extended_path =3D $self->{url} . '/' . $self->{path};
-	$extended_path =3D~ s#^\Q$repos_root\E(/|$)##;
-	$self->{path_regex} ||=3D qr/^\/\Q$extended_path\E\//;
+	$self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
@@ -2427,15 +2410,14 @@ sub find_parent_branch {
 	unless (defined $paths) {
 		my $err_handler =3D $SVN::Error::handler;
 		$SVN::Error::handler =3D \&Git::SVN::Ra::skip_unknown_revs;
-		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1, sub {
-		                   $paths =3D
-				      Git::SVN::Ra::dup_changed_paths($_[0]) });
+		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1,
+			sub { $paths =3D $_[0] });
 		$SVN::Error::handler =3D $err_handler;
 	}
 	return undef unless defined $paths;
=20
 	# look for a parent from another branch:
-	my @b_path_components =3D split m#/#, $self->rel_path;
+	my @b_path_components =3D split m#/#, $self->{path};
 	my @a_path_components;
 	my $i;
 	while (@b_path_components) {
@@ -2453,11 +2435,11 @@ sub find_parent_branch {
 	my $r =3D $i->{copyfrom_rev};
 	my $repos_root =3D $self->ra->{repos_root};
 	my $url =3D $self->ra->{url};
-	my $new_url =3D $repos_root . $branch_from;
+	my $new_url =3D $url . $branch_from;
 	print STDERR  "Found possible branch point: ",
 	              "$new_url =3D> ", $self->full_url, ", $r\n";
 	$branch_from =3D~ s#^/##;
-	my $gs =3D $self->other_gs($new_url, $url, $repos_root,
+	my $gs =3D $self->other_gs($new_url, $url,
 		                 $branch_from, $r, $self->{ref_id});
 	my ($r0, $parent) =3D $gs->find_rev_before($r, 1);
 	{
@@ -2642,9 +2624,9 @@ sub parse_svn_date {
 }
=20
 sub other_gs {
-	my ($self, $new_url, $url, $repos_root,
+	my ($self, $new_url, $url,
 	    $branch_from, $r, $old_ref_id) =3D @_;
-	my $gs =3D Git::SVN->find_by_url($new_url, $repos_root, $branch_from);
+	my $gs =3D Git::SVN->find_by_url($new_url, $url, $branch_from);
 	unless ($gs) {
 		my $ref_id =3D $old_ref_id;
 		$ref_id =3D~ s/\@\d+$//;
@@ -4280,6 +4262,31 @@ sub get_log {
 	my ($self, @args) =3D @_;
 	my $pool =3D SVN::Pool->new;
=20
+	# svn_log_changed_path_t objects passed to get_log are likely to be
+	# overwritten even if only the refs are copied to an external variable,
+	# so we should dup the structures in their entirety.  Using an
+	# externally passed pool (instead of our temporary and quickly cleared
+	# pool in Git::SVN::Ra) does not help matters at all...
+	my $receiver =3D pop @args;
+	my $prefix =3D "/".$self->{svn_path};
+	$prefix =3D~ s#/+($)##;
+	my $prefix_regex =3D qr#^\Q$prefix\E#;
+	push(@args, sub {
+		my ($paths) =3D $_[0];
+		return &$receiver(@_) unless $paths;
+		$_[0] =3D ();
+		foreach my $p (keys %$paths) {
+			my $i =3D $paths->{$p};
+			# Make path relative to our url, not repos_root
+			$p =3D~ s/$prefix_regex//;
+			my %s =3D map { $_ =3D> $i->$_; }
+				qw/copyfrom_path copyfrom_rev action/;
+			$s{'copyfrom_path'} =3D~ s/$prefix_regex// if $s{'copyfrom_path'};
+			$_[0]{$p} =3D \%s;
+		}
+		&$receiver(@_);
+	});
+
 	# the limit parameter was not supported in SVN 1.1.x, so we
 	# drop it.  Therefore, the receiver callback passed to it
 	# is made aware of this limitation by being wrapped if
@@ -4291,6 +4298,7 @@ sub get_log {
 			push(@args, sub { &$receiver(@_) if (--$limit >=3D 0) });
 		}
 	}
+
 	my $ret =3D $self->SUPER::get_log(@args, $pool);
 	$pool->clear;
 	$ret;
@@ -4448,8 +4456,7 @@ sub gs_fetch_loop_common {
 		};
 		sub _cb {
 			my ($paths, $r, $author, $date, $log) =3D @_;
-			[ dup_changed_paths($paths),
-			  { author =3D> $author, date =3D> $date, log =3D> $log } ];
+			[ $paths, { author =3D> $author, date =3D> $date, log =3D> $log } ];
 		}
 		$self->get_log([$longest_path], $min, $max, 0, 1, 1,
 		               sub { $revs{$_[1]} =3D _cb(@_) });
@@ -4668,24 +4675,6 @@ sub skip_unknown_revs {
 	die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
 }
=20
-# svn_log_changed_path_t objects passed to get_log are likely to be
-# overwritten even if only the refs are copied to an external variable,
-# so we should dup the structures in their entirety.  Using an externally
-# passed pool (instead of our temporary and quickly cleared pool in
-# Git::SVN::Ra) does not help matters at all...
-sub dup_changed_paths {
-	my ($paths) =3D @_;
-	return undef unless $paths;
-	my %ret;
-	foreach my $p (keys %$paths) {
-		my $i =3D $paths->{$p};
-		my %s =3D map { $_ =3D> $i->$_ }
-		              qw/copyfrom_path copyfrom_rev action/;
-		$ret{$p} =3D \%s;
-	}
-	\%ret;
-}
-
 package Git::SVN::Log;
 use strict;
 use warnings;
--=20
1.6.2.2

--=-uxYGb12iWmtN9YJSS7bF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkoJ+wsACgkQwJO1cHm4WqbpdgCeMjQlqvd77wCWVFHC+7yhJDZ+
QKYAmwWdwr/jwdcJu60Gpzk91gbQP5O7
=zdRL
-----END PGP SIGNATURE-----

--=-uxYGb12iWmtN9YJSS7bF--
