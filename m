From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] svmimport: avoid open "-|" list form for Perl 5.6
Date: Mon, 20 Feb 2006 14:12:32 -0800
Message-ID: <7vek1xaddb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:13:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJH7-0007iL-83
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWBTWMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWBTWMh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:12:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33494 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932680AbWBTWMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:12:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220221239.HPMS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:12:39 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16504>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-svnimport.perl |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

f7e8f8415c5c88082daecac44cfbba561113a3d9
diff --git a/git-svnimport.perl b/git-svnimport.perl
index c536d70..ee2940f 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -10,7 +10,6 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
 
-require 5.008; # for shell-safe open("-|",LIST)
 use strict;
 use warnings;
 use Getopt::Std;
@@ -322,8 +321,12 @@ sub get_file($$$) {
 		return undef unless defined $name;
 	}
 
-	open my $F, '-|', "git-hash-object", "-w", $name
+	my $pid = open(my $F, '-|');
+	die $! unless defined $pid;
+	if (!$pid) {
+	    exec("git-hash-object", "-w", $name)
 		or die "Cannot create object: $!\n";
+	}
 	my $sha = <$F>;
 	chomp $sha;
 	close $F;
@@ -398,7 +401,12 @@ sub copy_path($$$$$$$$) {
 			$srcpath =~ s#/*$#/#;
 	}
 	
-	open my $f,"-|","git-ls-tree","-r","-z",$gitrev,$srcpath;
+	my $pid = open my $f,'-|';
+	die $! unless defined $pid;
+	if (!$pid) {
+		exec("git-ls-tree","-r","-z",$gitrev,$srcpath)
+			or die $!;
+	}
 	local $/ = "\0";
 	while(<$f>) {
 		chomp;
@@ -554,7 +562,11 @@ sub commit {
 				@o1 = @old;
 				@old = ();
 			}
-			open my $F, "-|", "git-ls-files", "-z", @o1 or die $!;
+			my $pid = open my $F, "-|";
+			die "$!" unless defined $pid;
+			if (!$pid) {
+				exec("git-ls-files", "-z", @o1) or die $!;
+			}
 			@o1 = ();
 			local $/ = "\0";
 			while(<$F>) {
-- 
1.2.2.g5be4ea
