From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Make git-rename-script behave better with input containing Perl regexp metachars.
Date: Tue, 26 Jul 2005 03:40:28 -0400
Message-ID: <20050726074028.GL6098@mythryan2.michonline.com>
References: <20050725052646.GB6098@mythryan2.michonline.com> <7vpst7z9r9.fsf@assigned-by-dhcp.cox.net> <20050726065657.GI6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 09:41:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxK3P-0002Nb-KD
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 09:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVGZHke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 03:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGZHkb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 03:40:31 -0400
Received: from mail.autoweb.net ([198.172.237.26]:62606 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261841AbVGZHk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 03:40:29 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxK3A-00015l-P9; Tue, 26 Jul 2005 03:40:28 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxKBz-0006LM-00; Tue, 26 Jul 2005 03:49:35 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxK3A-0004yb-83; Tue, 26 Jul 2005 03:40:28 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050726065657.GI6098@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make git-rename-script behave much better when faced with input contain Perl
regular expression metacharacters.

Also, restore support for the GIT_DIR

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 git-rename-script |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

28d2bb7cbb38424c4c6879110bf8aff1e3e5ac42
diff --git a/git-rename-script b/git-rename-script
--- a/git-rename-script
+++ b/git-rename-script
@@ -12,8 +12,11 @@ use strict;
 sub usage($);
 
 # Sanity checks:
-unless ( -d ".git" && -d ".git/objects" && 
-	-d ".git/objects/00" && -d ".git/refs") {
+my $GIT_DIR = $$ENV{'GIT_DIR'};
+$GIT_DIR = ".git" unless defined $GIT_DIR;
+
+unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
+	-d $GIT_DIR . "/objects/00" && -d $GIT_DIR . "/refs") {
 	usage("Git repository not found.");
 }
 
@@ -31,23 +34,26 @@ if (-e $dst) {
 
 my (@allfiles,@srcfiles,@dstfiles);
 
-open(F,"-|","git-ls-files")
+$/ = "\0";
+open(F,"-|","git-ls-files","-z")
 	or die "Failed to open pipe from git-ls-files: " . $!;
 
-@allfiles = <F>;
+@allfiles = map { chomp; $_; } <F>;
 close(F);
-chomp for @allfiles;
-
 
-@srcfiles = grep /^$src/, @allfiles;
+my $safesrc = quotemeta($src);
+@srcfiles = grep /^$safesrc/, @allfiles;
 @dstfiles = @srcfiles;
-s#^$src(/|$)#$dst$1# for @dstfiles;
+s#^$safesrc(/|$)#$dst$1# for @dstfiles;
 
 rename($src,$dst)
 	or die "rename failed: $!";
 
-system("git-update-cache","--remove","--",@srcfiles);
-system("git-update-cache","--add","--",@dstfiles);
+my $rc = system("git-update-cache","--add","--",@dstfiles);
+die "git-update-cache failed to add new name with code $?\n" if $rc;
+
+$rc = system("git-update-cache","--remove","--",@srcfiles);
+die "git-update-cache failed to remove old name with code $?\n" if $rc;
 
 
 sub usage($) {
