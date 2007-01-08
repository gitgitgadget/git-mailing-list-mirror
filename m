From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: skip commits that are too recent
Date: Mon,  8 Jan 2007 19:43:39 +1300
Message-ID: <11682386193246-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 08 07:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3oEP-0002of-6u
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 07:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAHGnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 01:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbXAHGnh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 01:43:37 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:50573 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAHGnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 01:43:37 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1H3oEG-0007NB-UD; Mon, 08 Jan 2007 19:43:33 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1H3oEN-0005yV-00; Mon, 08 Jan 2007 19:43:39 +1300
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.5.0.rc0.g4017-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36238>

With this patch, cvsimport will skip commits made
in the last 10 minutes. The recent-ness test is of
5 minutes + cvsps fuzz window (5 minutes default).

To force recent commits to be imported, pass the
-a(ll) flag.

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
 Documentation/git-cvsimport.txt |    7 ++++++-
 git-cvsimport.perl              |   20 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index d21d66b..6deee94 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -90,7 +90,8 @@ If you need to pass multiple options, separate them with a comma.
 	Print a short usage message and exit.
 
 -z <fuzz>::
-        Pass the timestamp fuzz factor to cvsps.
+	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
+	cvsps defaults to 300s.
 
 -s <subst>::
 	Substitute the character "/" in branch names with <subst>
@@ -99,6 +100,10 @@ If you need to pass multiple options, separate them with a comma.
 	CVS by default uses the unix username when writing its
 	commit logs. Using this option and an author-conv-file
 	in this format
+
+-a::
+	Import all commits, including recent ones. cvsimport by default
+	skips commits that have a timestamp less than 10 minutes ago.
 +
 ---------
 	exon=Andreas Ericsson <ae@op5.se>
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index c5bf2d1..a75aaa3 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a);
 my (%conv_author_name, %conv_author_email);
 
 sub usage() {
@@ -37,7 +37,7 @@ sub usage() {
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz] [-i] [-k] [-u]
-       [-s subst] [-m] [-M regex] [-S regex] [CVS_module]
+       [-s subst] [-a] [-m] [-M regex] [-S regex] [CVS_module]
 END
 	exit(1);
 }
@@ -105,6 +105,8 @@ if ($opt_d) {
 }
 $opt_o ||= "origin";
 $opt_s ||= "-";
+$opt_a ||= 0;
+
 my $git_tree = $opt_C;
 $git_tree ||= ".";
 
@@ -129,6 +131,11 @@ if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
 }
 
+# Remember UTC of our starting time
+# we'll want to avoid importing commits
+# that are too recent
+our $starttime = time();
+
 select(STDERR); $|=1; select(STDOUT);
 
 
@@ -824,6 +831,15 @@ while (<CVS>) {
 			$state = 11;
 			next;
 		}
+		if ( !$opt_a && $starttime - 300 - (defined $opt_z ? $opt_z : 300) <= $date) {
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
