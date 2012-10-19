From: Jeff Muizelaar <jmuizelaar@mozilla.com>
Subject: [PATCH] diff: diff.context configuration gives default to -U
Date: Fri, 19 Oct 2012 16:54:55 -0400
Message-ID: <B3AF2A63-5243-43CF-ADCB-6F40C474F9B1@mozilla.com>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com> <7vobl82u26.fsf@alter.siamese.dyndns.org> <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com> <7vr4pnqs8l.fsf@alter.siamese.dyndns.org> <B358ACEB-83C2-45C6-887F-D85C25A3496E@mozilla.com> <7v3923p0tb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJb4-0002Ot-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab2JSUy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:54:59 -0400
Received: from mx1.corp.phx1.mozilla.com ([63.245.216.69]:61917 "EHLO
	smtp.mozilla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2JSUy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2012 16:54:58 -0400
Received: from [10.242.28.29] (unknown [66.207.208.98])
	(Authenticated sender: jmuizelaar@mozilla.com)
	by mx1.mail.corp.phx1.mozilla.com (Postfix) with ESMTPSA id D4B3BF22BE;
	Fri, 19 Oct 2012 13:54:56 -0700 (PDT)
In-Reply-To: <7v3923p0tb.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208063>

Introduce a configuration variable diff.context that tells
Porcelain commands to use a non-default number of context
lines instead of 3 (the default).  With this variable, users
do not have to keep repeating "git log -U8" from the command
line; instead, it becomes sufficient to say "git config
diff.context 8" just once.

Signed-off-by: Jeff Muizelaar <jmuizelaar@mozilla.com>
---
On 2012-09-27, at 6:18 PM, Junio C Hamano wrote:

> Jeff Muizelaar <jmuizelaar@mozilla.com> writes:
> 
>> +	if (!strcmp(var, "diff.context")) {
>> +		diff_context_default = git_config_int(var, value);
>> +		if (diff_context_default < 0)
>> +			return -1;
>> +		return 0;
> 
> I am somewhat torn on this part. This fails the entire command when
> diff.context is set to non integer or negative integer, which means
> trouble for a user of a future version of git that accepts such a
> value to do something intelligent we do not anticipate today. The
> useful configuration value cannot be given unless the user is
> certain that .gitconfig file will never be read by older version of
> git.
> 
> Perhaps it is OK, at least for now.  We'd have the same worry for
> what is given to -U<n> anyway.

I left this as is.

>> +test_expect_success 'diff.context affects log' '
>> +	git log -1 -p >output &&
>> +	! grep firstline output &&
>> +	git config diff.context 8 &&
>> +	git log -1 -p >output &&
>> +	grep firstline output
>> +'
> 
> Is there a reason to favor "log -1 -p" over something a lot simpler
> like "show"?  Not requesting to change anything, but just being
> curious.

No. I changed it to "show" to avoid the surprise.

Other than that I included the test changes you suggested. I did however
adjust the sed 'a' command. It seems that GNU sed and BSD sed have incompatible behaviour
here. Unfortunately this also seems to screw up the indentation.

---
 Documentation/diff-config.txt |    4 ++
 diff.c                        |    9 ++++-
 t/t4055-diff-context.sh       |   94 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletions(-)
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
index 0000000..60348b7
--- /dev/null
+++ b/t/t4055-diff-context.sh
@@ -0,0 +1,94 @@
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
+	cat >x <<-\EOF &&
+	firstline
+	b
+	c
+	d
+	e
+	f
+	preline
+	postline
+	i
+	j
+	k
+	l
+	m
+	n
+	EOF
+	git update-index --add x &&
+	git commit -m initial &&
+
+	git cat-file blob HEAD:x |
+	sed "s/preline/preline\\
+ADDED/" >x &&
+	git update-index --add x &&
+	git commit -m next &&
+
+	git cat-file blob HEAD:x |
+	sed s/ADDED/MODIFIED/ >x
+'
+
+test_expect_success 'the default number of context lines is 3' '
+	git diff >output &&
+	! grep "^ d" output &&
+	grep "^ e" output &&
+	grep "^ j" output &&
+	! grep "^ k" output
+'
+
+test_expect_success 'diff.context honored by "show"' '
+	git show >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	git show >output &&
+	grep "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context' '
+	git config diff.context 8 &&
+	git log -U4 -1 >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'diff.context honored by "diff"' '
+	git config diff.context 8 &&
+	git diff >output &&
+	grep "^ firstline" output
+'
+
+test_expect_success 'plumbing not affected' '
+	git config diff.context 8 &&
+	git diff-files -p >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'non-integer config parsing' '
+	git config diff.context no &&
+	test_must_fail git diff 2>output &&
+	test_i18ngrep "bad config value" output
+'
+
+test_expect_success 'negative integer config parsing' '
+	git config diff.context -1 &&
+	test_must_fail git diff 2>output &&
+	test_i18ngrep "bad config file" output
+'
+
+test_expect_success '-U0 is valid, so is diff.context=0' '
+	git config diff.context 0 &&
+	git diff >output &&
+	grep "^-ADDED" output &&
+	grep "^+MODIFIED" output &&
+	! grep "^ postline" output
+'
+
+test_done
-- 
1.7.4.4
