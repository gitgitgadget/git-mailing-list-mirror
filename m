From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 1/5] difftool: print_tool_help() globals
Date: Tue, 24 Jul 2012 19:59:29 -0700
Message-ID: <1343185173-48278-2-git-send-email-davvid@gmail.com>
References: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Strp4-0001za-2V
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809Ab2GYC7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab2GYC7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so634306pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fFaZoxOmwRiV0FATtNrPigdmw5GMipHZnFm/XsBp6HE=;
        b=C/jgmdRCdXQ06x2Nhrv+A6SMC2XCskAZHoEorWgkrN7oe6Huz7TlurOsUvf+iWGKAd
         gSL2tC2JP7T7EJPnc/FBVGoPFXX2ht44Z80MP6L3WkUcdDjrO54Uo3XdlRx2PT54+xBh
         SoLk4Z8cz+Rz7XC5eAe7c+Ql9q3xNVgv2MeX0NmxE7QGA0tuOdqlTm6ChKBarDhY9EEv
         ikm8Iw+kD1bQbhwOnHrNViCXybHr/XorrYAdv+iqarYiGb82WRuLHZebfH5UIEMQn70b
         bo3CACuW+y5GjVgHZVnDs6+YJT5P1tfIHItDAL1oeevuQl1pgmnTKy4WalOaIe5oXOE4
         2L4A==
Received: by 10.68.226.131 with SMTP id rs3mr49261175pbc.62.1343185173057;
        Tue, 24 Jul 2012 19:59:33 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202095>

Replace a global variable with a closure.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Differences from last time:

This keeps the original File::Find implementation and wraps the
global variable in a closure as the first step in the
globals-elimination cleanup.

 git-difftool.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index c079854..d4737e1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -23,7 +23,6 @@ use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
-my @tools;
 my @working_tree;
 my $rc;
 my $repo = Git->repository();
@@ -67,6 +66,7 @@ my $workdir = find_worktree();
 
 sub filter_tool_scripts
 {
+	my ($tools) = @_;
 	if (-d $_) {
 		if ($_ ne ".") {
 			# Ignore files in subdirectories
@@ -74,17 +74,17 @@ sub filter_tool_scripts
 		}
 	} else {
 		if ((-f $_) && ($_ ne "defaults")) {
-			push(@tools, $_);
+			push(@$tools, $_);
 		}
 	}
 }
 
 sub print_tool_help
 {
-	my ($cmd, @found, @notfound);
+	my ($cmd, @found, @notfound, @tools);
 	my $gitpath = Git::exec_path();
 
-	find(\&filter_tool_scripts, "$gitpath/mergetools");
+	find(sub { filter_tool_scripts(\@tools) }, "$gitpath/mergetools");
 
 	foreach my $tool (@tools) {
 		$cmd  = "TOOL_MODE=diff";
-- 
1.7.12.rc0.15.g8157c39
