From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add support for directories to git-rename-script.
Date: Mon, 25 Jul 2005 01:26:47 -0400
Message-ID: <20050725052646.GB6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 07:27:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwvUU-0000S2-6y
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 07:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVGYF0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 01:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVGYF0u
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 01:26:50 -0400
Received: from mail.autoweb.net ([198.172.237.26]:43724 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261688AbVGYF0s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 01:26:48 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwvUF-0005Ca-Q5; Mon, 25 Jul 2005 01:26:47 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dwvcv-0002KJ-00; Mon, 25 Jul 2005 01:35:45 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwvUF-0004iH-2P; Mon, 25 Jul 2005 01:26:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Oh, and in the process, rewrite it in Perl.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 git-rename-script |   68 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 63 insertions(+), 5 deletions(-)

f46717f9116bba7efb6a10ed99cd2fcea00fe5da
diff --git a/git-rename-script b/git-rename-script
--- a/git-rename-script
+++ b/git-rename-script
@@ -1,7 +1,65 @@
-#!/bin/sh
+#!/usr/bin/perl
+#
+# Copyright 2005, Ryan Anderson <ryan@michonline.com>
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus Torvalds.
 
-. git-sh-setup-script || die "Not a git archive"
 
-[ -f "$1" ] || [ -h "$1" ] || die "git rename: bad source"
-[ -e "$2" ] && die "git rename: destination already exists"
-mv -- "$1" "$2" && git-update-cache --add --remove -- "$1" "$2"
+use warnings;
+use strict;
+
+sub usage($);
+
+# Sanity checks:
+unless ( -d ".git" && -d ".git/objects" && 
+	-d ".git/objects/00" && -d ".git/refs") {
+	usage("Git repository not found.");
+}
+
+usage("") if scalar @ARGV != 2;
+
+my ($src,$dst) = @ARGV;
+
+unless (-f $src || -l $src || -d $src) {
+	usage("git rename: bad source '$src'");
+}
+
+if (-e $dst) {
+	usage("git rename: destinations '$dst' already exists");
+}
+
+my (@allfiles,@srcfiles,@dstfiles);
+
+open(F,"-|","git-ls-files")
+	or die "Failed to open pipe from git-ls-files: " . $!;
+
+@allfiles = <F>;
+close(F);
+chomp for @allfiles;
+
+
+@srcfiles = grep /^$src/, @allfiles;
+@dstfiles = @srcfiles;
+s#^$src(/|$)#$dst$1# for @dstfiles;
+
+rename($src,$dst)
+	or die "rename failed: $!";
+
+system("git-update-cache","--remove","--",@srcfiles);
+system("git-update-cache","--add","--",@dstfiles);
+
+
+sub usage($) {
+	my $s = shift;
+	print $s, "\n" if (length $s != 0);
+	print <<EOT;
+$0 <source> <dest>
+source must exist and be either a file, symlink or directory.
+dest must NOT exist.
+
+Renames source to dest, and updates the git cache to reflect the change.
+Use "git commit" to make record the change permanently.
+EOT
+	exit(1);
+}

-- 

Ryan Anderson
  sometimes Pug Majere
