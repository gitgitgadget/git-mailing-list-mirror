From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2] commit: make default of "cleanup" option configurable
Date: Wed,  9 Jan 2013 20:36:49 +0100
Message-ID: <1357760209-3407-1-git-send-email-ralf.thielow@gmail.com>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 09 20:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1Tb-0001Kc-2S
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab3AIThy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:37:54 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:60610 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3AIThx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:37:53 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so1128391bkc.7
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 11:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BLRtpXbarwMtqIkIOhqnKabSaRmse8twW3FWHD1XsF0=;
        b=0H8u/DIT9kqWVOay0Ui0xhcBar2ugocuBD262zxAN40Z28L8t6UFFI5wLZRd9Kjf4i
         9a+eUQTJrOmyybRGQnAgb0iL+CIESI7WmhROcdUlJZuyh7VT4pKmShNzmOuZ1jHhmTVe
         PPLakgExLDEV4l5oMznc9a8RwAjouickAEIbX9lJste9T1byQXYN8Z+7D+8VP1GyylT1
         7Q08WSpmrITOMoiX+ZYQfXWtMuakg3q10QwmuFJtsvKAJCKoFOwRhy5NrYa6DrEgNsQU
         jcGCBLoPwtE8nyBEc/2CDFIVIXReNlSNnnGQx2r99+MNbsCrxknVvuK5v4dDmlgXmntm
         Kr8A==
X-Received: by 10.204.11.67 with SMTP id s3mr34613438bks.12.1357760272487;
        Wed, 09 Jan 2013 11:37:52 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id e22sm49887181bke.14.2013.01.09.11.37.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 11:37:51 -0800 (PST)
X-Mailer: git-send-email 1.8.1.165.g0eb732d.dirty
In-Reply-To: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213084>

The default of the "cleanup" option in "git commit"
is not configurable. Users who don't want to use the
default have to pass this option on every commit since
there's no way to configure it. This commit introduces
a new config option "commit.cleanup" which can be used
to change the default of the "cleanup" option in
"git commit".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Changes in v2:
- simplify implementation
- mention configuration variable in documentation of "git commit --cleanup"
- add an example usecase to documention of commit.cleanup configuration variable
- add tests

 Documentation/config.txt        |  7 ++++
 Documentation/git-commit.txt    |  4 +-
 builtin/commit.c                |  5 ++-
 t/t7500/add-content-and-comment |  4 ++
 t/t7502-commit.sh               | 84 +++++++++++++++++++++++++++++++++++++----
 5 files changed, 95 insertions(+), 9 deletions(-)
 create mode 100755 t/t7500/add-content-and-comment

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53c4ca1..0452d56 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -917,6 +917,13 @@ column.tag::
 	Specify whether to output tag listing in `git tag` in columns.
 	See `column.ui` for details.
 
+commit.cleanup::
+	This setting overrides the default of the `--cleanup` option in
+	`git commit`. See linkgit:git-commit[1] for details. Changing the
+	default can be useful if you want to use the comment character (#)
+	consistently within your commit messages, in which case you would
+	like to change the default to 'whitespace'.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7bdb039..41b27da 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -179,7 +179,9 @@ OPTIONS
 	only if the message is to be edited. Otherwise only whitespace
 	removed. The 'verbatim' mode does not change message at all,
 	'whitespace' removes just leading/trailing whitespace lines
-	and 'strip' removes both whitespace and commentary.
+	and 'strip' removes both whitespace and commentary. The default
+	can be changed by the 'commit.cleanup' configuration variable
+	(see linkgit:git-config[1]).
 
 -e::
 --edit::
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..4d55f8f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -103,7 +103,7 @@ static enum {
 	CLEANUP_NONE,
 	CLEANUP_ALL
 } cleanup_mode;
-static char *cleanup_arg;
+static const char *cleanup_arg;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -966,6 +966,7 @@ static const char *read_commit_message(const char *name)
 	return out;
 }
 
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1320,6 +1321,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/t/t7500/add-content-and-comment b/t/t7500/add-content-and-comment
new file mode 100755
index 0000000..988f5e9
--- /dev/null
+++ b/t/t7500/add-content-and-comment
@@ -0,0 +1,4 @@
+#!/bin/sh
+echo "commit message" >> "$1"
+echo "# comment" >> "$1"
+exit 0
\ No newline at end of file
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 1a5cb69..b1c7648 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,6 +4,15 @@ test_description='git commit porcelain-ish'
 
 . ./test-lib.sh
 
+commit_msg_is () {
+	expect=commit_msg_is.expect
+	actual=commit_msg_is.actual
+
+	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
+	printf "%s" "$1" >$expect &&
+	test_i18ncmp $expect $actual
+}
+
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
@@ -168,7 +177,7 @@ test_expect_success 'verbose respects diff config' '
 	git config --unset color.diff
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-t)' '
+test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >expect &&
@@ -178,7 +187,7 @@ test_expect_success 'cleanup commit messages (verbatim,-t)' '
 
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-F)' '
+test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
@@ -187,7 +196,7 @@ test_expect_success 'cleanup commit messages (verbatim,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-m)' '
+test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
@@ -196,7 +205,7 @@ test_expect_success 'cleanup commit messages (verbatim,-m)' '
 
 '
 
-test_expect_success 'cleanup commit messages (whitespace,-F)' '
+test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >text &&
@@ -207,7 +216,7 @@ test_expect_success 'cleanup commit messages (whitespace,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (strip,-F)' '
+test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo sample;echo; } >text &&
@@ -218,7 +227,7 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (strip,-F,-e)' '
+test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
@@ -231,10 +240,71 @@ echo "sample
 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit." >expect
 
-test_expect_success 'cleanup commit messages (strip,-F,-e): output' '
+test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'cleanup commit message (fail on invalid cleanup mode option)' '
+	test_must_fail git commit --cleanup=non-existent
+'
+
+test_expect_success 'cleanup commit message (fail on invalid cleanup mode configuration)' '
+	test_must_fail git -c commit.cleanup=non-existent commit
+'
+
+test_expect_success 'cleanup commit message (no config and no option uses default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git commit --no-status &&
+	commit_msg_is "commit message"
+'
+
+test_expect_success 'cleanup commit message (option overrides default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git commit --cleanup=whitespace --no-status &&
+	commit_msg_is "commit message # comment"
+'
+
+test_expect_success 'cleanup commit message (config overrides default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git -c commit.cleanup=whitespace commit --no-status &&
+	commit_msg_is "commit message # comment"
+'
+
+test_expect_success 'cleanup commit message (option overrides config)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git -c commit.cleanup=whitespace commit --cleanup=default &&
+	commit_msg_is "commit message"
+'
+
+test_expect_success 'cleanup commit message (default, -m)' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
+test_expect_success 'cleanup commit message (whitespace option, -m)' '
+	echo content >>file &&
+	git add file &&
+	git commit --cleanup=whitespace --no-status -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
+test_expect_success 'cleanup commit message (whitespace config, -m)' '
+	echo content >>file &&
+	git add file &&
+	git -c commit.cleanup=whitespace commit --no-status -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
 test_expect_success 'message shows author when it is not equal to committer' '
 	echo >>negative &&
 	git commit -e -m "sample" -a &&
-- 
1.8.1.165.g0eb732d.dirty
