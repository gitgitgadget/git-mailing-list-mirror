From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Remove git-rename. git-mv does the same
Date: Sun, 13 Nov 2005 15:08:00 +0100
Message-ID: <200511131508.00964.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 15:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbIWt-0006Ck-Hr
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 15:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVKMOII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 09:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVKMOII
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 09:08:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:32687 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932503AbVKMOIH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 09:08:07 -0500
Received: (qmail invoked by alias); 13 Nov 2005 14:08:04 -0000
Received: from p549699FE.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.153.254]
  by mail.gmx.net (mp016) with SMTP; 13 Nov 2005 15:08:04 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11741>

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

We have git-mv now since quite some time, and it does all which
git-rename did, as it is derived from it. Even if you want to
keep git-rename, it should be a symlink to git-mv instead.

 .gitignore                   |    1 -
 Documentation/git-rename.txt |   32 -------------------
 Documentation/git.txt        |    3 --
 Makefile                     |    2 +
 git-rename.perl              |   70 ------------------------------------------
 5 files changed, 1 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/git-rename.txt
 delete mode 100755 git-rename.perl

applies-to: e915ab830dbf42430138b4542278097d16f9f2f1
9a06e0c0981cae2417e4355ae7220f1e4bae5e85
diff --git a/.gitignore b/.gitignore
index 328b399..26398b3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,7 +74,6 @@ git-read-tree
 git-rebase
 git-receive-pack
 git-relink
-git-rename
 git-repack
 git-request-pull
 git-reset
diff --git a/Documentation/git-rename.txt b/Documentation/git-rename.txt
deleted file mode 100644
index 583cb03..0000000
--- a/Documentation/git-rename.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-git-rename(1)
-=============
-
-NAME
-----
-git-rename - Script used to rename a file, directory or symlink.
-
-
-SYNOPSIS
---------
-'git-rename' <source> <destination>
-
-DESCRIPTION
------------
-This script is used to rename a file, directory or symlink.
-
-The index is updated after successful completion, but the change must still be
-committed.
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-Rewritten by Ryan Anderson <ryan@michonline.com>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a9d47c1..62c8ce7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -262,9 +262,6 @@ gitlink:git-push[1]::
 gitlink:git-rebase[1]::
 	Rebase local commits to new upstream head.
 
-gitlink:git-rename[1]::
-	Rename files and directories.
-
 gitlink:git-repack[1]::
 	Pack unpacked objects in a repository.
 
diff --git a/Makefile b/Makefile
index 514ab60..24884ab 100644
--- a/Makefile
+++ b/Makefile
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
+	git-shortlog.perl git-fmt-merge-msg.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
diff --git a/git-rename.perl b/git-rename.perl
deleted file mode 100755
index 3b1127b..0000000
--- a/git-rename.perl
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/usr/bin/perl
-#
-# Copyright 2005, Ryan Anderson <ryan@michonline.com>
-#
-# This file is licensed under the GPL v2, or a later version
-# at the discretion of Linus Torvalds.
-
-
-use warnings;
-use strict;
-
-sub usage($);
-
-# Sanity checks:
-my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
-
-unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
-	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
-	usage("Git repository not found.");
-}
-
-usage("") if scalar @ARGV != 2;
-
-my ($src,$dst) = @ARGV;
-
-unless (-f $src || -l $src || -d $src) {
-	usage("git rename: bad source '$src'");
-}
-
-if (-e $dst) {
-	usage("git rename: destinations '$dst' already exists");
-}
-
-my (@allfiles,@srcfiles,@dstfiles);
-
-$/ = "\0";
-open(F,"-|","git-ls-files","-z")
-	or die "Failed to open pipe from git-ls-files: " . $!;
-
-@allfiles = map { chomp; $_; } <F>;
-close(F);
-
-my $safesrc = quotemeta($src);
-@srcfiles = grep /^$safesrc/, @allfiles;
-@dstfiles = @srcfiles;
-s#^$safesrc(/|$)#$dst$1# for @dstfiles;
-
-rename($src,$dst)
-	or die "rename failed: $!";
-
-my $rc = system("git-update-index","--add","--",@dstfiles);
-die "git-update-index failed to add new name with code $?\n" if $rc;
-
-$rc = system("git-update-index","--remove","--",@srcfiles);
-die "git-update-index failed to remove old name with code $?\n" if $rc;
-
-
-sub usage($) {
-	my $s = shift;
-	print $s, "\n" if (length $s != 0);
-	print <<EOT;
-$0 <source> <dest>
-source must exist and be either a file, symlink or directory.
-dest must NOT exist.
-
-Renames source to dest, and updates the git cache to reflect the change.
-Use "git commit" to make record the change permanently.
-EOT
-	exit(1);
-}
---
0.99.9.GIT
