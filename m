From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/5] difftool: Simplify print_tool_help()
Date: Sun, 22 Jul 2012 20:57:07 -0700
Message-ID: <1343015831-17498-2-git-send-email-davvid@gmail.com>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9mN-0000L6-Cp
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab2GWD5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:57:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56934 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab2GWD5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:57:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so10168206pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YNvNTQLOZgYcyKyql1PcT6NxdoqDYw9B3XEN3pkX9ys=;
        b=Bq5hRprbRKYyndXHZaxSZAYVBtSC5TgcZJw54XhFKhjeaxqJYWhRPhF1F8K/ob3Keq
         inSvMLHQcqIP2u/WUoGdfvjHefcr8cYkp7IsS+7wkdSPioXSMo0oK8yh/oeYFs57PG6C
         ru7n6jmQQl7S/erv5ul3GW1C/2A0Bs6Z7YtWocnHI30SUz01+GxBJ36wWK/7mJrked4C
         EKAAf/gVY0SEnCuaitAGlCT/gT9JgnpOOSdgqK89eW3HFG4CxjnXCY7pUy6noCYoMQJ9
         /tww+43oILMLRjqpL7AHIUSUbuLQsgcL2lGBlvKfJmlsLJ6uUM/RslM7yanejk1ENHB8
         6Iyg==
Received: by 10.68.238.166 with SMTP id vl6mr9033562pbc.96.1343015827865;
        Sun, 22 Jul 2012 20:57:07 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id iw10sm8485543pbc.55.2012.07.22.20.57.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:57:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343015831-17498-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201887>

Eliminate a global variable and File::Find usage by building upon
basename() and glob() instead.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Same as before, resending because gmail ate patch 4/5

 git-difftool.perl | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index c079854..ac0ed63 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -13,17 +13,15 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(dirname);
+use File::Basename qw(basename dirname);
 use File::Copy;
 use File::Compare;
-use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
-my @tools;
 my @working_tree;
 my $rc;
 my $repo = Git->repository();
@@ -65,26 +63,13 @@ sub find_worktree
 
 my $workdir = find_worktree();
 
-sub filter_tool_scripts
-{
-	if (-d $_) {
-		if ($_ ne ".") {
-			# Ignore files in subdirectories
-			$File::Find::prune = 1;
-		}
-	} else {
-		if ((-f $_) && ($_ ne "defaults")) {
-			push(@tools, $_);
-		}
-	}
-}
-
 sub print_tool_help
 {
 	my ($cmd, @found, @notfound);
 	my $gitpath = Git::exec_path();
 
-	find(\&filter_tool_scripts, "$gitpath/mergetools");
+	my @files = map { basename($_) } glob("$gitpath/mergetools/*");
+	my @tools = sort(grep { !m{^defaults$} } @files);
 
 	foreach my $tool (@tools) {
 		$cmd  = "TOOL_MODE=diff";
@@ -99,10 +84,10 @@ sub print_tool_help
 	}
 
 	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
-	print "\t$_\n" for (sort(@found));
+	print "\t$_\n" for (@found);
 
 	print "\nThe following tools are valid, but not currently available:\n";
-	print "\t$_\n" for (sort(@notfound));
+	print "\t$_\n" for (@notfound);
 
 	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
 	print "environment. If run in a terminal-only session, they will fail.\n";
-- 
1.7.11.2.255.g5f133da
