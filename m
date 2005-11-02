From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: introduce -P <cvsps-output-file> option
Date: Wed, 2 Nov 2005 13:48:47 +1300
Message-ID: <11308925271764-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 02 01:45:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6kW-0006AV-4u
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVKBAom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKBAom
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:44:42 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:28374 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932098AbVKBAol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:44:41 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EX6k2-0007Lr-Fw; Wed, 02 Nov 2005 13:44:38 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EX6o3-0001et-00; Wed, 02 Nov 2005 13:48:47 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10984>

-P:: <cvsps-output-file>
       Instead of calling cvsps, read the provided cvsps output file. Useful
       for debugging or when cvsps is being handled outside cvsimport.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-cvsimport.txt |    4 ++++
 git-cvsimport.perl              |   12 ++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

applies-to: a0f3f0cdfb22033b0dd52a0abc7c5cebfc17e56d
16f5165e7258fcd0dc209f7eb4e85d4222ecaaa4
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index f5248c9..a2f97b3 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -60,6 +60,10 @@ the old cvs2git tool.
 +
 If you need to pass multiple options, separate them with a comma.
 
+-P:: <cvsps-output-file>
+	Instead of calling cvsps, read the provided cvsps output file. Useful
+	for debugging or when cvsps is being handled outside cvsimport.
+
 -m::    
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the name source 
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e3cad5a..0144670 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_s,$opt_m,$opt_M);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M);
 
 sub usage() {
 	print STDERR <<END;
@@ -41,7 +41,7 @@ END
 	exit(1);
 }
 
-getopts("hivmkuo:d:p:C:z:s:M:") or usage();
+getopts("hivmkuo:d:p:C:z:s:M:P:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -494,8 +494,12 @@ unless($pid) {
 	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 		push @opt, '--cvs-direct';
 	}
-	exec("cvsps",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
-	die "Could not start cvsps: $!\n";
+	if ($opt_P) {
+	    exec("cat", $opt_P);
+	} else {
+	    exec("cvsps",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
+	    die "Could not start cvsps: $!\n";
+	}
 }
 
 
---
0.99.8.GIT
