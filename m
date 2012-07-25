From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] difftool: Handle finding mergetools/ in a path with spaces
Date: Tue, 24 Jul 2012 20:14:22 -0700
Message-ID: <1343186064-49350-2-git-send-email-davvid@gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:15:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sts4C-0002WG-UE
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab2GYDOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:14:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64048 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab2GYDOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:14:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so653821pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8oz7ojw5JpX9ytZdVs7TJZ7O99zUMw03FA9pHSiWU10=;
        b=jl1R6HspibDzMItwC94kcdW/x/OFal52mj1r5FDIuzIVSxtc4HXUzw0p4yxmoQGNpc
         lQ4L+fMzBr27rvcnu4h5z/gAvHPYKQ65XLIUq7wr/XvPPTq5azlaeZ2Y9dfIOW3aPlCL
         pBknhDoNhKpGjw1yz1cy2HpM2t0YKV62iLmAdEENUkuiSC64cIQZUJG6kTN0gu7i2Ykk
         MQcwBQelwVfvcA01I/sxNyjO5MvhdhNBHK05HztPOS7URNJzHPkB8o3RbgxT4odqwGav
         FWQJAMQ51YCn92IJi9vqkXxes8Pm8xmE/0Up98wNaC0pMHPotQMENlfoewmqjhXInfNC
         35RQ==
Received: by 10.66.76.227 with SMTP id n3mr9290984paw.53.1343186071215;
        Tue, 24 Jul 2012 20:14:31 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ms9sm13401672pbb.43.2012.07.24.20.14.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:14:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202101>

Use the original File::Find implementation from bf73fc212a159210398b6d46ed5e9101c650e7db
so that we properly handle mergetools/ being located in a path containing
spaces.

One small difference is that we avoid using a global variable by
passing a reference to the list of tools.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5b371f..3057480 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -13,9 +13,10 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(basename dirname);
+use File::Basename qw(dirname);
 use File::Copy;
 use File::Compare;
+use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
@@ -58,13 +59,27 @@ sub find_worktree
 	return $worktree;
 }
 
+sub filter_tool_scripts
+{
+	my ($tools) = @_;
+	if (-d $_) {
+		if ($_ ne ".") {
+			# Ignore files in subdirectories
+			$File::Find::prune = 1;
+		}
+	} else {
+		if ((-f $_) && ($_ ne "defaults")) {
+			push(@$tools, $_);
+		}
+	}
+}
+
 sub print_tool_help
 {
-	my ($cmd, @found, @notfound);
+	my ($cmd, @found, @notfound, @tools);
 	my $gitpath = Git::exec_path();
 
-	my @files = map { basename($_) } glob("$gitpath/mergetools/*");
-	my @tools = sort(grep { !m{^defaults$} } @files);
+	find(sub { filter_tool_scripts(\@tools) }, "$gitpath/mergetools");
 
 	foreach my $tool (@tools) {
 		$cmd  = "TOOL_MODE=diff";
@@ -79,10 +94,10 @@ sub print_tool_help
 	}
 
 	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
-	print "\t$_\n" for (@found);
+	print "\t$_\n" for (sort(@found));
 
 	print "\nThe following tools are valid, but not currently available:\n";
-	print "\t$_\n" for (@notfound);
+	print "\t$_\n" for (sort(@notfound));
 
 	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
 	print "environment. If run in a terminal-only session, they will fail.\n";
-- 
1.7.12.rc0.15.g8157c39
