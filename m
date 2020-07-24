Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E47C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A2E206E3
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="nSfeRgHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGXAoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:44:34 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:52926 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728328AbgGXAoe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595551473; bh=Vsi25zdh6m7By1UtPW0XbPfaDu0LmrKoydFLV3ww8x0=;
        h=From:To:Cc:Subject:Date;
        b=nSfeRgHsyzRsL9LpUzvLST3BdMdwEG32dVCoZEFTmbNI/CeYoJMgsy6B8QpjJC/8m
         p5VdxlSSbb25oAxNVAXeu/Ai44Bn9VPmv4P/fCZ4rH1oQpfcIMkoAZSCFTkBLnm7Km
         AX7086mHglbtEOeiJMdjO5QGe3mrTRru36kAGMjI=
From:   Drew DeVault <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, "Jeff King" <peff@peff.net>
Subject: [PATCH v3] git-send-email: die if sendmail.* config is set
Date:   Thu, 23 Jul 2020 20:44:32 -0400
Message-Id: <20200724004432.185167-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've seen several people mis-configure git send-email on their first
attempt because they set the sendmail.* config options - not
sendemail.*. This patch detects this mistake and bails out with a
friendly warning.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 Documentation/config/sendemail.txt |  5 +++++
 git-send-email.perl                |  8 ++++++++
 perl/Git.pm                        | 26 ++++++++++++++++++++++++++
 t/t9001-send-email.sh              | 29 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..cbc5af42fd 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -61,3 +61,8 @@ sendemail.smtpBatchSize::
 sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
+
+sendemail.forbidSendmailVariables::
+	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
+	will abort with a warning if any configuration options for "sendmail"
+	exist. Set this variable to bypass the check.
diff --git a/git-send-email.perl b/git-send-email.perl
index 36c47bae1d..1f425c0809 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -250,6 +250,7 @@ sub do_edit {
 my $use_xmailer = 1;
 my $validate = 1;
 my $target_xfer_encoding = 'auto';
+my $forbid_sendmail_variables = 1;
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -263,6 +264,7 @@ sub do_edit {
     "multiedit" => \$multiedit,
     "annotate" => \$annotate,
     "xmailer" => \$use_xmailer,
+    "forbidsendmailvariables" => \$forbid_sendmail_variables,
 );
 
 my %config_settings = (
@@ -478,6 +480,12 @@ sub read_config {
     usage();
 }
 
+if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
+	die __("fatal: found configuration options for 'sendmail'\n" .
+		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
+		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
+}
+
 die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 54c9ed0dde..10df990959 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -723,6 +723,32 @@ sub config_int {
 	return scalar _config_common({'kind' => '--int'}, @_);
 }
 
+=item config_regexp ( RE )
+
+Retrieve the list of configuration key names matching the regular
+expression C<RE>. The return value is a list of strings matching
+this regex.
+
+=cut
+
+sub config_regexp {
+	my ($self, $regex) = _maybe_self(@_);
+	try {
+		my @cmd = ('config', '--name-only', '--get-regexp', $regex);
+		unshift @cmd, $self if $self;
+		my @matches = command(@cmd);
+		return @matches;
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			my @matches = ();
+			return @matches;
+		} else {
+			throw $E;
+		}
+	};
+}
+
 # Common subroutine to implement bulk of what the config* family of methods
 # do. This currently wraps command('config') so it is not so fast.
 sub _config_common {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ec261085ec..897bc6a631 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2142,4 +2142,33 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 		"$(pwd)/0001-add-master.patch"
 '
 
+test_expect_success $PREREQ 'test that sendmail config is rejected' '
+	test_config sendmail.program sendmail &&
+	test_must_fail git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^ 2>err &&
+	test_i18ngrep "found configuration options for '"'"sendmail"'"'" err
+'
+
+test_expect_success $PREREQ 'test that sendmail config rejection is specific' '
+	test_config resendmail.program sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^
+'
+
+test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
+	test_config sendmail.program sendmail &&
+	test_config sendemail.forbidSendmailVariables false &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^
+'
+
 test_done
-- 
2.27.0

