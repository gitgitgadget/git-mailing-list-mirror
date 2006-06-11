From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/5] git-svn: eol_cp corner-case fixes
Date: Sun, 11 Jun 2006 00:03:43 -0700
Message-ID: <11500094292561-git-send-email-normalperson@yhbt.net>
References: <11500094252972-git-send-email-normalperson@yhbt.net> <11500094271080-git-send-email-normalperson@yhbt.net> <11500094281515-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzN-0005iD-6M
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWFKHDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFKHDx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:30641 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750880AbWFKHDv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:51 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0852E7DC005;
	Sun, 11 Jun 2006 00:03:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:49 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
In-Reply-To: <11500094281515-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21635>

If we read the maximum size of our buffer into $buf, and the
last character is '\015', there's a chance that the character is
'\012', which means our regex won't work correctly.  At the
worst case, this could introduce an extra newline into the code.
We'll now read an extra character if we see '\015' is the last
character in $buf.

We also forgot to recalculate the length of $buf after doing the
newline substitution, causing some files to appeare truncated.
We'll do that now and force byte semantics in length() for good
measure.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 7ed11ef..8d2e7f7 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -866,19 +866,26 @@ sub eol_cp {
 	binmode $wfd or croak $!;
 
 	my $eol = $EOL{$es} or undef;
-	if ($eol) {
-		print  "$eol: $from => $to\n";
-	}
 	my $buf;
+	use bytes;
 	while (1) {
 		my ($r, $w, $t);
 		defined($r = sysread($rfd, $buf, 4096)) or croak $!;
 		return unless $r;
-		$buf =~ s/(?:\015|\012|\015\012)/$eol/gs if $eol;
+		if ($eol) {
+			if ($buf =~ /\015$/) {
+				my $c;
+				defined($r = sysread($rfd,$c,1)) or croak $!;
+				$buf .= $c if $r > 0;
+			}
+			$buf =~ s/(?:\015\012|\015|\012)/$eol/gs;
+			$r = length($buf);
+		}
 		for ($w = 0; $w < $r; $w += $t) {
 			$t = syswrite($wfd, $buf, $r - $w, $w) or croak $!;
 		}
 	}
+	no bytes;
 }
 
 sub do_update_index {
-- 
1.3.3.g2dc7b-dirty
