Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3176C433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732432074B
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="UnpptlsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGRUVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:21:46 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:37484 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGRUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595103704; bh=f6oh99t6XlcZna/3tjtFSIUyhcI3v/hKON+nrpG5nqY=;
        h=From:To:Cc:Subject:Date;
        b=UnpptlsQRVDUlRU1A66REVbwVc9m2nz+6qjdkadnsOqRPpklatGQhMp/XldSVh2N5
         g5rD26r8fpPy0J3dNyfx9qtoQnE0zQK+rSL/yE6hINZQQjzSOa6wfj/wqJShiuzgOw
         ipf95V6xtuUajXcAFNPwQbzioa/UxR9nqnJN/Bew=
From:   Drew DeVault <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2] git-send-email: die if sendmail.* config is set
Date:   Sat, 18 Jul 2020 16:21:42 -0400
Message-Id: <20200718202142.111015-1-sir@cmpwn.com>
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
 3 files changed, 39 insertions(+)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..1726d5f85e 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -61,3 +61,8 @@ sendemail.smtpBatchSize::
 sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
+
+sendemail.forceSendmailVariables::
+	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
+	will abort with a warning if any configuration options for "sendmail"
+	exist. Set this variable to bypass the check.
diff --git a/git-send-email.perl b/git-send-email.perl
index 36c47bae1d..1b186bc058 100755
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
 
+if ($forbid_sendmail_variables && (scalar Git::config_regexp("sendmail.*")) != 0) {
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
-- 
2.27.0

