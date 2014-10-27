From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/2] difftool: add support for --trust-exit-code
Date: Sun, 26 Oct 2014 18:15:42 -0700
Message-ID: <1414372542-3485-2-git-send-email-davvid@gmail.com>
References: <544CAC30.7000607@kdbg.org>
 <1414372542-3485-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 02:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiYuI-0004zP-Np
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 02:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbaJ0BPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 21:15:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51124 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaJ0BPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 21:15:30 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so4371108pad.35
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMfKlkeNQMSD4bUczuu5tnRz8O5a90D5vFPWby/e5fE=;
        b=RQFu2QXvQk2RiCo4OsL0nKJHWirzHUv9LaStPju2YtfDLdq22AdPQSPn4UEIhX4Gt5
         rp+Pco0MWrUy3lBTPhfPUJtUt8wFD8trDbpch3RBVc+IKhT30vaS4Q4KhN+788qUXz9P
         1uZp6T6rwo2hZ9G1dmmPWDuf+f1aSrmpnSLjjRUYwjQxMRPjvddjJzOUQ7z+L88EkJzE
         x6jxqhXfn8VcB2RLtHs5p3+ghicpkdycrq9VOMkMrG7lNmuZxuU+0kl5qyjjMOyyaaB8
         tbtsqR87ZGd/NoDTQIteseEjWRkDLi1rD6nUa1tc55UnhpBuzCMs5BAOAKt9VhvvC4kT
         ZEYQ==
X-Received: by 10.68.171.100 with SMTP id at4mr816056pbc.127.1414372530192;
        Sun, 26 Oct 2014 18:15:30 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id xr10sm9342375pab.35.2014.10.26.18.15.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 18:15:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.557.g1025af0
In-Reply-To: <1414372542-3485-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach difftool to exit when a diff tool returns a non-zero exit
code when either --trust-exit-code is specified or
difftool.trustExitCode is true.

Forward exit codes from invoked diff tools to the caller when
--trust-exit-code is used.

Suggested-by: Adri Farr <14farresa@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v2:

This series now depends on "difftool--helper: exit when reading a prompt answer fails".

A missing "git reset -- for-diff" was missing from the test.

Setting and testing of the status variable was moved to be
before "shift 7" to make things more cohesive; status setting
was previously buried inside the launch_merge_tool function,
which made it harder to follow.

 Documentation/git-difftool.txt | 14 ++++++++++++++
 git-difftool--helper.sh        |  6 ++++++
 git-difftool.perl              | 12 ++++++++++++
 t/t7800-difftool.sh            | 44 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 11887e6..333cf6f 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -91,6 +91,15 @@ instead.  `--no-symlinks` is the default on Windows.
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`.
 
+--[no-]trust-exit-code::
+	'git-difftool' invokes a diff tool individually on each file.
+	Errors reported by the diff tool are ignored by default.
+	Use `--trust-exit-code` to make 'git-difftool' exit when an
+	invoked diff tool returns a non-zero exit code.
++
+'git-difftool' will forward the exit code of the invoked tool when
+'--trust-exit-code' is used.
+
 See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
@@ -116,6 +125,11 @@ See the `--tool=<tool>` option above for more details.
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
+difftool.trustExitCode::
+	Exit difftool if the invoked diff tool returns a non-zero exit status.
++
+See the `--trust-exit-code` option above for more details.
+
 SEE ALSO
 --------
 linkgit:git-diff[1]::
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index aca0413..d4fb6df 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -85,6 +85,12 @@ else
 	while test $# -gt 6
 	do
 		launch_merge_tool "$1" "$2" "$5"
+		status=$?
+		if test "$status" != 0 &&
+			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
+		then
+			exit $status
+		fi
 		shift 7
 	done
 fi
diff --git a/git-difftool.perl b/git-difftool.perl
index 598fcc2..7df7c8a 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -342,6 +342,7 @@ sub main
 		symlinks => $^O ne 'cygwin' &&
 				$^O ne 'MSWin32' && $^O ne 'msys',
 		tool_help => undef,
+		trust_exit_code => undef,
 	);
 	GetOptions('g|gui!' => \$opts{gui},
 		'd|dir-diff' => \$opts{dirdiff},
@@ -352,6 +353,8 @@ sub main
 		'no-symlinks' => sub { $opts{symlinks} = 0; },
 		't|tool:s' => \$opts{difftool_cmd},
 		'tool-help' => \$opts{tool_help},
+		'trust-exit-code' => \$opts{trust_exit_code},
+		'no-trust-exit-code' => sub { $opts{trust_exit_code} = 0; },
 		'x|extcmd:s' => \$opts{extcmd});
 
 	if (defined($opts{help})) {
@@ -383,6 +386,15 @@ sub main
 		}
 	}
 
+	if (!defined $opts{trust_exit_code}) {
+		$opts{trust_exit_code} = Git::config_bool('difftool.trustExitCode');
+	}
+	if ($opts{trust_exit_code}) {
+		$ENV{GIT_DIFFTOOL_TRUST_EXIT_CODE} = 'true';
+	} else {
+		$ENV{GIT_DIFFTOOL_TRUST_EXIT_CODE} = 'false';
+	}
+
 	# In directory diff mode, 'git-difftool--helper' is called once
 	# to compare the a/b directories.  In file diff mode, 'git diff'
 	# will invoke a separate instance of 'git-difftool--helper' for
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index b5b7f62..7de18dd 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -76,6 +76,50 @@ test_expect_success PERL 'difftool forwards arguments to diff' '
 	rm for-diff
 '
 
+test_expect_success PERL 'difftool ignores exit code' '
+	test_config difftool.error.cmd false &&
+	git difftool -y -t error branch
+'
+
+test_expect_success PERL 'difftool forwards exit code with --trust-exit-code' '
+	test_config difftool.error.cmd false &&
+	test_must_fail git difftool -y --trust-exit-code -t error branch
+'
+
+test_expect_success PERL 'difftool honors difftool.trustExitCode = true' '
+	test_config difftool.error.cmd false &&
+	test_config difftool.trustExitCode true &&
+	test_must_fail git difftool -y -t error branch
+'
+
+test_expect_success PERL 'difftool honors difftool.trustExitCode = false' '
+	test_config difftool.error.cmd false &&
+	test_config difftool.trustExitCode false &&
+	git difftool -y -t error branch
+'
+
+test_expect_success PERL 'difftool ignores exit code with --no-trust-exit-code' '
+	test_config difftool.error.cmd false &&
+	test_config difftool.trustExitCode true &&
+	git difftool -y --no-trust-exit-code -t error branch
+'
+
+write_script .git/fail-right-file <<\EOF
+echo "$2"
+exit 1
+EOF
+
+test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
+	>for-diff &&
+	git add for-diff &&
+	echo file>expect &&
+	test_must_fail git difftool -y --trust-exit-code \
+		--extcmd .git/fail-right-file branch >actual &&
+	test_cmp expect actual &&
+	git reset -- for-diff &&
+	rm -f for-diff .git/fail-right-file
+'
+
 test_expect_success PERL 'difftool honors --gui' '
 	difftool_test_setup &&
 	test_config merge.tool bogus-tool &&
-- 
2.1.2.557.g1025af0
