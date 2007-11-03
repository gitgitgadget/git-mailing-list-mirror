From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 1/2] Added basic color support to git add --interactive
Date: Fri, 2 Nov 2007 22:41:00 -0500
Message-ID: <20071102224100.71665182@paradox.zwell.net>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_PPvYPEyTj2rZcHem.rG.SkY
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 04:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io9tJ-00049Y-Sf
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 04:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbXKCDl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756526AbXKCDl2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 23:41:28 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:49339 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbXKCDl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 23:41:27 -0400
Received: from [143.44.70.185] (port=59543 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Io9sr-0007Kv-RL; Fri, 02 Nov 2007 22:41:20 -0500
In-Reply-To: <20071023035221.66ea537f@danzwell.com>
X-Mailer: Claws Mail 3.0.0 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63203>

--MP_PPvYPEyTj2rZcHem.rG.SkY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46rom 29b34bb32846921c9432bf1b74c93d06a0667a44 Mon Sep 17 00:00:00 2001
From: Dan Zwell <dzwell@zwell.net>
Date: Mon, 22 Oct 2007 15:55:20 -0500
Subject: [PATCH] Added basic color support to git add --interactive

Added function "print_colored" that prints text with a color that
is passed in. Converted many calls to "print" to being calls to
"print_colored".

The prompt, the header, and the help output are the 3 types of
colorized output, and each has its own color.

Colorization is done through Term::ANSIColor, which is included
with modern versions of perl. This is optional, and should not
need to be present if color.interactive is not turned on.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
I believe this version takes care of the complaints people had
with this patch. I hope this is helpful.

 Documentation/config.txt  |    6 ++++++
 git-add--interactive.perl |   42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index edf50cd..2fd783f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -382,6 +382,12 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.
=20
+color.interactive::
+	When true (or `always`), always use colors in `git add
+	--interactive`.  When false (or `never`), never.  When set to
+	`auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ac598f8..16dc7b0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,36 @@
=20
 use strict;
=20
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+my $color_config =3D qx(git config --get color.interactive);
+if ($color_config=3D~/true|always/ || -t STDOUT && $color_config=3D~/auto/=
) {
+	require Term::ANSIColor;
+
+	$use_color =3D "true";
+	# Sane (visible) defaults:
+	$prompt_color =3D Term::ANSIColor::color("blue bold");
+	$header_color =3D Term::ANSIColor::color("bold");
+	$help_color   =3D Term::ANSIColor::color("red bold");
+	$normal_color =3D Term::ANSIColor::color("reset");
+}
+
+sub print_colored {
+	my $color =3D shift;
+	my $string =3D join("", @_);
+
+	if ($use_color) {
+		# Put a color code at the beginning of each line, a reset at the end
+		# color after newlines that are not at the end of the string
+		$string =3D~ s/(\n+)(.)/$1$color$2/g;
+		# reset before newlines
+		$string =3D~ s/(\n+)/$normal_color$1/g;
+		# codes at beginning and end (if necessary):
+		$string =3D~ s/^/$color/;
+		$string =3D~ s/$/$normal_color/ unless $string =3D~ /\n$/;
+	}
+	print $string;
+}
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid =3D grep {m/[":*]/} @_;
@@ -175,7 +205,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print_colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i =3D 0; $i < @stuff; $i++) {
 			my $chosen =3D $chosen[$i] ? '*' : ' ';
@@ -205,7 +235,7 @@ sub list_and_choose {
=20
 		return if ($opts->{LIST_ONLY});
=20
-		print $opts->{PROMPT};
+		print_colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +574,7 @@ sub coalesce_overlapping_hunks {
 }
=20
 sub help_patch_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +649,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line =3D <STDIN>;
 		if ($line) {
 			if ($line =3D~ /^y/i) {
@@ -673,7 +703,7 @@ sub patch_update_cmd {
 			elsif ($other =3D~ /s/ && $line =3D~ /^s/) {
 				my @split =3D split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print_colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -766,7 +796,7 @@ sub quit_cmd {
 }
=20
 sub help_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
--=20
1.5.3.5.474.g3e4bb


--MP_PPvYPEyTj2rZcHem.rG.SkY
Content-Type: text/x-patch;
 name=0001-Added-basic-color-support-to-git-add-interactive.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Added-basic-color-support-to-git-add-interactive.patch

>From 29b34bb32846921c9432bf1b74c93d06a0667a44 Mon Sep 17 00:00:00 2001
From: Dan Zwell <dzwell@zwell.net>
Date: Mon, 22 Oct 2007 15:55:20 -0500
Subject: [PATCH] Added basic color support to git add --interactive

Added function "print_colored" that prints text with a color that
is passed in. Converted many calls to "print" to being calls to
"print_colored".

The prompt, the header, and the help output are the 3 types of
colorized output, and each has its own color.

Colorization is done through Term::ANSIColor, which is included
with modern versions of perl. This is optional, and should not
need to be present if color.interactive is not turned on.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 Documentation/config.txt  |    6 ++++++
 git-add--interactive.perl |   42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index edf50cd..2fd783f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -382,6 +382,12 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.interactive::
+	When true (or `always`), always use colors in `git add
+	--interactive`.  When false (or `never`), never.  When set to
+	`auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ac598f8..16dc7b0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,36 @@
 
 use strict;
 
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
+	require Term::ANSIColor;
+
+	$use_color = "true";
+	# Sane (visible) defaults:
+	$prompt_color = Term::ANSIColor::color("blue bold");
+	$header_color = Term::ANSIColor::color("bold");
+	$help_color   = Term::ANSIColor::color("red bold");
+	$normal_color = Term::ANSIColor::color("reset");
+}
+
+sub print_colored {
+	my $color = shift;
+	my $string = join("", @_);
+
+	if ($use_color) {
+		# Put a color code at the beginning of each line, a reset at the end
+		# color after newlines that are not at the end of the string
+		$string =~ s/(\n+)(.)/$1$color$2/g;
+		# reset before newlines
+		$string =~ s/(\n+)/$normal_color$1/g;
+		# codes at beginning and end (if necessary):
+		$string =~ s/^/$color/;
+		$string =~ s/$/$normal_color/ unless $string =~ /\n$/;
+	}
+	print $string;
+}
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -175,7 +205,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print_colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +235,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print_colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +574,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +649,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -673,7 +703,7 @@ sub patch_update_cmd {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print_colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -766,7 +796,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
-- 
1.5.3.5.474.g3e4bb


--MP_PPvYPEyTj2rZcHem.rG.SkY--
