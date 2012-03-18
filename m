From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/9 v2] difftool: exit(0) when usage is printed
Date: Sat, 17 Mar 2012 21:55:27 -0400
Message-ID: <1332035734-5443-3-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MW-0004Hw-1x
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268Ab2CRB4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930Ab2CRB4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:05 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5QIEgZd05kU5TtidBKWEGlhkg8YYeh59cTo/DZ6EtQk=;
        b=yvu7LsZjymm1pKUYJIq9fMGUVZwQZP1ENwE+CKT36nkMkBCsmxYRFW905/v+7Ycoc/
         sy43TZvCLgQj9SG5FIHotwYzYnY+i14BeKaEDDAIxRSliRiN06nWXUQv0twWqEpICsFx
         DG2uuNkBGuDzn/IC8PQY4ymbVaBDIYMadHO82Bfp3dWvoELuEMxxvVBAcGmkcHC4eYAn
         0PwKSl0hPDnQTDJor/DWT2w88EqaerWiCyGYwJmKhy+Z/6I4R5Ztr7XhpYXQ0zkaJpXH
         HXMqQINyBF9Jw16T5bcY7pbLF51o2V18N3iufWdRzt7KkFI9f13LXCnyzxT4P2Ikx1Y4
         Funw==
Received: by 10.50.106.168 with SMTP id gv8mr2887125igb.25.1332035764967;
        Sat, 17 Mar 2012 18:56:04 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id hq3sm9870337igc.0.2012.03.17.18.56.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193356>

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
index e365727..81ecf34 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -20,12 +20,13 @@ use Git;
 
 sub usage
 {
+	my $exitcode = shift;
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
                     [-y|--no-prompt]   [-g|--gui]
                     ['git diff' options]
 USAGE
-	exit 1;
+	exit($exitcode);
 }
 
 sub setup_environment
@@ -56,14 +57,14 @@ GetOptions('g|gui' => \$gui,
 	'y|no-prompt' => \$no_prompt);
 
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
@@ -71,7 +72,7 @@ if (defined($extcmd)) {
 		$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
 	} else {
 		print "No <cmd> given for --extcmd=<cmd>\n";
-		usage();
+		usage(1);
 	}
 }
 if (defined($gui)) {
-- 
1.7.9.1.290.gbd444
