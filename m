From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2nd try] Also handle CVS branches with a '/' in their name
Date: Wed, 17 Aug 2005 11:19:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508171118500.4997@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6il11wi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508170906480.10754@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vbr3x10rr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 11:20:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5K5Y-00039n-R3
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 11:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVHQJTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 05:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVHQJTW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 05:19:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11948 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751017AbVHQJTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 05:19:22 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0961EE262F; Wed, 17 Aug 2005 11:19:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E090899C22; Wed, 17 Aug 2005 11:19:20 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CACFD99C10; Wed, 17 Aug 2005 11:19:20 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4509E262F; Wed, 17 Aug 2005 11:19:20 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr3x10rr.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I track a CVS project which has a branch with a '/' in the branch name.
Since git wants the branch name to be a file name at the same time,
substitute that character to a '-' by default (override with "-s <subst>").
This should work well, despite the fact that a division and a difference
are completely different :-)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 Documentation/git-cvsimport-script.txt |    6 +++++-
 git-cvsimport-script                   |    8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

b4327595f6cd2a0a4e573ceb12983765321f4790
diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			[ -C <GIT_repository> ] [ -i ] [ -k ] [ <CVS_module> ]
+			[ -C <GIT_repository> ] [ -i ] [ -k ]
+			[ -s <subst> ] [ <CVS_module> ]
 
 
 DESCRIPTION
@@ -69,6 +70,9 @@ OPTIONS
 -z <fuzz>::
         Pass the timestamp fuzz factor to cvsps.
 
+-s <subst>::
+	Substitute the character "/" in branch names with <subst>
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_s);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
        [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ -i ] [ -k ] [ CVS_module ]
+       [ -i ] [ -k ] [-s subst] [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hivko:d:p:C:z:") or usage();
+getopts("hivko:d:p:C:z:s:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -59,6 +59,7 @@ if($opt_d) {
 	die "CVSROOT needs to be set";
 }
 $opt_o ||= "origin";
+$opt_s ||= "-";
 my $git_tree = $opt_C;
 $git_tree ||= ".";
 
@@ -621,6 +622,7 @@ while(<CVS>) {
 		$state = 4;
 	} elsif($state == 4 and s/^Branch:\s+//) {
 		s/\s+$//;
+		s/[\/]/$opt_s/g;
 		$branch = $_;
 		$state = 5;
 	} elsif($state == 5 and s/^Ancestor branch:\s+//) {
