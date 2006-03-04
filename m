From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: anonymous cvs via pserver support
Date: Sat, 4 Mar 2006 20:30:41 +1300
Message-ID: <11414574412510-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Mar 04 08:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFQy3-00050K-VB
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 08:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWCDHOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 02:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWCDHOM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 02:14:12 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:14280 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751065AbWCDHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 02:14:12 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FFQxu-000500-0Q; Sat, 04 Mar 2006 20:14:10 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1FFRDt-00025b-00; Sat, 04 Mar 2006 20:30:41 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17178>

git-cvsserver now knows how to do the pserver auth chat when the user
is anonymous. To get it to work, add a line to your inetd.conf like

  cvspserver stream tcp nowait nobody git-cvsserver pserver

(On some inetd implementations you may have to put the pserver parameter twice.)

Commits are blocked. Naively, git-cvsserver assumes non-malicious users. Please
review the code before setting this up on an internet-accessible server.

NOTE: the <nobody> user above will need write access to the .git directory
to maintain the sqlite database. Updating of the sqlite database should be
put in an update hook to avoid this problem, so that it is maintained by
users with write access.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsserver.perl |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

91a6bf468230d63c414a21adeef94f1242eaaaab
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b450792..7d3f78e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -87,6 +87,31 @@ $log->info("--------------- STARTING ---
 my $TEMP_DIR = tempdir( CLEANUP => 1 );
 $log->debug("Temporary directory is '$TEMP_DIR'");
 
+# if we are called with a pserver argument,
+# deal with the authentication cat before entereing the
+# main loop
+if (@ARGV && $ARGV[0] eq 'pserver') {
+    my $line = <STDIN>; chomp $line;
+    unless( $line eq 'BEGIN AUTH REQUEST') {
+       die "E Do not understand $line - expecting BEGIN AUTH REQUEST\n";
+    }
+    $line = <STDIN>; chomp $line;
+    req_Root('root', $line) # reuse Root
+       or die "E Invalid root $line \n";
+    $line = <STDIN>; chomp $line;
+    unless ($line eq 'anonymous') {
+       print "E Only anonymous user allowed via pserver\n";
+       print "I HATE YOU\n";
+    }
+    $line = <STDIN>; chomp $line;    # validate the password?
+    $line = <STDIN>; chomp $line;
+    unless ($line eq 'END AUTH REQUEST') {
+       die "E Do not understand $line -- expecting END AUTH REQUEST\n";
+    }
+    print "I LOVE YOU\n";
+    # and now back to our regular programme...
+}
+
 # Keep going until the client closes the connection
 while (<STDIN>)
 {
@@ -165,6 +190,7 @@ sub req_Root
         print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
         print "E \n";
         print "error 1 GITCVS emulation disabled\n";
+        return 0;
     }
 
     if ( defined ( $cfg->{gitcvs}{logfile} ) )
@@ -173,6 +199,8 @@ sub req_Root
     } else {
         $log->nofile();
     }
+
+    return 1;
 }
 
 # Global_option option \n
@@ -914,6 +942,12 @@ sub req_ci
 
     $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
 
+    if ( @ARGV && $ARGV[0] eq 'pserver')
+    {
+        print "error 1 pserver access cannot commit\n";
+        exit;
+    }
+
     if ( -e $state->{CVSROOT} . "/index" )
     {
         print "error 1 Index already exists in git repo\n";
-- 
1.2.4.g09a27-dirty
