From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] Make git-cvsexportcommit "status" each file in turn
Date: Wed, 15 Aug 2007 14:27:28 +0100
Organization: Insert joke here
Message-ID: <1187184448.13096.54.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YqF15qJagyF/ietGW97V"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 15:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILItc-000642-Qw
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 15:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbXHON0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 09:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbXHON0q
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 09:26:46 -0400
Received: from mx.transitive.com ([217.207.128.220]:53984 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753738AbXHON0p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 09:26:45 -0400
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1ILIkR-0004F4-7m
	for git@vger.kernel.org; Wed, 15 Aug 2007 13:17:20 +0000
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55901>


--=-YqF15qJagyF/ietGW97V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

It turns out CVS doesn't always give the status output in the order
requested. According to my local CVS gurus this is a known CVS issue.

The attached patch just makes the script check each file in turn. It's
slower but correct.

I also slightly formatted the warn output when it detects problems as
multiple line wraps with long file paths where making my eyes bleed :-)

-- 
Alex, homepage: http://www.bennee.com/~alex/
Absence makes the heart go wander.

--=-YqF15qJagyF/ietGW97V
Content-Disposition: attachment; filename*0=0001-Make-git-cvsexportcommit-status-each-CVS-file-in-tur.pat; filename*1=ch
Content-Type: application/mbox; name=0001-Make-git-cvsexportcommit-status-each-CVS-file-in-tur.patch
Content-Transfer-Encoding: 7bit

>From 66c826f423bc0a0018f1facd733ef45b639a72f6 Mon Sep 17 00:00:00 2001
From: Alex Bennee <alex@bennee.com>
Date: Wed, 15 Aug 2007 14:24:12 +0100
Subject: [PATCH] Make git-cvsexportcommit status each CVS file in turn to ensure we get it right. Format the warn output to be a bit more friendly with line wrapping.

---
 git-cvsexportcommit.perl |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index e9832d2..ee02c56 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -182,15 +182,21 @@ if (@canstatusfiles) {
       my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
       print @updated;
     }
-    my @cvsoutput;
-    @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
-    my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
-            $cvsstat{$canstatusfiles[$matchcount]} = $1;
-            $matchcount++;
-        }
+
+    # We can't status all the files at once as CVS doesn't gaurentee
+    # that it will output the status bits in the order requested.
+
+    foreach my $f (@canstatusfiles)
+    {
+	my $cvscmd = join(' ', @cvs)." status $f";
+	my $cvsoutput = `$cvscmd`;
+
+	# slurp out the status out of the result
+	my ($status) = $cvsoutput =~ m/.*Status: (\S*)/;
+
+	$opt_v && print "Status of $f is $status\n";
+
+	$cvsstat{$f} = $status;
     }
 }
 
@@ -198,10 +204,14 @@ if (@canstatusfiles) {
 foreach my $f (@afiles) {
     if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
 	$dirty = 1;
-	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
+	warn "File $f is already known in your CVS checkout.\n"
+	warn "  Perhaps it has been added by another user.\n"
+	warn "  Or this may indicate that it exists on a different branch.\n"
+	warn "  If this is the case, use -f to force the merge.\n";
 	warn "Status was: $cvsstat{$f}\n";
     }
 }
+
 # ... validate known files.
 foreach my $f (@files) {
     next if grep { $_ eq $f } @afiles;
-- 
1.5.2.3


--=-YqF15qJagyF/ietGW97V--
