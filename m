From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: fixes for path handling
Date: Wed, 1 Mar 2006 19:09:23 +0100
Message-ID: <200603011909.23357.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 19:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVlR-0004jc-8K
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 19:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWCASJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 13:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCASJ0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 13:09:26 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:21959 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750734AbWCASJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 13:09:25 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 3B62A2268;
	Wed,  1 Mar 2006 19:09:24 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17002>

Moving a directory ending in a slash was not working as the
destination was not calculated correctly.
E.g. in the git repo,

 git-mv t/ Documentation

gave the error

 Error: destination 'Documentation' already exists

To get rid of this problem, strip trailing slashes from all arguments.
The comment in cg-mv made me curious about this issue; Pasky, thanks!
As result, the workaround in cg-mv is not needed any more.

Also, another bug was shown by cg-mv. When moving files outside of
a subdirectory, it typically calls git-mv with something like

 git-mv Documentation/git.txt Documentation/../git-mv.txt

which triggers the following error from git-update-index:

 Ignoring path Documentation/../git-mv.txt

The result is a moved file, removed from git revisioning, but not
added again. To fix this, the paths have to be normalized not have ".."
in the middle. This was already done in git-mv, but only for
a better visual appearance :(

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-mv.perl |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

15d94ce0807c1d99d10f6c3ddd32963b1ac0fece
diff --git a/git-mv.perl b/git-mv.perl
index 8cd95c4..9b43dcc 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -31,11 +31,12 @@ chomp($GIT_DIR);
 my (@srcArgs, @dstArgs, @srcs, @dsts);
 my ($src, $dst, $base, $dstDir);
 
+# remove any trailing slash in arguments
+for (@ARGV) { s/\/*$//; }
+
 my $argCount = scalar @ARGV;
 if (-d $ARGV[$argCount-1]) {
 	$dstDir = $ARGV[$argCount-1];
-	# remove any trailing slash
-	$dstDir =~ s/\/$//;
 	@srcArgs = @ARGV[0..$argCount-2];
 	
 	foreach $src (@srcArgs) {
@@ -61,6 +62,16 @@ else {
     $dstDir = "";
 }
 
+# normalize paths, needed to compare against versioned files and update-index
+# also, this is nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
+for (@srcArgs, @dstArgs) {
+    s|^\./||;
+    s|/\./|/| while (m|/\./|);
+    s|//+|/|g;
+    # Also "a/b/../c" ==> "a/c"
+    1 while (s,(^|/)[^/]+/\.\./,$1,);
+}
+
 my (@allfiles,@srcfiles,@dstfiles);
 my $safesrc;
 my (%overwritten, %srcForDst);
@@ -79,15 +90,6 @@ while(scalar @srcArgs > 0) {
     $dst = shift @dstArgs;
     $bad = "";
 
-    for ($src, $dst) {
-	# Be nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
-	s|^\./||;
-	s|/\./|/| while (m|/\./|);
-	s|//+|/|g;
-	# Also "a/b/../c" ==> "a/c"
-	1 while (s,(^|/)[^/]+/\.\./,$1,);
-    }
-
     if ($opt_v) {
 	print "Checking rename of '$src' to '$dst'\n";
     }
-- 
1.2.0.g719b
