From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 3/9 v6] difftool: exit(0) when usage is printed
Date: Thu, 22 Mar 2012 15:52:18 -0400
Message-ID: <1332445944-10944-4-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4a-0005Ez-KO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab2CVTxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:20 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50321 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2CVTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:18 -0400
Received: by qcqw6 with SMTP id w6so1554395qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9KRXocIuVgBfu/j17YJ2vKV0+xSI1+iuC/698ouFZZw=;
        b=rgO7VhjlTMdFEbx+EZFQ/fF3FQTfAiHSeWcVudAddvSPW3HOS61hgVxbuCygLjCN+G
         fBccFW1+Sa60KbUlxujeXcDb+bbj32cG3Cs9N7cBqsZAkuD7nfzQTq1jHUyWVkZ1KdLv
         U3iFFpKVqpCux63zl+BrSUK+CUDLcmMZ5ZqIPJf9D+ZRRKp8y/Qmxp0KhihCLP/B4Iqc
         NVX+/hcKkhO3q5IvBYSJZknyKHOlAAHrqn/5AYh/Jk0uxAeeMgi43Rwb6dWqMYM6ACRJ
         gqiPFTXROiU8k9MDHt/h5hP9rPZ6FxB5cBspFzENqRqSwiSCH2xC23jGxBXH9YIMx5e6
         UCPQ==
Received: by 10.224.116.197 with SMTP id n5mr12779811qaq.3.1332445998391;
        Thu, 22 Mar 2012 12:53:18 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id dm8sm9978425qab.18.2012.03.22.12.53.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193702>

Prior to this commit, the script exited with an error whenever the
usage string was printed, regardless of the reason it was done. In
cases where usage was printed due to a user request (e.g. '-h'
option), the script should exit without error (exit 0).

This commit adds an argument to the usage function that allows the
exit code to be specified when the function is called.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index bf51b79..33ae30a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -20,6 +20,7 @@ use Git;
 
 sub usage
 {
+	my $exitcode = shift;
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>]
                     [-x|--extcmd=<cmd>]
@@ -27,7 +28,7 @@ usage: git difftool [-t|--tool=<tool>]
                     [--prompt] [-y|--no-prompt]
                     ['git diff' options]
 USAGE
-	exit 1;
+	exit($exitcode);
 }
 
 sub setup_environment
@@ -58,14 +59,14 @@ GetOptions('g|gui!' => \$gui,
 	'x|extcmd:s' => \$extcmd);
 
 if (defined($help)) {
-	usage();
+	usage(0);
 } 
 if (defined($difftool_cmd)) {
 	if (length($difftool_cmd) > 0) {
 		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
 	} else {
 		print "No <tool> given for --tool=<tool>\n";
-		usage();
+		usage(1);
 	}
 }
 if (defined($extcmd)) {
@@ -73,7 +74,7 @@ if (defined($extcmd)) {
 		$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
 	} else {
 		print "No <cmd> given for --extcmd=<cmd>\n";
-		usage();
+		usage(1);
 	}
 }
 if ($gui) {
-- 
1.7.10.rc1.36.g15e879
