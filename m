From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Make git-reset delete empty directories
Date: Fri, 17 Feb 2006 02:26:16 -0500
Message-ID: <20060217072616.GA15358@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 17 08:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA00y-0003OE-PI
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 08:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWBQH0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 02:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWBQH0V
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 02:26:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:5270 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932546AbWBQH0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 02:26:20 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FA00Q-0004IL-2T
	for git@vger.kernel.org; Fri, 17 Feb 2006 02:26:18 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id BC74620FBA0; Fri, 17 Feb 2006 02:26:16 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16331>

When git-reset --hard is used and a subdirectory becomes
empty (as it contains no tracked files in the target tree)
the empty subdirectory should be removed.  This matches
the behavior of git-checkout-index and git-read-tree -m
which would not have created the subdirectory or would
have deleted it when updating the working directory.

Subdirectories which are not empty will be left behind.
This may happen if the subdirectory still contains object
files from the user's build process (for example).

---

 git-reset.sh     |   17 ++++++++++++---
 t/t7101-reset.sh |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100755 t/t7101-reset.sh

base 3397f9df53092871de2c33c143f1f4413654c40d
last 9e4158a26134a05e6011613976e26e7bfa813aca
diff --git a/git-reset.sh b/git-reset.sh
index fe53fc8065dc82c0054ba9891b28a00b0752bf87..8eac4640bc8dfb655f8429036b68644df027dea4 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -74,22 +74,33 @@ case "$reset_type" in
 	git-ls-files --cached -z |
 	perl -e '
 		use strict;
-		my (%keep, $fh);
+		my (%keep_file, %keep_dir, %rm_dir, $fh);
 		$/ = "\0";
 		while (<STDIN>) {
 			chomp;
-			$keep{$_} = 1;
+			$keep_file{$_} = 1;
+			while (s,/?[^/]+$,, && $_) {
+				last if $keep_dir{$_}++;
+			}
 		}
 		open $fh, "<", $ARGV[0]
 			or die "cannot open $ARGV[0]";
 		while (<$fh>) {
 			chomp;
-			if (! exists $keep{$_}) {
+			if (! exists $keep_file{$_}) {
 				# it is ok if this fails -- it may already
 				# have been culled by checkout-index.
 				unlink $_;
+				while (s,/?[^/]+$,, && $_ && !$keep_dir{$_}) {
+					last if $rm_dir{$_}++;
+				}
 			}
 		}
+		foreach (sort {length($b) <=> length($a)} keys %rm_dir) {
+			# it is ok if this fails -- it may have user files
+			# we do not track and thus should not delete.
+			rmdir $_;
+		}
 	' $tmp-exists
 	;;
 --soft )
diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
new file mode 100755
index 0000000000000000000000000000000000000000..a9191407f21c748f4c00bf909f670fc2b5124ec3
--- /dev/null
+++ b/t/t7101-reset.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn Pearce
+#
+
+test_description='git-reset should cull empty subdirs'
+. ./test-lib.sh
+
+test_expect_success \
+    'creating initial files' \
+    'mkdir path0 &&
+     cp ../../COPYING path0/COPYING &&
+     git-add path0/COPYING &&
+     git-commit -m add -a'
+
+test_expect_success \
+    'creating second files' \
+    'mkdir path1 &&
+     mkdir path1/path2 &&
+     cp ../../COPYING path1/path2/COPYING &&
+     cp ../../COPYING path1/COPYING &&
+     cp ../../COPYING COPYING &&
+     cp ../../COPYING path0/COPYING-TOO &&
+     git-add path1/path2/COPYING &&
+     git-add path1/COPYING &&
+     git-add COPYING &&
+     git-add path0/COPYING-TOO &&
+     git-commit -m change -a'
+
+test_expect_success \
+    'resetting tree HEAD^' \
+    'git-reset --hard HEAD^'
+
+test_expect_success \
+    'checking initial files exist after rewind' \
+    'test -d path0 &&
+     test -f path0/COPYING'
+
+test_expect_failure \
+    'checking lack of path1/path2/COPYING' \
+    'test -f path1/path2/COPYING'
+
+test_expect_failure \
+    'checking lack of path1/COPYING' \
+    'test -f path1/COPYING'
+
+test_expect_failure \
+    'checking lack of COPYING' \
+    'test -f COPYING'
+
+test_expect_failure \
+    'checking checking lack of path1/COPYING-TOO' \
+    'test -f path0/COPYING-TOO'
+
+test_expect_failure \
+    'checking lack of path1/path2' \
+    'test -d path1/path2'
+
+test_expect_failure \
+    'checking lack of path1' \
+    'test -d path1'
+
+test_done
