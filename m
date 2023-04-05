Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BDC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 23:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjDEXNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDEXNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 19:13:21 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36CB185
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 16:13:17 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 09289100004;
        Wed,  5 Apr 2023 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680736394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87meFzEnAzhjzrKCa5SNNit8kDo2naDOVbg+EIA7lJo=;
        b=bPj1XaOKYkFG/ZClcIDzDPFQ9ZW4BNA/SF1e+T0+j7jttHDdHgweetYvEMsCGS78kEZ7a0
        BCcqXyHGO3ttKB5gBIYrDSXDJTtH4pxbJpN/qu7FQSd0hIMSsXHlqNSFUVORa+iLav/9Zt
        adKGObWn9WaeG83XfN1ienA3xl416KB5br0lFX8OGhtB1QrnX9fklZJWML8UkSWHDCXyxi
        wbpnqTaF37kgl0qCQpc4bctdTxv/UnP5IWa97SURlH6BTMRciaWKLSHfHfkn6/BPAavP8D
        oR5xGsBUjgIP/OvFP8sCctE5e/13JYoNbWDfalqJV2gBB+7V/L/K8hHU4SyfPg==
From:   Robin Jarry <robin@jarry.cc>
To:     git@vger.kernel.org
Cc:     Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Robin Jarry <robin@jarry.cc>
Subject: [PATCH v2] hooks: add sendemail-validate-series
Date:   Thu,  6 Apr 2023 01:13:05 +0200
Message-Id: <20230405231305.96996-1-robin@jarry.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230402185635.302653-1-robin@jarry.cc>
References: <20230402185635.302653-1-robin@jarry.cc>
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
patch. The patch files are provided in the hook script standard input,
one per line. Patch file names that contain LF characters are *not*
validated.

Signed-off-by: Robin Jarry <robin@jarry.cc>
---

Notes:
    v1 -> v2:
    
    - Use `git hook run --to-stdin` with a temp file.
    - Skip validation (with an explicit warning) for patch file names that
      contain newline characters.
    - Updated docs.

 Documentation/git-send-email.txt |  1 +
 Documentation/githooks.txt       | 19 +++++++++++++++++
 git-send-email.perl              | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 62908602e7be..0e8573c6c116 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -600,6 +600,25 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes `git send-email` to abort before sending any
 e-mails.
 
+sendemail-validate-series
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-send-email[1].  It allows performing
+validation on a complete patch series at once, instead of patch by patch with
+`sendemail-validate`.
+
+`sendemail-validate-series` takes no arguments.  For each e-mail to be sent,
+it receives on standard input a line of the format:
+
+  <patch-file> LF
+
+where '<patch-file>' is an absolute path to a file that holds an e-mail to be
+sent.  Any '<patch-file>' that contains a 'LF' character will *not* be fed to
+the hook and an explicit warning will be printed instead.
+
+If the hook exits with non-zero status, `git send-email` will abort before
+sending any e-mails.
+
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbeaad..b29050e14c06 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -800,6 +800,7 @@ sub is_format_patch_arg {
 			validate_patch($f, $target_xfer_encoding);
 		}
 	}
+	validate_patch_series(@files)
 }
 
 if (@files) {
@@ -2125,6 +2126,41 @@ sub validate_patch {
 	return;
 }
 
+sub validate_patch_series {
+	my @files = @_;
+
+	unless ($repo) {
+		return;
+	}
+	require File::Temp;
+	my $tmp = File::Temp->new(
+		TEMPLATE => "sendemail-series.XXXXXXXX",
+		UNLINK => 1,
+	);
+	for my $fn (@files) {
+		unless (-p $fn) {
+			$fn = Cwd::abs_path($fn);
+			if ($fn =~ /\n/) {
+				$fn =~ s/\n/'\\n'/g;
+				printf STDERR __("warning: file name contains '\\n': %s. Skipping validation.\n"), $fn;
+			} else {
+				$tmp->print("$fn\n");
+			}
+		}
+	}
+	my $hook_name = "sendemail-validate-series";
+	my @cmd = ("git", "hook", "run", "--ignore-missing",
+		   "--to-stdin", $tmp->filename, $hook_name, "--");
+	my $hook_error = system_or_msg(\@cmd, undef, "@cmd");
+	if ($hook_error) {
+		$hook_error = sprintf(
+		    __("fatal: series rejected by %s hook\n%s\nwarning: no patches were sent\n"),
+		    $hook_name, $hook_error);
+		die $hook_error;
+	}
+	return;
+}
+
 sub handle_backup {
 	my ($last, $lastlen, $file, $known_suffix) = @_;
 	my ($suffix, $skip);
-- 
2.40.0

