From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Remove git-findtags.perl
Date: Tue, 01 Nov 2005 21:26:03 +0100
Message-ID: <20051101202603.16900.9063.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:28:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX2ht-0005TD-By
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 21:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVKAU0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVKAU0G
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 15:26:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14468 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751133AbVKAU0F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 15:26:05 -0500
Received: (qmail 16916 invoked from network); 1 Nov 2005 21:26:03 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 21:26:03 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10952>

This script was superseded by git-name-rev, which is more versatile,
actually documented, faster, and everything else...

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile          |    2 +
 git-findtags.perl |   94 -----------------------------------------------------
 2 files changed, 1 insertions(+), 95 deletions(-)

diff --git a/Makefile b/Makefile
index 644b517..a2ba886 100644
--- a/Makefile
+++ b/Makefile
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
-	git-findtags.perl git-svnimport.perl git-mv.perl
+	git-svnimport.perl git-mv.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-findtags.perl b/git-findtags.perl
deleted file mode 100755
index 745affe..0000000
--- a/git-findtags.perl
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/usr/bin/perl -w
-#
-# Copyright (c) 2005 Martin Langhoff
-#
-# Walk the tags and find if they match a commit
-# expects a SHA1 of a commit. Option -t enables 
-# searching trees too.
-#
-
-use strict;
-use File::Basename;
-use File::Find;
-use Getopt::Std;
-
-my $git_dir = $ENV{GIT_DIR} || '.git';
-$git_dir =~ s|/$||; # chomp trailing slash
-
-# options
-our $opt_t;
-getopts("t") || usage();
-
-my @tagfiles   = `find $git_dir/refs/tags -follow -type f`; # haystack
-my $target = shift @ARGV;                     # needle
-unless ($target) {
-    usage();
-}
-
-# drive the processing from the find hook
-# slower, safer (?) than the find utility
-find( { wanted   => \&process,
-	no_chdir => 1,
-	follow   => 1,
-      }, "$git_dir/refs/tags");
-
-
-sub process {
-    my ($dev,$ino,$mode,$nlink,$uid,$gid);
-
-    # process only regular files
-    unless ((($dev,$ino,$mode,$nlink,$uid,$gid) = lstat($_)) && -f _) {
-	return 1; # ignored anyway
-    }
-
-    my $tagfile = $_;
-    chomp $tagfile;
-    my $tagname = substr($tagfile, length($git_dir.'/refs/tags/'));
-
-    my $tagid = quickread($tagfile);
-    chomp $tagid;
-
-    # is it just a soft tag?
-    if ($tagid eq $target) {
-	print "$tagname\n";
-	return 1; # done with this tag
-    }
-
-    # grab the first 2 lines (the whole tag could be large)
-    my $tagobj = `git-cat-file tag $tagid | head -n2 `;
-    if ($tagobj =~  m/^type commit$/m) { # only deal with commits
-
-	if ($tagobj =~ m/^object $target$/m) { # match on the commit
-	    print "$tagname\n";
-
-	} elsif ( $opt_t &&                      # follow the commit
-		 $tagobj =~ m/^object (\S+)$/m) { # and try to match trees
-	    my $commitid = $1;
-	    my $commitobj = `git-cat-file commit $commitid | head -n1`;
-	    chomp $commitobj;
-	    $commitobj =~ m/^tree (\S+)$/;
-	    my $treeid = $1;
-	    if ($target eq $treeid) {
-		print "$tagname\n";
-	    }
-	}
-    }
-}
-
-sub quickread {
-    my $file = shift;
-    local $/; # undef: slurp mode
-    open FILE, "<$file"
-	or die "Cannot open $file : $!";
-    my $content = <FILE>;
-    close FILE;
-    return $content;
-}
-
-sub usage {
-	print STDERR <<END;
-Usage: ${\basename $0}     # find tags for a commit or tree
-       [ -t ] <commit-or-tree-sha1>
-END
-	exit(1);
-}
