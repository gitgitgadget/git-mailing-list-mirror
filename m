From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH 2/3] Use File::Find rather than find and xargs in git-archimport
Date: Fri, 10 Feb 2006 15:35:57 -0800
Message-ID: <1103.1139614557@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 11 00:36:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hoL-0007Tp-Er
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWBJXf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWBJXf6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:35:58 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:50338 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932250AbWBJXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:35:58 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1ANZvxZ001107
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:35:57 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1ANZvn0001106
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:35:57 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15904>

git-archimport uses find and xargs directly to find and apply patches.
Replace these by File::Find and save one call to find.  Tested on
Solaris 8 with a moderately complex, interrelated set of Arch repos.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 git-archimport.perl |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

5cd391ce78022806bbe12d5fda5ff49843e53207
diff --git a/git-archimport.perl b/git-archimport.perl
index 841738d..17502a4 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -60,6 +60,7 @@ use Getopt::Std;
 use File::Temp qw(tempdir);
 use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
+use File::Find;
 use Data::Dumper qw/ Dumper /;
 use IPC::Open2;
 
@@ -664,17 +665,30 @@ sub apply_cset {
     # get the changeset
     safe_pipe_capture($TLA,'get-changeset',$ps->{id},"$tmp/changeset");
     die "Cannot get changeset: $!" if $?;
-    
+
+    my @patchlist;
+    my $wanted_patches = sub {
+        # We want all those non-empty *.patch files that do not modify
+        # arch state.
+	if (-f && !-z && /^.*\.patch$/ && !/{arch}/) {
+	    push @patchlist, $File::Find::name;
+	}
+    }; # perl note: This needs to be an anonymous sub to share
+       # @patchlist correctly.
+
     # apply patches
-    if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
-        # this can be sped up considerably by doing
-        #    (find | xargs cat) | patch
-        # but that cna get mucked up by patches
-        # with missing trailing newlines or the standard 
-        # 'missing newline' flag in the patch - possibly
-        # produced with an old/buggy diff.
-        # slow and safe, we invoke patch once per patchfile
-        `find $tmp/changeset/patches -type f -name '*.patch' -print0 | grep -zv '{arch}' | xargs -iFILE -0 --no-run-if-empty patch -p1 --forward -iFILE`;
+
+    # this can be sped up considerably by applying all the patches in
+    # one pass, as with
+    #    (find | xargs cat) | patch
+    # but that can get mucked up by patches with missing trailing
+    # newlines or the standard 'missing newline' flag in the patch -
+    # possibly produced with an old/buggy diff.
+    # slow and safe, we invoke patch once per patchfile
+
+    File::Find ($wanted_patches, $tmp . "/changeset/patches");
+    foreach my $patchname (@patchlist) {
+	safe_pipe_capture("patch", "-p1", "--forward", "-i", $patchname);
         die "Problem applying patches! $!" if $?;
     }
 
-- 
1.1.6.g0d39d
