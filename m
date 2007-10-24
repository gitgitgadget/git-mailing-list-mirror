From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Wed, 24 Oct 2007 19:28:39 -0400
Message-ID: <1193268519.8008.11.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 01:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkpgE-0007PM-3m
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 01:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbXJXXaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 19:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbXJXXaR
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 19:30:17 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:54398 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbXJXXaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 19:30:16 -0400
Received: from jankymail-a1.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by sumo.dreamhost.com (Postfix) with ESMTP id 0E9EC17DDC5
	for <git@vger.kernel.org>; Wed, 24 Oct 2007 16:30:16 -0700 (PDT)
Received: from [129.2.207.218] (rmccutch.student.umd.edu [129.2.207.218])
	by jankymail-a1.dreamhost.com (Postfix) with ESMTP id 7AF6B986E8;
	Wed, 24 Oct 2007 16:28:40 -0700 (PDT)
X-Mailer: Evolution 2.12.1 (2.12.1-3.matt1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62254>

I had a git repository for development of rsync and wanted to start
importing the upstream CVS with git-cvsimport, but git-cvsimport saw
that the git repository existed and insisted on updating a previous
import.  This patch adds an -N option to git-cvsimport to force a new
import and updates the documentation appropriately.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
I implemented this because I needed it; adopt it in the main git if you
like it.

 Documentation/git-cvsimport.txt |    5 ++++-
 git-cvsimport.perl              |    9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index fdd7ec7..f595957 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
 	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [<CVS_module>]
+	      [-r <remote>] [-N] [<CVS_module>]
 

 DESCRIPTION
@@ -144,6 +144,9 @@ It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
 gitlink:git-cvsexportcommit[1].
 
+-N::
+	Do a new import even if the git repository already exists.
+
 -h::
 	Print a short usage message and exit.
 
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2954fb8..6f03be9 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_N);
 my (%conv_author_name, %conv_author_email);
 
 sub usage(;$) {
@@ -40,7 +40,7 @@ Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [-r remote] [CVS_module]
+       [-r remote] [-N] [CVS_module]
 END
 	exit(1);
 }
@@ -114,7 +114,7 @@ sub read_repo_config {
     }
 }
 
-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
+my $opts = "haivmkuNo:d:p:r:C:z:s:M:P:A:S:L:";
 read_repo_config($opts);
 getopts($opts) or usage();
 usage if $opt_h;
@@ -563,7 +563,10 @@ unless (-d $git_dir) {
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
 	system("git-read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
+	$opt_N = 1;
+}
 
+if ($opt_N) {
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
-- 
1.5.3.3.128.g56927
