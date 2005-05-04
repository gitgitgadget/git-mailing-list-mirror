From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-relink-script, a tool to hardlink two existing repositories.
Date: Wed, 4 May 2005 01:54:01 -0400
Message-ID: <20050504055401.GC1740@mythryan2.michonline.com>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com> <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 07:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTCjv-0007E2-Dy
	for gcvg-git@gmane.org; Wed, 04 May 2005 07:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVEDFyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 01:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEDFyV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 01:54:21 -0400
Received: from mail.autoweb.net ([198.172.237.26]:18663 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262034AbVEDFyF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 01:54:05 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DTCpe-0008KC-6t; Wed, 04 May 2005 01:54:02 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DTCpe-000113-00; Wed, 04 May 2005 01:54:02 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DTCpd-0006Pe-SS; Wed, 04 May 2005 01:54:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Add git-relink-script, which will find common objects in two git
repositories and replace one copy with a hardlink.

Signed-Off-By: Ryan Anderson <ryan@michonline.com>

---
commit a3bcc763d71bdb91a3b48e9105fbaa5e79abb807
tree 2553e2d8befbe0cda3e413616fd4cc7bf04157ad
parent a31c6d022e2435a514fcc8ca57f9995c4376a986
author Ryan Anderson <ryan@mythryan2.(none)> 1115185675 -0400
committer Ryan Anderson <ryan@michonline.com> 1115185675 -0400

Index: Makefile
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/Makefile  (mode:100644 sha1:99b4753d34879842b972da9b68694c9d0485f216)
+++ 2553e2d8befbe0cda3e413616fd4cc7bf04157ad/Makefile  (mode:100644 sha1:a99665e252a2342caa84238e886a80a5f27ac3c8)
@@ -13,7 +13,7 @@
 AR=ar
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script
+	git-pull-script git-tag-script git-relink-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
Index: git-relink-script
===================================================================
--- /dev/null  (tree:51a882a2dc62e0d3cdc79e0badc61559fb723481)
+++ 2553e2d8befbe0cda3e413616fd4cc7bf04157ad/git-relink-script  (mode:100644 sha1:78c954edcc370d8be951c856bfbfd38975d08348)
@@ -0,0 +1,115 @@
+#!/usr/bin/env perl
+# Copyright 2005, Ryan Anderson <ryan@michonline.com>
+# Distribution permitted under the GPL v2, as distributed
+# by the Free Software Foundation.
+# Later versions of the GPL at the discretion of Linus Torvalds
+#
+# Scan two git object-trees, and hardlink any common objects between them.
+
+use 5.006;
+use strict;
+use warnings;
+
+sub get_canonical_form($);
+sub do_scan_directory($$$);
+sub compare_two_files($$);
+
+# stats
+my $linked = 0;
+my $already = 0;
+
+my ($dir1, $dir2) = @ARGV;
+
+if (!defined $dir1 || !defined $dir2) {
+	print("Usage: $0 <dir1> <dir2>\nBoth dir1 and dir2 should contain a .git/objects/ subdirectory.\n");
+	exit(1);
+}
+
+$dir1 = get_canonical_form($dir1);
+$dir2 = get_canonical_form($dir2);
+
+printf("Searching '%s' and '%s' for common objects and hardlinking them...\n",$dir1,$dir2);
+
+opendir(D,$dir1 . "objects/")
+	or die "Failed to open $dir1/objects/ : $!";
+
+my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
+foreach my $hashdir (@hashdirs) {
+	do_scan_directory($dir1, $hashdir, $dir2);
+}
+
+printf("Linked %d files, %d were already linked.\n",$linked, $already);
+
+
+sub do_scan_directory($$$) {
+	my ($srcdir, $subdir, $dstdir) = @_;
+
+	my $sfulldir = sprintf("%sobjects/%s/",$srcdir,$subdir);
+	my $dfulldir = sprintf("%sobjects/%s/",$dstdir,$subdir);
+
+	opendir(S,$sfulldir)
+		or die "Failed to opendir $sfulldir: $!";
+
+	foreach my $file (grep(!/\.{1,2}$/, readdir(S))) {
+		my $sfilename = $sfulldir . $file;
+		my $dfilename = $dfulldir . $file;
+
+		compare_two_files($sfilename,$dfilename);
+
+	}
+	closedir(S);
+}
+
+sub compare_two_files($$) {
+	my ($sfilename, $dfilename) = @_;
+
+	# Perl's stat returns relevant information as follows:
+	# 0 = dev number
+	# 1 = inode number
+	# 7 = size
+	my @sstatinfo = stat($sfilename);
+	my @dstatinfo = stat($dfilename);
+
+	if (@sstatinfo == 0 && @dstatinfo == 0) {
+		die sprintf("Stat of both %s and %s failed: %s\n",$sfilename, $dfilename, $!);
+
+	} elsif (@dstatinfo == 0) {
+		return;
+	}
+
+	if ( ($sstatinfo[0] == $dstatinfo[0]) &&
+	     ($sstatinfo[1] != $dstatinfo[1])) {
+		if ($sstatinfo[7] == $dstatinfo[7]) {
+			unlink($dfilename)
+				or die "Unlink of $dfilename failed: $!\n";
+
+			link($sfilename,$dfilename)
+				or die "Failed to link $sfilename to $dfilename: $!\n" .
+					"Git Repository containing $dfilename is probably corrupted, please copy '$sfilename' to '$dfilename' to fix.\n";
+
+			$linked++;
+
+		} else {
+			die sprintf("ERROR: File sizes are not the same, cannot relink %s to %s.\n",
+				$sfilename, $dfilename);
+		}
+
+	} elsif ( ($sstatinfo[0] == $dstatinfo[0]) &&
+	     ($sstatinfo[1] == $dstatinfo[1])) {
+		$already++;
+	}
+}
+
+sub get_canonical_form($) {
+	my $dir = shift;
+	my $original = $dir;
+
+	die "$dir is not a directory." unless -d $dir;
+
+	$dir .= "/" unless $dir =~ m#/$#;
+	$dir .= ".git/" unless $dir =~ m#\.git/$#;
+
+	die "$original does not have a .git/ subdirectory.\n" unless -d $dir;
+
+	return $dir;
+}



-- 

Ryan Anderson
  sometimes Pug Majere
