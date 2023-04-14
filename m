Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97573C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDNPxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDNPw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 11:52:58 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF11886AC
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:52:56 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B3E31C0007;
        Fri, 14 Apr 2023 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681487575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvYXaBI5b8B+3/rtHmxpw4VdRzEmAnd2BZXhlw+G5DA=;
        b=GzuXsAerPp7onl+Iy0v4wOhS7dS+CERGPXxbg2m7kwH3IvAEyjAR7R5LOHqC4YWwRn/BJn
        vSPYDwg2R5R8kATg8r7y0xLA8/FYJL3NTcH9/pnT+3WzcNm4maD5KSwcX3Nnwfpd6wxn1z
        JudISJCc7ZYn2IcnOY2DNPyL7O9JqGddZY01cKjC8A8HXpouObsbm64Bmu/a+pKpH1Q5nX
        8ZvKWcvGdkWjDzgcvmv7m29EaRmmJt5CwW5E2MAvk1idV7rTguL5r45KxZfNmFxCxsw9h2
        yc51yWWbz1PhlroRAvCVYSZsInYP92ME1kPf+bWsrSCYi/1LNfb0vc99qXRaRg==
From:   Robin Jarry <robin@jarry.cc>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Robin Jarry <robin@jarry.cc>
Subject: [PATCH v5] send-email: export patch counters in validate environment
Date:   Fri, 14 Apr 2023 17:52:49 +0200
Message-Id: <20230414155249.667180-1-robin@jarry.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414152843.659667-1-robin@jarry.cc>
References: <20230414152843.659667-1-robin@jarry.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sending patch series (with a cover-letter or not)
sendemail-validate is called with every email/patch file independently
from the others. When one of the patches depends on a previous one, it
may not be possible to use this hook in a meaningful way. A hook that
wants to check some property of the whole series needs to know which
patch is the final one.

Expose the current and total number of patches to the hook via the
GIT_SENDEMAIL_PATCH_COUNTER and GIT_SENDEMAIL_PATCH_TOTAL environment
variables so that both incremental and global validation is possible.

Sharing any other state between successive invocations of the validate
hook must be done via external means. For example, by storing it in
a git config sendemail.validateWorktree entry.

Add a sample script with placeholder validations and update tests to
check that the counters are properly exported.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Robin Jarry <robin@jarry.cc>
---

Notes:
    v4 -> v5:
    
    * Fixed shell syntax error introduced by last minute change.
    
    v3 -> v4:
    
    * Added test case.
    * Make sure to always cleanup the temp worktree.
    * Add configuration knobs to tweak the remote and ref on which to check
      if the patches apply without conflicts.

 Documentation/githooks.txt                 | 22 +++++++
 git-send-email.perl                        | 17 ++++-
 t/t9001-send-email.sh                      | 31 +++++++++
 templates/hooks--sendemail-validate.sample | 77 ++++++++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100755 templates/hooks--sendemail-validate.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62908602e7be..c8e55b2613f5 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -600,6 +600,28 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes `git send-email` to abort before sending any
 e-mails.
 
+The following environment variables are set when executing the hook.
+
+`GIT_SENDEMAIL_FILE_COUNTER`::
+	A 1-based counter incremented by one for every file holding an e-mail
+	to be sent (excluding any FIFOs). This counter does not follow the
+	patch series counter scheme. It will always start at 1 and will end at
+	GIT_SENDEMAIL_FILE_TOTAL.
+
+`GIT_SENDEMAIL_FILE_TOTAL`::
+	The total number of files that will be sent (excluding any FIFOs). This
+	counter does not follow the patch series counter scheme. It will always
+	be equal to the number of files being sent, whether there is a cover
+	letter or not.
+
+These variables may for instance be used to validate patch series.
+
+The sample `sendemail-validate` hook that comes with Git checks that all sent
+patches (excluding the cover letter) can be applied on top of the upstream
+repository default branch without conflicts. Some placeholders are left for
+additional validation steps to be performed after all patches of a given series
+have been applied.
+
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbeaad..497ec0354790 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -795,11 +795,26 @@ sub is_format_patch_arg {
 @files = handle_backup_files(@files);
 
 if ($validate) {
+	# FIFOs can only be read once, exclude them from validation.
+	my @real_files = ();
 	foreach my $f (@files) {
 		unless (-p $f) {
-			validate_patch($f, $target_xfer_encoding);
+			push(@real_files, $f);
 		}
 	}
+
+	# Run the loop once again to avoid gaps in the counter due to FIFO
+	# arguments provided by the user.
+	my $num = 1;
+	my $num_files = scalar @real_files;
+	$ENV{GIT_SENDEMAIL_FILE_TOTAL} = "$num_files";
+	foreach my $r (@real_files) {
+		$ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
+		validate_patch($r, $target_xfer_encoding);
+		$num += 1;
+	}
+	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
+	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
 }
 
 if (@files) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 323952a572d6..7c7625759883 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2326,6 +2326,37 @@ test_expect_success $PREREQ 'invoke hook' '
 	)
 '
 
+expected_file_counter_output () {
+	total=$1
+	count=0
+	while test $count -ne $total
+	do
+		count=$((count + 1)) &&
+		echo "$count/$total" || return
+	done
+}
+
+test_expect_success $PREREQ '--validate hook allows counting of messages' '
+	test_when_finished "rm -rf my-hooks.log" &&
+	test_config core.hooksPath "my-hooks" &&
+	mkdir -p my-hooks &&
+
+	write_script my-hooks/sendemail-validate <<-\EOF &&
+		num=$GIT_SENDEMAIL_FILE_COUNTER &&
+		tot=$GIT_SENDEMAIL_FILE_TOTAL &&
+		echo "$num/$tot" >>my-hooks.log || exit 1
+	EOF
+
+	>my-hooks.log &&
+	expected_file_counter_output 4 >expect &&
+	git send-email \
+		--from="Example <from@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate -3 --cover-letter --force &&
+	test_cmp expect my-hooks.log
+'
+
 test_expect_success $PREREQ 'test that send-email works outside a repo' '
 	nongit git send-email \
 		--from="Example <nobody@example.com>" \
diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks--sendemail-validate.sample
new file mode 100755
index 000000000000..ad2f9a86473d
--- /dev/null
+++ b/templates/hooks--sendemail-validate.sample
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+# An example hook script to validate a patch (and/or patch series) before
+# sending it via email.
+#
+# The hook should exit with non-zero status after issuing an appropriate
+# message if it wants to prevent the email(s) from being sent.
+#
+# To enable this hook, rename this file to "sendemail-validate".
+#
+# By default, it will only check that the patch(es) can be applied on top of
+# the default upstream branch without conflicts in a secondary worktree. After
+# validation (successful or not) of the last patch of a series, the worktree
+# will be deleted.
+#
+# The following config variables can be set to change the default remote and
+# remote ref that are used to apply the patches against:
+#
+#   sendemail.validateRemote (default: origin)
+#   sendemail.validateRemoteRef (default: HEAD)
+#
+# Replace the TODO placeholders with appropriate checks according to your
+# needs.
+
+validate_cover_letter() {
+	file="$1"
+	# TODO: Replace with appropriate checks (e.g. spell checking).
+	true
+}
+
+validate_patch() {
+	file="$1"
+	# Ensure that the patch applies without conflicts.
+	git am -3 "$file" || return
+	# TODO: Replace with appropriate checks for this patch
+	# (e.g. checkpatch.pl).
+	true
+}
+
+validate_series() {
+	# TODO: Replace with appropriate checks for the whole series
+	# (e.g. quick build, coding style checks, etc.).
+	true
+}
+
+# main -------------------------------------------------------------------------
+
+if test "$GIT_SENDEMAIL_FILE_COUNTER" = 1
+then
+	remote=$(git config --default origin --get sendemail.validateRemote) &&
+	ref=$(git config --default HEAD --get sendemail.validateRemoteRef) &&
+	worktree=$(mktemp --tmpdir -d sendemail-validate.XXXXXXX) &&
+	git worktree add -fd --checkout "$worktree" "refs/remotes/$remote/$ref" &&
+	git config --replace-all sendemail.validateWorktree "$worktree"
+else
+	worktree=$(git config --get sendemail.validateWorktree)
+fi || {
+	echo "sendemail-validate: error: failed to prepare worktree" >&2
+	exit 1
+}
+
+unset GIT_DIR GIT_WORK_TREE
+cd "$worktree" &&
+
+if grep -q "^diff --git " "$1"
+then
+	validate_patch "$1"
+else
+	validate_cover_letter "$1"
+fi &&
+
+if test "$GIT_SENDEMAIL_FILE_COUNTER" = "$GIT_SENDEMAIL_FILE_TOTAL"
+then
+	git config --unset-all sendemail.validateWorktree &&
+	trap 'git worktree remove -ff "$worktree"' EXIT &&
+	validate_series
+fi
-- 
2.40.0

