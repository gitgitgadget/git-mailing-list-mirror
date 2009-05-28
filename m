From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: [PATCH] git-cvsexportcommit can't commit files which have been removed
 from CVS
Date: Fri, 29 May 2009 00:23:33 +0100
Message-ID: <4A1F1CF5.8030002@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 01:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9owr-00012k-Vi
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 01:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZE1XXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZE1XXd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 19:23:33 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:53689 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbZE1XXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 19:23:32 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1M9owe-0002yf-SL
	for git@vger.kernel.org; Fri, 29 May 2009 00:23:33 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120241>

If a file X is removed from CVS, it goes into the Attic directory, and
CVS reports it as 'no file X' but with status 'Up-to-date'.  This is
misinterpreted an existing file when git-cvsexportcommit tries to commit a file
with the same name as one of these.  This patch attempts to correctly identify
these files, so that new files with the same name can be committed.

Added a test to t9200-git-cvsexportcommit.sh, which tests that we can
re-commit a removed filename which remains in CVS's attic. This adds a
file 'attic_gremlin' in CVS, then "removes" it, then tries to commit a
file with the same name from git.

Signed-off-by: Nick Woolley <git.wu-lee@noodlefactory.co.uk>
---
 git-cvsexportcommit.perl       |   49 ++++++++++++++++++++++++++++-----------
 t/t9200-git-cvsexportcommit.sh |   18 ++++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6d9f0ef..e5e8ca9 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -225,7 +225,14 @@ if (@canstatusfiles) {
       foreach my $name (keys %todo) {
 	my $basename = basename($name);

-	$basename = "no file " . $basename if (exists($added{$basename}));
+	# CVS reports files which are "status"ed which don't exist
+	# in the current revision as "no file $basename", so we
+	# should anticipate that.  Totally unknown files will have
+	# a status "Unknown". However, if they exist in the attic
+	# their status will be "Up-to-date" (this means they were
+	# added once but have been removed).
+	$basename = "no file $basename" if $added{$basename};
+
 	$basename =~ s/^\s+//;
 	$basename =~ s/\s+$//;

@@ -233,31 +240,45 @@ if (@canstatusfiles) {
 	  $fullname{$basename} = $name;
 	  push (@canstatusfiles2, $name);
 	  delete($todo{$name});
-        }
+	}
       }
       my @cvsoutput;
       @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles2);
       foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ($l =~ /^File:\s+(.*\S)\s+Status: (.*)$/) {
-	  if (!exists($fullname{$1})) {
-	    print STDERR "Huh? Status reported for unexpected file '$1'\n";
-	  } else {
-	    $cvsstat{$fullname{$1}} = $2;
-	  }
-	}
+	chomp $l;
+	next unless
+	    my ($file, $status) = $l =~ /^File:\s+(.*\S)\s+Status: (.*)$/;
+
+	my $fullname = $fullname{$file};
+	print STDERR "Huh? Status '$status' reported for unexpected file '$file'\n"
+	    unless defined $fullname;
+
+	# This response means the file does not exist except in
+	# CVS's attic, so set the status accordingly
+	$status = "In-attic"
+	    if $file =~ /^no file /
+		&& $status eq 'Up-to-date';
+
+	$cvsstat{$fullname{$file}} = $status;
       }
     }
 }

-# ... validate new files,
+# ... Validate new files have the correct status
 foreach my $f (@afiles) {
-    if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
-	$dirty = 1;
+    next unless defined(my $stat = $cvsstat{$f});
+
+    # This means the file has never been seen before
+    next if $stat eq 'Unknown';
+
+    # This means the file has been seen before but was removed
+    next if $stat eq 'In-attic';
+
+    $dirty = 1;
 	warn "File $f is already known in your CVS checkout -- perhaps it has been
added by another user. Or this may indicate that it exists on a different
branch. If this is the case, use -f to force the merge.\n";
 	warn "Status was: $cvsstat{$f}\n";
-    }
 }
+
 # ... validate known files.
 foreach my $f (@files) {
     next if grep { $_ eq $f } @afiles;
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 56b7c06..ef1f8d2 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -317,4 +317,22 @@ test_expect_success 'use the same checkout for Git and CVS' '

 '

+test_expect_success 're-commit a removed filename which remains in CVS attic' '
+
+    (cd "$CVSWORK" &&
+     echo >attic_gremlin &&
+     cvs -Q add attic_gremlin &&
+     cvs -Q ci -m "added attic_gremlin" &&
+     rm attic_gremlin &&
+     cvs -Q rm attic_gremlin &&
+     cvs -Q ci -m "removed attic_gremlin") &&
+
+    echo > attic_gremlin &&
+    git add attic_gremlin &&
+    git commit -m "Added attic_gremlin" &&
+	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
+    (cd "$CVSWORK"; cvs -Q update -d) &&
+    test -f "$CVSWORK/attic_gremlin"
+'
+
 test_done
