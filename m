From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Add git-findtags
Date: Wed, 12 Oct 2005 16:19:29 +1300
Message-ID: <1129087169926-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 05:20:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPX9t-0004ZI-EC
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 05:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVJLDTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 23:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVJLDTZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 23:19:25 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56744 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932386AbVJLDTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 23:19:24 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=aporo.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with smtp (Exim 4.50)
	id 1EPX9H-0006Bu-9H; Wed, 12 Oct 2005 16:19:23 +1300
To: git@vger.kernel.org
X-Mailer: git-send-email
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9999>

A short perl script that will walk the tag refs, tag objects, and even commit
objects in its quest to figure out whether the given SHA1 (for a commit or
tree) was ever tagged.

Usage: git-findtags.perl [ -t ] <commit-or-tree-sha1>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Makefile          |    3 ++
 git-findtags.perl |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100755 git-findtags.perl

applies-to: ef9b5c2cb61cf509adf2f5ef37fa1db517291f48
58597ae99b77a690a788d2f096cecc1b7ae809fd
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
index 0000000..40eb284
--- /dev/null
+++ b/git-findtags.perl
@@ -0,0 +1,70 @@
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
+use Getopt::Std;
+
+my $git_dir = $ENV{GIT_DIR} || '.git';
+
+# options
+our $opt_t;
+getopts("t") || usage();
+
+my @tagfiles   = `find $git_dir/refs/tags -follow -type f`; # haystack
+my $target = shift @ARGV;                     # needle
+
+unless ($target) { 
+    usage();
+}
+
+
+foreach my $tagfile (@tagfiles) {
+    chomp $tagfile;
+    my $tagid = quickread($tagfile);
+    chomp $tagid;
+
+    # grab the first 2 lines (the whole tag could be large)
+    my $tagobj = `git-cat-file tag $tagid | head -n2 `;
+    if ($tagobj =~  m/^type commit$/m) { # only deal with commits
+
+	if ($tagobj =~ m/^object $target$/m) { # match on the commit
+	    print basename($tagfile) . "\n";
+
+	} elsif ( $opt_t &&                      # follow the commit
+		 $tagobj =~ m/^object (\S+)$/m) { # and try to match trees
+	    my $commitid = $1;
+	    my $commitobj = `git-cat-file commit $commitid | head -n1`;
+	    chomp $commitobj;
+	    $commitobj =~ m/^tree (\S+)$/;
+	    my $treeid = $1;
+	    if ($target eq $treeid) {
+		print  basename($tagfile) . "\n";
+	    }
+	}
+    }
+}
+
+sub quickread {
+    my $file = shift;
+    local $/; undef $/; # slurp mode
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
