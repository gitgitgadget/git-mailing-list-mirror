Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F84C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 09:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLJyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDLJyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 05:54:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB427690
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:54:39 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id DE3514000D;
        Wed, 12 Apr 2023 09:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681293278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70tgvnJ4Rg8E1gemWXnY1Z+M755c+LOujRrvtfQw9fo=;
        b=eAW9QAigSnaC2SXdM8SLr5xUeyl2r0l1l1AXf+XXLTYaBttVff9WA4yK2weMWlPxX6H2IL
        3rV6eiYl4QxAbOhHjVRJpw3wB0jumTQlU4DpHR/d2UetkaAlt+ULGjS43vGjxSm8smqo7o
        v0nNYE8TVx5ITPySwls1lNoKLEaLn8r89MZMtOB1Ni6x4pEGov3hl11s6yLLwAseEZ6was
        HZfCwAptM7qZJiG+TWsQOE97VlV77VZtoSjmQYqzYxZrVpCHIoNDjjq0ME7izyW+gySzFj
        8ckKxyxhVrTBKpG0vdZnKiJJfPWCnZQeZgrZvv92Uh4w6+34X/arY7FWoMxN2Q==
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
Subject: [PATCH v2] send-email: export patch counters in validate environment
Date:   Wed, 12 Apr 2023 11:54:34 +0200
Message-Id: <20230412095434.140754-1-robin@jarry.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411114723.89029-1-robin@jarry.cc>
References: <20230411114723.89029-1-robin@jarry.cc>
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
a git config sendemail.validateWorkdir entry.

Add a sample script with placeholder validations.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Robin Jarry <robin@jarry.cc>
---

Notes:
    v1 -> v2:
    
    * Added more details in documentation.
    * Exclude FIFOs from COUNT/TOTAL
    * Only set TOTAL once.
    * Only unset COUNT/TOTAL once.
    * Add sample hook script.

 Documentation/githooks.txt                 | 22 ++++++
 git-send-email.perl                        | 17 ++++-
 templates/hooks--sendemail-validate.sample | 84 ++++++++++++++++++++++
 3 files changed, 122 insertions(+), 1 deletion(-)
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
diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks--sendemail-validate.sample
new file mode 100755
index 000000000000..c898ee3ab167
--- /dev/null
+++ b/templates/hooks--sendemail-validate.sample
@@ -0,0 +1,84 @@
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
+# the default upstream branch without conflicts. Replace the XXX placeholders
+# with appropriate checks according to your needs.
+
+set -e
+
+validate_cover_letter()
+{
+	file="$1"
+	# XXX: Add appropriate checks here (e.g. spell checking).
+}
+
+validate_patch()
+{
+	file="$1"
+	# Ensure that the patch applies without conflicts to the latest
+	# upstream version.
+	git am -3 "$file" || die "failed to apply patch on upstream repo"
+	# XXX: Add appropriate checks here (e.g. checkpatch.pl).
+}
+
+validate_series()
+{
+	# XXX: Add appropriate checks here (e.g. quick build, etc.).
+}
+
+die()
+{
+	echo "sendemail-validate: error: $*" >&2
+	exit 1
+}
+
+get_work_dir()
+{
+	git config --get sendemail.validateWorkdir || {
+		# Initialize it to a temp dir, if unset.
+		git config --add sendemail.validateWorkdir "$(mktemp -d)"
+		git config --get sendemail.validateWorkdir
+	}
+}
+
+get_upstream_url()
+{
+	git config --get remote.origin.url ||
+		die "cannot get remote.origin.url"
+}
+
+clone_upstream()
+{
+	workdir="$1"
+	url="$(get_upstream_url)"
+	rm -rf -- "$workdir"
+	git clone --depth=1 "$url" "$workdir" ||
+		die "failed to clone upstream repository"
+}
+
+# main -------------------------------------------------------------------------
+
+workdir=$(get_work_dir)
+if [ "$GIT_SENDEMAIL_FILE_COUNTER" = 1 ]; then
+	clone_upstream "$workdir"
+fi
+cd "$workdir"
+export GIT_DIR="$workdir/.git"
+
+if grep -q "^diff --git " "$1"; then
+	validate_patch "$1"
+else
+	validate_cover_letter "$1"
+fi
+
+if [ "$GIT_SENDEMAIL_FILE_COUNTER" = "$GIT_SENDEMAIL_FILE_TOTAL" ]; then
+	validate_series || die "patch series was rejected"
+fi
-- 
2.40.0

