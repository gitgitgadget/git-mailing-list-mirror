From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Add findtags - reworked
Date: Thu, 13 Oct 2005 21:56:50 +1300
Message-ID: <11291938104157-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Oct 13 10:57:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPytV-0003GM-Ow
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVJMI4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 04:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJMI4y
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 04:56:54 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:43237 "HELO
	mx.nzl.com.ar") by vger.kernel.org with SMTP id S932483AbVJMI4y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 04:56:54 -0400
Received: (qmail 15101 invoked from network); 13 Oct 2005 08:56:41 -0000
Received: from unknown (HELO aporo.local) (192.168.0.35)
  by 202-0-36-112.cable.paradise.net.nz with SMTP; 13 Oct 2005 08:56:41 -0000
X-Mailer: git-send-email
In-Reply-To: 
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10068>

A short perl script that will walk the tag refs, tag objects, and even commit
objects in its quest to figure out whether the given SHA1 (for a commit or
tree) was ever tagged.

This version is reworked incorporating sanity, feature and style fixes from
Junio.

Usage: git-findtags.perl [ -t ] <commit-or-tree-sha1>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Makefile          |    3 +-
 git-findtags.perl |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletions(-)
 create mode 100755 git-findtags.perl

applies-to: ef9b5c2cb61cf509adf2f5ef37fa1db517291f48
342d4cd1c66d8e58e1ba2221366c9237f9197b03
diff --git a/Makefile b/Makefile
index 8697d52..a5d9cd4 100644
--- a/Makefile
+++ b/Makefile
@@ -93,7 +93,8 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl
+	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
+	git-findtags.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-findtags.perl b/git-findtags.perl
new file mode 100755
index 0000000..745affe
--- /dev/null
+++ b/git-findtags.perl
@@ -0,0 +1,94 @@
+#!/usr/bin/perl -w
+#
+# Copyright (c) 2005 Martin Langhoff
+#
+# Walk the tags and find if they match a commit
+# expects a SHA1 of a commit. Option -t enables 
+# searching trees too.
+#
+
+use strict;
+use File::Basename;
+use File::Find;
+use Getopt::Std;
+
+my $git_dir = $ENV{GIT_DIR} || '.git';
+$git_dir =~ s|/$||; # chomp trailing slash
+
+# options
+our $opt_t;
+getopts("t") || usage();
+
+my @tagfiles   = `find $git_dir/refs/tags -follow -type f`; # haystack
+my $target = shift @ARGV;                     # needle
+unless ($target) {
+    usage();
+}
+
+# drive the processing from the find hook
+# slower, safer (?) than the find utility
+find( { wanted   => \&process,
+	no_chdir => 1,
+	follow   => 1,
+      }, "$git_dir/refs/tags");
+
+
+sub process {
+    my ($dev,$ino,$mode,$nlink,$uid,$gid);
+
+    # process only regular files
+    unless ((($dev,$ino,$mode,$nlink,$uid,$gid) = lstat($_)) && -f _) {
+	return 1; # ignored anyway
+    }
+
+    my $tagfile = $_;
+    chomp $tagfile;
+    my $tagname = substr($tagfile, length($git_dir.'/refs/tags/'));
+
+    my $tagid = quickread($tagfile);
+    chomp $tagid;
+
+    # is it just a soft tag?
+    if ($tagid eq $target) {
+	print "$tagname\n";
+	return 1; # done with this tag
+    }
+
+    # grab the first 2 lines (the whole tag could be large)
+    my $tagobj = `git-cat-file tag $tagid | head -n2 `;
+    if ($tagobj =~  m/^type commit$/m) { # only deal with commits
+
+	if ($tagobj =~ m/^object $target$/m) { # match on the commit
+	    print "$tagname\n";
+
+	} elsif ( $opt_t &&                      # follow the commit
+		 $tagobj =~ m/^object (\S+)$/m) { # and try to match trees
+	    my $commitid = $1;
+	    my $commitobj = `git-cat-file commit $commitid | head -n1`;
+	    chomp $commitobj;
+	    $commitobj =~ m/^tree (\S+)$/;
+	    my $treeid = $1;
+	    if ($target eq $treeid) {
+		print "$tagname\n";
+	    }
+	}
+    }
+}
+
+sub quickread {
+    my $file = shift;
+    local $/; # undef: slurp mode
+    open FILE, "<$file"
+	or die "Cannot open $file : $!";
+    my $content = <FILE>;
+    close FILE;
+    return $content;
+}
+
+sub usage {
+	print STDERR <<END;
+Usage: ${\basename $0}     # find tags for a commit or tree
+       [ -t ] <commit-or-tree-sha1>
+END
+	exit(1);
+}
---
0.99.8.GIT
