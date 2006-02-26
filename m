From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 3/4] Convert the svn:ignore property
Date: Sun, 26 Feb 2006 06:11:29 +0100
Message-ID: <20060226051129.24860.25274.stgit@backpacker.hemma.treskal.com>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Feb 26 06:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDEC6-0000Rg-1A
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWBZFLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:11:31 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWBZFLb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:11:31 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:24773 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751212AbWBZFLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 00:11:31 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060226051129.WHYA16046.mxfep01.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:29 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 6B8B8167C
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:29 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16775>

Put the value of the svn:ignore property in a regular file when
converting a Subversion repository to GIT. The Subversion and GIT
ignore syntaxes are similar enough that it often just works to set the
filename to .gitignore and do nothing else.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Documentation/git-svnimport.txt |    8 +++++
 git-svnimport.perl              |   60 +++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index b5c7721..c95ff84 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
-		<SVN_repository_URL> [ <path> ]
+		[ -I <ignorefile_name> ] <SVN_repository_URL> [ <path> ]
=20
=20
 DESCRIPTION
@@ -65,6 +65,12 @@ When importing incrementally, you might=20
 	Prepend 'rX: ' to commit messages, where X is the imported
 	subversion revision.
=20
+-I <ignorefile_name>::
+	Import the svn:ignore directory property to files with this
+	name in each directory. (The Subversion and GIT ignore
+	syntaxes are similar enough that using the Subversion patterns
+	directly with "-I .gitignore" will almost always just work.)
+
 -m::
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the name source
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 6603b96..0dd9fab 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -29,19 +29,21 @@ die "Need SVN:Core 1.2.1 or better" if $
 $SIG{'PIPE'}=3D"IGNORE";
 $ENV{'TZ'}=3D"UTC";
=20
-our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$op=
t_T,$opt_b,$opt_r,$opt_s,$opt_l,$opt_d,$opt_D);
+our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$op=
t_T,
+    $opt_b,$opt_r,$opt_I,$opt_s,$opt_l,$opt_d,$opt_D);
=20
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
-       [-d|-D] [-i] [-u] [-r] [-s start_chg] [-m] [-M regex] [SVN_URL]
+       [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
+       [-m] [-M regex] [SVN_URL]
 END
 	exit(1);
 }
=20
-getopts("b:C:dDhil:mM:o:rs:t:T:uv") or usage();
+getopts("b:C:dDhiI:l:mM:o:rs:t:T:uv") or usage();
 usage if $opt_h;
=20
 my $tag_name =3D $opt_t || "tags";
@@ -130,6 +132,24 @@ sub file {
 	return ($name, $mode);
 }
=20
+sub ignore {
+	my($self,$path,$rev) =3D @_;
+
+	print "... $rev $path ...\n" if $opt_v;
+	my (undef,undef,$properties)
+	    =3D $self->{'svn'}->get_dir($path,$rev,undef);
+	if (exists $properties->{'svn:ignore'}) {
+		my ($fh, $name) =3D tempfile('gitsvn.XXXXXX',
+					   DIR =3D> File::Spec->tmpdir(),
+					   UNLINK =3D> 1);
+		print $fh $properties->{'svn:ignore'};
+		close($fh);
+		return $name;
+	} else {
+		return undef;
+	}
+}
+
 package main;
 use URI;
=20
@@ -341,6 +361,34 @@ sub get_file($$$) {
 	return [$mode, $sha, $path];
 }
=20
+sub get_ignore($$$$$) {
+	my($new,$old,$rev,$branch,$path) =3D @_;
+
+	return unless $opt_I;
+	my $svnpath =3D revert_split_path($branch,$path);
+	my $name =3D $svn->ignore("$svnpath",$rev);
+	if ($path eq '/') {
+		$path =3D $opt_I;
+	} else {
+		$path =3D File::Spec->catfile($path,$opt_I);
+	}
+	if (defined $name) {
+		my $pid =3D open(my $F, '-|');
+		die $! unless defined $pid;
+		if (!$pid) {
+			exec("git-hash-object", "-w", $name)
+			    or die "Cannot create object: $!\n";
+		}
+		my $sha =3D <$F>;
+		chomp $sha;
+		close $F;
+		unlink $name;
+		push(@$new,['0644',$sha,$path]);
+	} else {
+		push(@$old,$path);
+	}
+}
+
 sub split_path($$) {
 	my($rev,$path) =3D @_;
 	my $branch;
@@ -546,6 +594,9 @@ sub commit {
 						my $opath =3D $action->[3];
 						print STDERR "$revision: $branch: could not fetch '$opath'\n";
 					}
+				} elsif ($node_kind eq $SVN::Node::dir) {
+					get_ignore(\@new, \@old, $revision,
+						   $branch,$path);
 				}
 			} elsif ($action->[0] eq "D") {
 				push(@old,$path);
@@ -554,6 +605,9 @@ sub commit {
 				if ($node_kind eq $SVN::Node::file) {
 					my $f =3D get_file($revision,$branch,$path);
 					push(@new,$f) if $f;
+				} elsif ($node_kind eq $SVN::Node::dir) {
+					get_ignore(\@new, \@old, $revision,
+						   $branch,$path);
 				}
 			} else {
 				die "$revision: unknown action '".$action->[0]."' for $path\n";
