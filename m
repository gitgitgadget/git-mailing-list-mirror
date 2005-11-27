From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: shrink usage, no usage on error
Date: Sun, 27 Nov 2005 21:58:52 +0100
Message-ID: <200511272158.53234.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:00:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTcE-0006O1-7t
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 21:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVK0U65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 15:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVK0U64
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 15:58:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:42206 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751098AbVK0U64 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 15:58:56 -0500
Received: (qmail invoked by alias); 27 Nov 2005 20:58:54 -0000
Received: from p5496A06C.dip0.t-ipconnect.de (EHLO linux) [84.150.160.108]
  by mail.gmx.net (mp016) with SMTP; 27 Nov 2005 21:58:54 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12820>

Small fixes to be consistent with other git scripts:
- usage message is only about options and arguments
- on error, exit(1) without the usage message

Additionally, "beautifies" output with -n a little bit

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---
This conflicts with Johannes's (and Junio's corrected)
 [PATCH] Make git-mv work in subdirectories, too
so this should be changed accordingly.
Otherwise, I can acknowlegde that your correction to this
patch (make git-mv work in subdirs) works for me.
What is the correct way to "Ack" a patch?

Josef

 git-mv.perl |   46 +++++++++++++++++++---------------------------
 1 files changed, 19 insertions(+), 27 deletions(-)

applies-to: 1dc0816b6c98ef90985d2761f1ab80739e4fbc7d
58d858a354c10c3be0b9eae68cabdce8a3d87f27
diff --git a/git-mv.perl b/git-mv.perl
index b2eace5..990bec5 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -13,22 +13,8 @@ use Getopt::Std;
 
 sub usage() {
 	print <<EOT;
-$0 [-f] [-n] <source> <dest>
-$0 [-f] [-k] [-n] <source> ... <dest directory>
-
-In the first form, source must exist and be either a file,
-symlink or directory, dest must not exist. It renames source to dest.
-In the second form, the last argument has to be an existing
-directory; the given sources will be moved into this directory.
-
-Updates the git cache to reflect the change.
-Use "git commit" to make the change permanently.
-
-Options:
-  -f   Force renaming/moving, even if target exists
-  -k   Continue on error by skipping
-       not-existing or not revision-controlled source
-  -n   Do nothing; show what would happen
+$0 [-f] [-n] <source> <destination>
+$0 [-f] [-n] [-k] <source> ... <destination directory>
 EOT
 	exit(1);
 }
@@ -38,8 +24,8 @@ my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
 
 unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
 	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
-    print "Git repository not found.";
-    usage();
+    print "Error: git repository not found.";
+    exit(1);
 }
 
 
@@ -70,7 +56,7 @@ else {
 	print "Error: moving to directory '"
 	    . $ARGV[$argCount-1]
 	    . "' not possible; not exisiting\n";
-	usage;
+	exit(1);
     }
     @srcArgs = ($ARGV[0]);
     @dstArgs = ($ARGV[1]);
@@ -148,7 +134,7 @@ while(scalar @srcArgs > 0) {
 	    next;
 	}
 	print "Error: $bad\n";
-	usage();
+	exit(1);
     }
     push @srcs, $src;
     push @dsts, $dst;
@@ -187,33 +173,39 @@ while(scalar @srcs > 0) {
 }
 
 if ($opt_n) {
+    if (@changedfiles) {
 	print "Changed  : ". join(", ", @changedfiles) ."\n";
+    }
+    if (@addedfiles) {
 	print "Adding   : ". join(", ", @addedfiles) ."\n";
+    }
+    if (@deletedfiles) {
 	print "Deleting : ". join(", ", @deletedfiles) ."\n";
-	exit(1);
+    }
 }
-	
-if (@changedfiles) {
+else {
+    if (@changedfiles) {
 	open(H, "| git-update-index -z --stdin")
 		or die "git-update-index failed to update changed files with code $!\n";
 	foreach my $fileName (@changedfiles) {
 		print H "$fileName\0";
 	}
 	close(H);
-}
-if (@addedfiles) {
+    }
+    if (@addedfiles) {
 	open(H, "| git-update-index --add -z --stdin")
 		or die "git-update-index failed to add new names with code $!\n";
 	foreach my $fileName (@addedfiles) {
 		print H "$fileName\0";
 	}
 	close(H);
-}
-if (@deletedfiles) {
+    }
+    if (@deletedfiles) {
 	open(H, "| git-update-index --remove -z --stdin")
 		or die "git-update-index failed to remove old names with code $!\n";
 	foreach my $fileName (@deletedfiles) {
 		print H "$fileName\0";
 	}
 	close(H);
+    }
 }
---
0.99.9.GIT
