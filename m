Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D991F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbcFULsX (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:48:23 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:51978 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752083AbcFULp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:45:26 -0400
Received: (qmail 9859 invoked from network); 21 Jun 2016 11:45:24 -0000
Received: (qmail 27785 invoked from network); 21 Jun 2016 11:45:24 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/11] i18n: add--interactive: mark strings for translation
Date:	Tue, 21 Jun 2016 11:44:03 +0000
Message-Id: <20160621114413.9467-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark simple strings (without interpolation) for translation.

Brackets around first parameter of ternary operator is necessary because
otherwise xgettext fails to extract strings marked for translation from
the rest of the file.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 68 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 822f857..fb8e5de 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -4,6 +4,7 @@ use 5.008;
 use strict;
 use warnings;
 use Git;
+use Git::I18N;
 
 binmode(STDOUT, ":raw");
 
@@ -252,7 +253,7 @@ sub list_untracked {
 }
 
 my $status_fmt = '%12s %12s %s';
-my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
+my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'));
 
 {
 	my $initial;
@@ -678,7 +679,7 @@ sub update_cmd {
 	my @mods = list_modified('file-only');
 	return if (!@mods);
 
-	my @update = list_and_choose({ PROMPT => 'Update',
+	my @update = list_and_choose({ PROMPT => __('Update'),
 				       HEADER => $status_head, },
 				     @mods);
 	if (@update) {
@@ -690,7 +691,7 @@ sub update_cmd {
 }
 
 sub revert_cmd {
-	my @update = list_and_choose({ PROMPT => 'Revert',
+	my @update = list_and_choose({ PROMPT => __('Revert'),
 				       HEADER => $status_head, },
 				     list_modified());
 	if (@update) {
@@ -724,13 +725,13 @@ sub revert_cmd {
 }
 
 sub add_untracked_cmd {
-	my @add = list_and_choose({ PROMPT => 'Add untracked' },
+	my @add = list_and_choose({ PROMPT => __('Add untracked') },
 				  list_untracked());
 	if (@add) {
 		system(qw(git update-index --add --), @add);
 		say_n_paths('added', @add);
 	} else {
-		print "No untracked files.\n";
+		print __("No untracked files.\n");
 	}
 	print "\n";
 }
@@ -1159,8 +1160,11 @@ sub edit_hunk_loop {
 		}
 		else {
 			prompt_yesno(
-				'Your edited hunk does not apply. Edit again '
-				. '(saying "no" discards!) [y/n]? '
+				# TRANSLATORS: do not translate [y/n]
+				# The program will only accept that input
+				# at this point.
+				__('Your edited hunk does not apply. Edit again '
+				   . '(saying "no" discards!) [y/n]? ')
 				) or return undef;
 		}
 	}
@@ -1206,11 +1210,11 @@ sub apply_patch_for_checkout_commit {
 		run_git_apply 'apply '.$reverse, @_;
 		return 1;
 	} elsif (!$applies_index) {
-		print colored $error_color, "The selected hunks do not apply to the index!\n";
-		if (prompt_yesno "Apply them to the worktree anyway? ") {
+		print colored $error_color, __("The selected hunks do not apply to the index!\n");
+		if (prompt_yesno __("Apply them to the worktree anyway? ")) {
 			return run_git_apply 'apply '.$reverse, @_;
 		} else {
-			print colored $error_color, "Nothing was applied.\n";
+			print colored $error_color, __("Nothing was applied.\n");
 			return 0;
 		}
 	} else {
@@ -1230,9 +1234,9 @@ sub patch_update_cmd {
 
 	if (!@mods) {
 		if (@all_mods) {
-			print STDERR "Only binary files changed.\n";
+			print STDERR __("Only binary files changed.\n");
 		} else {
-			print STDERR "No changes.\n";
+			print STDERR __("No changes.\n");
 		}
 		return 0;
 	}
@@ -1390,12 +1394,12 @@ sub patch_update_file {
 				my $response = $1;
 				my $no = $ix > 10 ? $ix - 10 : 0;
 				while ($response eq '') {
-					my $extra = "";
 					$no = display_hunks(\@hunk, $no);
 					if ($no < $num) {
-						$extra = " (<ret> to see more)";
+						print __("go to which hunk (<ret> to see more)? ");
+					} else {
+						print __("go to which hunk? ");
 					}
-					print "go to which hunk$extra? ";
 					$response = <STDIN>;
 					if (!defined $response) {
 						$response = '';
@@ -1432,7 +1436,7 @@ sub patch_update_file {
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
 				if ($1 eq "") {
-					print colored $prompt_color, "search for regex? ";
+					print colored $prompt_color, __("search for regex? ");
 					$regex = <STDIN>;
 					if (defined $regex) {
 						chomp $regex;
@@ -1455,7 +1459,7 @@ sub patch_update_file {
 					$iy++;
 					$iy = 0 if ($iy >= $num);
 					if ($ix == $iy) {
-						error_msg "No hunk matches the given pattern\n";
+						error_msg __("No hunk matches the given pattern\n");
 						last;
 					}
 				}
@@ -1467,7 +1471,7 @@ sub patch_update_file {
 					$ix--;
 				}
 				else {
-					error_msg "No previous hunk\n";
+					error_msg __("No previous hunk\n");
 				}
 				next;
 			}
@@ -1476,7 +1480,7 @@ sub patch_update_file {
 					$ix++;
 				}
 				else {
-					error_msg "No next hunk\n";
+					error_msg __("No next hunk\n");
 				}
 				next;
 			}
@@ -1489,13 +1493,13 @@ sub patch_update_file {
 					}
 				}
 				else {
-					error_msg "No previous hunk\n";
+					error_msg __("No previous hunk\n");
 				}
 				next;
 			}
 			elsif ($line =~ /^j/) {
 				if ($other !~ /j/) {
-					error_msg "No next hunk\n";
+					error_msg __("No next hunk\n");
 					next;
 				}
 			}
@@ -1553,18 +1557,18 @@ sub diff_cmd {
 	my @mods = list_modified('index-only');
 	@mods = grep { !($_->{BINARY}) } @mods;
 	return if (!@mods);
-	my (@them) = list_and_choose({ PROMPT => 'Review diff',
+	my (@them) = list_and_choose({ PROMPT => __('Review diff'),
 				     IMMEDIATE => 1,
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	my $reference = is_initial_commit() ? get_empty_tree() : 'HEAD';
+	my $reference = (is_initial_commit()) ? get_empty_tree() : 'HEAD';
 	system(qw(git diff -p --cached), $reference, '--',
 		map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
-	print "Bye.\n";
+	print __("Bye.\n");
 	exit(0);
 }
 
@@ -1587,32 +1591,32 @@ sub process_args {
 			if ($1 eq 'reset') {
 				$patch_mode = 'reset_head';
 				$patch_mode_revision = 'HEAD';
-				$arg = shift @ARGV or die "missing --";
+				$arg = shift @ARGV or die __("missing --");
 				if ($arg ne '--') {
 					$patch_mode_revision = $arg;
 					$patch_mode = ($arg eq 'HEAD' ?
 						       'reset_head' : 'reset_nothead');
-					$arg = shift @ARGV or die "missing --";
+					$arg = shift @ARGV or die __("missing --");
 				}
 			} elsif ($1 eq 'checkout') {
-				$arg = shift @ARGV or die "missing --";
+				$arg = shift @ARGV or die __("missing --");
 				if ($arg eq '--') {
 					$patch_mode = 'checkout_index';
 				} else {
 					$patch_mode_revision = $arg;
 					$patch_mode = ($arg eq 'HEAD' ?
 						       'checkout_head' : 'checkout_nothead');
-					$arg = shift @ARGV or die "missing --";
+					$arg = shift @ARGV or die __("missing --");
 				}
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
-				$arg = shift @ARGV or die "missing --";
+				$arg = shift @ARGV or die __("missing --");
 			} else {
 				die "unknown --patch mode: $1";
 			}
 		} else {
 			$patch_mode = 'stage';
-			$arg = shift @ARGV or die "missing --";
+			$arg = shift @ARGV or die __("missing --");
 		}
 		die "invalid argument $arg, expecting --"
 		    unless $arg eq "--";
@@ -1634,10 +1638,10 @@ sub main_loop {
 		   [ 'help', \&help_cmd, ],
 	);
 	while (1) {
-		my ($it) = list_and_choose({ PROMPT => 'What now',
+		my ($it) = list_and_choose({ PROMPT => __('What now'),
 					     SINGLETON => 1,
 					     LIST_FLAT => 4,
-					     HEADER => '*** Commands ***',
+					     HEADER => __('*** Commands ***'),
 					     ON_EOF => \&quit_cmd,
 					     IMMEDIATE => 1 }, @cmd);
 		if ($it) {
-- 
2.6.6

