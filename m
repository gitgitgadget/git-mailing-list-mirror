From: Jeff Muizelaar <jmuizelaar@mozilla.com>
Subject: [PATCH] diff: diff.context configuration gives default to -U
Date: Thu, 27 Sep 2012 15:12:52 -0400
Message-ID: <B358ACEB-83C2-45C6-887F-D85C25A3496E@mozilla.com>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com> <7vobl82u26.fsf@alter.siamese.dyndns.org> <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com> <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:13:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJWD-0004Hb-6A
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab2I0TMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:12:55 -0400
Received: from mx2.corp.phx1.mozilla.com ([63.245.216.70]:43793 "EHLO
	smtp.mozilla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2I0TMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 15:12:55 -0400
Received: from [10.242.28.29] (unknown [66.207.208.98])
	(Authenticated sender: jmuizelaar@mozilla.com)
	by mx2.mail.corp.phx1.mozilla.com (Postfix) with ESMTPSA id 0CF9FF2665;
	Thu, 27 Sep 2012 12:12:53 -0700 (PDT)
In-Reply-To: <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206510>

Introduce a configuration variable diff.context that tells
Porcelain commands to use a non-default number of context
lines instead of 3 (the default).  With this variable, users
do not have to keep repeating "git log -U8" from the command
line; instead, it becomes sufficient to say "git config
diff.context 8" just once.

Signed-off-by: Jeff Muizelaar <jmuizelaar@mozilla.com>
---

This fixes the tests to behave better and avoids 'grep -v'

 Documentation/diff-config.txt |    4 +
 diff.c                        |    9 +++-
 t/t4055-diff-context.sh       |  128 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 1 deletions(-)
 create mode 100755 t/t4055-diff-context.sh

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 67a90a8..75ab8a5 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -56,6 +56,10 @@ diff.statGraphWidth::
 	Limit the width of the graph part in --stat output. If set, applies
 	to all commands generating --stat output except format-patch.
 
+diff.context::
+	Generate diffs with <n> lines of context instead of the default of
+	3. This value is overridden by the -U option.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/diff.c b/diff.c
index 35d3f07..86e5f2a 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@ static int diff_detect_rename_default;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
@@ -141,6 +142,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.context")) {
+		diff_context_default = git_config_int(var, value);
+		if (diff_context_default < 0)
+			return -1;
+		return 0;
+	}
 	if (!strcmp(var, "diff.renames")) {
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
@@ -3170,7 +3177,7 @@ void diff_setup(struct diff_options *options)
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
-	options->context = 3;
+	options->context = diff_context_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	options->change = diff_change;
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
new file mode 100755
index 0000000..8a31448
--- /dev/null
+++ b/t/t4055-diff-context.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Mozilla Foundation
+#
+
+test_description='diff.context configuration'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >x <<-EOF &&
+firstline
+b
+c
+d
+e
+f
+preline
+postline
+i
+j
+k
+l
+m
+n
+EOF
+	git update-index --add x &&
+	git commit -m initial &&
+	cat >x <<-\EOF &&
+firstline
+b
+c
+d
+e
+f
+preline
+1
+postline
+i
+j
+k
+l
+m
+n
+EOF
+	git update-index --add x &&
+	git commit -m next &&
+cat >x <<-\EOF
+firstline
+b
+c
+d
+e
+f
+preline
+2
+postline
+i
+j
+k
+l
+m
+n
+EOF
+'
+
+test_expect_success 'diff.context affects log' '
+	git log -1 -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	git log -1 -p >output &&
+	grep firstline output
+'
+
+test_expect_success 'different -U value' '
+	git config diff.context 8 &&
+	git log -U4 -1 >output &&
+	! grep firstline output
+'
+
+test_expect_success 'diff.context affects diff' '
+	git config diff.context 8 &&
+	git diff >output &&
+	grep firstline output
+'
+
+test_expect_success 'plumbing not affected' '
+	git config diff.context 8 &&
+	git diff-files -p > output &&
+	! grep firstline output
+'
+test_expect_success 'non-integer config parsing' '
+	cat > .git/config <<-\EOF &&
+[diff]
+	context = no
+EOF
+	! git diff 2>output &&
+	grep "bad config value" output
+'
+
+test_expect_success 'negative integer config parsing' '
+	cat >.git/config <<-\EOF &&
+[diff]
+	context = -1
+EOF
+	! git diff 2>output &&
+	grep "bad config file" output
+'
+
+test_expect_success '0 config parsing' '
+	cat > .git/config <<-\EOF &&
+[diff]
+	context = 0
+EOF
+	git diff >output &&
+	grep preline output
+'
+
+test_expect_success 'config parsing' '
+	cat >.git/config <<-\EOF &&
+[diff]
+	context = 8
+EOF
+	git diff >output &&
+	grep postline output
+'
+
+test_done
-- 
1.7.4.4
