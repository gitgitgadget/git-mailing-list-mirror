From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Sun, 22 Jul 2012 20:42:16 -0700
Message-ID: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9Xz-00065r-A5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2GWDmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:42:16 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56673 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2GWDmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:42:15 -0400
Received: by gglu4 with SMTP id u4so5053842ggl.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Keqf4oJ7QneoO2/CWxSFspo+3a5IIKjwmz0YxIhXfr0=;
        b=zya8q2XH4PzRr54gV0V3xrJSLY7e2RxYf3SmMU6V75MbMzZ+2da0FUKsucj43UYUty
         QvkSACNHF0diW9Vev51psCjnugmQ6Q08Sjt8G+UoRUG28YArERVSDh7vxjgLYs5n0s3j
         77AuJAXiBjXId+izkZ73fDgtc8YvY4d0fG68k4XrgfC3KO3xdOQj6oyZhefw4coWjegf
         nEbZHmZhswNqcC7HH+IcDef/7WZLDJdAGeDQc1IMekbymerPcCij2cbMBm8PnZaJH6RE
         YLrCHXqYSY/iUxrJOlcLP1bOURlyDxgyirGRTVDDesbtM/G81mOdgW9AeRz/5NYiP7EI
         8k0A==
Received: by 10.66.87.136 with SMTP id ay8mr27717397pab.25.1343014934337;
        Sun, 22 Jul 2012 20:42:14 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ru10sm9051189pbc.50.2012.07.22.20.42.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:42:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201881>

Eliminate a global variable and File::Find usage by building upon
basename() and glob() instead.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index c079854..ac0ed63 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -13,17 +13,15 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(dirname);
+use File::Basename qw(basename dirname);
 use File::Copy;
 use File::Compare;
-use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
-my @tools;
 my @working_tree;
 my $rc;
 my $repo = Git->repository();
@@ -65,26 +63,13 @@ sub find_worktree
 
 my $workdir = find_worktree();
 
-sub filter_tool_scripts
-{
-	if (-d $_) {
-		if ($_ ne ".") {
-			# Ignore files in subdirectories
-			$File::Find::prune = 1;
-		}
-	} else {
-		if ((-f $_) && ($_ ne "defaults")) {
-			push(@tools, $_);
-		}
-	}
-}
-
 sub print_tool_help
 {
 	my ($cmd, @found, @notfound);
 	my $gitpath = Git::exec_path();
 
-	find(\&filter_tool_scripts, "$gitpath/mergetools");
+	my @files = map { basename($_) } glob("$gitpath/mergetools/*");
+	my @tools = sort(grep { !m{^defaults$} } @files);
 
 	foreach my $tool (@tools) {
 		$cmd  = "TOOL_MODE=diff";
@@ -99,10 +84,10 @@ sub print_tool_help
 	}
 
 	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
-	print "\t$_\n" for (sort(@found));
+	print "\t$_\n" for (@found);
 
 	print "\nThe following tools are valid, but not currently available:\n";
-	print "\t$_\n" for (sort(@notfound));
+	print "\t$_\n" for (@notfound);
 
 	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
 	print "environment. If run in a terminal-only session, they will fail.\n";
-- 
1.7.11.2.255.g5f133da
