From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] This commit implements git-mv
Date: Sun, 23 Oct 2005 18:15:34 +0200
Message-ID: <200510231815.35551.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 18:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETiVg-0005Uv-7S
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 18:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJWQPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 12:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVJWQPg
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 12:15:36 -0400
Received: from imap.gmx.net ([213.165.64.20]:31373 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750734AbVJWQPg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 12:15:36 -0400
Received: (qmail invoked by alias); 23 Oct 2005 16:15:30 -0000
Received: from p549695C7.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.149.199]
  by mail.gmx.net (mp029) with SMTP; 23 Oct 2005 18:15:30 +0200
X-Authenticated: #352111
To: junkio@cox.net
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10492>

It superceeds git-rename by adding functionality to move
multiple files, directories or symlinks into another directory.
It also provides according documentation.

The implementation renames multiple files, using the arguments
from the command line to produce an array of sources and destinations.
In a first pass, all requested renames are checked for errors, and
overwriting of existing files is only allowed with '-f'.
The actual renaming is done in a second pass.
This ensures that any error condition is checked before anything is
changed.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---
The recent request on the list for "mv" in GIT reminded me about
an addition to git-rename I made a week ago. I renamed it to
"git-mv" and added some documentation.

If this works, we can remove git-rename sometimes in the future.

I should complement this command with tests. Also, a nice addition
would be to support an interactive mode like 'mv', by asking if
files should be overwritten.

By the way, it also checks for a request to move a directory into
itself, which of course is an error.

Option "-k" is good for this:
E.g. a "git-mv -k * dir" moves all revision controlled files and
directories (but not "dir"!) into "dir". "-k" makes sure that
the errors (trying to move "dir" into itself, or move files
without revision control around) will not terminate the command
but silently ignored and skipped.
"-k" was taken from "make": Continue even on an error.

Josef

 Documentation/git-mv.txt |   51 +++++++++++++
 Makefile                 |    2 
 git-mv.perl              |  185 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-mv.txt
 create mode 100755 git-mv.perl

applies-to: b9f56dae60decf015079f5feef4544e7177b143a
0baacba7907046796e5a15eb2b191c1e2cb48793
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
new file mode 100644
index 0000000..f2d5882
--- /dev/null
+++ b/Documentation/git-mv.txt
@@ -0,0 +1,51 @@
+git-mv(1)
+=========
+
+NAME
+----
+git-mv - Script used to move or rename a file, directory or symlink.
+
+
+SYNOPSIS
+--------
+'git-mv' [-f] [-n] <source> <destination>
+'git-mv' [-f] [-k] [-n] <source> ... <destination directory>
+
+DESCRIPTION
+-----------
+This script is used to move or rename a file, directory or symlink.
+In the first form, it renames <source>, which must exist and be either
+a file, symlink or directory, to <destination>, which must not exist.
+In the second form, the last argument has to be an existing
+directory; the given sources will be moved into this directory.
+
+The index is updated after successful completion, but the change must still be
+committed.
+
+OPTIONS
+-------
+-f::
+	Force renaming or moving even targets exist
+-k::
+        Skip move or rename actions which would lead to an error
+	condition. An error happens when a source is neither existing nor
+        controlled by GIT, or when it would overwrite an existing
+        file unless '-f' is given.
+-n::
+	Do nothing; only show what would happen
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+Rewritten by Ryan Anderson <ryan@michonline.com>
+Move functionality added by Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 5ee72bc..b43c170 100644
--- a/Makefile
+++ b/Makefile
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
-	git-findtags.perl git-svnimport.perl
+	git-findtags.perl git-svnimport.perl git-mv.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-mv.perl b/git-mv.perl
new file mode 100755
index 0000000..28bced9
--- /dev/null
+++ b/git-mv.perl
@@ -0,0 +1,185 @@
+#!/usr/bin/perl
+#
+# Copyright 2005, Ryan Anderson <ryan@michonline.com>
+#                 Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus Torvalds.
+
+
+use warnings;
+use strict;
+use Getopt::Std;
+
+sub usage() {
+	print <<EOT;
+$0 [-f] [-n] <source> <dest>
+$0 [-f] [-k] [-n] <source> ... <dest directory>
+
+In the first form, source must exist and be either a file,
+symlink or directory, dest must not exist. It renames source to dest.
+In the second form, the last argument has to be an existing
+directory; the given sources will be moved into this directory.
+
+Updates the git cache to reflect the change.
+Use "git commit" to make the change permanently.
+
+Options:
+  -f   Force renaming/moving, even if target exists
+  -k   Continue on error by skipping
+       not-existing or not revision-controlled source
+  -n   Do nothing; show what would happen
+EOT
+	exit(1);
+}
+
+# Sanity checks:
+my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
+
+unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
+	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
+    print "Git repository not found.";
+    usage();
+}
+
+
+our ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
+getopts("hnfkv") || usage;
+usage() if $opt_h;
+@ARGV >= 1 or usage;
+
+my (@srcArgs, @dstArgs, @srcs, @dsts);
+my ($src, $dst, $base, $dstDir);
+
+my $argCount = scalar @ARGV;
+if (-d $ARGV[$argCount-1]) {
+	$dstDir = $ARGV[$argCount-1];
+	@srcArgs = @ARGV[0..$argCount-2];
+	
+	foreach $src (@srcArgs) {
+		$base = $src;
+		$base =~ s/^.*\///;
+		$dst = "$dstDir/". $base;
+		push @dstArgs, $dst;
+	}
+}
+else {
+    if ($argCount != 2) {
+	print "Error: moving to directory '"
+	    . $ARGV[$argCount-1]
+	    . "' not possible; not exisiting\n";
+	usage;
+    }
+    @srcArgs = ($ARGV[0]);
+    @dstArgs = ($ARGV[1]);
+    $dstDir = "";
+}
+
+my (@allfiles,@srcfiles,@dstfiles);
+my $safesrc;
+my %overwritten;
+
+$/ = "\0";
+open(F,"-|","git-ls-files","-z")
+        or die "Failed to open pipe from git-ls-files: " . $!;
+
+@allfiles = map { chomp; $_; } <F>;
+close(F);
+
+
+my ($i, $bad);
+while(scalar @srcArgs > 0) {
+    $src = shift @srcArgs;
+    $dst = shift @dstArgs;
+    $bad = "";
+
+    if ($opt_v) {
+	print "Checking rename of '$src' to '$dst'\n";
+    }
+
+    unless (-f $src || -l $src || -d $src) {
+	$bad = "bad source '$src'";
+    }
+
+    $overwritten{$dst} = 0;
+    if (($bad eq "") && -e $dst) {
+	$bad = "destination '$dst' already exists";
+	if (-f $dst && $opt_f) {
+	    print "Warning: $bad; will overwrite!\n";
+	    $bad = "";
+	    $overwritten{$dst} = 1;
+	}
+    }
+    
+    if (($bad eq "") && ($src eq $dstDir)) {
+	$bad = "can not move directory '$src' into itself";
+    }
+
+    if ($bad eq "") {
+	$safesrc = quotemeta($src);
+	@srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
+        if (scalar @srcfiles == 0) {
+	    $bad = "'$src' not under version control";
+	}
+    }
+
+    if ($bad ne "") {
+	if ($opt_k) {
+	    print "Warning: $bad; skipping\n";
+	    next;
+	}
+	print "Error: $bad\n";
+	usage();
+    }
+    push @srcs, $src;
+    push @dsts, $dst;
+}
+
+# Final pass: rename/move
+my (@deletedfiles,@addedfiles,@changedfiles);
+while(scalar @srcs > 0) {
+    $src = shift @srcs;
+    $dst = shift @dsts;
+
+    if ($opt_n || $opt_v) { print "Renaming $src to $dst\n"; }
+    if (!$opt_n) {
+	rename($src,$dst)
+	    or die "rename failed: $!";
+    }
+
+    $safesrc = quotemeta($src);
+    @srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
+    @dstfiles = @srcfiles;
+    s/^$safesrc(\/|$)/$dst$1/ for @dstfiles;
+
+    push @deletedfiles, @srcfiles;
+    if (scalar @srcfiles == 1) {
+	if ($overwritten{$dst} ==1) {
+	    push @changedfiles, $dst;
+	} else {
+	    push @addedfiles, $dst;
+	}
+    }
+    else {
+	push @addedfiles, @dstfiles;
+    }
+}
+
+if ($opt_n) {
+	print "Changed  : ". join(", ", @changedfiles) ."\n";
+	print "Adding   : ". join(", ", @addedfiles) ."\n";
+	print "Deleting : ". join(", ", @deletedfiles) ."\n";
+	exit(1);
+}
+	
+my $rc;
+if (scalar @changedfiles >0) {
+	$rc = system("git-update-index","--",@changedfiles);
+	die "git-update-index failed to update changed files with code $?\n" if $rc;
+}
+if (scalar @addedfiles >0) {
+	$rc = system("git-update-index","--add","--",@addedfiles);
+	die "git-update-index failed to add new names with code $?\n" if $rc;
+}
+$rc = system("git-update-index","--remove","--",@deletedfiles);
+die "git-update-index failed to remove old names with code $?\n" if $rc;
---
0.99.8.GIT
