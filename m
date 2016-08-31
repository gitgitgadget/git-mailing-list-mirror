Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5F61F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbcHaMdG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:33:06 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42614 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:33:06 -0400
Received: (qmail 13213 invoked from network); 31 Aug 2016 12:33:04 -0000
Received: (qmail 7770 invoked from network); 31 Aug 2016 12:33:04 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:32:59 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 05/11] i18n: add--interactive: mark message for translation
Date:   Wed, 31 Aug 2016 12:31:24 +0000
Message-Id: <1472646690-9699-6-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark message assembled in place for translation, unfolding each use case
for each entry in the %patch_modes hash table.

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
 git-add--interactive.perl | 91 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 08badfa..5b89b97 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -91,6 +91,7 @@ sub colored {
 }
 
 # command line options
+my $cmd;
 my $patch_mode;
 my $patch_mode_revision;
 
@@ -171,7 +172,8 @@ my %patch_modes = (
 	},
 );
 
-my %patch_mode_flavour = %{$patch_modes{stage}};
+$patch_mode = 'stage';
+my %patch_mode_flavour = %{$patch_modes{$patch_mode}};
 
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
@@ -1372,12 +1374,84 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, $patch_mode_flavour{VERB},
-		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
-		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
-		   ' this hunk'),
-		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		if ($patch_mode eq 'stage') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Stage mode change [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Stage deletion [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Stage this hunk [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'stash') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Stash mode change [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Stash deletion [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Stash this hunk [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'reset_head') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Unstage mode change [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Unstage deletion [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Unstage this hunk [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'reset_nothead') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Apply mode change to index [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Apply deletion to index [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'checkout_index') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'checkout_head') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		} elsif ($patch_mode eq 'checkout_nothead') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf(__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf(__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			} else {
+			  print colored $prompt_color,
+			    sprintf(__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
+			}
+		}
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1631,6 +1705,7 @@ sub process_args {
 		die sprintf(__("invalid argument %s, expecting --"),
 			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
+		$cmd = 1;
 	}
 	elsif ($arg ne "--") {
 		die sprintf(__("invalid argument %s, expecting --"), $arg);
@@ -1667,7 +1742,7 @@ sub main_loop {
 
 process_args();
 refresh();
-if ($patch_mode) {
+if ($cmd) {
 	patch_update_cmd();
 }
 else {
-- 
2.7.4

