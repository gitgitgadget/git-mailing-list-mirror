From: Thomas Rast <trast@student.ethz.ch>
Subject: [WIP PATCH v2] git-add--interactive: manual hunk editing mode
Date: Thu, 5 Jun 2008 14:38:06 +0200
Message-ID: <200806051438.12758.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1302165.0IukMCzHmf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:38:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Ejl-0002Hx-TC
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbYFEMhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbYFEMhn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:37:43 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:58420 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661AbYFEMhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 08:37:42 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 14:37:40 +0200
Received: from vpn-global-dhcp3-023.ethz.ch ([129.132.210.23]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 14:37:40 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080605014618.GA27381@sigill.intra.peff.net>
X-OriginalArrivalTime: 05 Jun 2008 12:37:40.0655 (UTC) FILETIME=[F19133F0:01C8C708]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83914>

--nextPart1302165.0IukMCzHmf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Adds a new option 'e' to the 'add -p' command loop that lets you
edit the current hunk in your favourite editor.

=2D--

Jeff King wrote:
> Hmm. Repeating this chunk is a bit ugly. I wonder if the whole loop
> might be a bit more readable in two sections: first parse into a list of
> hunks, and then fixup each hunk.
[...]
>  - Minor fixups and style comments. All of my style comments are "I
>    would have done it as..." and not "Oh God, this is horrible" so I
>    don't think any block acceptance.

This is the squashed patch, changed according to your comments, and
with the loop in question rewritten as you suggested.  (It's indeed
far less obscure.)

Not ready for commit yet because

>  - I'd really like to see a few testcases before that, though.

is still missing.

=2D Thomas


 git-add--interactive.perl |  164 ++++++++++++++++++++++++++++++++++++++++-=
=2D---
 1 files changed, 147 insertions(+), 17 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..5fb8402 100755
=2D-- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,7 @@
=20
 use strict;
 use Git;
+use File::Temp qw/tempfile/;
=20
 my $repo =3D Git->repository();
=20
@@ -18,6 +19,18 @@ my ($fraginfo_color) =3D
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
+my ($diff_plain_color) =3D
+	$diff_use_color ? (
+		$repo->get_color('color.diff.plain', ''),
+	) : ();
+my ($diff_old_color) =3D
+	$diff_use_color ? (
+		$repo->get_color('color.diff.old', 'red'),
+	) : ();
+my ($diff_new_color) =3D
+	$diff_use_color ? (
+		$repo->get_color('color.diff.new', 'green'),
+	) : ();
=20
 my $normal_color =3D $repo->get_color("", "reset");
=20
@@ -581,6 +594,13 @@ sub parse_hunk_header {
 	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 }
=20
+sub format_hunk_header {
+	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D @_;
+	return ("@@ -$o_ofs" . (($o_cnt !=3D 1) ? ",$o_cnt" : '')
+		. " +$n_ofs" . (($n_cnt !=3D 1) ? ",$n_cnt" : '')
+		. " @@\n");
+}
+
 sub split_hunk {
 	my ($text, $display) =3D @_;
 	my @split =3D ();
@@ -667,11 +687,7 @@ sub split_hunk {
 		my $o_cnt =3D $hunk->{OCNT};
 		my $n_cnt =3D $hunk->{NCNT};
=20
=2D		my $head =3D ("@@ -$o_ofs" .
=2D			    (($o_cnt !=3D 1) ? ",$o_cnt" : '') .
=2D			    " +$n_ofs" .
=2D			    (($n_cnt !=3D 1) ? ",$n_cnt" : '') .
=2D			    " @@\n");
+		my $head =3D format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 		my $display_head =3D $head;
 		unshift @{$hunk->{TEXT}}, $head;
 		if ($diff_use_color) {
@@ -741,11 +757,7 @@ sub merge_hunk {
 		}
 		push @line, $line;
 	}
=2D	my $head =3D ("@@ -$o0_ofs" .
=2D		    (($o_cnt !=3D 1) ? ",$o_cnt" : '') .
=2D		    " +$n0_ofs" .
=2D		    (($n_cnt !=3D 1) ? ",$n_cnt" : '') .
=2D		    " @@\n");
+	my $head =3D format_hunk_header($o0_ofs, $o_cnt, $n0_ofs, $n_cnt);
 	@{$prev->{TEXT}} =3D ($head, @line);
 }
=20
@@ -770,6 +782,122 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
=20
+sub edit_hunk_manually {
+	my @oldtext =3D map { @{$_->{TEXT}} } @_;
+
+	my ($fh, $editpath) =3D tempfile($repo->repo_path() . "/git-hunk-edit.XXX=
XXX",
+				       SUFFIX =3D> ".diff", UNLINK =3D> 0);
+	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $fh @oldtext;
+	print $fh <<EOF;
+# ---
+# To remove '-' lines, make them ' ' lines (context).
+# To remove '+' lines, delete them.
+# Empty lines and lines starting with # will be removed.
+#
+# Lines starting with @ start a new hunk. Line counts will be adjusted
+# according to contents. If the line numbers are missing altogether,
+# they will be inferred from the previous hunk.
+#
+# You can change the hunk to your heart's content, but it will be
+# refused if the end result (the entire patch including your edited
+# hunk) does not apply cleanly.
+EOF
+	close $fh;
+
+	my $editor =3D $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $editpath);
+
+	open $fh, '<', $editpath
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext =3D grep { !/^#/ } <$fh>;
+	close $fh;
+	unlink(glob($editpath . "*"));
+	# Reinsert the first hunk header if the user accidentally deleted it
+	if ($newtext[0] !~ /^@/) {
+		splice @newtext, 0, 0, $oldtext[0];
+	}
+	# Split into hunks
+	my @hunktexts =3D ();
+	my $curhunk =3D [];
+	for (@newtext) {
+		if (/^@/ && @{$curhunk} > 0) {
+			push @hunktexts, $curhunk;
+			$curhunk =3D [];
+		}
+		push @{$curhunk}, $_;
+	}
+	push @hunktexts, $curhunk;
+	# Fix the hunk headers
+	my ($guess_o_ofs, undef, $guess_n_ofs, undef) =3D parse_hunk_header($oldt=
ext[0]);
+	for my $hunk (@hunktexts) {
+		my ($o_ofs, undef, $n_ofs, undef) =3D parse_hunk_header($hunk->[0]);
+		$o_ofs =3D $guess_o_ofs unless defined $o_ofs;
+		$n_ofs =3D $guess_n_ofs unless defined $n_ofs;
+		my $plus_cnt =3D grep /^\+/, @{$hunk};
+		my $minus_cnt =3D grep /^-/, @{$hunk};
+		my $context_cnt =3D grep { /^ / || /^$/ } @{$hunk};
+		my $o_cnt =3D $context_cnt + $minus_cnt;
+		my $n_cnt =3D $context_cnt + $plus_cnt;
+		$hunk->[0] =3D format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+		$guess_o_ofs =3D $o_ofs + $o_cnt;
+		$guess_n_ofs =3D $n_ofs + $n_cnt;
+	}
+	# Recolor the hunks
+	my (@hunks) =3D ();
+	for my $hunk (@hunktexts) {
+		my @hunkdisplay =3D map {
+			colored((/^@/  ? $fraginfo_color :
+				 /^\+/ ? $diff_new_color :
+				 /^-/  ? $diff_old_color :
+				 $diff_plain_color),
+				$_);
+		} @{$hunk};
+		push @hunks, {TEXT =3D> $hunk, DISPLAY =3D> \@hunkdisplay};
+	}
+
+	return @hunks;
+}
+
+sub diff_applies {
+	my $fh;
+	open $fh, '| git apply --cached --check';
+	for my $h (@_) {
+		print $fh @{$h->{TEXT}};
+	}
+	return close $fh;
+}
+
+sub edit_hunk_loop {
+	my ($head, $hunks, $ix) =3D @_;
+
+	my @newhunks =3D ($hunks->[$ix]);
+
+      EDIT:
+	while (1) {
+		@newhunks =3D edit_hunk_manually(@newhunks);
+		if (!diff_applies($head, @$hunks[0..$ix-1], @newhunks,
+				  @$hunks[$ix+1..$#{$hunks}])) {
+			while (1) {
+				print colored $prompt_color, 'Your edited hunk does not apply. Edit ag=
ain (saying "no" discards!) [y/n]? ';
+				my $line =3D <STDIN>;
+				if ($line =3D~ /^y/i) {
+					redo EDIT;
+				}
+				elsif ($line =3D~ /^n/i) {
+					return $hunks->[$ix];
+				}
+			}
+		}
+		if (1 < @newhunks) {
+			print colored $header_color, "Manually edited into ",
+			scalar(@newhunks), " hunks.\n";
+		}
+		return @newhunks;
+	}
+}
+
 sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
@@ -781,6 +909,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -885,6 +1014,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .=3D '/s';
 		}
+		$other .=3D '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1079,11 @@ sub patch_update_file {
 				$num =3D scalar @hunk;
 				next;
 			}
+			elsif ($line =3D~ /^e/) {
+				splice @hunk, $ix, 1, edit_hunk_loop($head, \@hunk, $ix);
+				$num =3D scalar @hunk;
+				next;
+			}
 			else {
 				help_patch_cmd($other);
 				next;
@@ -985,13 +1120,8 @@ sub patch_update_file {
 		else {
 			if ($n_lofs) {
 				$n_ofs +=3D $n_lofs;
=2D				$text->[0] =3D ("@@ -$o_ofs" .
=2D					      (($o_cnt !=3D 1)
=2D					       ? ",$o_cnt" : '') .
=2D					      " +$n_ofs" .
=2D					      (($n_cnt !=3D 1)
=2D					       ? ",$n_cnt" : '') .
=2D					      " @@\n");
+				$text->[0] =3D format_hunk_header($o_ofs, $o_cnt,
+								$n_ofs, $n_cnt);
 			}
 			for (@$text) {
 				push @result, $_;
=2D-
1.5.6.rc1.137.g537d1


--nextPart1302165.0IukMCzHmf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIR940qUud07tmzP0RAnjjAKCgiZEwgz9wNVEx48kUJVo/tTeaJQCeMIW8
gyuKDuv2siYpSJrhibYoBBQ=
=rtsm
-----END PGP SIGNATURE-----

--nextPart1302165.0IukMCzHmf--
