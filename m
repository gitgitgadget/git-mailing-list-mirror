From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: add support for --trust-exit-code
Date: Sat, 25 Oct 2014 18:24:49 -0700
Message-ID: <1414286689-62082-1-git-send-email-davvid@gmail.com>
References: <CAPfWmhgS8JXyXz5qp04+faqjdeHsydBz-fui-HeNhF3wYLv71g@mail.gmail.com>
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 02:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiCZk-0002zW-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 02:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaJZBYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 21:24:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62165 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaJZBYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 21:24:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id et14so867684pad.29
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1yTjGqwcImwyTB/2ztd3MBDpwbs6B3d2xAr6BPLG/4=;
        b=gaSOEbIPk1ixeVyNodpMwe5Kjoqp/cvSviAnU/vZZkghwi3XnK/7FtAI9qHDjAAJkj
         +PyNNUTOUSr/2VOePVAlEnJBcouT+6hTN9MfxywsS+1MhWCmTmh04iFuYdnPSRgiQWmo
         4kHzmsltglxlUVffp5PVXtZJZ8bfqy0bffcqZP6ShFowY7ljvHeptRFAQnN44Ni2EX0K
         svPo/OhbTeGquLeivcO/Cvyooc0L9OTq8K+Mw27zKjQnxzZKTlpjmHpXPmWoh/1FjbGC
         op75zEsqO8BRliq5S7RsQcBo9h3Kq9SZlZdubBkb0H57IwQQlNQZ36uEUHAipv6WJ4/V
         IfNg==
X-Received: by 10.70.2.226 with SMTP id 2mr14609810pdx.56.1414286685338;
        Sat, 25 Oct 2014 18:24:45 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o5sm7204084pdc.24.2014.10.25.18.24.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 25 Oct 2014 18:24:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.556.g2136b5c
In-Reply-To: <CAPfWmhgS8JXyXz5qp04+faqjdeHsydBz-fui-HeNhF3wYLv71g@mail.gmail.com>
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
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-difftool.txt | 14 ++++++++++++++
 git-difftool--helper.sh        |  7 +++++++
 git-difftool.perl              | 12 ++++++++++++
 t/t7800-difftool.sh            | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 11887e6..dc843d3 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -91,6 +91,15 @@ instead.  `--no-symlinks` is the default on Windows.
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`.
 
+--[no-]trust-exit-code::
+	'git-difftool' invokes a diff tool individually on each file.
+	Errors reported by the diff tool are ignored by default.
+	Use `--trust-exit-code` to make 'git-difftool' exit when an an
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
index 7ef36b9..fdbd768 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -62,6 +62,8 @@ launch_merge_tool () {
 	else
 		run_merge_tool "$merge_tool"
 	fi
+	status=$?
+	return $status
 }
 
 if ! use_ext_cmd
@@ -85,5 +87,10 @@ else
 	do
 		launch_merge_tool "$1" "$2" "$5"
 		shift 7
+		if test "$status" != 0 &&
+			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
+		then
+			exit $status
+		fi
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
index dc30a51..2b89b7b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -76,6 +76,49 @@ test_expect_success PERL 'difftool forwards arguments to diff' '
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
+write_script fail-right-file <<\EOF
+echo "$2"
+exit 1
+EOF
+
+test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
+	>for-diff &&
+	git add for-diff &&
+	echo branch >actual &&
+	test_must_fail git difftool -y --trust-exit-code \
+		--extcmd "$(pwd)/fail-right-file" branch >actual &&
+	test_cmp expect actual &&
+	rm -f for-diff fail-right-file
+'
+
 test_expect_success PERL 'difftool honors --gui' '
 	difftool_test_setup &&
 	test_config merge.tool bogus-tool &&
-- 
2.1.2.556.g2136b5c
