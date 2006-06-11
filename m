From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: complete the cvsps run before starting the import - take 2
Date: Sun, 11 Jun 2006 20:12:20 +1200
Message-ID: <11500135403166-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Jun 11 10:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpL3Z-00008V-OU
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 10:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFKIMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 04:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFKIMU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 04:12:20 -0400
Received: from 203-79-116-174.cable.paradise.net.nz ([203.79.116.174]:17625
	"EHLO 203-79-116-174.cable.paradise.net.nz") by vger.kernel.org
	with ESMTP id S1750794AbWFKIMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 04:12:20 -0400
Received: by 203-79-116-174.cable.paradise.net.nz (Postfix, from userid 501)
	id 624A1466FE7; Sun, 11 Jun 2006 20:12:20 +1200 (NZST)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.gcda2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21642>

On 5/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
> It's entirely possible that the fact that it now seems to work for me is
> purely timing-related, since I also ended up using "-P cvsps-output" to
> avoid having a huge cvsps binary in memory at the same time.

We now capture the output of cvsps to a tempfile, and then read it in.
cvsps 2.1 works quite a bit "in memory", and only prints its patchset info
once it has finished talking with cvs, but apparently retaining all that
memory allocation. With this patch, cvsps is finished and reaped before
cvsimport start working (and growing). So the footprint of the whole
process is much lower.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---

This is a more reliable implementation, which fork/execs and passes the cvsps
output into the tempfile.
---
 git-cvsimport.perl |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 07b3203..9a7408b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -529,25 +529,39 @@ if ($opt_A) {
 	write_author_info("$git_dir/cvs-authors");
 }
 
-my $pid = open(CVS,"-|");
-die "Cannot fork: $!\n" unless defined $pid;
-unless($pid) {
-	my @opt;
-	@opt = split(/,/,$opt_p) if defined $opt_p;
-	unshift @opt, '-z', $opt_z if defined $opt_z;
-	unshift @opt, '-q'         unless defined $opt_v;
-	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
-		push @opt, '--cvs-direct';
+
+#
+# run cvsps into a file unless we are getting
+# it passed as a file via $opt_P
+#
+unless ($opt_P) {
+	print "Running cvsps...\n" if $opt_v;
+	my $pid = open(CVSPS,"-|");
+	die "Cannot fork: $!\n" unless defined $pid;
+	unless($pid) {
+		my @opt;
+		@opt = split(/,/,$opt_p) if defined $opt_p;
+		unshift @opt, '-z', $opt_z if defined $opt_z;
+		unshift @opt, '-q'         unless defined $opt_v;
+		unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
+			push @opt, '--cvs-direct';
+		}
+		exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
+		die "Could not start cvsps: $!\n";
 	}
-	if ($opt_P) {
-	    exec("cat", $opt_P);
-	} else {
-	    exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
-	    die "Could not start cvsps: $!\n";
+	my ($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
+					     DIR => File::Spec->tmpdir());
+	while (<CVSPS>) {
+	    print $cvspsfh $_;
 	}
+	close CVSPS;
+	close $cvspsfh;
+	$opt_P = $cvspsfile;
 }
 
 
+open(CVS, "<$opt_P") or die $!;
+
 ## cvsps output:
 #---------------------
 #PatchSet 314
-- 
1.4.0.gcda2
