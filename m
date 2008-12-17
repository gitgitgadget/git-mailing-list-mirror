From: Neil Roberts <bpeeluk@yahoo.co.uk>
Subject: [PATCH] Add git-edit-index.perl
Date: Wed, 17 Dec 2008 20:47:49 +0000
Message-ID: <20081217204749.GA18261@janet.wally>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 21:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3KQ-0005XS-Kk
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYLQUrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbYLQUrw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:47:52 -0500
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:29504 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYLQUrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:47:52 -0500
X-IronPort-AV: E=Sophos;i="4.36,238,1228089600"; 
   d="scan'208";a="55613795"
Received: from unknown (HELO localhost) ([91.84.60.59])
  by smtpout.karoo.kcom.com with ESMTP; 17 Dec 2008 20:47:49 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103389>

This script can be used to edit a file in the index without affecting
your working tree. It checkouts a copy of the file to a temporary file
and runs an editor on it. If the editor completes successfully with a
non-empty file then it updates the index with the new data.

This is useful to fine tune the results from git add -p. For example
sometimes your unrelated changes are too close together and
git-add--interactive will refuse to split them up. Using this script
you can add both the changes and later edit the index file to
temporarily remove one of the changes.

Signed-off-by: Neil Roberts <bpeeluk@yahoo.co.uk>
---
 .gitignore          |    1 +
 Makefile            |    1 +
 git-edit-index.perl |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100755 git-edit-index.perl

diff --git a/.gitignore b/.gitignore
index d9adce5..251d90b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@ git-diff-files
 git-diff-index
 git-diff-tree
 git-describe
+git-edit-index
 git-fast-export
 git-fast-import
 git-fetch
diff --git a/Makefile b/Makefile
index 5158197..77ee97f 100644
--- a/Makefile
+++ b/Makefile
@@ -275,6 +275,7 @@ SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
 SCRIPT_PERL += git-cvsserver.perl
+SCRIPT_PERL += git-edit-index.perl
 SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
diff --git a/git-edit-index.perl b/git-edit-index.perl
new file mode 100755
index 0000000..a5d9886
--- /dev/null
+++ b/git-edit-index.perl
@@ -0,0 +1,98 @@
+#!/usr/bin/perl -w
+#
+# Copyright 2008 Neil Roberts <bpeeluk@yahoo.co.uk>
+#
+# GPL v2 (See COPYING)
+#
+# Opens an editor on a copy of a file in the index and updates it when
+# the editor is finished. This can be used to fine tune to results of
+# git add -p
+
+use strict;
+use warnings;
+use Git;
+
+sub usage {
+	print <<EOT;
+git edit-index <file>...
+EOT
+	exit(1);
+}
+
+sub delete_temp_files {
+        # Delete the temporary files created by checkout-index
+        # --temp. The output from checkout-index should be passed as
+        # arguments
+        foreach my $fnfull (@_) {
+                my ($tmp_fn, $fn) = split(/\t/, $fnfull);
+                unlink($tmp_fn);
+        }
+}
+
+sub check_file_size {
+        my ($fn) = @_;
+        my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
+            $atime, $mtime, $ctime, $blksize, $blocks) = stat($fn);
+
+        $size;
+}
+
+usage unless @ARGV;
+
+my $repo = Git->repository();
+
+my %file_modes;
+
+my $editor = $ENV{GIT_EDITOR}
+    || $repo->config("core.editor")
+    || $ENV{VISUAL}
+    || $ENV{EDITOR}
+    || "vi";
+
+# Create a temporary copy of each file in the index
+my @file_list = $repo->command(qw(checkout-index --temp --), @ARGV);
+
+# Get the current mode of each file
+foreach my $fnfull (@file_list) {
+        my ($tmp_fn, $fn) = split(/\t/, $fnfull);
+        my ($file_details) = $repo->command_oneline(qw(ls-files --stage --),
+                                                    $fn);
+        unless (defined($file_details) && $file_details =~ /\A([0-7]{6}) /)
+        {
+                delete_temp_files(@file_list);
+                die("$fn is not in the index");
+        }
+
+        $file_modes{$fn} = $1;
+}
+
+# Edit each file
+foreach my $fnfull (@file_list) {
+        my ($tmp_fn, $fn) = split(/\t/, $fnfull);
+
+        unless (system($editor, $tmp_fn) == 0
+                && check_file_size($tmp_fn)) {
+                # If the editor failed, the file has disappeared or it
+                # has zero size then give up
+                delete_temp_files(@file_list);
+                die("Editor failed or file has zero size");
+        }
+}
+
+# Add each file back to the index
+foreach my $fnfull (@file_list) {
+        my ($tmp_fn, $fn) = split(/\t/, $fnfull);
+
+        my $hash = $repo->command_oneline(qw(hash-object -w --), $tmp_fn);
+
+        unless (defined($hash) && $hash =~ /\A[0-9a-f]{40}\z/) {
+                delete_temp_files(@file_list);
+                die("Failed to add new file");
+        }
+
+        $repo->command(qw(update-index --cacheinfo),
+                       $file_modes{$fn}, $hash, $fn);
+}
+
+# Clean up the temporary files
+delete_temp_files(@file_list);
-- 
1.5.6.3
