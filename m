From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-find-new-files to spot files added to the tree, but not the repository
Date: Sat, 23 Jul 2005 03:42:19 -0400
Message-ID: <20050723074219.GB3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 09:43:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwEeq-0002Og-GQ
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 09:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGWHm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 03:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVGWHm1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 03:42:27 -0400
Received: from mail.autoweb.net ([198.172.237.26]:26797 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261514AbVGWHmW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 03:42:22 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwEeK-0004vE-6q; Sat, 23 Jul 2005 03:42:20 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwEmb-0003tK-00; Sat, 23 Jul 2005 03:50:53 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwEeJ-0000xS-Ij; Sat, 23 Jul 2005 03:42:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add git-find-new-files to find files that are in the tree, but not checked into the repository.

Most users will probably want to "make clean" before using this for real
significant changes, as it does such a good job that it finds binaries that
just got built.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Makefile           |    2 +-
 git-find-new-files |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletions(-)
 create mode 100755 git-find-new-files

028b21ae78dba3edab5e9b1a24cdf68011e42ab7
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote
+	git-branch-script git-parse-remote git-find-new-files
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-find-new-files b/git-find-new-files
new file mode 100755
--- /dev/null
+++ b/git-find-new-files
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+#
+# A simple script to take a look at all the files git knows about and compare
+# that to the files that we actually see in teh source tree, and output a
+# listing of the difference between them.
+#
+# The original command that did this is below, but a pure-Perl version can skip
+# the temp files.
+#
+#	find . -name .git -type d -prune -o -type f -print \
+#		| grep -v -e .tree1 -e .tree2 \
+#		| sed -e "s/^\.\///" \
+#		| sort >.tree1
+#	git-ls-files | grep -v -e .tree1 -e .tree2 \
+#		| sort >.tree2
+#	diff -u .tree1 .tree2
+
+use warnings;
+use strict;
+
+# Since we're using NUL (ASCII value of 0) to terminate strings,
+# set the field separator to that:
+$/ = "\0";
+
+my (%actual,%git);
+
+open(F,"-|","find . -name .git -type d -prune -o -type f -print0")
+	or die "Failed to open pipe from find: " . $!;
+
+while(<F>) {
+	chomp;
+	s#^\./##;
+	$actual{$_}++;
+}
+close(F);
+
+open(F,"-|","git-ls-files -z")
+	or die "Failed to open pipe from git-ls-files: " . $!;
+
+while(<F>) {
+	chomp;
+	delete $actual{$_};
+}
+close(F);
+
+foreach my $f (sort keys %actual) {
+	printf("A\t%s\n",$f);
+}
-- 

Ryan Anderson
  sometimes Pug Majere
