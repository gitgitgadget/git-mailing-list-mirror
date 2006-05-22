From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: introduce -L<imit> option to workaround memory leaks
Date: Mon, 22 May 2006 23:38:08 +1200
Message-ID: <11482978883713-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon May 22 13:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi8ee-0000UQ-My
	for gcvg-git@gmane.org; Mon, 22 May 2006 13:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWEVLcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWEVLcx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 07:32:53 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:47270 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750758AbWEVLcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 07:32:53 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fi8eX-00028U-D6; Mon, 22 May 2006 23:32:49 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1Fi8jh-0003KN-00; Mon, 22 May 2006 23:38:09 +1200
To: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de,
	torvals@osdl.org, spyderous@gentoo.org, smurf@smurf.noris.de
X-Mailer: git-send-email 1.3.0.g9927-dirty
In-Reply-To: Pine.LNX.4.64.0605220203200.3697@g5.osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20499>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---
This is ugly, but while I work on cleaning up the leak
that seems to be somewhere in the commit() sub, we may
as well set up a workaround.

I am not 100% happy woth including this in git.git. 
In any case, I hope we can revert it soon.

---

 git-cvsimport.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

64ea3c83d8cd176ee972055bd1d11f398655dad8
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index c0ae00b..c1923d1 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L);
 my (%conv_author_name, %conv_author_email);
 
 sub usage() {
@@ -85,7 +85,7 @@ sub write_author_info($) {
 	close ($f);
 }
 
-getopts("hivmkuo:d:p:C:z:s:M:P:A:S:") or usage();
+getopts("hivmkuo:d:p:C:z:s:M:P:A:S:L:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -716,6 +716,7 @@ my $commit = sub {
 	}
 };
 
+my $commitcount = 1;
 while(<CVS>) {
 	chomp;
 	if($state == 0 and /^-+$/) {
@@ -849,6 +850,9 @@ #	VERSION:1.96->1.96.2.1
 	} elsif($state == 9 and /^\s*$/) {
 		$state = 10;
 	} elsif(($state == 9 or $state == 10) and /^-+$/) {
+		if ($opt_L && $commitcount++ >= $opt_L) {
+			last;
+		}
 		&$commit();
 		$state = 1;
 	} elsif($state == 11 and /^-+$/) {
-- 
1.3.2.g82000
