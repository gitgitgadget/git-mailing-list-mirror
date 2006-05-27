From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Make cvsexportcommit create parent directories as needed.
Date: Sat, 27 May 2006 18:39:35 +0200
Message-ID: <20060527163935.474.22794.stgit@gandelf.nowhere.earth>
References: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 18:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1l9-0000Rf-0c
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWE0QfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWE0QfU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:35:20 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:30687 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964907AbWE0QfS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:35:18 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D0E557312D;
	Sat, 27 May 2006 18:35:16 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fk1wx-0006ue-Fr; Sat, 27 May 2006 18:47:39 +0200
To: junkio@cox.net
In-Reply-To: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20861>


This is a quick port of my initial patch for 1.0.7, that I had forgotten to
post.  Possibly needs some testing before applying to master.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 git-cvsexportcommit.perl |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 3e4e90b..57088c3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -2,7 +2,6 @@ #!/usr/bin/perl -w
 
 # Known limitations:
 # - cannot add or remove binary files
-# - cannot add parent directories when needed
 # - does not propagate permissions
 # - tells "ready for commit" even when things could not be completed
 #   (eg addition of a binary file)
@@ -11,7 +10,7 @@ use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
 use Data::Dumper;
-use File::Basename qw(basename);
+use File::Basename qw(basename dirname);
 
 unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
     die "GIT_DIR is not defined or is unreadable";
@@ -91,7 +90,7 @@ close MSG;
 `git-cat-file commit $commit | sed -e '1,/^\$/d' >> .msg`;
 $? && die "Error extracting the commit message";
 
-my (@afiles, @dfiles, @mfiles);
+my (@afiles, @dfiles, @mfiles, @dirs);
 my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
 #print @files;
 $? && die "Error in git-diff-tree";
@@ -99,7 +98,14 @@ foreach my $f (@files) {
     chomp $f;
     my @fields = split(m!\s+!, $f);
     if ($fields[4] eq 'A') {
-	push @afiles, $fields[5];
+        my $path = $fields[5];
+	push @afiles, $path;
+        # add any needed parent directories
+	$path = dirname $path;
+	while (!-d $path and ! grep { $_ eq $path } @dirs) {
+	    unshift @dirs, $path;
+	    $path = dirname $path;
+	}
     }
     if ($fields[4] eq 'M') {
 	push @mfiles, $fields[5];
@@ -114,13 +120,21 @@ undef @files; # don't need it anymore
 
 # check that the files are clean and up to date according to cvs
 my $dirty;
+foreach my $d (@dirs) {
+    if (-e $d) {
+	$dirty = 1;
+	warn "$d exists and is not a directory!\n";
+    }
+}
 foreach my $f (@afiles) {
     # This should return only one value
     my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
     if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
-    unless ($status[0] =~ m/Status: Unknown$/) {
+    if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
+	and $status[0] !~ m/^File: no file /) {
  	$dirty = 1;
 	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
+	warn "Status was: $status\n";
     }
 }
 foreach my $f (@mfiles, @dfiles) {
@@ -146,6 +160,19 @@ ###       you MUST call cleanupcvs(@file
 ###
 
 
+print "Creating new directories\n";
+foreach my $d (@dirs) {
+    unless (mkdir $d) {
+        warn "Could not mkdir $d: $!";
+	$dirty = 1;
+    }
+    `cvs add $d`;
+    if ($?) {
+	$dirty = 1;
+	warn "Failed to cvs add directory $d -- you may need to do it manually";
+    }
+}
+
 print "'Patching' binary files\n";
 
 my @bfiles = grep(m/^Binary/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit));
