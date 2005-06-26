From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 14:15:16 -0400
Message-ID: <20050626181516.GC20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 26 20:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmbfb-0002VY-WD
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 20:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVFZSVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 14:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZSTM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 14:19:12 -0400
Received: from mail.autoweb.net ([198.172.237.26]:19592 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261546AbVFZSPS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 14:15:18 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dmbf3-0006B5-QD; Sun, 26 Jun 2005 14:15:17 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dmbj6-0001At-00; Sun, 26 Jun 2005 14:19:28 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1Dmbf3-0008KK-2A; Sun, 26 Jun 2005 14:15:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Add git-relink-script

This will scan 2 or more object repositories and look for common objects, check
if they are hardlinked, and replace one with a hardlink to the other if not.

This version warns when skipping files because of size differences, and
handle more than 2 repositories automatically.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry git-rebase-script
+	gitk git-cherry git-rebase-script git-relink-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-relink-script b/git-relink-script
new file mode 100644
--- /dev/null
+++ b/git-relink-script
@@ -0,0 +1,173 @@
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
+use Getopt::Long;
+
+sub get_canonical_form($);
+sub do_scan_directory($$$);
+sub compare_two_files($$);
+sub usage();
+sub link_two_files($$);
+
+# stats
+my $total_linked = 0;
+my $total_already = 0;
+my ($linked,$already);
+
+my $fail_on_different_sizes = 0;
+my $help = 0;
+GetOptions("safe" => \$fail_on_different_sizes,
+	   "help" => \$help);
+
+usage() if $help;
+
+my (@dirs) = @ARGV;
+
+usage() if (!defined $dirs[0] || !defined $dirs[1]);
+
+$_ = get_canonical_form($_) foreach (@dirs);
+
+my $master_dir = pop @dirs;
+
+opendir(D,$master_dir . "objects/")
+	or die "Failed to open $master_dir/objects/ : $!";
+
+my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
+
+foreach my $repo (@dirs) {
+	$linked = 0;
+	$already = 0;
+	printf("Searching '%s' and '%s' for common objects and hardlinking them...\n",
+		$master_dir,$repo);
+
+	foreach my $hashdir (@hashdirs) {
+		do_scan_directory($master_dir, $hashdir, $repo);
+	}
+
+	printf("Linked %d files, %d were already linked.\n",$linked, $already);
+
+	$total_linked += $linked;
+	$total_already += $already;
+}
+
+printf("Totals: Linked %d files, %d were already linked.\n",
+	$total_linked, $total_already);
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
+			link_two_files($sfilename, $dfilename);
+
+		} else {
+			my $err = sprintf("ERROR: File sizes are not the same, cannot relink %s to %s.\n",
+				$sfilename, $dfilename);
+			if ($fail_on_different_sizes) {
+				die $err;
+			} else {
+				warn $err;
+			}
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
+
+sub link_two_files($$) {
+	my ($sfilename, $dfilename) = @_;
+	my $tmpdname = sprintf("%s.old",$dfilename);
+	rename($dfilename,$tmpdname)
+		or die sprintf("Failure renaming %s to %s: %s",
+			$dfilename, $tmpdname, $!);
+
+	if (! link($sfilename,$dfilename)) {
+		my $failtxt = "";
+		unless (rename($tmpdname,$dfilename)) {
+			$failtxt = sprintf(
+				"Git Repository containing %s is probably corrupted, " .
+				"please copy '%s' to '%s' to fix.\n",
+				$tmpdname, $dfilename);
+		}
+
+		die sprintf("Failed to link %s to %s: %s\n%s" .
+			$sfilename, $dfilename,
+			$!, $dfilename, $failtxt);
+	}
+
+	unlink($tmpdname)
+		or die sprintf("Unlink of %s failed: %s\n",
+			$dfilename, $!);
+
+	$linked++;
+}
+
+
+sub usage() {
+	print("Usage: $0 [--safe] <dir> [<dir> ...] <master_dir> \n");
+	print("All directories should contain a .git/objects/ subdirectory.\n");
+	print("Options\n");
+	print("\t--safe\t" .
+		"Stops if two objects with the same hash exist but " .
+		"have different sizes.  Default is to warn and continue.\n");
+	exit(1);
+}
-- 

Ryan Anderson
  sometimes Pug Majere
