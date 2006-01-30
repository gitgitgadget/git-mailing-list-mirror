From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: Add -S <skipfileregex> support and -v announces files retrieved
Date: Mon, 30 Jan 2006 19:12:41 +1300
Message-ID: <11386015612035-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 30 07:13:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3SHf-0000Zz-US
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 07:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWA3GMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 01:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWA3GMm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 01:12:42 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:13241 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751248AbWA3GMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 01:12:42 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=aporo.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with smtp (Exim 4.50)
	id 1F3SHI-0006aq-Qg; Mon, 30 Jan 2006 19:12:40 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15258>

A couple of things that seem to help importing broken CVS repos...

 -S '<slash-delimited-regex>' skips files with a matching path
 -v prints file name and version before fetching from cvs

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

You can now see what file fetch is breaking the import and 
you can then tell cvsimport to skip it. 

 git-cvsimport.perl |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

d42ad86243882f6937b7af8b1ae10c0ec899a8a3
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index fc207fc..00fc3ba 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S);
 my (%conv_author_name, %conv_author_email);
 
 sub usage() {
@@ -37,7 +37,7 @@ sub usage() {
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz] [-i] [-k] [-u]
-       [-s subst] [-m] [-M regex] [CVS_module]
+       [-s subst] [-m] [-M regex] [-S regex] [CVS_module]
 END
 	exit(1);
 }
@@ -85,7 +85,7 @@ sub write_author_info($) {
 	close ($f);
 }
 
-getopts("hivmkuo:d:p:C:z:s:M:P:A:") or usage();
+getopts("hivmkuo:d:p:C:z:s:M:P:A:S:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -579,7 +579,7 @@ unless($pid) {
 my $state = 0;
 
 my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my(@old,@new);
+my(@old,@new,@skipped);
 my $commit = sub {
 	my $pid;
 	while(@old) {
@@ -675,6 +675,11 @@ my $commit = sub {
 	substr($logmsg,32767) = "" if length($logmsg) > 32767;
 	$logmsg =~ s/[\s\n]+\z//;
 
+	if (@skipped) {
+	    $logmsg .= "\n\n\nSKIPPED:\n\t";
+	    $logmsg .= join("\n\t", @skipped) . "\n";
+	}
+
 	print $pw "$logmsg\n"
 		or die "Error writing to git-commit-tree: $!\n";
 	$pw->close();
@@ -832,6 +837,12 @@ while(<CVS>) {
 		my $fn = $1;
 		my $rev = $3;
 		$fn =~ s#^/+##;
+		if ($opt_S && $fn =~ m/$opt_S/) {
+		    print "SKIPPING $fn v $rev\n";
+		    push(@skipped, $fn);
+		    next;
+		}
+		print "Fetching $fn   v $rev\n" if $opt_v;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
 		if($size == -1) {
 			push(@old,$fn);
-- 
1.1.6.g170f-dirty
