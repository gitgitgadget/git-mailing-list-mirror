From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders the
 arguments
Date: Mon, 18 Feb 2008 01:31:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802180127100.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:32:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQurp-0000ve-JD
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 02:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYBRBbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 20:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbYBRBbs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 20:31:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:51175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750959AbYBRBbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 20:31:47 -0500
Received: (qmail invoked by alias); 18 Feb 2008 01:31:45 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 18 Feb 2008 02:31:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4SdB7lES4Aa8T8wN0Hq6bVxDkM9t2Xmp6pulDgM
	ovRGy9H10pKqpe
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74212>


In my use cases, "cvs status" sometimes reordered the passed filenames,
which often led to a misdetection of a dirty state (when it was in
reality a clean state).

I finally tracked it down to two filenames having the same basename.

So no longer trust the order of the results blindly, but actually check
the file name.

Since "cvs status" only returns the basename (and the complete path on the
server which is useless for our purposes), run "cvs status" several times
with lists consisting of files with unique (chomped) basenames.

This makes cvsexportcommit slightly slower, when the list of changed files
has non-unique basenames, but at least it is accurate now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	So I finally broke down.  I really need a working cvsexportcommit, 
	everything else is just too painful.

	Feel free to criticise/educate me on my Perl style.

 git-cvsexportcommit.perl       |   33 +++++++++++++++++++++++++--------
 t/t9200-git-cvsexportcommit.sh |   23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 2a8ad1e..7fd05c7 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -197,15 +197,32 @@ if (@canstatusfiles) {
       my @updated = xargs_safe_pipe_capture([@cvs, 'update'], @canstatusfiles);
       print @updated;
     }
-    my @cvsoutput;
-    @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles);
-    my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
-            $cvsstat{$canstatusfiles[$matchcount]} = $1;
-            $matchcount++;
+    # "cvs status" reorders the parameters, notably when there are multiple
+    # arguments with the same basename.  So be precise here.
+    while (@canstatusfiles) {
+      my @canstatusfiles2 = ();
+      my %basenames = ();
+      for (my $i = 0; $i <= $#canstatusfiles; $i++) {
+        my $name = $canstatusfiles[$i];
+	my $basename = $name;
+	$basename =~ s/.*\///;
+	$basename = "no file " . $basename if (grep {$_ eq $basename} @afiles);
+	chomp($basename);
+	if (!defined($basenames{$basename})) {
+	  $basenames{$basename} = $name;
+	  push (@canstatusfiles2, $name);
+	  splice (@canstatusfiles, $i, 1);
+	  $i--;
         }
+      }
+      my @cvsoutput;
+      @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles2);
+      foreach my $l (@cvsoutput) {
+          chomp $l;
+          if ( $l =~ /^File:\s+(.*\S)\s+Status: (.*)$/ ) {
+            $cvsstat{$basenames{$1}} = $2 if defined($basenames{$1});
+          }
+      }
     }
 }
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 49d57a8..483d8fa 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -262,4 +262,27 @@ test_expect_success '-w option should work with relative GIT_DIR' '
       )
 '
 
+test_expect_success 'check files before directories' '
+
+	echo Notes > release-notes &&
+	git add release-notes &&
+	git commit -m "Add release notes" release-notes &&
+	id=$(git rev-parse HEAD) &&
+	git cvsexportcommit -w "$CVSWORK" -c $id &&
+
+	echo new > DS &&
+	echo new > E/DS &&
+	echo modified > release-notes &&
+	git add DS E/DS release-notes &&
+	git commit -m "Add two files with the same basename" &&
+	id=$(git rev-parse HEAD) &&
+	git cvsexportcommit -w "$CVSWORK" -c $id &&
+	check_entries "$CVSWORK/E" "DS/1.1/|newfile5.txt/1.1/" &&
+	check_entries "$CVSWORK" "DS/1.1/|release-notes/1.2/" &&
+	diff -u "$CVSWORK/DS" DS &&
+	diff -u "$CVSWORK/E/DS" E/DS &&
+	diff -u "$CVSWORK/release-notes" release-notes
+
+'
+
 test_done
-- 
1.5.4.2.217.g468be
