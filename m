From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 13/9 v5] difftool: add '--no-gui' as an option
Date: Thu, 22 Mar 2012 11:02:21 -0400
Message-ID: <1332428541-24878-3-git-send-email-tim.henigan@gmail.com>
References: <1332428541-24878-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 16:09:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAjdd-0000IA-PG
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 16:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386Ab2CVPJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 11:09:14 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43136 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2CVPJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 11:09:11 -0400
Received: by mail-qc0-f174.google.com with SMTP id w6so1367266qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Yg30JMTJ+Wq8RP0sPDeM25mmYQ0NPhO4nwlDGvxPGhs=;
        b=lGtb7mAE3W2UKcSKt4T6VmEAEIkl/HEaA8vOH7vIXK4MIl0uPB+sq5IrW4NxcmFyf9
         Kix3Y8DNDiU4k8UXBe+doFTe218pV/W338Cc7PzJUDWZ/XRl3qcbNyT4D37lQCgXPoTw
         N9Ed7KTVH4T21ceXWWvE8xQbf6jUtAwWK18Fnuv8451J32xYHzCyEB3VmjE+Rw9nEYGW
         ors5MWA+DX1vbbnxM8SKr75mhK40ntUm7xeHyocZCA35s2uSBW756IxzmKn6sfx9AEDP
         1A2p0aVmz9XMuo4Ss5xlXfCiudahAbDQ0UnAiDmNoFqme+YdIWrwgjZsV4NwQAXQOZlT
         bMkw==
Received: by 10.224.9.141 with SMTP id l13mr11257423qal.52.1332428951073;
        Thu, 22 Mar 2012 08:09:11 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id by18sm6333513qab.12.2012.03.22.08.09.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 08:09:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.40.g756bbcd
In-Reply-To: <1332428541-24878-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193663>

This commit teaches difftool to handle the '--no-gui' option. This option
negates the existing '--gui' option. The last setting given on the command
line wins.

This allows a user to configure "[alias] mdt = difftool --gui", but still
have the ability to override the setting without error:

$ git mdt --no-gui

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch is new to the series. It fixes a potential bug pointed out
by Junio Hamano on the Git developers list [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/193601/focus=193633


 git-difftool.perl   |    7 ++++---
 t/t7800-difftool.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 9892d1e..d9be7d6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -29,7 +29,8 @@ sub usage
 	my $exitcode = shift;
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [--tool-help]
-                    [-x|--extcmd=<cmd>] [-g|--gui]
+                    [-x|--extcmd=<cmd>]
+                    [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
                     [-d|--dir-diff]
                     ['git diff' options]
@@ -132,7 +133,7 @@ sub setup_dir_diff
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
 my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
-GetOptions('g|gui' => \$gui,
+GetOptions('g|gui!' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
 	'prompt!' => \$prompt,
@@ -169,7 +170,7 @@ if (defined($extcmd)) {
 		usage(1);
 	}
 }
-if (defined($gui)) {
+if ($gui) {
 	my $guitool = "";
 	$guitool = Git::config('diff.guitool');
 	if (length($guitool) > 0) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 5f3ad3f..bbe71e5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -94,6 +94,19 @@ test_expect_success PERL 'difftool honors --gui' '
 	restore_test_defaults
 '
 
+test_expect_success PERL 'difftool --gui last setting wins' '
+	git config diff.guitool bogus-tool &&
+	git difftool --no-prompt --gui --no-gui &&
+
+	git config merge.tool bogus-tool &&
+	git config diff.tool bogus-tool &&
+	git config diff.guitool test-tool &&
+	diff=$(git difftool --no-prompt --no-gui --gui branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
 test_expect_success PERL 'difftool --gui works without configured diff.guitool' '
 	git config diff.tool test-tool &&
 
-- 
1.7.10.rc1.40.g756bbcd
