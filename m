From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH (corrected)] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Wed, 9 May 2007 09:45:14 +0200
Message-ID: <82A134F6-C11A-440C-8424-DDDDBF7DCD7A@zib.de>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de> <EC3AE084-0AB8-406A-A3C7-916CCF35BEAE@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 09:45:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlgrI-0001eo-Qw
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXEIHpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 03:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXEIHpG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:45:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:51806 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbXEIHpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 03:45:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l497j25u028995
	for <git@vger.kernel.org>; Wed, 9 May 2007 09:45:02 +0200 (CEST)
Received: from [192.168.178.32] (p54BF2F28.dip0.t-ipconnect.de [84.191.47.40])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l497j2j9008903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 May 2007 09:45:02 +0200 (MEST)
In-Reply-To: <EC3AE084-0AB8-406A-A3C7-916CCF35BEAE@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46676>

The old implementation executed 'cvs status' for each file touched by  
the patch
to be applied. The new code calls 'cvs status' only once and parses  
cvs's
output to collect status information of all files contained in the  
cvs working
copy.

Runtime is now independent of the number of modified files. A  
drawback is that
the new code retrieves status information for all files even if only  
a few are
touched. The old implementation may be noticeably faster for small  
patches to
large workingcopies. However, the old implementation doesn't scale if  
more
files are touched, especially in remotely located cvs repositories.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
git-cvsexportcommit.perl |   48 +++++++++++++++++++++++++++++++++++ 
+---------
1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6ed4719..4d91574 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -160,36 +160,64 @@ foreach my $p (@afiles) {
      }
}
+# ... check dirs,
foreach my $d (@dirs) {
      if (-e $d) {
         $dirty = 1;
         warn "$d exists and is not a directory!\n";
      }
}
+
+# ... query and store status of files by parsing output of 'cvs  
status',
+# Note, we must use -n to avoid any modifications to working copy.
+# Otherwise the testsuite fails because it expects unmodfied CVS/ 
Entries files.
+my @cvsoutput;
+my %cvsstat;
+open CVSSTAT, "cvs -n status 2>&1 |" || die "failed to query cvs  
status";
+@cvsoutput=<CVSSTAT>;
+close CVSSTAT || die "failed to query cvs status";
+my ( $dir, $status, $file );
+foreach my $f (@cvsoutput) {
+# cvs reports directories on stderr before reporting file status on  
stdout
+# using basename of 'Repository revision:' should be a safe way to  
deal with whitespace in filenames.
+    chomp $f;
+    if ( $f =~ /^cvs status: Examining (.*)$/ ) {
+        $dir = $1;
+        if ( $dir ne "." ) {
+            $dir .= "/";
+        } else {
+            $dir = "";
+        }
+    } elsif ( $f =~ /Status: (.*)$/ ) {
+        $status = $1;
+    } elsif ( $f =~ /^   Repository revision:/ ) {
+        $f =~ s/,v$//;
+        $f =~ /([^\/]*)$/;
+        $file = $1;
+        $cvsstat{"$dir$file"} = $status;
+    }
+}
+
+# ... validate new files,
foreach my $f (@afiles) {
      # This should return only one value
      if ($f =~ m,(.*)/[^/]*$,) {
         my $p = $1;
         next if (grep { $_ eq $p } @dirs);
      }
-    my @status = grep(m/^File/,  safe_pipe_capture(@cvs, '-q',  
'status' ,$f));
-    if (@status > 1) { warn 'Strange! cvs status returned more than  
one line?'};
-    if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
-       and $status[0] !~ m/^File: no file /) {
+    if (defined ($cvsstat{$f})) {
         $dirty = 1;
         warn "File $f is already known in your CVS checkout --  
perhaps it has been added by another user. Or this may indicate that  
it exists on a different branch. If this is the case, use -f to force  
the merge.\n";
-       warn "Status was: $status[0]\n";
+       warn "Status was: $cvsstat{$f}\n";
      }
}
-
+# ... validate known files.
foreach my $f (@files) {
      next if grep { $_ eq $f } @afiles;
      # TODO:we need to handle removed in cvs
-    my @status = grep(m/^File/,  safe_pipe_capture(@cvs, '-q',  
'status' ,$f));
-    if (@status > 1) { warn 'Strange! cvs status returned more than  
one line?'};
-    unless ($status[0] =~ m/Status: Up-to-date$/) {
+    unless (defined ($cvsstat{$f}) and $cvsstat{$f} eq "Up-to-date") {
         $dirty = 1;
-       warn "File $f not up to date in your CVS checkout!\n";
+       warn "File $f not up to date but has status '$cvsstat{$f}' in  
your CVS checkout!\n";
      }
}
if ($dirty) {
--
1.5.1.2
