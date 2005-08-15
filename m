From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] cvsgit fixes: spaces in filenames and CVS server dialog woes
Date: Mon, 15 Aug 2005 11:28:34 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.15.09.28.12.779733@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 15 11:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4bIg-0003SO-JM
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVHOJac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVHOJac
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:30:32 -0400
Received: from main.gmane.org ([80.91.229.2]:5598 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932337AbVHOJab (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 05:30:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E4bHJ-00037O-Ey
	for git@vger.kernel.org; Mon, 15 Aug 2005 11:29:09 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 11:29:09 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 11:29:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Problems found while importing dasher's CVS:

* Allow spaces in filenames.
* cvsps may create unnamed branches with revisions that don't really
  exist, which causes the CVS server to return something we haven't
  hitherto expected.
* Report deleted files when being verbose.
* Also, report the commit date.

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -294,6 +293,12 @@ sub _line {
 				return $res;
 			} elsif($line =~ s/^E //) {
 				# print STDERR "S: $line\n";
+			} elsif($line =~ /^Remove-entry /i) {
+				$line = $self->readline(); # filename
+				$line = $self->readline(); # OK
+				chomp $line;
+				die "Unknown: $line" if $line ne "ok";
+				return -1;
 			} else {
 				die "Unknown: $line\n";
 			}
@@ -561,7 +566,7 @@ my $commit = sub {
 		or die "Error writing to git-commit-tree: $!\n";
 	$pw->close();
 
-	print "Committed patch $patchset ($branch)\n" if $opt_v;
+	print "Committed patch $patchset ($branch ".strftime("%Y-%m-%d %H:%M:%S",gmtime($date)).")\n" if $opt_v;
 	chomp(my $cid = <$pr>);
 	length($cid) == 40
 		or die "Cannot get commit id ($cid): $!\n";
@@ -675,26 +680,32 @@ while(<CVS>) {
 		$state = 9;
 	} elsif($state == 8) {
 		$logmsg .= "$_\n";
-	} elsif($state == 9 and /^\s+(\S+):(INITIAL|\d+(?:\.\d+)+)->(\d+(?:\.\d+)+)\s*$/) {
+	} elsif($state == 9 and /^\s+(.+?):(INITIAL|\d+(?:\.\d+)+)->(\d+(?:\.\d+)+)\s*$/) {
 #	VERSION:1.96->1.96.2.1
 		my $init = ($2 eq "INITIAL");
 		my $fn = $1;
 		my $rev = $3;
 		$fn =~ s#^/+##;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
-		print "".($init ? "New" : "Update")." $fn: $size bytes.\n" if $opt_v;
-		open my $F, '-|', "git-hash-object -w $tmpname"
-			or die "Cannot create object: $!\n";
-		my $sha = <$F>;
-		chomp $sha;
-		close $F;
+		if($size == -1) {
+			push(@old,$fn);
+			print "Drop $fn\n" if $opt_v;
+		} else {
+			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
+			open my $F, '-|', "git-hash-object -w $tmpname"
+				or die "Cannot create object: $!\n";
+			my $sha = <$F>;
+			chomp $sha;
+			close $F;
+			my $mode = pmode($cvs->{'mode'});
+			push(@new,[$mode, $sha, $fn]); # may be resurrected!
+		}
 		unlink($tmpname);
-		my $mode = pmode($cvs->{'mode'});
-		push(@new,[$mode, $sha, $fn]); # may be resurrected!
-	} elsif($state == 9 and /^\s+(\S+):\d(?:\.\d+)+->(\d(?:\.\d+)+)\(DEAD\)\s*$/) {
+	} elsif($state == 9 and /^\s+(.+?):\d(?:\.\d+)+->(\d(?:\.\d+)+)\(DEAD\)\s*$/) {
 		my $fn = $1;
 		$fn =~ s#^/+##;
 		push(@old,$fn);
+		print "Delete $fn\n" if $opt_v;
 	} elsif($state == 9 and /^\s*$/) {
 		$state = 10;
 	} elsif(($state == 9 or $state == 10) and /^-+$/) {
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Let he who takes the plunge remember to return it by Tuesday.
