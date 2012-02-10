From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] diff-highlight: Work for multiline changes too
Date: Fri, 10 Feb 2012 22:47:13 +0100
Message-ID: <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <20120210213209.GA7582@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 22:47:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvyJQ-0006lQ-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760243Ab2BJVrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:47:19 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52617 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759185Ab2BJVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:47:19 -0500
Received: by eekc14 with SMTP id c14so1101763eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ktSKDHQqSf00NiPvqPdgvU+ASQ06qYmYnSlIrHFPggk=;
        b=nnn5bWxwtI3qbW4Vy7dxFwsJWIRr3mAbS0zx15TvSpO1tCZt5XhKVi0kPPVVOBM05K
         fH+v0hdt6kLk/2Vl3daDZFGhBcJsANo9pT2mXpzPDLSBR64Yt9kFbbh4H3QKyHoGjxu6
         +kfCCSBHrji+Z8MlnCmGFljhjgLUy4PhxqCrM=
Received: by 10.213.7.67 with SMTP id c3mr1358118ebc.31.1328910437911;
        Fri, 10 Feb 2012 13:47:17 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm26843408eeb.7.2012.02.10.13.47.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:47:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <20120210213209.GA7582@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190464>

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

After looking at outputs I noticed that it can also ignore lines with
prefixes/suffixes that consist only of punctuation (asterisk, semicolon=
, dot,
etc), because otherwise whole line is highlighted except for terminatin=
g
punctuation.

 contrib/diff-highlight/diff-highlight |   96 ++++++++++++++++++++++---=
--------
 1 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highl=
ight/diff-highlight
index d893898..4811550 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,28 +1,40 @@
 #!/usr/bin/perl
=20
+use warnings;
+use strict;
+
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
 my $HIGHLIGHT   =3D "\x1b[7m";
 my $UNHIGHLIGHT =3D "\x1b[27m";
 my $COLOR =3D qr/\x1b\[[0-9;]*m/;
=20
-my @window;
+my $context;
+my @removed =3D ();
+my @added =3D ();
+my $started =3D 0;
=20
 while (<>) {
-	# We highlight only single-line changes, so we need
-	# a 4-line window to make a decision on whether
-	# to highlight.
-	push @window, $_;
-	next if @window < 4;
-	if ($window[0] =3D~ /^$COLOR*(\@| )/ &&
-	    $window[1] =3D~ /^$COLOR*-/ &&
-	    $window[2] =3D~ /^$COLOR*\+/ &&
-	    $window[3] !~ /^$COLOR*\+/) {
-		print shift @window;
-		show_pair(shift @window, shift @window);
-	}
-	else {
-		print shift @window;
+	if (/^$COLOR*-/) {
+		push @removed, $_;
+	} elsif (/^$COLOR*\+/) {
+		push @added, $_;
+	} else {
+		if ($started =3D=3D 1 ) {
+			show_pairs(\@removed, \@added);
+		} else {
+			print @removed;
+			print @added;
+		}
+		@removed =3D ();
+		@added =3D ();
+		print $_;
+
+		if (/^$COLOR*(\@| )/) {
+			$started =3D 1;
+		} else {
+			$started =3D 0;
+		}
 	}
=20
 	# Most of the time there is enough output to keep things streaming,
@@ -38,23 +50,33 @@ while (<>) {
 	}
 }
=20
-# Special case a single-line hunk at the end of file.
-if (@window =3D=3D 3 &&
-    $window[0] =3D~ /^$COLOR*(\@| )/ &&
-    $window[1] =3D~ /^$COLOR*-/ &&
-    $window[2] =3D~ /^$COLOR*\+/) {
-	print shift @window;
-	show_pair(shift @window, shift @window);
-}
-
-# And then flush any remaining lines.
-while (@window) {
-	print shift @window;
-}
+show_pairs(\@removed, \@added);
=20
 exit 0;
=20
-sub show_pair {
+sub show_pairs {
+	my $a =3D shift;
+	my $b =3D shift;
+
+	if (scalar(@{$a}) =3D=3D scalar(@{$b}) && scalar(@${a}) > 0) {
+		my @removed;
+		my @added;
+
+		for(my $i =3D 0; $i < scalar(@{$a}); $i++) {
+			my ($rm, $add) =3D highlight_pair($a->[$i], $b->[$i]);
+			push @removed, $rm;
+			push @added, $add;
+		}
+
+		print @removed;
+		print @added;
+	} else {
+		print @{$a};
+		print @{$b};
+	}
+}
+
+sub highlight_pair {
 	my @a =3D split_line(shift);
 	my @b =3D split_line(shift);
=20
@@ -101,8 +123,20 @@ sub show_pair {
 		}
 	}
=20
-	print highlight(\@a, $pa, $sa);
-	print highlight(\@b, $pb, $sb);
+	my $prefa =3D join('', @a[0..($pa-1)]);
+	my $prefb =3D join('', @b[0..($pb-1)]);
+	my $sufa =3D join('', @a[($sa+1)..$#a]);
+	my $sufb =3D join('', @b[($sb+1)..$#b]);
+
+	# Highlight only if prefix or suffix is interesting (i.e. not consist=
ing
+	# of color and (for prefix) +/-). Otherwise we would highlight whole
+	# lines.
+	if ($prefa =3D~ /^($COLOR)*-(\s|$COLOR)*$/ && $sufa =3D~ /^(\s|$COLOR=
)*$/
+		&& $prefb =3D~ /^($COLOR)*\+(\s|$COLOR)*$/ && $sufb =3D~ /^(\s|$COLO=
R)*$/) {
+		return join('', @a), join('', @b);
+	} else {
+		return highlight(\@a, $pa, $sa), highlight(\@b, $pb, $sb);
+	}
 }
=20
 sub split_line {
--=20
1.7.3.4
