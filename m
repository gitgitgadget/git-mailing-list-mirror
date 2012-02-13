From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] diff-highlight: don't highlight whole lines
Date: Mon, 13 Feb 2012 17:32:47 -0500
Message-ID: <20120213223247.GB19521@sigill.intra.peff.net>
References: <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4S7-0002Hk-VM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2BMWcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 17:32:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34495
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250Ab2BMWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:32:50 -0500
Received: (qmail 1884 invoked by uid 107); 13 Feb 2012 22:40:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:40:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:32:47 -0500
Content-Disposition: inline
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190683>

If you have a change like:

  -foo
  +bar

we end up highlighting the entirety of both lines (since the
whole thing is changed). But the point of diff highlighting
is to pinpoint the specific change in a pair of lines that
are mostly identical. In this case, the highlighting is just
noise, since there is nothing to pinpoint, and we are better
off doing nothing.

The implementation looks for "interesting" pairs by checking
to see whether they actually have a matching prefix or
suffix that does not simply consist of colorization and
whitespace.  However, the implementation makes it easy to
plug in other heuristics, too, like:

  1. Depending on the source material, the set of "boring"
     characters could be tweaked to include language-specific
     stuff (like braces or semicolons for C).

  2. Instead of saying "an interesting line has at least one
     character of prefix or suffix", we could require that
     less than N percent of the line be highlighted.

The simple "ignore whitespace, and highlight if there are
any matched characters" implemented by this patch seems to
give good results on git.git. I'll leave experimentation
with other heuristics to somebody who has a dataset that
does not look good with the current code.

Based on an original idea and implementation by Micha=C5=82
Kiedrowicz.

Signed-off-by: Jeff King <peff@peff.net>
---
Regarding attribution: I kept myself as author, because I rewrote it a
bit and figured that I would take primary responsibility for bugs in
this patch, and in the long run would be responsible for maintaining it=
=2E
But the idea and the substance of the patch are yours, and I would be
happy to list you as author if you prefer getting the credit that way
(after all, it bumps your shortlog numbers :) ).

The implementation is similar to yours, but pulls some of the decisions
out into a separate function to make tweaking the above heuristics
easier.

 contrib/diff-highlight/diff-highlight |   28 +++++++++++++++++++++++++=
+--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highl=
ight/diff-highlight
index c3302dd..0d8df84 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -8,6 +8,7 @@ use strict;
 my $HIGHLIGHT   =3D "\x1b[7m";
 my $UNHIGHLIGHT =3D "\x1b[27m";
 my $COLOR =3D qr/\x1b\[[0-9;]*m/;
+my $BORING =3D qr/$COLOR|\s/;
=20
 my @window;
=20
@@ -104,8 +105,14 @@ sub show_pair {
 		}
 	}
=20
-	print highlight(\@a, $pa, $sa);
-	print highlight(\@b, $pb, $sb);
+	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
+		print highlight(\@a, $pa, $sa);
+		print highlight(\@b, $pb, $sb);
+	}
+	else {
+		print join('', @a);
+		print join('', @b);
+	}
 }
=20
 sub split_line {
@@ -125,3 +132,20 @@ sub highlight {
 		@{$line}[($suffix+1)..$#$line]
 	);
 }
+
+# Pairs are interesting to highlight only if we are going to end up
+# highlighting a subset (i.e., not the whole line). Otherwise, the hig=
hlighting
+# is just useless noise. We can detect this by finding either a matchi=
ng prefix
+# or suffix (disregarding boring bits like whitespace and colorization=
).
+sub is_pair_interesting {
+	my ($a, $pa, $sa, $b, $pb, $sb) =3D @_;
+	my $prefix_a =3D join('', @$a[0..($pa-1)]);
+	my $prefix_b =3D join('', @$b[0..($pb-1)]);
+	my $suffix_a =3D join('', @$a[($sa+1)..$#$a]);
+	my $suffix_b =3D join('', @$b[($sb+1)..$#$b]);
+
+	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
+	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
+	       $suffix_a !~ /^$BORING*$/ ||
+	       $suffix_b !~ /^$BORING*$/;
+}
--=20
1.7.8.4.17.g2df81
