From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3 10/9] difftool: do not allow mix of '--prompt' with '--no-prompt'
Date: Wed, 21 Mar 2012 15:35:58 -0400
Message-ID: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 21 20:37:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARLD-0000dP-7F
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab2CUTg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:36:58 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53854 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab2CUTg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:36:57 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so1925406qae.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZMTXBdWUlVXkTgOABTadruA3TpDbJdZevyUA4Imetww=;
        b=yu5vhMK0ruDlwKF/YGPKFpAgEv1Q4PPJvkdYNIhKGDO6c/Ij3ObANJi10DIn4RQcox
         cyATpUZQ3ZC8281owefyaQNeGxaQh6rRyK00iLZBVe7hAmFHvaDIlOxhCpwJCq7mTtQa
         SEserAntTCzY14Smo6DICOEnGmkyIf718f1PNshztXKFo9QH030yZDXzt/zb5T2F1lRE
         gh7qAtLkuMiX6TrcULEsn9cXf3oOzmPSMQUClnKFVtlnpRT1A4+7olDW66F92jJ+AxzI
         rl3MdVBOHV6pzGh9QK3pvbN34wXc4m7GiF5PycTYCwWSnnNSLfiw55qHygnT6PaW7Knl
         U8DQ==
Received: by 10.224.208.1 with SMTP id ga1mr7554506qab.21.1332358616796;
        Wed, 21 Mar 2012 12:36:56 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id by18sm1916418qab.12.2012.03.21.12.36.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 12:36:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.g6e141f
In-Reply-To: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193604>

When difftool was changed to use Getopt::Long, it changed the way that
the '--prompt' and '--no-prompt' options are handled. Prior to the change,
if both options were given, then the last option was used.  After the
change, if both were given, then '--prompt' was always used.

This commit teaches difftool to exit with an error if both options are
given at the command line. t7800 was updated to match.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl   |    6 +++++-
 t/t7800-difftool.sh |   16 +++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 9f0f9a9..9629811 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -202,7 +202,11 @@ if (defined($dirdiff)) {
 		chmod(stat("$b/$_")->mode, "$workdir/$_") or die $!;
 	}
 } else {
-	if (defined($prompt)) {
+	if (defined($prompt) and defined($no_prompt)) {
+		print("Cannot command '--prompt' and '--no-prompt' at the same time.\n");
+		usage(1);
+	}
+	elsif (defined($prompt)) {
 		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
 	}
 	elsif (defined($no_prompt)) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 4fb4c93..dc181cf 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -202,17 +202,11 @@ test_expect_success PERL 'difftool.prompt can overridden with --prompt' '
 	restore_test_defaults
 '
 
-# Test that the last flag passed on the command-line wins
-test_expect_success PERL 'difftool last flag wins' '
-	diff=$(git difftool --prompt --no-prompt branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults &&
-
-	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+# Test that an error is given when both --prompt and --no-prompt are
+# commanded
+test_expect_success PERL '--prompt / --no-prompt conflict' '
+	test_must_fail git difftool --prompt --no-prompt branch &&
+	test_must_fail git difftool --no-prompt --prompt branch
 '
 
 # git-difftool falls back to git-mergetool config variables
-- 
1.7.10.rc1.39.g6e141f
