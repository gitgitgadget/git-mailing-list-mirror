From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: add "import only" option
Date: Mon, 11 Jul 2005 16:57:49 +0200
Message-ID: <20050711145749.GF9370MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 20:12:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds2kb-00075P-7Z
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 20:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVGKSK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGKPTL
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 11:19:11 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:42639 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261975AbVGKPR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 11:17:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 879D833E8B
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 17:17:25 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 9450F33E8C
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 17:17:23 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 87121AED85
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 17:17:23 +0200 (CEST)
Received: (qmail 20017 invoked by uid 500); 11 Jul 2005 14:57:49 -0000
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: add "import only" option.

Acked-by: Matthias Urlichs <smurf@smurf.noris.de>
Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit 1be6fbebb010083a083d8e2ee69fced7b6ae1261
tree a69017b2d10fd0a2655070d177f7cf59ab21882f
parent a3eb250f996bf5e12376ec88622c4ccaabf20ea8
author Sven Verdoolaege <skimo@kotnet.org> Mon, 11 Jul 2005 16:17:25 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 11 Jul 2005 16:17:25 +0200

 Documentation/git-cvsimport-script.txt |    7 ++++++-
 git-cvsimport-script                   |   18 +++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			[ -C <GIT_repository> ] [ <CVS_module> ]
+			[ -C <GIT_repository> ] [ -i ] [ <CVS_module> ]
 
 
 DESCRIPTION
@@ -29,6 +29,11 @@ OPTIONS
 	currently, only the :local:, :ext: and :pserver: access methods 
 	are supported.
 
+-i::
+	Import-only: don't perform a checkout after importing.  This option
+	ensures the working directory and cache remain untouched and will
+	not create them if they do not exist.
+
 -o <branch-for-HEAD>::
 	The 'HEAD' branch from CVS is imported to the 'origin' branch within
 	the git repository, as 'HEAD' already has a special meaning for git.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C,$opt_z);
+our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
        [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ CVS_module ]
+       [ -i ] [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hvo:d:p:C:z:") or usage();
+getopts("hivo:d:p:C:z:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -723,8 +723,10 @@ if($orig_branch) {
 	print "DONE\n" if $opt_v;
 	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
 		if $forward_master;
-	system('git-read-tree', '-m', '-u', 'CVS2GIT_HEAD', 'HEAD');
-	die "read-tree failed: $?\n" if $?;
+	unless ($opt_i) {
+		system('git-read-tree', '-m', '-u', 'CVS2GIT_HEAD', 'HEAD');
+		die "read-tree failed: $?\n" if $?;
+	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
@@ -732,7 +734,9 @@ if($orig_branch) {
 		unless -f "$git_dir/refs/heads/master";
 	unlink("$git_dir/HEAD");
 	symlink("refs/heads/$orig_branch","$git_dir/HEAD");
-	system('git checkout');
-	die "checkout failed: $?\n" if $?;
+	unless ($opt_i) {
+		system('git checkout');
+		die "checkout failed: $?\n" if $?;
+	}
 }
 unlink("$git_dir/CVS2GIT_HEAD");
