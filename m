Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BBC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33F92177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="BoaNWKLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgH0Rz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:55:56 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47448 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgH0Rzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598550954; bh=i5nXkiboSZPDRIW2wWPy99+k7FLnJnJyN0w1TjkDrVM=;
        h=From:To:Cc:Subject:Date;
        b=BoaNWKLrLSJ++AdwJctNlrwY/1T4FZS0fxWvL3E9MRVh2BG1ZHj5cwifqvCfzPFKR
         1j9bI4P7JMG0FEL7GM2mxU1iiUEfVC0r6cJHBqIgZjVprIWaK4DXlCwNLL/GRJm6zD
         hPDh4m2rzkwzT8NRFGrg7NvGq4NNse/WisDII7LE=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] send-email: do not prompt for In-Reply-To
Date:   Thu, 27 Aug 2020 13:55:52 -0400
Message-Id: <20200827175552.132193-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.28.0.339.ge198d205b2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most mailing lists prefer that new patchsets and their revisions are
placed into a new thread. Additionally, knowledge of what In-Reply-To
means and where to find the Message-Id to fill in are domain-specific
and confusing to new users. In the niche situations where this is called
for, the --in-reply-to flag is sufficient.

A config option, sendemail.promptInReplyTo, has been added to re-enable
the old behavior.
---
 Documentation/config/sendemail.txt | 7 +++++++
 git-send-email.perl                | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index cbc5af42fd..34ca8263d0 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -66,3 +66,10 @@ sendemail.forbidSendmailVariables::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
 	will abort with a warning if any configuration options for "sendmail"
 	exist. Set this variable to bypass the check.
+
+sendemail.promptInReplyTo::
+	Previous versions of linkgit:git-send-email[1] would prompt the user to
+	input an In-Reply-To header for every patchset sent. This was removed as
+	the default behavior, being generally undesirable on most mailing lists,
+	and confusing for new users. Set this variable to re-enable the old
+	behavior.
diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c0809..f3abccef6d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -251,6 +251,7 @@ sub do_edit {
 my $validate = 1;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $prompt_in_reply_to = 0;
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -265,6 +266,7 @@ sub do_edit {
     "annotate" => \$annotate,
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
+    "promptinreplyto" => \$prompt_in_reply_to,
 );
 
 my %config_settings = (
@@ -467,6 +469,7 @@ sub read_config {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
+		    "prompt-in-reply-to" => \$prompt_in_reply_to,
 	 );
 
 # Munge any "either config or getopt, not both" variables
@@ -978,7 +981,7 @@ sub expand_one_alias {
 @initial_cc = process_address_list(@initial_cc);
 @initial_bcc = process_address_list(@initial_bcc);
 
-if ($thread && !defined $initial_in_reply_to && $prompting) {
+if ($thread && !defined $initial_in_reply_to && $prompting && $prompt_in_reply_to) {
 	$initial_in_reply_to = ask(
 		__("Message-ID to be used as In-Reply-To for the first email (if any)? "),
 		default => "",
-- 
2.28.0

