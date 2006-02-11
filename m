From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH 2/3] Use File::Find rather than find and xargs in git-archimport
Date: Fri, 10 Feb 2006 18:52:03 -0800
Message-ID: <549.1139626323@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 11 03:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7krs-0003Hv-2k
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 03:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWBKCwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 21:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBKCwH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 21:52:07 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:37283 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932094AbWBKCwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 21:52:04 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1B2q4xZ000554
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 18:52:04 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1B2q3DF000553
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 18:52:04 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15919>

git-archimport uses find and xargs directly to find and apply patches.
Replace these by File::Find and save one call to find.  Tested on
Solaris 8 with a quite complex, interrelated set of Arch repos.

Hopefully handles {arch} subdirectories correctly.  Thanks to Randal
Schwartz for pointing out the problem.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 git-archimport.perl |   39 +++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

8e7119df3d59da189baa741d44b04e7c8da2c421
diff --git a/git-archimport.perl b/git-archimport.perl
index 841738d..ffdf742 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -60,6 +60,7 @@ use Getopt::Std;
 use File::Temp qw(tempdir);
 use File::Path qw(mkpath rmtree);
 use File::Basename qw(basename dirname);
+use File::Find;
 use Data::Dumper qw/ Dumper /;
 use IPC::Open2;
 
@@ -664,17 +665,35 @@ sub apply_cset {
     # get the changeset
     safe_pipe_capture($TLA,'get-changeset',$ps->{id},"$tmp/changeset");
     die "Cannot get changeset: $!" if $?;
-    
+
+    my @patchlist;
+    my $wanted_patches = sub {
+        # We want all those non-empty *.patch files that do not modify
+        # arch state.  The preprocess argument strips out {arch}.
+	if (-f && !-z && /^.*\.patch$/) {
+	    push @patchlist, $File::Find::name;
+	}
+	if ($File::Find::dir =~ /\{arch\}/) {
+	    print STDERR "AUGH!  tested " . $File::Find::name . "\n";
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
+    File::Find ({wanted => $wanted_patches,
+		 preprocess => sub { grep(!/^\{arch\}$/, @_); }},
+		$tmp . "/changeset/patches");
+    foreach my $patchname (@patchlist) {
+	safe_pipe_capture("patch", "-p1", "--forward", "-i", $patchname);
         die "Problem applying patches! $!" if $?;
     }
 
-- 
1.1.6.g0d39d
