Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4A920133
	for <e@80x24.org>; Thu,  2 Mar 2017 10:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdCBKPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 05:15:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:37115 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdCBKPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 05:15:09 -0500
Received: (qmail 27867 invoked by uid 109); 2 Mar 2017 09:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 09:48:24 +0000
Received: (qmail 15819 invoked by uid 111); 2 Mar 2017 09:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 04:48:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 04:48:22 -0500
Date:   Thu, 2 Mar 2017 04:48:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] add--interactive: fix missing file prompt for patch mode
 with "-i"
Message-ID: <20170302094822.7a65bk2i3qciw6jg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When invoked as "git add -i", each menu interactive menu
option prompts the user to select a list of files. This
includes the "patch" option, which gets the list before
starting the hunk-selection loop.

As "git add -p", it behaves differently, and jumps straight
to the hunk selection loop.

Since 0539d5e6d (i18n: add--interactive: mark patch prompt
for translation, 2016-12-14), the "add -i" case mistakenly
jumps to straight to the hunk-selection loop. Prior to that
commit the distinction between the two cases was managed by
the $patch_mode variable. That commit used $patch_mode for
something else, and moved the old meaning to the "$cmd"
variable.  But it forgot to update the $patch_mode check
inside patch_update_cmd() which controls the file-list
behavior.

The simplest fix would be to change that line to check $cmd.
But while we're here, let's use a less obscure name for this
flag: $patch_mode_only, a boolean which tells whether we are
in full-interactive mode or only in patch-mode.

Reported-by: Henrik Grubbström <grubba@grubba.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl  |  8 ++++----
 t/t3701-add-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 982593c89..f5c816e27 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -92,7 +92,7 @@ sub colored {
 }
 
 # command line options
-my $cmd;
+my $patch_mode_only;
 my $patch_mode;
 my $patch_mode_revision;
 
@@ -1299,7 +1299,7 @@ sub patch_update_cmd {
 		}
 		return 0;
 	}
-	if ($patch_mode) {
+	if ($patch_mode_only) {
 		@them = @mods;
 	}
 	else {
@@ -1721,7 +1721,7 @@ sub process_args {
 		die sprintf(__("invalid argument %s, expecting --"),
 			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
-		$cmd = 1;
+		$patch_mode_only = 1;
 	}
 	elsif ($arg ne "--") {
 		die sprintf(__("invalid argument %s, expecting --"), $arg);
@@ -1758,7 +1758,7 @@ sub main_loop {
 
 process_args();
 refresh();
-if ($cmd) {
+if ($patch_mode_only) {
 	patch_update_cmd();
 }
 else {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5ffe78e92..aaa258daa 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -394,4 +394,22 @@ test_expect_success 'diffs can be colorized' '
 	grep "$(printf "\\033")" output
 '
 
+test_expect_success 'patch-mode via -i prompts for files' '
+	git reset --hard &&
+
+	echo one >file &&
+	echo two >test &&
+	git add -i <<-\EOF &&
+	patch
+	test
+
+	y
+	quit
+	EOF
+
+	echo test >expect &&
+	git diff --cached --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.367.gb23790f66
