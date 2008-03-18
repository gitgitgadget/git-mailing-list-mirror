From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: [patch] Import "git-forest" into contrib/
Date: Tue, 18 Mar 2008 19:25:38 +0100 (CET)
Message-ID: <alpine.LNX.1.00.0803181924560.8851@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4rC-0004ng-Jl
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbYCSUEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYCSUEH
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:04:07 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:41444 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbYCSUEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:04:05 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 5A67C1802E646; Tue, 18 Mar 2008 19:25:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 418521C00E290
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 19:25:39 +0100 (CET)
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77532>

commit b6612a2efe93660be7ecdb799625015efedadff1
Author: Jan Engelhardt <jengelh@computergmbh.de>
Date:   Tue Mar 18 19:24:33 2008 +0100

     Import "git-forest" into contrib/

diff --git a/contrib/git-forest/git-forest b/contrib/git-forest/git-for=
est
new file mode 100755
index 0000000..f5d6f81
--- /dev/null
+++ b/contrib/git-forest/git-forest
@@ -0,0 +1,391 @@
+#!/usr/bin/perl
+#
+#	git-=E6=A3=AE=E6=9E=97
+#	text-based tree visualisation
+#	Copyright =C2=A9 Jan Engelhardt <jengelh [at] gmx de>, 2008
+#
+#	This program is free software; you can redistribute it and/or modify
+#	it under the terms of the GNU General Public License as published by
+#	the Free Software Foundation; either version 2 or 3 of the license.
+#
+use Getopt::Long;
+use Git;
+use strict;
+use encoding "utf8";
+my $Repo     =3D Git->repository($ENV{"GIT_DIR"} || ".");
+my $Style    =3D 2;
+my $With_sha =3D 0;
+my %Color    =3D (
+	"default" =3D> "\e[0m",
+	"at"      =3D> "\e[1;30m",
+	"head"    =3D> "\e[1;32m",
+	"ref"     =3D> "\e[1;34m",
+	"remote"  =3D> "\e[1;35m",
+	"sha"     =3D> "\e[0;31m",
+	"tag"     =3D> "\e[1;33m",
+	"tree"    =3D> "\e[0;33m",
+);
+
+&main();
+
+sub main ()
+{
+	&Getopt::Long::Configure(qw(bundling pass_through));
+	&GetOptions(
+		"no-color" =3D> sub { %Color =3D (); },
+		"style=3Di"  =3D> \$Style,
+		"sha"      =3D> \$With_sha,
+	);
+	&process();
+}
+
+sub process ()
+{
+	my(@vine);
+	my $refs =3D &get_refs();
+	my($fh, $fhc) =3D $Repo->command_output_pipe("log", "--date-order",
+	                "--pretty=3Dformat:<%H><%h><%P>%s", @ARGV);
+
+	while (defined(my $line =3D <$fh>)) {
+		chomp $line;
+		my($sha, $mini_sha, $parents, $msg) =3D
+			($line =3D~ /^<(.*?)><(.*?)><(.*?)>(.*)/s);
+		my @parents =3D split(" ", $parents);
+
+		&vine_branch(\@vine, $sha);
+		my $ra =3D &vine_commit(\@vine, $sha, \@parents);
+
+		if (exists($refs->{$sha})) {
+			print &vis_post(&vis_commit($ra,
+			      $Color{at}."=E2=94=80".$Color{default}));
+			&ref_print($refs->{$sha});
+		} else {
+			print &vis_post(&vis_commit($ra, " "));
+		}
+		if ($With_sha) {
+			print $msg, $Color{at}, "=E2=94=80=E2=94=80(", $Color{sha}, $mini_s=
ha,
+			      $Color{at}, ")", $Color{default}, "\n";
+		} else {
+			print $msg, "\n";
+		}
+
+		&vine_merge(\@vine, $sha, \@parents);
+	}
+	$Repo->command_close_pipe($fh, $fhc);
+}
+
+sub get_refs ()
+{
+	my($fh, $c) =3D $Repo->command_output_pipe("show-ref");
+	my $ret =3D {};
+
+	while (defined(my $ln =3D <$fh>)) {
+		chomp $ln;
+		if (length($ln) =3D=3D 0) {
+			next;
+		}
+
+		my($sha, $name) =3D ($ln =3D~ /^(\S+)\s+(.*)/s);
+		if (!exists($ret->{$sha})) {
+			$ret->{$sha} =3D [];
+		}
+		push(@{$ret->{$sha}}, $name);
+		if ($name =3D~ m{^refs/tags/}) {
+			my $sub_sha =3D $Repo->command("log", "-1",
+			              "--pretty=3Dformat:%H", $name);
+			chomp $sub_sha;
+			if ($sha ne $sub_sha) {
+				push(@{$ret->{$sub_sha}}, $name);
+			}
+		}
+	}
+
+	$Repo->command_close_pipe($fh, $c);
+	return $ret;
+}
+
+sub ref_print ($)
+{
+	foreach my $symbol (@{shift @_}) {
+		print $Color{at}, "[";
+		if ($symbol =3D~ m{^refs/(remotes/[^/]+)/(.*)}s) {
+			print $Color{remote}, $1, $Color{head}, "/$2";
+		} elsif ($symbol =3D~ m{^refs/heads/(.*)}s) {
+			print $Color{head}, $1;
+		} elsif ($symbol =3D~ m{^refs/tags/(.*)}s) {
+			print $Color{tag}, $1;
+		} elsif ($symbol =3D~ m{^refs/(.*)}s) {
+			print $Color{ref}, $1;
+		}
+		print $Color{at}, "]=E2=94=80=E2=94=80", $Color{default};
+	}
+}
+
+sub vine_branch ($$)
+{
+	my($vine, $rev) =3D @_;
+	my $idx;
+
+	my $left =3D "=E2=95=A0";
+	my $matched =3D 0;
+	my $ret;
+
+	for ($idx =3D 0; $idx < scalar(@$vine); ++$idx) {
+		if (!defined($vine->[$idx])) {
+			$ret .=3D "=E2=95=90";
+			next;
+		} elsif ($vine->[$idx] ne $rev) {
+			$ret .=3D "=E2=95=AA";
+			next;
+		}
+		if ($matched =3D=3D 0) {
+			$ret .=3D "=E2=95=A0";
+		} else {
+			$ret .=3D "=E2=95=A9";
+			$vine->[$idx] =3D undef;
+		}
+		++$matched;
+	}
+
+	if ($matched < 2) {
+		return;
+	}
+
+	while (!defined($vine->[$#$vine])) {
+		pop(@$vine);
+	}
+
+	print &vis_post(&vis_branch($ret)), "\n";
+}
+
+sub vine_commit ($$$)
+{
+	my($vine, $rev, $parents) =3D @_;
+	my $ret;
+
+	for (my $i =3D 0; $i <=3D $#$vine; ++$i) {
+		if (!defined($vine->[$i])) {
+			$ret .=3D " ";
+		} elsif ($vine->[$i] eq $rev) {
+			$ret .=3D "=E2=95=9F";
+		} else {
+			$ret .=3D "=E2=95=91";
+		}
+	}
+
+	if ($ret !~ /=E2=95=9F/) {
+		# Not having produced a =E2=95=9F before means this is a HEAD
+		$ret .=3D "=E2=95=93";
+		push(@$vine, $rev);
+	}
+
+	while (scalar(@$vine) > 0 && !defined($vine->[$#$vine])) {
+		pop(@$vine);
+	}
+
+	if (scalar(@$parents) =3D=3D 0) {
+		# tree root
+		$ret =3D~ s/=E2=95=9F/=E2=95=99/g;
+	}
+
+	return $ret;
+}
+
+#
+#	Generate vine graphics for a merge
+#
+sub vine_merge ($$$)
+{
+	my($vine, $rev, $parents) =3D @_;
+	my $orig_vine =3D -1;
+	my @slot;
+	my($ret, $max);
+
+	for (my $i =3D 0; $i <=3D $#$vine; ++$i) {
+		if ($vine->[$i] eq $rev) {
+			$orig_vine =3D $i;
+			last;
+		}
+	}
+
+	if ($orig_vine =3D=3D -1) {
+		die "vine_commit() did not add this vine.";
+	}
+
+	if (scalar(@$parents) <=3D 1) {
+		#
+		# A single parent does not need a visual. Update and return.
+		#
+		$vine->[$orig_vine] =3D $parents->[0];
+
+		while (scalar(@$vine) > 0 && !defined($vine->[$#$vine])) {
+			pop(@$vine);
+		}
+		return;
+	}
+
+	#
+	# Find some good spots to split out into.
+	#
+	push(@slot, $orig_vine);
+	my $parent =3D 0;
+
+	for (my $seeker =3D 2; $parent < $#$parents &&
+	    $seeker < 2 + 2 * $#$vine; ++$seeker)
+	{
+		my $idx =3D ($seeker % 2 =3D=3D 0) ? -1 : 1;
+		$idx   *=3D int($seeker / 2);
+		$idx   +=3D $orig_vine;
+
+		if ($idx >=3D 0 && $idx <=3D $#$vine && !defined($vine->[$idx])) {
+			push(@slot, $idx);
+			++$parent;
+		}
+	}
+	for (my $idx =3D $orig_vine + 1; $parent < $#$parents; ++$idx) {
+		if (!defined($vine->[$idx])) {
+			push(@slot, $idx);
+			++$parent;
+		}
+	}
+
+	if (scalar(@slot) !=3D scalar(@$parents)) {
+		die "Serious internal problem";
+	}
+
+	@slot =3D sort { $a <=3D> $b } @slot;
+	$max  =3D scalar(@$vine) + scalar(@slot);
+
+	for (my $i =3D 0; $i < $max; ++$i) {
+		if ($#slot >=3D 0 && $i =3D=3D $slot[0]) {
+			shift @slot;
+			$vine->[$i] =3D shift @$parents;
+			$ret .=3D ($i =3D=3D $orig_vine) ? "S" : "s";
+		} elsif (defined($vine->[$i])) {
+			$ret .=3D "=E2=95=91";
+		} else {
+			$ret .=3D " ";
+		}
+
+	}
+
+	$ret =3D~ s/ +$//gs;
+	print &vis_post(&vis_merge($ret)), "\n";
+}
+
+sub vis_branch ($)
+{
+	# Sample input: =E2=95=AC=E2=95=90=E2=95=A0=E2=95=AC=E2=95=AC=E2=95=AC=
=E2=95=A9=E2=95=AC=E2=95=90=E2=95=AC=E2=95=AC=E2=95=AC=E2=95=AC=E2=95=AC=
=E2=95=AC=E2=95=A9=E2=95=AC=E2=95=A9=E2=95=90=E2=95=AC=E2=95=AC
+	my $ra =3D shift @_;
+	my $i;
+
+	$ra =3D~ s{^(.+?)=E2=95=A0}{
+		$_ =3D $1;
+		$_ =3D~ tr/=E2=95=AA=E2=95=90/=E2=95=91 /;
+		$_ =3D~ s/(.)/$1 /gs;
+		$_ .=3D '=E2=95=A0';
+	}es;
+	$ra =3D~ s{(=E2=95=A0.*)=E2=95=A9}{
+		$_ =3D $1;
+		$_ =3D~ s/(.)/$1=E2=95=90/gs;
+		$_ .=3D '=E2=95=9D';
+	}es;
+	$ra =3D~ s{=E2=95=9D(.*)$}{
+		$_ =3D $1;
+		$_ =3D~ tr/=E2=95=AA=E2=95=90/=E2=95=91 /;
+		$_ =3D~ s/(.)/$1 /gs;
+		$_ =3D "=E2=95=9D $_";
+	}es;
+	return $ra;
+}
+
+sub vis_commit ($$)
+{
+	my($ra, $sep) =3D @_;
+	my($l, $r) =3D ($ra =3D~ /^(.*?)([=E2=95=9F=E2=95=93=E2=95=99].*)/);
+	$l =3D~ s/(.)/$1 /gs;
+	$r =3D~ s/(.)/$1 /gs;
+	$r =3D~ s/ /$sep/gs;
+	return $l.$r;
+}
+
+sub vis_merge ($)
+{
+	my $s =3D shift @_;
+
+	if ($s =3D~ s/(s.*)S(.*s)/&vis_merge3($1, $2)/es) {
+		;
+	} elsif ($s =3D~ /(?:s.*)S/s) {
+		while ($s =3D~ s/(s.*)=E2=95=91(.*S)/$1=E2=95=AA$2/s) {
+			;
+		}
+		$s =3D~ s/(s.*)S/&vis_merge2L($1)."=E2=95=A3"/es;
+	} elsif ($s =3D~ /S(?:.*s)/s) {
+		while ($s =3D~ s/(S.*)=E2=95=91(.*s)/$1=E2=95=AA$2/s) {
+			;
+		}
+		$s =3D~ /S(.*s)/;
+		$s =3D~ s/S(.*s)/"=E2=95=A0".&vis_merge2R($1)/es;
+	} else {
+		# $s =3D~ s/S/=E2=95=91/s;
+		die "Should not come here";
+	}
+	$s =3D~ s{(.)}{&vis_merge1($1)}egs;
+	return $s;
+}
+
+sub vis_merge1 ($)
+{
+	if ($_[0] eq "=E2=95=94" || $_[0] eq "=E2=95=A6" || $_[0] eq "=E2=95=A0=
" || $_[0] eq "=E2=95=AA") {
+		return $_[0]."=E2=95=90";
+	} else {
+		return $_[0]." ";
+	}
+}
+
+sub vis_merge2L ($)
+{
+	my $l =3D shift @_;
+	$l =3D~ s/^s/=E2=95=94/;
+	$l =3D~ s/s/=E2=95=A6/g;
+	return $l;
+}
+
+sub vis_merge2R ($)
+{
+	my $r =3D shift @_;
+	$r =3D~ s/s$/=E2=95=97/;
+	$r =3D~ s/s/=E2=95=A6/g;
+	return $r;
+}
+
+sub vis_merge3 ($$)
+{
+	my($l, $r) =3D shift @_;
+	$l =3D~ s/^s/=E2=95=94/;
+	$l =3D~ s/s/=E2=95=A6/g;
+	$r =3D~ s/s$/=E2=95=97/;
+	$r =3D~ s/s/=E2=95=A6/g;
+	return "$l=E2=95=AA$r";
+}
+
+#
+#	post-process vine graphic
+#
+sub vis_post ($)
+{
+	my $s =3D shift @_;
+
+	if ($Style =3D=3D 1) {
+		$s =3D~ tr/=E2=95=94=E2=95=A6=E2=95=97=E2=95=A0=E2=95=AC=E2=95=A3=E2=
=95=9A=E2=95=A9=E2=95=9D=E2=95=91=E2=95=90=E2=95=9F=E2=95=93=E2=95=99=E2=
=95=AA/=E2=94=8C=E2=94=AC=E2=94=90=E2=94=9C=E2=94=BC=E2=94=A4=E2=94=94=E2=
=94=B4=E2=94=98=E2=94=82=E2=94=80=E2=94=9C=E2=94=8C=E2=94=94=E2=94=BC/;
+	} elsif ($Style =3D=3D 2) {
+		$s =3D~ tr/=E2=95=AA/=E2=95=AC/;
+	} elsif ($Style =3D=3D 3) {
+		$s =3D~ tr/=E2=95=94=E2=95=A6=E2=95=97=E2=95=A0=E2=95=AC=E2=95=A3=E2=
=95=9A=E2=95=A9=E2=95=9D=E2=95=91=E2=95=9F=E2=95=93=E2=95=99/=E2=95=92=E2=
=95=A4=E2=95=95=E2=95=9E=E2=95=AA=E2=95=A1=E2=95=98=E2=95=A7=E2=95=9B=E2=
=94=82=E2=94=9C=E2=94=8C=E2=94=94/;
+	}
+
+	if ($Color{default} ne "") {
+		$s =3D~ s{\Q$Color{default}\E}{$&$Color{tree}}g;
+	}
+	return $Color{tree}, $s, $Color{default};
+}
diff --git a/contrib/git-forest/git-forest.txt b/contrib/git-forest/git=
-forest.txt
new file mode 100644
index 0000000..0adfd6d
--- /dev/null
+++ b/contrib/git-forest/git-forest.txt
@@ -0,0 +1,34 @@
+
+Options:
+
+--style=3D1
+	Use single-line visuals
+--style=3D2
+	Use double-line visuals (default)
+--style=3D3
+	Use single-line visuals in vertical direction,
+	and double-line ones in horizontal direction.
+--sha
+	Display SHAs for each commit
+
+All other options and arguments are passed down to git-log.
+Commonly useful are --all and --topo-order; along with the
+tag name or commit range.
+
+This tool does not try to minimize the empty space between branches
+like gitk does. Take it as a feature.
+
+Notes on interpretation:
+
+'=E2=95=AC' (or variants thereof, like =E2=95=AA) is meant to be a "pa=
th bridge", i.e.
+traversal is only "allowed" horizontal OR vertical direction.
+
+Branching:
+C D E F G
+=E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=90=
=E2=95=9D  A->{C,E,F,G} and B->D.
+A B
+
+Merging:
+E F
+=E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=A6=E2=95=90=E2=95=97    {A,=
C,D}->E, B->F.
+A B C D
