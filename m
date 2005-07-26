From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Make git-rename-script behave much better when faced with input contain Perl regular expression metacharacters.
Date: Tue, 26 Jul 2005 02:56:57 -0400
Message-ID: <20050726065657.GI6098@mythryan2.michonline.com>
References: <20050725052646.GB6098@mythryan2.michonline.com> <7vpst7z9r9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 08:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxJNK-00066b-3q
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 08:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVGZG5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 02:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGZG5B
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 02:57:01 -0400
Received: from mail.autoweb.net ([198.172.237.26]:8588 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261770AbVGZG5A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 02:57:00 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxJN3-0000TG-Pe; Tue, 26 Jul 2005 02:56:57 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxJVs-0005YK-00; Tue, 26 Jul 2005 03:06:04 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxJN3-0004Kj-5U; Tue, 26 Jul 2005 02:56:57 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpst7z9r9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Also, restore support for the GIT_DIR

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 git-rename-script |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

1ed66638c7ce328d882639447b80099f096c2993
diff --git a/git-rename-script b/git-rename-script
--- a/git-rename-script
+++ b/git-rename-script
@@ -12,11 +12,8 @@ use strict;
 sub usage($);
 
 # Sanity checks:
-my $GIT_DIR = $$ENV{'GIT_DIR'};
-$GIT_DIR = ".git" unless defined $GIT_DIR;
-
-unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
-	-d $GIT_DIR . "/objects/00" && -d $GIT_DIR . "/refs") {
+unless ( -d ".git" && -d ".git/objects" && 
+	-d ".git/objects/00" && -d ".git/refs") {
 	usage("Git repository not found.");
 }
 
@@ -34,26 +31,23 @@ if (-e $dst) {
 
 my (@allfiles,@srcfiles,@dstfiles);
 
-$/ = "\0";
-open(F,"-|","git-ls-files","-z")
+open(F,"-|","git-ls-files")
 	or die "Failed to open pipe from git-ls-files: " . $!;
 
-@allfiles = map { chomp; $_; } <F>;
+@allfiles = <F>;
 close(F);
+chomp for @allfiles;
+
 
-my $safesrc = quotemeta($src);
-@srcfiles = grep /^$safesrc/, @allfiles;
+@srcfiles = grep /^$src/, @allfiles;
 @dstfiles = @srcfiles;
-s#^$safesrc(/|$)#$dst$1# for @dstfiles;
+s#^$src(/|$)#$dst$1# for @dstfiles;
 
 rename($src,$dst)
 	or die "rename failed: $!";
 
-my $rc = system("git-update-cache","--add","--",@dstfiles);
-die "git-update-cache failed to add new name with code $?\n" if $rc;
-
-$rc = system("git-update-cache","--remove","--",@srcfiles);
-die "git-update-cache failed to remove old name with code $?\n" if $rc;
+system("git-update-cache","--remove","--",@srcfiles);
+system("git-update-cache","--add","--",@dstfiles);
 
 
 sub usage($) {

-- 

Ryan Anderson
  sometimes Pug Majere
