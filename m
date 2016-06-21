Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392A61F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbcFULp4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:45:56 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47449 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752047AbcFULpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:45:55 -0400
Received: (qmail 28647 invoked from network); 21 Jun 2016 11:45:48 -0000
Received: (qmail 32359 invoked from network); 21 Jun 2016 11:45:48 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:42 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/11] i18n: add--interactive: mark message for translation
Date:	Tue, 21 Jun 2016 11:44:07 +0000
Message-Id: <20160621114413.9467-5-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
 git-add--interactive.perl | 112 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ef50ba0..909f396 100755
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
@@ -1372,12 +1374,105 @@ sub patch_update_file {
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
+			    sprintf __("Stage mode change [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Stage deletion [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'stash') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Stash mode change [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Stash deletion [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'reset_head') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Unstage mode change [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Unstage deletion [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'reset_nothead') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'checkout_index') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'checkout_head') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		} elsif ($patch_mode eq 'checkout_nothead') {
+			if ($hunk[$ix]{TYPE} eq 'mode') {
+			  print colored $prompt_color,
+			    sprintf __("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
+			  print colored $prompt_color,
+			    sprintf __("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			} else {
+			  print colored $prompt_color,
+			    sprintf __("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+				       $other;
+			}
+		}
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1631,6 +1726,7 @@ sub process_args {
 		die sprintf __("invalid argument %s, expecting --"),
 			       $arg unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
+		$cmd = 1;
 	}
 	elsif ($arg ne "--") {
 		die sprintf __("invalid argument %s, expecting --"), $arg;
@@ -1667,7 +1763,7 @@ sub main_loop {
 
 process_args();
 refresh();
-if ($patch_mode) {
+if ($cmd) {
 	patch_update_cmd();
 }
 else {
-- 
2.6.6

