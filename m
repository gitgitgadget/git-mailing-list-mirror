From: Jonas Berlin <xkr47@outerspace.dyndns.org>
Subject: [PATCH] Fix "cvs log" to use UTC timezone instead of local
Date: Tue,  4 Sep 2007 15:31:33 +0300
Message-ID: <11889090932256-git-send-email-xkr47@outerspace.dyndns.org>
Cc: Jonas Berlin <xkr47@outerspace.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 14:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISXlE-0004S0-EX
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 14:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbXIDMn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 08:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbXIDMn4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 08:43:56 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:40966 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbXIDMnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 08:43:55 -0400
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2007 08:43:55 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 6A6451BE91F
	for <git@vger.kernel.org>; Tue,  4 Sep 2007 15:31:33 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A04B6B649DC; Tue, 04 Sep 2007 15:31:33 +0300
Received: from outerspace.dyndns.org (a88-112-29-101.elisa-laajakaista.fi [88.112.29.101])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 3776E2BEE9
	for <git@vger.kernel.org>; Tue,  4 Sep 2007 15:31:32 +0300 (EEST)
Received: by outerspace.dyndns.org (Postfix, from userid 501)
	id 1C48571136; Tue,  4 Sep 2007 15:31:33 +0300 (EEST)
X-Mailer: git-send-email 1.5.1.6
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57558>

The timestamp format used in "cvs log" output does not include a
timezone, and must thus be in UTC timezone. The timestamps from git on
the other hand contain timezone information for each commit timestamp,
but git-cvsserver discarded this information and used the timestamps
without adjusting the time accordingly. The patch adds code to apply
the timezone offset to produce a UTC timestamp.

Signed-off-by: Jonas Berlin <xkr47@outerspace.dyndns.org>
---
    Could it perhaps be that git previously reported timestamps in UTC
    instead of including a timezone?

 git-cvsserver.perl              |   11 ++++++++++-
 t/t9400-git-cvsserver-server.sh |   24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13dbd27..5ae9933 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -23,6 +23,7 @@ use Fcntl;
 use File::Temp qw/tempdir tempfile/;
 use File::Basename;
 use Getopt::Long qw(:config require_order no_ignore_case);
+use Time::Local;
 
 my $VERSION = '@@GIT_VERSION@@';
 
@@ -1686,7 +1687,15 @@ sub req_log
             print "M ----------------------------\n";
             print "M revision 1.$revision->{revision}\n";
             # reformat the date for log output
-            $revision->{modified} = sprintf('%04d/%02d/%02d %s', $3, $DATE_LIST->{$2}, $1, $4 ) if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and defined($DATE_LIST->{$2}) );
+            if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\d\d):(\d\d):(\d\d) ([-+])(\d\d)(\d\d)/ and defined($DATE_LIST->{$2}) )
+            {
+                my $off = $8 * 3600 + $9 * 60;
+                my $time = timegm($6, $5, $4, $1, $DATE_LIST->{$2}-1, $3 - 1900);
+                $off = -$off if ( $7 eq "-" );
+                $time -= $off;
+                my ( $sec, $min, $hour, $mday, $mon, $year ) = gmtime($time);
+                $revision->{modified} = sprintf('%04d/%02d/%02d %02d:%02d:%02d', $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
+            }
             $revision->{author} =~ s/\s+.*//;
             $revision->{author} =~ s/^(.{8}).*/$1/;
             print "M date: $revision->{modified};  author: $revision->{author};  state: " . ( $revision->{filehash} eq "deleted" ? "dead" : "Exp" ) . ";  lines: +2 -3\n";
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 641303e..254eab7 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -405,4 +405,28 @@ test_expect_success 'cvs update (merge no-op)' \
     GIT_CONFIG="$git_config" cvs -Q update &&
     diff -q merge ../merge'
 
+#------------
+# CVS LOG
+#------------
+
+cd "$WORKDIR"
+test_expect_success 'cvs log (check that timestamps are in UTC)' \
+  'echo stamp > stamp &&
+   git add stamp &&
+   TZ=GMT-01 git commit -q -m "Add stamp" &&
+   git push gitcvs.git >/dev/null &&
+   GIT_STAMP=$(git-show --pretty=format:%ct --name-only stamp | grep -v stamp) &&
+   [ "$GIT_STAMP" ] &&
+   cd cvswork &&
+   GIT_CONFIG="$git_config" cvs -Q update &&
+   CVS_STAMP=$(GIT_CONFIG="$git_config" cvs log stamp | perl -e '\''
+      use Time::Local;
+      while(<>) {
+        last if(/^date:/);
+      }
+      my ($dummy,$y,$m,$d,$H,$M,$S) = split(m!\D+!);
+      print timegm($S,$M,$H,$d,$m-1,$y-1900);
+   '\'') &&
+   test "$CVS_STAMP" = "$GIT_STAMP"'
+
 test_done
-- 
1.5.1.6
