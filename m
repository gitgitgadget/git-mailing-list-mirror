From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 3/4] t7800: modernize tests
Date: Tue, 19 Feb 2013 21:35:27 -0800
Message-ID: <1361338528-17835-3-git-send-email-davvid@gmail.com>
References: <1361338528-17835-1-git-send-email-davvid@gmail.com>
 <1361338528-17835-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:36:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U82Lq-00010i-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 06:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab3BTFfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 00:35:50 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:48213 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab3BTFfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 00:35:48 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so3314388dam.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 21:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zhdviClz7gUvScLt4uOPLdqNw14H1d5VG4ceQhYs+zQ=;
        b=sIJi7j94WrT1SGtM+xXtmZ58rUa0NY9y5SF+TkA2MbJBZokB/cPRqEZKRL2ryDu/Jj
         nF3MPn8r42Ye4Oq4PCzMlbl53pdAHtRh6S9HYvZ0O4rzZiD7PGPrJCnZ5YY9hSTFHwB/
         W30RbA9lHqfozgbOGgYatN4NY/bn7FLFaJGyDOW6NoMRLOuN/PGbEr0HWfwL9XKVS2Q0
         lAdmum4zsZcUVxW6c86iXNVy9bGp2HQilQb2iC7JOMSVgy0bAidiWiO2cX2tVGcGwcLL
         kFbpPPtglSBSK4n1LUZWmqprDKund8AmkAryKErEdq/uKG5sYLwMbov/lY6sEfMMpCu1
         ny5A==
X-Received: by 10.66.21.2 with SMTP id r2mr585617pae.200.1361338548026;
        Tue, 19 Feb 2013 21:35:48 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id s9sm26625100pav.7.2013.02.19.21.35.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 21:35:46 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
In-Reply-To: <1361338528-17835-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216678>

Eliminate a lot of redundant work by using test_config().
Catch more return codes by more use of temporary files
and test_cmp.

The original tests relied upon restore_test_defaults()
from the previous test to provide the next test with a sane
environment.  Make the tests do their own setup so that they
are not dependent on the success of the previous test.
The end result is shorter tests and better test isolation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
We no longer export variables into the environment per Jonathan's
suggestion.  This covers all of the review notes.

 t/t7800-difftool.sh | 360 ++++++++++++++++++++++++----------------------------
 1 file changed, 165 insertions(+), 195 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 5b5939b..b577c01 100755
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
@@ -65,249 +47,237 @@ test_expect_success PERL 'setup' '
 
 # Configure a custom difftool.<tool>.cmd and use it
 test_expect_success PERL 'custom commands' '
-	restore_test_defaults &&
-	git config difftool.test-tool.cmd "cat \$REMOTE" &&
+	difftool_test_setup &&
+	test_config difftool.test-tool.cmd "cat \$REMOTE" &&
+	echo master >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
 
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "master" &&
-
-	restore_test_defaults &&
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch"
+	test_config difftool.test-tool.cmd "cat \$LOCAL" &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
 '
 
-# Ensures that a custom difftool.<tool>.cmd overrides built-ins
-test_expect_success PERL 'custom commands override built-ins' '
-	restore_test_defaults &&
-	git config difftool.defaults.cmd "cat \$REMOTE" &&
-
-	diff=$(git difftool --tool defaults --no-prompt branch) &&
-	test "$diff" = "master" &&
-
-	git config --unset difftool.defaults.cmd
+test_expect_success PERL 'custom tool commands override built-ins' '
+	test_config difftool.defaults.cmd "cat \$REMOTE" &&
+	echo master >expect &&
+	git difftool --tool defaults --no-prompt branch >actual &&
+	test_cmp expect actual
 '
 
-# Ensures that git-difftool ignores bogus --tool values
 test_expect_success PERL 'difftool ignores bad --tool values' '
-	diff=$(git difftool --no-prompt --tool=bad-tool branch)
-	test "$?" = 1 &&
-	test "$diff" = ""
+	: >expect &&
+	test_expect_code 1 \
+		git difftool --no-prompt --tool=bad-tool branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool forwards arguments to diff' '
+	difftool_test_setup &&
 	>for-diff &&
 	git add for-diff &&
 	echo changes>for-diff &&
 	git add for-diff &&
-	diff=$(git difftool --cached --no-prompt -- for-diff) &&
-	test "$diff" = "" &&
+	: >expect &&
+	git difftool --cached --no-prompt -- for-diff >actual &&
+	test_cmp expect actual &&
 	git reset -- for-diff &&
 	rm for-diff
 '
 
 test_expect_success PERL 'difftool honors --gui' '
-	git config merge.tool bogus-tool &&
-	git config diff.tool bogus-tool &&
-	git config diff.guitool test-tool &&
-
-	diff=$(git difftool --no-prompt --gui branch) &&
-	test "$diff" = "branch" &&
+	difftool_test_setup &&
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
 
-	restore_test_defaults
+	echo branch >expect &&
+	git difftool --no-prompt --gui branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --gui last setting wins' '
-	git config diff.guitool bogus-tool &&
-	git difftool --no-prompt --gui --no-gui &&
+	difftool_test_setup &&
+	: >expect &&
+	git difftool --no-prompt --gui --no-gui >actual &&
+	test_cmp expect actual &&
 
-	git config merge.tool bogus-tool &&
-	git config diff.tool bogus-tool &&
-	git config diff.guitool test-tool &&
-	diff=$(git difftool --no-prompt --no-gui --gui branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	echo branch >expect &&
+	git difftool --no-prompt --no-gui --gui branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --gui works without configured diff.guitool' '
-	git config diff.tool test-tool &&
-
-	diff=$(git difftool --no-prompt --gui branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	echo branch >expect &&
+	git difftool --no-prompt --gui branch >actual &&
+	test_cmp expect actual
 '
 
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	test_might_fail git config --unset diff.tool &&
-	GIT_DIFF_TOOL=test-tool &&
-	export GIT_DIFF_TOOL &&
-
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	git config --unset diff.tool &&
+	echo branch >expect &&
+	GIT_DIFF_TOOL=test-tool git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
 '
 
 # Test the $GIT_*_TOOL variables and ensure
 # that $GIT_DIFF_TOOL always wins unless --tool is specified
 test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
-	git config diff.tool bogus-tool &&
-	git config merge.tool bogus-tool &&
-
-	GIT_DIFF_TOOL=test-tool &&
-	export GIT_DIFF_TOOL &&
-
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
+	difftool_test_setup &&
+	test_config diff.tool bogus-tool &&
+	test_config merge.tool bogus-tool &&
 
-	GIT_DIFF_TOOL=bogus-tool &&
-	export GIT_DIFF_TOOL &&
+	echo branch >expect &&
+	GIT_DIFF_TOOL=test-tool git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
 
-	diff=$(git difftool --no-prompt --tool=test-tool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test_config diff.tool bogus-tool &&
+	test_config merge.tool bogus-tool &&
+	GIT_DIFF_TOOL=bogus-tool \
+		git difftool --no-prompt --tool=test-tool branch >actual &&
+	test_cmp expect actual
 '
 
 # Test that we don't have to pass --no-prompt to difftool
 # when $GIT_DIFFTOOL_NO_PROMPT is true
 test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
-	GIT_DIFFTOOL_NO_PROMPT=true &&
-	export GIT_DIFFTOOL_NO_PROMPT &&
-
-	diff=$(git difftool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	echo branch >expect &&
+	GIT_DIFFTOOL_NO_PROMPT=true git difftool branch >actual &&
+	test_cmp expect actual
 '
 
 # git-difftool supports the difftool.prompt variable.
 # Test that GIT_DIFFTOOL_PROMPT can override difftool.prompt = false
 test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
-	git config difftool.prompt false &&
-	GIT_DIFFTOOL_PROMPT=true &&
-	export GIT_DIFFTOOL_PROMPT &&
-
-	prompt=$(echo | git difftool branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
+	echo >input &&
+	GIT_DIFFTOOL_PROMPT=true git difftool branch <input >output &&
+	prompt=$(tail -1 <output) &&
+	prompt_given "$prompt"
 '
 
 # Test that we don't have to pass --no-prompt when difftool.prompt is false
 test_expect_success PERL 'difftool.prompt config variable is false' '
-	git config difftool.prompt false &&
-
-	diff=$(git difftool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
+	echo branch >expect &&
+	git difftool branch >actual &&
+	test_cmp expect actual
 '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
 test_expect_success PERL 'difftool merge.prompt = false' '
+	difftool_test_setup &&
 	test_might_fail git config --unset difftool.prompt &&
-	git config mergetool.prompt false &&
-
-	diff=$(git difftool branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test_config mergetool.prompt false &&
+	echo branch >expect &&
+	git difftool branch >actual &&
+	test_cmp expect actual
 '
 
 # Test that the -y flag can override difftool.prompt = true
 test_expect_success PERL 'difftool.prompt can overridden with -y' '
-	git config difftool.prompt true &&
-
-	diff=$(git difftool -y branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	test_config difftool.prompt true &&
+	echo branch >expect &&
+	git difftool -y branch >actual &&
+	test_cmp expect actual
 '
 
 # Test that the --prompt flag can override difftool.prompt = false
 test_expect_success PERL 'difftool.prompt can overridden with --prompt' '
-	git config difftool.prompt false &&
-
-	prompt=$(echo | git difftool --prompt branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	test_config difftool.prompt false &&
+	echo >input &&
+	git difftool --prompt branch <input >output &&
+	prompt=$(tail -1 <output) &&
+	prompt_given "$prompt"
 '
 
 # Test that the last flag passed on the command-line wins
 test_expect_success PERL 'difftool last flag wins' '
-	diff=$(git difftool --prompt --no-prompt branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults &&
-
-	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
-	prompt_given "$prompt" &&
-
-	restore_test_defaults
+	difftool_test_setup &&
+	echo branch >expect &&
+	git difftool --prompt --no-prompt branch >actual &&
+	test_cmp expect actual &&
+	echo >input &&
+	git difftool --no-prompt --prompt branch <input >output &&
+	prompt=$(tail -1 <output) &&
+	prompt_given "$prompt"
 '
 
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars &&
-	git config merge.tool test-tool &&
-	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
-
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
+	test_config merge.tool test-tool &&
+	test_config mergetool.test-tool.cmd "cat \$LOCAL" &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
 
 	# set merge.tool to something bogus, diff.tool to test-tool
-	git config merge.tool bogus-tool &&
-	git config diff.tool test-tool &&
-
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
-
-	restore_test_defaults
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool test-tool &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool.<tool>.path' '
-	git config difftool.tkdiff.path echo &&
-	diff=$(git difftool --tool=tkdiff --no-prompt branch) &&
-	git config --unset difftool.tkdiff.path &&
-	lines=$(echo "$diff" | grep file | wc -l) &&
-	test "$lines" -eq 1 &&
-
-	restore_test_defaults
+	test_config difftool.tkdiff.path echo &&
+	git difftool --tool=tkdiff --no-prompt branch >output &&
+	lines=$(grep file output | wc -l) &&
+	test "$lines" -eq 1
 '
 
 test_expect_success PERL 'difftool --extcmd=cat' '
-	diff=$(git difftool --no-prompt --extcmd=cat branch) &&
-	test "$diff" = branch"$LF"master
+	echo branch >expect &&
+	echo master >>expect &&
+	git difftool --no-prompt --extcmd=cat branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --extcmd cat' '
-	diff=$(git difftool --no-prompt --extcmd cat branch) &&
-	test "$diff" = branch"$LF"master
+	echo branch >expect &&
+	echo master >>expect &&
+	git difftool --no-prompt --extcmd=cat branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool -x cat' '
-	diff=$(git difftool --no-prompt -x cat branch) &&
-	test "$diff" = branch"$LF"master
+	echo branch >expect &&
+	echo master >>expect &&
+	git difftool --no-prompt -x cat branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --extcmd echo arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch) &&
-	test "$diff" = file
+	echo file >expect &&
+	git difftool --no-prompt \
+		--extcmd sh\ -c\ \"echo\ \$1\" branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch) &&
-	test "$diff" = master
+	echo master >expect &&
+	git difftool --no-prompt \
+		--extcmd sh\ -c\ \"cat\ \$1\" branch >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg2' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch) &&
-	test "$diff" = branch
+	echo branch >expect &&
+	git difftool --no-prompt \
+		--extcmd sh\ -c\ \"cat\ \$2\" branch >actual &&
+	test_cmp expect actual
 '
 
 # Create a second file on master and a different version on branch
@@ -324,26 +294,26 @@ test_expect_success PERL 'setup with 2 files different' '
 '
 
 test_expect_success PERL 'say no to the first file' '
-	diff=$( (echo n; echo) | git difftool -x cat branch ) &&
-
-	echo "$diff" | stdin_contains m2 &&
-	echo "$diff" | stdin_contains br2 &&
-	echo "$diff" | stdin_doesnot_contain master &&
-	echo "$diff" | stdin_doesnot_contain branch
+	(echo n && echo) >input &&
+	git difftool -x cat branch <input >output &&
+	cat output | stdin_contains m2 &&
+	cat output | stdin_contains br2 &&
+	cat output | stdin_doesnot_contain master &&
+	cat output | stdin_doesnot_contain branch
 '
 
 test_expect_success PERL 'say no to the second file' '
-	diff=$( (echo; echo n) | git difftool -x cat branch ) &&
-
-	echo "$diff" | stdin_contains master &&
-	echo "$diff" | stdin_contains branch &&
-	echo "$diff" | stdin_doesnot_contain m2 &&
-	echo "$diff" | stdin_doesnot_contain br2
+	(echo && echo n) >input &&
+	git difftool -x cat branch <input >output &&
+	cat output | stdin_contains master &&
+	cat output | stdin_contains branch &&
+	cat output | stdin_doesnot_contain m2 &&
+	cat output | stdin_doesnot_contain br2
 '
 
 test_expect_success PERL 'difftool --tool-help' '
-	tool_help=$(git difftool --tool-help) &&
-	echo "$tool_help" | stdin_contains tool
+	git difftool --tool-help >output &&
+	cat output | stdin_contains tool
 '
 
 test_expect_success PERL 'setup change in subdirectory' '
@@ -359,29 +329,29 @@ test_expect_success PERL 'setup change in subdirectory' '
 '
 
 test_expect_success PERL 'difftool -d' '
-	diff=$(git difftool -d --extcmd ls branch) &&
-	echo "$diff" | stdin_contains sub &&
-	echo "$diff" | stdin_contains file
+	git difftool -d --extcmd ls branch >output &&
+	cat output | stdin_contains sub &&
+	cat output | stdin_contains file
 '
 
 test_expect_success PERL 'difftool --dir-diff' '
-	diff=$(git difftool --dir-diff --extcmd ls branch) &&
-	echo "$diff" | stdin_contains sub &&
-	echo "$diff" | stdin_contains file
+	git difftool --dir-diff --extcmd ls branch >output &&
+	cat output | stdin_contains sub &&
+	cat output | stdin_contains file
 '
 
 test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
-	diff=$(git difftool --dir-diff --prompt --extcmd ls branch) &&
-	echo "$diff" | stdin_contains sub &&
-	echo "$diff" | stdin_contains file
+	git difftool --dir-diff --prompt --extcmd ls branch >output &&
+	cat output | stdin_contains sub &&
+	cat output | stdin_contains file
 '
 
 test_expect_success PERL 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
-		diff=$(git difftool --dir-diff --extcmd ls branch) &&
-		echo "$diff" | stdin_contains sub &&
-		echo "$diff" | stdin_contains file
+		git difftool --dir-diff --extcmd ls branch >output &&
+		cat output | stdin_contains sub &&
+		cat output | stdin_contains file
 	)
 '
 
-- 
1.8.2.rc0.20.gf548dd7
