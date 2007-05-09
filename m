From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Optimized cvsexportcommit: calling 'cvs status' once instead of once per touched file.
Date: Thu, 10 May 2007 01:06:36 +0200
Message-ID: <11787519961666-git-send-email-prohaska@zib.de>
References: <380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
Cc: robin.rosenberg.lists@dewire.com,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 01:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlvFF-0001Rm-7X
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984AbXEIXGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759119AbXEIXGk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:06:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:59009 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757984AbXEIXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 19:06:38 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l49N6bRC003130;
	Thu, 10 May 2007 01:06:37 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l49N6ac2021653;
	Thu, 10 May 2007 01:06:36 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46808>

Runtime is now independent of the number of modified files.

The old implementation executed 'cvs status' for each file touched by the patch
to be applied. The new code calls 'cvs status' only once with all touched files
and parses cvs's output to collect all available status information.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-cvsexportcommit.perl |   45 ++++++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6ed4719..21d49f6 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -160,36 +160,51 @@ foreach my $p (@afiles) {
     }
 }
 
+# ... check dirs,
 foreach my $d (@dirs) {
     if (-e $d) {
 	$dirty = 1;
 	warn "$d exists and is not a directory!\n";
     }
 }
-foreach my $f (@afiles) {
-    # This should return only one value
-    if ($f =~ m,(.*)/[^/]*$,) {
-	my $p = $1;
-	next if (grep { $_ eq $p } @dirs);
+
+# ... query status of all files that we have a directory for and parse output of 'cvs status' to %cvsstat.
+my @canstatusfiles;
+foreach my $f (@files) {
+    my $path = dirname $f;
+    next if (grep { $_ eq $path } @dirs);
+    push @canstatusfiles, $f;
+}
+  
+my %cvsstat;
+if (@canstatusfiles) {
+    my @cvsoutput;
+    @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
+    my $matchcount = 0;
+    foreach my $l (@cvsoutput) {
+        chomp $l;
+        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) { 
+            $cvsstat{$canstatusfiles[$matchcount]} = $1;
+            $matchcount++;
+        }
     }
-    my @status = grep(m/^File/,  safe_pipe_capture(@cvs, '-q', 'status' ,$f));
-    if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
-    if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
-	and $status[0] !~ m/^File: no file /) {
+}
+
+# ... validate new files,
+foreach my $f (@afiles) {
+    if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
  	$dirty = 1;
 	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
-	warn "Status was: $status[0]\n";
+	warn "Status was: $cvsstat{$f}\n";
     }
 }
-
+# ... validate known files. 
 foreach my $f (@files) {
     next if grep { $_ eq $f } @afiles;
     # TODO:we need to handle removed in cvs
-    my @status = grep(m/^File/,  safe_pipe_capture(@cvs, '-q', 'status' ,$f));
-    if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
-    unless ($status[0] =~ m/Status: Up-to-date$/) {
+    unless (defined ($cvsstat{$f}) and $cvsstat{$f} eq "Up-to-date") {
 	$dirty = 1;
-	warn "File $f not up to date in your CVS checkout!\n";
+	warn "File $f not up to date but has status '$cvsstat{$f}' in your CVS checkout!\n";
     }
 }
 if ($dirty) {
-- 
1.5.1.2
