Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4DB209B6
	for <e@80x24.org>; Wed,  5 Oct 2016 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754724AbcJERWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:22:04 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:44414 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754675AbcJERWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:22:02 -0400
Received: (qmail 22033 invoked from network); 5 Oct 2016 17:22:00 -0000
Received: (qmail 9811 invoked from network); 5 Oct 2016 17:22:00 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 Oct 2016 17:21:55 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/14] i18n: add--interactive: mark patch prompt for translation
Date:   Wed,  5 Oct 2016 17:21:02 +0000
Message-Id: <20161005172110.30801-7-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.366.g8a57a7a
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark prompt message assembled in place for translation, unfolding each
use case for each entry in the %patch_modes hash table.

Previously, this script relied on whether $patch_mode was set to run the
command patch_update_cmd() or show status and loop the main loop. Now,
it uses $cmd to indicate we must run patch_update_cmd() and $patch_mode
is used to tell which flavor of the %patch_modes are we on.  This is
introduced in order to be able to mark and unfold the message prompt
knowing in which context we are.

The tracking of context was done previously by point %patch_mode_flavour
hash table to the correct entry of %patch_modes, focusing only on value
of %patch_modes. Now, we are also interested in the key ('staged',
'stash', 'checkout_head', ...).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 54 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 6bbde2d..c8d5093 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -93,6 +93,7 @@ sub colored {
 }
 
 # command line options
+my $cmd;
 my $patch_mode;
 my $patch_mode_revision;
 
@@ -173,7 +174,8 @@ my %patch_modes = (
 	},
 );
 
-my %patch_mode_flavour = %{$patch_modes{stage}};
+$patch_mode = 'stage';
+my %patch_mode_flavour = %{$patch_modes{$patch_mode}};
 
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
@@ -1311,6 +1313,44 @@ sub display_hunks {
 	return $i;
 }
 
+my %patch_update_prompt_modes = (
+	stage => {
+		mode => __("Stage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Stage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	stash => {
+		mode => __("Stash mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Stash deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_head => {
+		mode => __("Unstage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Unstage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_nothead => {
+		mode => __("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_index => {
+		mode => __("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_head => {
+		mode => __("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_nothead => {
+		mode => __("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => __("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => __("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+);
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
@@ -1383,12 +1423,9 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, $patch_mode_flavour{VERB},
-		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
-		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
-		   ' this hunk'),
-		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		print colored $prompt_color,
+			sprintf($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}, $other);
+
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1644,6 +1681,7 @@ sub process_args {
 		die sprintf(__("invalid argument %s, expecting --"),
 			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
+		$cmd = 1;
 	}
 	elsif ($arg ne "--") {
 		die sprintf(__("invalid argument %s, expecting --"), $arg);
@@ -1680,7 +1718,7 @@ sub main_loop {
 
 process_args();
 refresh();
-if ($patch_mode) {
+if ($cmd) {
 	patch_update_cmd();
 }
 else {
-- 
2.7.4

