From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/9 v6] difftool: add '--no-gui' option
Date: Thu, 22 Mar 2012 15:52:17 -0400
Message-ID: <1332445944-10944-3-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4P-00053X-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab2CVTxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:09 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35234 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2CVTxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:06 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so523561qad.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CtklRIvAxHunu1jjiVapem25XlFdlmuhxTYDqyRPAVo=;
        b=A3dDpOT/ED3/mxdfQzcdAGiN1HARxoz70GlT+CRA8S8pDdtoLXUFfUKcGzFljYUr5l
         xasQolKXba9RT4PJo0tWE3NrEoe+fMY6EeF2yXk83u2o0vB70WrtdXosX7O5iUvm+/ox
         cdR1RW4XrgOuVKhCkpXZNKLq+o8B50LmVQ4MC1BiIdPl52Gs1g3AfoRIgBdVV4LwGhxi
         dCFO+V0TkSWG/mwhuix3RmnauKdBIKiWtx3aX10VkgMtXsOL6y43VLFe/5Ny7MT5lYmn
         8CNxJsw8GvqtY68f3PUW7acxAbtFZzl7sNcX9ZHdpJCwpKRea5Z+BzZBgG+TG4tXz0JL
         eQJg==
Received: by 10.229.136.12 with SMTP id p12mr3607275qct.125.1332445986478;
        Thu, 22 Mar 2012 12:53:06 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id v8sm10000161qaa.11.2012.03.22.12.53.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193701>

This commit teaches difftool to handle the '--no-gui' option. This option
negates the existing '--gui' option. The last setting given on the command
line wins.

This allows a user to configure "[alias] mdt = difftool --gui", but still
have the ability to override the setting without error:

$ git mdt --no-gui

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v6:
  - This was patch 13/9 in the previous version of the series. It has
    simply been moved to 2/9.


 git-difftool.perl   |    7 ++++---
 t/t7800-difftool.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index f4e28a6..bf51b79 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -22,7 +22,8 @@ sub usage
 {
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>]
-                    [-x|--extcmd=<cmd>] [-g|--gui]
+                    [-x|--extcmd=<cmd>]
+                    [-g|--gui] [--no-gui]
                     [--prompt] [-y|--no-prompt]
                     ['git diff' options]
 USAGE
@@ -49,7 +50,7 @@ sub exe
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
 my ($difftool_cmd, $extcmd, $gui, $help, $prompt);
-GetOptions('g|gui' => \$gui,
+GetOptions('g|gui!' => \$gui,
 	'h' => \$help,
 	'prompt!' => \$prompt,
 	'y' => sub { $prompt = 0; },
@@ -75,7 +76,7 @@ if (defined($extcmd)) {
 		usage();
 	}
 }
-if (defined($gui)) {
+if ($gui) {
 	my $guitool = "";
 	$guitool = Git::config('diff.guitool');
 	if (length($guitool) > 0) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 4fb4c93..e716d06 100755
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
1.7.10.rc1.36.g15e879
