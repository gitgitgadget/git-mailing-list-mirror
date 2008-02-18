From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 17:55:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181754451.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org> <47B9A354.7070905@catalyst.net.nz> <alpine.LSU.1.00.0802181624490.30505@racer.site>
 <47B9B35B.7040200@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRADq-0004rc-Q6
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbYBRRzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYBRRzf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:55:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752171AbYBRRze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:55:34 -0500
Received: (qmail invoked by alias); 18 Feb 2008 17:55:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 18 Feb 2008 18:55:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zOZMNOPvzQbdWBwXm/gvZjLDfr8SL/Q/kg/ypRV
	SW6cF8MhBr5KKZ
X-X-Sender: gene099@racer.site
In-Reply-To: <47B9B35B.7040200@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74323>


In my use cases, "cvs status" sometimes reordered the passed filenames,
which often led to a misdetection of a dirty state (when it was in
reality a clean state).

I finally tracked it down to two filenames having the same basename.

So no longer trust the order of the results blindly, but actually check
the file name.

Since "cvs status" only returns the basename (and the complete path on the
server which is useless for our purposes), run "cvs status" several times
with lists consisting of files with unique (chomped) basenames.

Be a bit clever about new files: these are reported as "no file <blabla>",
so in order to discern it from existing files, prepend "no file " to the
basename.

In other words, one call to "cvs status" will not ask for two files
"blabla" (which does not yet exist) and "no file blabla" (which exists).

This patch makes cvsexportcommit slightly slower, when the list of changed
files has non-unique basenames, but at least it is accurate now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This should address your concerns, Junio!

 git-cvsexportcommit.perl       |   40 ++++++++++++++++++++++++++++++++--------
 t/t9200-git-cvsexportcommit.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 2a8ad1e..c00368b 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -197,15 +197,39 @@ if (@canstatusfiles) {
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
+
+    my %added = map { $_ => 1 } @afiles;
+    my %todo = map { $_ => 1 } @canstatusfiles;
+
+    while (%todo) {
+      my @canstatusfiles2 = ();
+      my %fullname = ();
+      foreach my $name (keys %todo) {
+	my $basename = $name;
+	$basename =~ s/.*\///;
+	$basename = "no file " . $basename if (exists($added{$basename}));
+	chomp($basename);
+
+	if (!exists($fullname{$basename})) {
+	  $fullname{$basename} = $name;
+	  push (@canstatusfiles2, $name);
+	  delete($todo{$name});
         }
+      }
+      my @cvsoutput;
+      @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles2);
+      foreach my $l (@cvsoutput) {
+        chomp $l;
+        if ($l =~ /^File:\s+(.*\S)\s+Status: (.*)$/) {
+	  if (!exists($fullname{$1})) {
+	    print STDERR "Huh? Status reported for unexpected file '$1'\n";
+	  } else {
+	    $cvsstat{$fullname{$1}} = $2;
+	  }
+	}
+      }
     }
 }
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 49d57a8..a55a203 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -262,4 +262,39 @@ test_expect_success '-w option should work with relative GIT_DIR' '
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
+test_expect_success 'commit a file with leading spaces in the name' '
+
+	echo space > " space" &&
+	git add " space" &&
+	git commit -m "Add a file with a leading space" &&
+	id=$(git rev-parse HEAD) &&
+	git cvsexportcommit -w "$CVSWORK" -c $id &&
+	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|release-notes/1.2/" &&
+	diff -u "$CVSWORK/ space" " space"
+
+'
+	
 test_done
-- 
1.5.4.2.217.g468be
