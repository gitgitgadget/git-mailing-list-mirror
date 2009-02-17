From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 15:09:18 +0100
Message-ID: <200902171509.21434.trast@student.ethz.ch>
References: <499AB8A1.7090909@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1604842.APSADoQgTe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:11:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQf3-0007rY-5W
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZBQOJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZBQOJY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:09:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:59641 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbZBQOJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:09:23 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 15:09:22 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 15:09:21 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <499AB8A1.7090909@datacom.ind.br>
X-OriginalArrivalTime: 17 Feb 2009 14:09:21.0909 (UTC) FILETIME=[54BBB250:01C99109]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110383>

--nextPart1604842.APSADoQgTe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Samuel Lucas Vaz de Mello wrote:
> Is there any way to git blame (or annotate) a diff between two
> commits?

Piecing it together from existing tools isn't really hard, and made
for a nice distraction.

Call it as './git-blame-diff.perl HEAD^ HEAD' or so.

This lacks proper argument checking and a chdir to the repository top
level.  Maybe you could fill in the gaps and shape it as a contrib
patch?  For bonus points, change it so that the workdir version can be
used as the new side of the diff, by omitting the second argument.

=2D-- 8< ---
#!/usr/bin/perl -w

sub parse_hunk_header {
	my ($line) =3D @_;
	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D
	    $line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
	$o_cnt =3D 1 unless defined $o_cnt;
	$n_cnt =3D 1 unless defined $n_cnt;
	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
}

sub get_blame_prefix {
	my ($line) =3D @_;
	$line =3D~ /^([0-9a-f]+\s+\([^\)]+\))/ or die "bad blame output: $line";
	return $1;
}

my ($oldrev, $newrev) =3D @ARGV;
open($diff, '-|', 'git', '--no-pager', 'diff', $oldrev, $newrev) or die;

my ($pre, $post);
my $filename;
while (<$diff>) {
	if (m{^diff --git ./(.*) ./\1$}) {
		$filename =3D $1;
	} elsif (m{^(\+\+\+|---) ./$filename$}) {
		# ignore
	} elsif (m{^@@ }) {
		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt)
			=3D parse_hunk_header($_);
		my $o_end =3D $o_ofs + $o_cnt;
		my $n_end =3D $n_ofs + $n_cnt;
		open($pre, '-|', 'git', 'blame', "-L$o_ofs,$o_end",
		     $oldrev, '--', $filename) or die;
		open($post, '-|', 'git', 'blame', "-L$n_ofs,$n_end",
		     $newrev, '--', $filename) or die;
	} elsif (m{^ }) {
		print get_blame_prefix(scalar <$pre>), "\t", $_;
		scalar <$post>; # discard
	} elsif (m{^\-}) {
		print get_blame_prefix(scalar <$pre>), "\t", $_;
	} elsif (m{^\+}) {
		print get_blame_prefix(scalar <$post>), "\t", $_;
	}=20
}

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1604842.APSADoQgTe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmaxREACgkQqUud07tmzP2VuQCfXKNp6IhdfjXvGw12sp/R6tlg
OrsAn3UEdqVGBeInPewIFEMTAKtvviy0
=QElX
-----END PGP SIGNATURE-----

--nextPart1604842.APSADoQgTe--
