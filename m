From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] Make specification of CVS module to convert optional.
Date: Sun, 3 Jul 2005 12:36:54 +0200
Message-ID: <20050703103654.GK5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 12:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp26Z-0002sT-Ai
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 12:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVGCKxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 06:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGCKxd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 06:53:33 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:21406 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261255AbVGCKxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 06:53:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 4173D137AD3
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:53:13 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 491F7137AC3
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:53:11 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 1F4554C2C5
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:53:11 +0200 (CEST)
Received: (qmail 17605 invoked by uid 500); 3 Jul 2005 10:36:54 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make specification of CVS module to convert optional.

If we're inside a checked out CVS repository, there is
no need to explicitly specify the module as it is
available in CVS/Repository.
Also read CVS/Root if it's available and -d is not specified.
Finally, explicitly pass root to cvsps as CVS/Root takes
precedence over CVSROOT.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit f9714a4a0cd4ed0ccca3833743d98ea874a2232d
tree de5d7bba63538f29b8ea2b801d932b7679289b96
parent 1cd3674add10d1e511446f3034a1d233a3da7eab
author Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 11:34:59 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 11:40:44 +0200

 Documentation/git-cvsimport-script.txt |    2 +-
 git-cvsimport-script                   |   34 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			<CVS_module> [ <GIT_repository> ]
+			[ -C <GIT_repository> ] [ <CVS_module> ]
 
 
 DESCRIPTION
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -26,35 +26,53 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p);
+our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
 	   [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
-       [ -p opts-for-cvsps ]
-       CVS_module [ GIT_repository ]
+       [ -p opts-for-cvsps ] [ -C GIT_repository ]
+       [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hqvo:d:p:") or usage();
+getopts("hqvo:d:p:C:") or usage();
 usage if $opt_h;
 
-@ARGV == 1 or @ARGV == 2 or usage();
-
-my($cvs_tree, $git_tree) = @ARGV;
+@ARGV <= 1 or usage();
 
 if($opt_d) {
 	$ENV{"CVSROOT"} = $opt_d;
+} elsif(-f 'CVS/Root') {
+	open my $f, '<', 'CVS/Root' or die 'Failed to open CVS/Root';
+	$opt_d = <$f>;
+	chomp $opt_d;
+	close $f;
+	$ENV{"CVSROOT"} = $opt_d;
 } elsif($ENV{"CVSROOT"}) {
 	$opt_d = $ENV{"CVSROOT"};
 } else {
 	die "CVSROOT needs to be set";
 }
 $opt_o ||= "origin";
+my $git_tree = $opt_C;
 $git_tree ||= ".";
 
+my $cvs_tree;
+if ($#ARGV == 0) {
+	$cvs_tree = $ARGV[0];
+} elsif (-f 'CVS/Repository') {
+	open my $f, '<', 'CVS/Repository' or 
+	    die 'Failed to open CVS/Repository';
+	$cvs_tree = <$f>;
+	chomp $cvs_tree;
+	close $f
+} else {
+	usage();
+}
+
 select(STDERR); $|=1; select(STDOUT);
 
 
@@ -378,7 +396,7 @@ die "Cannot fork: $!\n" unless defined $
 unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
-	exec("cvsps",@opt,"-x","-A","--cvs-direct",$cvs_tree);
+	exec("cvsps",@opt,"-x","-A","--cvs-direct",'--root',$opt_d,$cvs_tree);
 	die "Could not start cvsps: $!\n";
 }
 
