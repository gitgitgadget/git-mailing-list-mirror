From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 16:45:41 +0200
Message-ID: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
References: <471045DA.5050902@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 16:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiHO-0002HZ-CK
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762629AbXJMOqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2007 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762624AbXJMOqf
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:46:35 -0400
Received: from wincent.com ([72.3.236.74]:46479 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762623AbXJMOqe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 10:46:34 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9DEk6u3014276;
	Sat, 13 Oct 2007 09:46:07 -0500
In-Reply-To: <471045DA.5050902@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 13/10/2007, a las 6:13, Dan Zwell escribi=F3:

> Dan Zwell<Color-add-interactive.patch.gz>

Based on a couple of the suggestions you've received I made a couple =20
of changes to your patch and given it a quick try-out. I'm no perl =20
hacker so there may be better ways.

- as per Jeff's suggestion, changed your print_ansi_color method, =20
modelling it after the print_color_ln and color_vprintf functions =20
defined in color.c; accepts a color, a string, and an optional =20
trailer (where if there is a newline you pass it as the trailer)

- as Johannes pointed out, "clear" and "reset" are not used =20
consistently even though the Term::ANSIColor documentation says that =20
they're the same, so settled on "clear"; although in any case, the =20
changes to the print_ansi_color function mean that it is now the only =20
site where clearing takes place

- changed the regex as suggested by Johannes, and a couple of others =20
that are used when splitting hunks

- used more explicit notation for regex as proposed by Frank

Took it for a basic spin here and seems to work. Didn't even think =20
about implementing user-settable colors.

Cheers,
Wincent

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be68814..ae3d11e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,28 @@

  use strict;

+my $use_color;
+my $color_config =3D qx(git config --get color.add-interactive);
+if ($color_config =3D~ /true/ || -t STDOUT && $color_config =3D~ /auto=
/) {
+	$use_color =3D "true";
+	require Term::ANSIColor;
+}
+
+sub print_ansi_color($$;$) {
+	my $color =3D shift;
+	my $string =3D shift;
+	my $trailer =3D shift;
+	if ($use_color) {
+		printf '%s%s%s', Term::ANSIColor::color($color), $string,
+		    Term::ANSIColor::color('clear');
+	} else {
+		print $string;
+	}
+	if ($trailer) {
+		print $trailer;
+	}
+}
+
  sub run_cmd_pipe {
  	if ($^O eq 'MSWin32') {
  		my @invalid =3D grep {m/[":*]/} @_;
@@ -175,7 +197,7 @@ sub list_and_choose {
  			if (!$opts->{LIST_FLAT}) {
  				print "     ";
  			}
-			print "$opts->{HEADER}\n";
+			print_ansi_color "bold", "$opts->{HEADER}", "\n";
  		}
  		for ($i =3D 0; $i < @stuff; $i++) {
  			my $chosen =3D $chosen[$i] ? '*' : ' ';
@@ -205,7 +227,7 @@ sub list_and_choose {

  		return if ($opts->{LIST_ONLY});

-		print $opts->{PROMPT};
+		print_ansi_color "bold blue", $opts->{PROMPT};
  		if ($opts->{SINGLETON}) {
  			print "> ";
  		}
@@ -338,11 +360,17 @@ sub add_untracked_cmd {

  sub parse_diff {
  	my ($path) =3D @_;
-	my @diff =3D run_cmd_pipe(qw(git diff-files -p --), $path);
+	my @diff;
+	if ($use_color) {
+		@diff =3D run_cmd_pipe(qw(git diff-files --color -p --), $path);
+	}
+	else {
+		@diff =3D run_cmd_pipe(qw(git diff-files -p --), $path);
+	}
  	my (@hunk) =3D { TEXT =3D> [] };

  	for (@diff) {
-		if (/^@@ /) {
+		if (/^[^-+ ]*@@ /) {
  			push @hunk, { TEXT =3D> [] };
  		}
  		push @{$hunk[-1]{TEXT}}, $_;
@@ -360,7 +388,7 @@ sub hunk_splittable {
  sub parse_hunk_header {
  	my ($line) =3D @_;
  	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D
-	    $line =3D~ /^@@ -(\d+)(?:,(\d+)) \+(\d+)(?:,(\d+)) @@/;
+	    $line =3D~ /^[^-+ ]*@@ -(\d+)(?:,(\d+)) \+(\d+)(?:,(\d+)) @@/;
  	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
  }

@@ -426,7 +454,7 @@ sub split_hunk {
  			}
  			push @{$this->{TEXT}}, $line;
  			$this->{ADDDEL}++;
-			if ($line =3D~ /^-/) {
+			if ($line =3D~ /^[^-+ ]*-/) {
  				$this->{OCNT}++;
  			}
  			else {
@@ -483,7 +511,7 @@ sub merge_hunk {
  	$o_cnt =3D $n_cnt =3D 0;
  	for ($i =3D 1; $i < @{$prev->{TEXT}}; $i++) {
  		my $line =3D $prev->{TEXT}[$i];
-		if ($line =3D~ /^\+/) {
+		if ($line =3D~ /^[^-+ ]*\+/) {
  			$n_cnt++;
  			push @line, $line;
  			next;
@@ -501,7 +529,7 @@ sub merge_hunk {

  	for ($i =3D 1; $i < @{$this->{TEXT}}; $i++) {
  		my $line =3D $this->{TEXT}[$i];
-		if ($line =3D~ /^\+/) {
+		if ($line =3D~ /^[^-+ ]*\+/) {
  			$n_cnt++;
  			push @line, $line;
  			next;
@@ -544,7 +572,7 @@ sub coalesce_overlapping_hunks {
  }

  sub help_patch_cmd {
-	print <<\EOF ;
+	my $help =3D <<\EOF ;
  y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks
@@ -555,6 +583,7 @@ k - leave this hunk undecided, see previous =20
undecided hunk
  K - leave this hunk undecided, see previous hunk
  s - split the current hunk into smaller hunks
  EOF
+	print_ansi_color "blue", $_, "\n" foreach (split /[\r\n]/, $help);
  }

  sub patch_update_cmd {
@@ -619,7 +648,7 @@ sub patch_update_cmd {
  		for (@{$hunk[$ix]{TEXT}}) {
  			print;
  		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_ansi_color "bold", "Stage this hunk [y/n/a/d$other/?]? ";
  		my $line =3D <STDIN>;
  		if ($line) {
  			if ($line =3D~ /^y/i) {
