Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49563C7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjDBS4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 14:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDBS4s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 14:56:48 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5818A57
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 11:56:45 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 01F7A100005;
        Sun,  2 Apr 2023 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680461804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kA+qNYZ5JpOQwIRlzHiWwSldLogcP3FOowQI9xDhQCo=;
        b=f9K1VXe7DLJbypwn0p0u2EQ6HDeksFTRlZ4VSz/YWm1uqAWqxD+GwEV3B0Vj2ZP+1rZhu6
        F059mydfqCBXCbPlwkE412GRoa7OjaH2PK65MpGnZ3/Vj/N09C9Y4Jgm+gMbDwyuh7AQ7Z
        p7R7HuMgrWWiLdvNm09LdZU66XVTjhUerg4QUl532U9Q+5avx/9JcG52OYt9A+diqv/Ndr
        mSly5m2D5Qr64zI/XQpSYcDmOrcogKSoPdksY8PWkqFzV8pZAefFmbUR8DBZZlNMOjj0j1
        Y5C21uHduA7p44X7q7j9rOjhXoa0ArCbIAunbbeB/bS9ZyAlkF6nUxWwI6L0Mg==
From:   Robin Jarry <robin@jarry.cc>
To:     git@vger.kernel.org
Cc:     Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Robin Jarry <robin@jarry.cc>
Subject: [PATCH RESEND] hooks: add sendemail-validate-series
Date:   Sun,  2 Apr 2023 20:56:35 +0200
Message-Id: <20230402185635.302653-1-robin@jarry.cc>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sending patch series (with a cover-letter or not)
sendemail-validate is called with every email/patch file independently
from the others. When one of the patches depends on a previous one, it
may not be possible to use this hook in a meaningful way.

Changing sendemail-validate to take all patches as arguments would break
backward compatibility.

Add a new hook to allow validating patch series instead of patch by
patch. The patch files are provided in the hook script standard input.

git hook run cannot be used since it closes the hook standard input. Run
the hook directly.

Signed-off-by: Robin Jarry <robin@jarry.cc>
---
Rebased on 140b9478dad5 ("The sixth batch")

 Documentation/git-send-email.txt |  1 +
 Documentation/githooks.txt       | 17 +++++++++++++
 git-send-email.perl              | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 765b2df8530d..45113b928593 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -438,6 +438,7 @@ have been specified, in which case default to 'compose'.
 +
 --
 		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
+		*	Invoke the sendemail-validate-series hook if present (see linkgit:githooks[5]).
 		*	Warn of patches that contain lines longer than
 			998 characters unless a suitable transfer encoding
 			('auto', 'base64', or 'quoted-printable') is used;
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62908602e7be..b81783235111 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -600,6 +600,23 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes `git send-email` to abort before sending any
 e-mails.
 
+sendemail-validate-series
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-send-email[1].  It allows performing
+validation on a complete patch series at once, instead of patch by patch with
+`sendemail-validate`.
+
+`sendemail-validate-series` takes no arguments, but for each e-mail to be sent
+it receives on standard input a line of the format:
+
+  <patch-file> LF
+
+where `<patch-file>` is a name of a file that holds an e-mail to be sent,
+
+If the hook exits with non-zero status, `git send-email` will abort before
+sending any e-mails.
+
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbeaad..bec4d0f4ab47 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -800,6 +800,7 @@ sub is_format_patch_arg {
 			validate_patch($f, $target_xfer_encoding);
 		}
 	}
+	validate_patch_series(@files)
 }
 
 if (@files) {
@@ -2125,6 +2126,47 @@ sub validate_patch {
 	return;
 }
 
+sub validate_patch_series {
+	my @files = @_;
+
+	unless ($repo) {
+		return;
+	}
+
+	my $hook_name = 'sendemail-validate-series';
+	my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
+	require File::Spec;
+	my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);
+	my $hook_error;
+	unless (-x $validate_hook) {
+		return;
+	}
+
+	# The hook needs a correct cwd and GIT_DIR.
+	require Cwd;
+	my $cwd_save = Cwd::getcwd();
+	chdir($repo->wc_path() or $repo->repo_path()) or die("chdir: $!");
+	local $ENV{"GIT_DIR"} = $repo->repo_path();
+	# cannot use git hook run, it closes stdin before forking the hook
+	open(my $stdin, "|-", $validate_hook) or die("fork: $!");
+	chdir($cwd_save) or die("chdir: $!");
+	for my $fn (@files) {
+		unless (-p $fn) {
+			$fn = Cwd::abs_path($fn);
+			$stdin->print("$fn\n");
+		}
+	}
+	close($stdin); # calls waitpid
+	if ($? & 0x7f) {
+		my $sig = $? & 0x7f;
+		die("fatal: hook $hook_name killed by signal $sig");
+	} elsif ($? >> 8) {
+		my $err = $? >> 8;
+		die("fatal: hook $hook_name rejected patch series (exit code $err)");
+	}
+	return;
+}
+
 sub handle_backup {
 	my ($last, $lastlen, $file, $known_suffix) = @_;
 	my ($suffix, $skip);
-- 
2.39.2

