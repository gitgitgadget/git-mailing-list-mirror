From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add support for renaming multiple items at once, and for the destination to be a directory.
Date: Mon, 31 Oct 2005 02:25:31 -0500
Message-ID: <11307435312942-git-send-email-ryan@michonline.com>
References: <7vzmp04uot.fsf@assigned-by-dhcp.cox.net>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 08:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWU32-0003AS-Fj
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 08:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVJaHZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 02:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVJaHZh
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 02:25:37 -0500
Received: from mail.autoweb.net ([198.172.237.26]:42115 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932322AbVJaHZg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 02:25:36 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EWU2y-0002Pv-1p; Mon, 31 Oct 2005 02:25:36 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EWU2x-0005GI-00; Mon, 31 Oct 2005 02:25:35 -0500
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.54)
	id 1EWU2t-00077a-HH; Mon, 31 Oct 2005 02:25:31 -0500
In-Reply-To: <7vzmp04uot.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10854>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

> *1* It strikes me that git rename *could* be friendlier by emulating
> how "mv" treats the paths parameters (current implementation insists
> two parameters $src and $dst).  What do you think, Ryan?

How does this look?

 Documentation/git-rename.txt |    1 +
 git-rename.perl              |   69 +++++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 24 deletions(-)

applies-to: 0146495a383d5af298e9c9ef33e1c5d506c63afc
172761431e16af8650f973fc16fae6e74935b422
diff --git a/Documentation/git-rename.txt b/Documentation/git-rename.txt
index 583cb03..17ca558 100644
--- a/Documentation/git-rename.txt
+++ b/Documentation/git-rename.txt
@@ -9,6 +9,7 @@ git-rename - Script used to rename a fil
 SYNOPSIS
 --------
 'git-rename' <source> <destination>
+'git-rename' <source> [source ... ] <destination directory>
 
 DESCRIPTION
 -----------
diff --git a/git-rename.perl b/git-rename.perl
index 3b1127b..51dec91 100755
--- a/git-rename.perl
+++ b/git-rename.perl
@@ -8,6 +8,9 @@
 
 use warnings;
 use strict;
+require 5.008;
+
+use File::Basename qw(basename);
 
 sub usage($);
 
@@ -19,40 +22,58 @@ unless ( -d $GIT_DIR && -d $GIT_DIR . "/
 	usage("Git repository not found.");
 }
 
-usage("") if scalar @ARGV != 2;
+usage("") if scalar @ARGV < 2;
 
-my ($src,$dst) = @ARGV;
+my $dst = pop @ARGV;
+my @src = @ARGV;
 
-unless (-f $src || -l $src || -d $src) {
-	usage("git rename: bad source '$src'");
+foreach my $src (@src) {
+	unless (-f $src || -l $src || -d $src) {
+		usage("git rename: bad source '$src'");
+	}
 }
 
-if (-e $dst) {
-	usage("git rename: destinations '$dst' already exists");
+if (-e $dst && !-d $dst) {
+	usage("git rename: destination '$dst' already exists");
 }
 
-my (@allfiles,@srcfiles,@dstfiles);
-
-$/ = "\0";
-open(F,"-|","git-ls-files","-z")
-	or die "Failed to open pipe from git-ls-files: " . $!;
+# Append a "/" if one doesn't exist on the end of $dst, and $dst is
+# a directory.
+$dst .= "/" if -d $dst && $dst !~ m#/$#;
+
+foreach my $src (@src) {
+	my (@allfiles,@srcfiles,@dstfiles);
+	my $actualdst = $dst;
+
+	$/ = "\0";
+	open(F,"-|","git-ls-files","-z")
+		or die "Failed to open pipe from git-ls-files: " . $!;
+
+	@allfiles = map { chomp; $_; } <F>;
+	close(F);
+
+	if (-d $src) {
+		# Remove a trailing / if any
+		$src =~ s#/$##;
+		my $tsrc = basename $src;
+		$actualdst = $dst . $tsrc;
+	}
+
+	my $safesrc = quotemeta($src);
+	@srcfiles = grep /^$safesrc/, @allfiles;
+	@dstfiles = @srcfiles;
+	s#^$safesrc(/|$)#$actualdst$1# for @dstfiles;
 
-@allfiles = map { chomp; $_; } <F>;
-close(F);
 
-my $safesrc = quotemeta($src);
-@srcfiles = grep /^$safesrc/, @allfiles;
-@dstfiles = @srcfiles;
-s#^$safesrc(/|$)#$dst$1# for @dstfiles;
+	rename($src,$actualdst)
+		or die "rename($src,$actualdst) failed: $!";
 
-rename($src,$dst)
-	or die "rename failed: $!";
+	my $rc = system("git-update-index","--add","--",@dstfiles);
+	die "git-update-index failed to add new name (related to $src and $dst) with code $?\n" if $rc;
 
-my $rc = system("git-update-index","--add","--",@dstfiles);
-die "git-update-index failed to add new name with code $?\n" if $rc;
-
-$rc = system("git-update-index","--remove","--",@srcfiles);
-die "git-update-index failed to remove old name with code $?\n" if $rc;
+	$rc = system("git-update-index","--remove","--",@srcfiles);
+	die "git-update-index failed to remove old name (related to $src) with code $?\n" if $rc;
+}
 
 
 sub usage($) {
---
0.99.9.GIT
