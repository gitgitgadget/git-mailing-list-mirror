Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F524C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF0E2070E
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 13:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="Ih7PDT0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGRNdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:33:15 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:37148 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 09:33:15 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2020 09:33:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595078594; bh=uOdjjHPcvsE8xgfQSm7QpZ0H3vLzzk1w616ev4ukNh8=;
        h=From:To:Cc:Subject:Date;
        b=Ih7PDT0sK1kx2c2xFg1Edh/8TZIXdncQ4fcLuKXwYvfSCMuoOWjzVOp8kMLlI0QUe
         AzSMAqwTWN2fIeS2OGtUDHZHx7XMyoOKPLWPbwUTaIiaY8JeinI2TyuSAfq0R2iHEu
         KR0H8dKhrMAwCID1Zdbtny2npgM641bX+PjGDfOs=
From:   Drew DeVault <sir@cmpwn.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] git-send-email: die if sendmail.* config is set
Date:   Sat, 18 Jul 2020 09:23:11 -0400
Message-Id: <20200718132311.27248-1-sir@cmpwn.com>
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
 git-send-email.perl |  6 ++++++
 perl/Git.pm         | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 36c47bae1d..8e42ba00c1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -478,6 +478,12 @@ sub read_config {
     usage();
 }
 
+if ((scalar Git::config_regexp("sendmail.*")) != 0) {
+	die __("fatal: found configuration options for 'sendmail'\n" .
+		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
+		"Assuming this is a mistake and bailing out.\n");
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

