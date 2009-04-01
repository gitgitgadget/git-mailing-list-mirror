From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 01/10] difftool: add support for a difftool.prompt config variable
Date: Wed,  1 Apr 2009 05:55:05 -0700
Message-ID: <1238590514-41893-2-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01f-0004A8-By
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764690AbZDAMzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764688AbZDAMzk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:10345 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764259AbZDAMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29184rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=V+Cp7PCND/cV1+1/pZBgcFDxP3d4WzYecj7xnXKi1PM=;
        b=Ub4VS6ALTKK6yIKrThgQaamTVaqbOnFhhACFdjwYo9wUwyFtxji+47czxgpnbhxsYi
         6IXNs004cxXUbbRqynqm1Wu0rrXxZ2fF53vycOZWXftq3Olk85Dol+m1X31aEMcJRLXY
         oieUFjwEnDXsqKsrL/dS7KQveR2znf2UT+aMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uTh2PHAYrrR7e+jl/58oqltbMNHqJtludh0ZJe71IQethehaou6e6YxvxPGRy2j1Tc
         o/FiCPw8ewql84+1K5+U+i7Qp36gdyeIfmJ1lLlHBrh5ByK4vueoe+D0Y3yHovmt/7Ye
         SElyEt9/xkFzItD/ZNNw2DMUlwl1A4SiP4qio=
Received: by 10.114.200.2 with SMTP id x2mr5210420waf.83.1238590532261;
        Wed, 01 Apr 2009 05:55:32 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m31sm7243861wag.64.2009.04.01.05.55.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115386>

difftool now supports difftool.prompt so that users do not have to
pass --no-prompt or hit enter each time a diff tool is launched.
The --prompt flag overrides the configuration variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/config.txt       |    3 ++
 Documentation/git-difftool.txt |   10 +++++-
 git-difftool-helper.sh         |   10 +++++-
 git-difftool.perl              |   15 +++++++--
 t/t7800-difftool.sh            |   64 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 185a9ef..79c8b66 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -684,6 +684,9 @@ difftool.<tool>.cmd::
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
 
+difftool.prompt::
+	Prompt before each invocation of the diff tool.
+
 diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index a00e943..73d4782 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,7 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [-y|--no-prompt] [<'git diff' options>]
+'git difftool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<'git diff' options>]
 
 DESCRIPTION
 -----------
@@ -21,6 +21,11 @@ OPTIONS
 --no-prompt::
 	Do not prompt before launching a diff tool.
 
+--prompt::
+	Prompt before each invocation of the diff tool.
+	This is the default behaviour; the option is provided to
+	override any configuration settings.
+
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
@@ -72,6 +77,9 @@ difftool.<tool>.cmd::
 +
 See the `--tool=<tool>` option above for more details.
 
+difftool.prompt::
+	Prompt before each invocation of the diff tool.
+
 SEE ALSO
 --------
 linkgit:git-diff[1]::
diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index b91002b..02bb135 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -7,9 +7,15 @@
 #
 # Copyright (c) 2009 David Aguilar
 
-# Set GIT_DIFFTOOL_NO_PROMPT to bypass the per-file prompt.
+# difftool.prompt controls the default prompt/no-prompt behavior
+# and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
-	test -z "$GIT_DIFFTOOL_NO_PROMPT"
+	prompt=$(git config --bool difftool.prompt || echo true)
+	if test "$prompt" = true; then
+		test -z "$GIT_DIFFTOOL_NO_PROMPT"
+	else
+		test -n "$GIT_DIFFTOOL_PROMPT"
+	fi
 }
 
 # This function prepares temporary files and launches the appropriate
diff --git a/git-difftool.perl b/git-difftool.perl
index 8c160e5..985dfe0 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -2,9 +2,12 @@
 # Copyright (c) 2009 David Aguilar
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
-# git-difftool-helper script.  This script exports
-# GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
-# GIT_DIFFTOOL_NO_PROMPT and GIT_DIFF_TOOL for use by git-difftool-helper.
+# git-difftool-helper script.
+#
+# This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
+# GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
+# are exported for use by git-difftool-helper.
+#
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
 use strict;
@@ -62,6 +65,12 @@ sub generate_command
 		}
 		if ($arg eq '-y' || $arg eq '--no-prompt') {
 			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+			delete $ENV{GIT_DIFFTOOL_PROMPT};
+			next;
+		}
+		if ($arg eq '--prompt') {
+			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+			delete $ENV{GIT_DIFFTOOL_NO_PROMPT};
 			next;
 		}
 		if ($arg eq '-h' || $arg eq '--help') {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ceef84b..33d07e6 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -15,6 +15,7 @@ remove_config_vars()
 	# Unset all config variables used by git-difftool
 	git config --unset diff.tool
 	git config --unset difftool.test-tool.cmd
+	git config --unset difftool.prompt
 	git config --unset merge.tool
 	git config --unset mergetool.test-tool.cmd
 	return 0
@@ -26,11 +27,18 @@ restore_test_defaults()
 	remove_config_vars
 	unset GIT_DIFF_TOOL
 	unset GIT_MERGE_TOOL
+	unset GIT_DIFFTOOL_PROMPT
 	unset GIT_DIFFTOOL_NO_PROMPT
 	git config diff.tool test-tool &&
 	git config difftool.test-tool.cmd 'cat $LOCAL'
 }
 
+prompt_given()
+{
+	prompt="$1"
+	test "$prompt" = "Hit return to launch 'test-tool': branch"
+}
+
 # Create a file on master and change it on branch
 test_expect_success 'setup' '
 	echo master >file &&
@@ -116,6 +124,62 @@ test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variable' '
 	restore_test_defaults
 '
 
+# git-difftool supports the difftool.prompt variable.
+# Test that GIT_DIFFTOOL_PROMPT can override difftool.prompt = false
+test_expect_success 'GIT_DIFFTOOL_PROMPT variable' '
+	git config difftool.prompt false &&
+	GIT_DIFFTOOL_PROMPT=true &&
+	export GIT_DIFFTOOL_PROMPT &&
+
+	prompt=$(echo | git difftool --prompt branch | tail -1) &&
+	prompt_given "$prompt" &&
+
+	restore_test_defaults
+'
+
+# Test that we don't have to pass --no-prompt when difftool.prompt is false
+test_expect_success 'difftool.prompt config variable is false' '
+	git config difftool.prompt false &&
+
+	diff=$(git difftool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test that the -y flag can override difftool.prompt = true
+test_expect_success 'difftool.prompt can overridden with -y' '
+	git config difftool.prompt true &&
+
+	diff=$(git difftool -y branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test that the --prompt flag can override difftool.prompt = false
+test_expect_success 'difftool.prompt can overridden with --prompt' '
+	git config difftool.prompt false &&
+
+	prompt=$(echo | git difftool --prompt branch | tail -1) &&
+	prompt_given "$prompt" &&
+
+	restore_test_defaults
+'
+
+# Test that the last flag passed on the command-line wins
+test_expect_success 'difftool last flag wins' '
+	diff=$(git difftool --prompt --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults &&
+
+	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
+	prompt_given "$prompt" &&
+
+	restore_test_defaults
+'
+
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success 'difftool + mergetool config variables' '
-- 
1.6.1.3
