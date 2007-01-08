From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: skip commits that are too recent
Date: Mon,  8 Jan 2007 14:11:23 +1300
Message-ID: <1168218683853-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 08 02:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jQ0-0004yE-Kf
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbXAHBfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbXAHBfR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:35:17 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:46657 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbXAHBfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:35:16 -0500
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 20:35:15 EST
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1H3j2k-0002bo-RM; Mon, 08 Jan 2007 14:11:18 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1H3j2p-00042i-00; Mon, 08 Jan 2007 14:11:23 +1300
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g4017-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36214>

With this patch, cvsimport will skip commits made
in the last 10 minutes. The recent-ness test is of
5 minutes + cvsps fuzz window (5 minutes default).

When working with a CVS repository that is in use,
importing commits that are too recent can lead to
partially incorrect trees. This is mainly due to

 - Commits that are within the cvsps fuzz window may later
   be found to have affected more files.

 - When performing incremental imports, clock drift between
   the systems may lead to skipped commits.

This commit helps keep incremental imports of in-use
CVS repositories sane.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-cvsimport.perl |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index c5bf2d1..2686775 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -129,6 +129,11 @@ if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
 }
 
+# Remember UTC of our starting time
+# we'll want to avoid importing commits
+# that are too recent
+our $starttime = time();
+
 select(STDERR); $|=1; select(STDOUT);
 
 
@@ -824,6 +829,15 @@ while (<CVS>) {
 			$state = 11;
 			next;
 		}
+		if ( $starttime - 300 - (defined $opt_z ? $opt_z : 300) <= $date) {
+			# skip if the commit is too recent
+			# that the cvsps default fuzz is 300s, we give ourselves another
+			# 300s just in case -- this also prevents skipping commits
+			# due to server clock drift
+			print "skip patchset $patchset: $date too recent\n" if $opt_v;
+			$state = 11;
+			next;
+		}
 		if (exists $ignorebranch{$branch}) {
 			print STDERR "Skipping $branch\n";
 			$state = 11;
-- 
1.5.0.rc0.g4017-dirty
