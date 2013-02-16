From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/4] t7800: modernize tests
Date: Fri, 15 Feb 2013 21:47:45 -0800
Message-ID: <1360993666-81308-3-git-send-email-davvid@gmail.com>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
 <1360993666-81308-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 06:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6adO-0001e6-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 06:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab3BPFr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 00:47:58 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:34140 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3BPFr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 00:47:57 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so3895175iak.24
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oJo1OHsM7obQq9kLfzP39pLL3ALzvilYm9r8xdE+zUI=;
        b=qkh1YVFs1Q6c8cq08olX0pRSFP5Hv1zeoBLE/e9c6SGQJIyDo/bKRky+Uz16TKLbJd
         L045Dfw1AarOSEBgDbn/1W+qwAA6V3QPyVWVudCvAJ/Zl42TRb657pvQMKurdb+qIyyB
         IN8Xb81fP6Wggj2TM6hXYOOIsi1Z7801fRruHmraSeqV9HTSKUhOneGPZ7auZ1coyeuo
         bsM17bXEc19ReKcE/Okaa1aoF9QlBP0IfHeBO2elYJMDW3mv7NyMktjh18ekRbjkySvj
         Mqyfskjm0gRlvrIv/CosRlm3nuwQa2ykKYxbQrnyJ9jZjFDFatoqZvHJ9IKi/qT0m5sh
         U7Xw==
X-Received: by 10.50.159.162 with SMTP id xd2mr3478169igb.11.1360993676883;
        Fri, 15 Feb 2013 21:47:56 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id z1sm6255743igc.1.2013.02.15.21.47.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 21:47:56 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.623.g622c8fc
In-Reply-To: <1360993666-81308-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216374>

Eliminate a lot of redundant work by using test_config().
Chain everything together by using sane_unset() and a
simpler difftool_test_setup().

The original tests relied upon restore_test_defaults()
from the previous test to provide the next test with a sane
environment.  Make the tests do their own setup so that they
are not dependent on the success of the previous test.
The end result is shorter tests and better test isolation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 160 +++++++++++++++++++++-------------------------------
 1 file changed, 63 insertions(+), 97 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bb3158a..2d1ba8d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -10,29 +10,11 @@ Testing basic diff tool invocation
 
 . ./test-lib.sh
 
-remove_config_vars()
+difftool_test_setup()
 {
-	# Unset all config variables used by git-difftool
-	git config --unset diff.tool
-	git config --unset diff.guitool
-	git config --unset difftool.test-tool.cmd
-	git config --unset difftool.prompt
-	git config --unset merge.tool
-	git config --unset mergetool.test-tool.cmd
-	git config --unset mergetool.prompt
-	return 0
-}
-
-restore_test_defaults()
-{
-	# Restores the test defaults used by several tests
-	remove_config_vars
-	unset GIT_DIFF_TOOL
-	unset GIT_DIFFTOOL_PROMPT
-	unset GIT_DIFFTOOL_NO_PROMPT
-	git config diff.tool test-tool &&
-	git config difftool.test-tool.cmd 'cat $LOCAL'
-	git config difftool.bogus-tool.cmd false
+	test_config diff.tool test-tool &&
+	test_config difftool.test-tool.cmd 'cat $LOCAL' &&
+	test_config difftool.bogus-tool.cmd false
 }
 
 prompt_given()
@@ -65,36 +47,33 @@ test_expect_success PERL 'setup' '
 
 # Configure a custom difftool.<tool>.cmd and use it
 test_expect_success PERL 'custom commands' '
-	restore_test_defaults &&
-	git config difftool.test-tool.cmd "cat \$REMOTE" &&
-
+	difftool_test_setup &&
+	test_config difftool.test-tool.cmd "cat \$REMOTE" &&
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "master" &&
 
-	restore_test_defaults &&
+	test_config difftool.test-tool.cmd "cat \$LOCAL" &&
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "branch"
 '
 
 # Ensures that a custom difftool.<tool>.cmd overrides built-ins
 test_expect_success PERL 'custom commands override built-ins' '
-	restore_test_defaults &&
-	git config difftool.defaults.cmd "cat \$REMOTE" &&
+	test_config difftool.defaults.cmd "cat \$REMOTE" &&
 
 	diff=$(git difftool --tool defaults --no-prompt branch) &&
-	test "$diff" = "master" &&
-
-	git config --unset difftool.defaults.cmd
+	test "$diff" = "master"
 '
 
 # Ensures that git-difftool ignores bogus --tool values
 test_expect_success PERL 'difftool ignores bad --tool values' '
 	diff=$(git difftool --no-prompt --tool=bad-tool branch)
 	test "$?" = 1 &&
-	test "$diff" = ""
+	test -z "$diff"
 '
 
 test_expect_success PERL 'difftool forwards arguments to diff' '
+	difftool_test_setup &&
 	>for-diff &&
 	git add for-diff &&
 	echo changes>for-diff &&
@@ -106,178 +85,165 @@ test_expect_success PERL 'difftool forwards arguments to diff' '
 '
 
 test_expect_success PERL 'difftool honors --gui' '
-	git config merge.tool bogus-tool &&
-	git config diff.tool bogus-tool &&
-	git config diff.guitool test-tool &&
+	difftool_test_setup &&
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
 
 	diff=$(git difftool --no-prompt --gui branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 test_expect_success PERL 'difftool --gui last setting wins' '
-	git config diff.guitool bogus-tool &&
-	git difftool --no-prompt --gui --no-gui &&
+	difftool_test_setup &&
 
-	git config merge.tool bogus-tool &&
-	git config diff.tool bogus-tool &&
-	git config diff.guitool test-tool &&
-	diff=$(git difftool --no-prompt --no-gui --gui branch) &&
-	test "$diff" = "branch" &&
+	diff=$(git difftool --no-prompt --gui --no-gui) &&
+	test -z "$diff" &&
 
-	restore_test_defaults
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+
+	diff=$(git difftool --no-prompt --no-gui --gui branch) &&
+	test "$diff" = "branch"
 '
 
 test_expect_success PERL 'difftool --gui works without configured diff.guitool' '
-	git config diff.tool test-tool &&
+	difftool_test_setup &&
 
 	diff=$(git difftool --no-prompt --gui branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	test_might_fail git config --unset diff.tool &&
+	difftool_test_setup &&
+	git config --unset diff.tool &&
+
 	GIT_DIFF_TOOL=test-tool &&
 	export GIT_DIFF_TOOL &&
 
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	sane_unset GIT_DIFF_TOOL
 '
 
 # Test the $GIT_*_TOOL variables and ensure
 # that $GIT_DIFF_TOOL always wins unless --tool is specified
 test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
-	git config diff.tool bogus-tool &&
-	git config merge.tool bogus-tool &&
-
+	difftool_test_setup &&
+	test_config diff.tool bogus-tool &&
+	test_config merge.tool bogus-tool &&
 	GIT_DIFF_TOOL=test-tool &&
 	export GIT_DIFF_TOOL &&
 
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "branch" &&
 
+	test_config diff.tool bogus-tool &&
+	test_config merge.tool bogus-tool &&
 	GIT_DIFF_TOOL=bogus-tool &&
 	export GIT_DIFF_TOOL &&
 
 	diff=$(git difftool --no-prompt --tool=test-tool branch) &&
 	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	sane_unset GIT_DIFF_TOOL
 '
 
 # Test that we don't have to pass --no-prompt to difftool
 # when $GIT_DIFFTOOL_NO_PROMPT is true
 test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
+	difftool_test_setup &&
 	GIT_DIFFTOOL_NO_PROMPT=true &&
 	export GIT_DIFFTOOL_NO_PROMPT &&
 
 	diff=$(git difftool branch) &&
 	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	sane_unset GIT_DIFFTOOL_NO_PROMPT
 '
 
 # git-difftool supports the difftool.prompt variable.
 # Test that GIT_DIFFTOOL_PROMPT can override difftool.prompt = false
 test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
-	git config difftool.prompt false &&
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
 	GIT_DIFFTOOL_PROMPT=true &&
 	export GIT_DIFFTOOL_PROMPT &&
 
 	prompt=$(echo | git difftool branch | tail -1) &&
 	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	sane_unset GIT_DIFFTOOL_PROMPT
 '
 
 # Test that we don't have to pass --no-prompt when difftool.prompt is false
 test_expect_success PERL 'difftool.prompt config variable is false' '
-	git config difftool.prompt false &&
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
 
 	diff=$(git difftool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
 test_expect_success PERL 'difftool merge.prompt = false' '
+	difftool_test_setup &&
 	test_might_fail git config --unset difftool.prompt &&
-	git config mergetool.prompt false &&
+	test_config mergetool.prompt false &&
 
 	diff=$(git difftool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 # Test that the -y flag can override difftool.prompt = true
 test_expect_success PERL 'difftool.prompt can overridden with -y' '
-	git config difftool.prompt true &&
+	difftool_test_setup &&
+	test_config difftool.prompt true &&
 
 	diff=$(git difftool -y branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 # Test that the --prompt flag can override difftool.prompt = false
 test_expect_success PERL 'difftool.prompt can overridden with --prompt' '
-	git config difftool.prompt false &&
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
 
 	prompt=$(echo | git difftool --prompt branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	prompt_given "$prompt"
 '
 
 # Test that the last flag passed on the command-line wins
 test_expect_success PERL 'difftool last flag wins' '
+	difftool_test_setup &&
 	diff=$(git difftool --prompt --no-prompt branch) &&
 	test "$diff" = "branch" &&
 
-	restore_test_defaults &&
-
 	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	prompt_given "$prompt"
 '
 
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars &&
-	git config merge.tool test-tool &&
-	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
+	test_config merge.tool test-tool &&
+	test_config mergetool.test-tool.cmd "cat \$LOCAL" &&
 
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "branch" &&
 
 	# set merge.tool to something bogus, diff.tool to test-tool
-	git config merge.tool bogus-tool &&
-	git config diff.tool test-tool &&
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool test-tool &&
 
 	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test "$diff" = "branch"
 '
 
 test_expect_success PERL 'difftool.<tool>.path' '
-	git config difftool.tkdiff.path echo &&
+	test_config difftool.tkdiff.path echo &&
 	diff=$(git difftool --tool=tkdiff --no-prompt branch) &&
-	git config --unset difftool.tkdiff.path &&
 	lines=$(echo "$diff" | grep file | wc -l) &&
-	test "$lines" -eq 1 &&
-
-	restore_test_defaults
+	test "$lines" -eq 1
 '
 
 test_expect_success PERL 'difftool --extcmd=cat' '
-- 
1.8.1.3.623.g622c8fc
