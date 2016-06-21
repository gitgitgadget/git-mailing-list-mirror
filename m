Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C361F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcFULpk (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:45:40 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:43616 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752245AbcFULph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:45:37 -0400
Received: (qmail 1927 invoked from network); 21 Jun 2016 11:45:35 -0000
Received: (qmail 30146 invoked from network); 21 Jun 2016 11:45:35 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:30 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/11] i18n: add--interactive: mark strings with interpolation for translation
Date:	Tue, 21 Jun 2016 11:44:05 +0000
Message-Id: <20160621114413.9467-3-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use of sprintf following die or error_msg is necessary for placeholder
substitution take place.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e11a33d..d8d61d4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -612,12 +612,12 @@ sub list_and_choose {
 			else {
 				$bottom = $top = find_unique($choice, @stuff);
 				if (!defined $bottom) {
-					error_msg "Huh ($choice)?\n";
+					error_msg sprintf __("Huh (%s)?\n"), $choice;
 					next TOPLOOP;
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				error_msg "Huh ($choice)?\n";
+				error_msg sprintf __("Huh (%s)?\n"), $choice;
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -1048,7 +1048,7 @@ sub edit_hunk_manually {
 	my $hunkfile = $repo->repo_path . "/addp-hunk-edit.diff";
 	my $fh;
 	open $fh, '>', $hunkfile
-		or die "failed to open hunk edit file for writing: " . $!;
+		or die sprintf __("failed to open hunk edit file for writing: %s"), $!;
 	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
 	print $fh @$oldtext;
 	my $participle = $patch_mode_flavour{PARTICIPLE};
@@ -1075,7 +1075,7 @@ EOF
 	}
 
 	open $fh, '<', $hunkfile
-		or die "failed to open hunk edit file for reading: " . $!;
+		or die sprintf __("failed to open hunk edit file for reading: %s"), $!;
 	my @newtext = grep { !/^#/ } <$fh>;
 	close $fh;
 	unlink $hunkfile;
@@ -1225,7 +1225,7 @@ sub apply_patch_for_checkout_commit {
 
 sub patch_update_cmd {
 	my @all_mods = list_modified($patch_mode_flavour{FILTER});
-	error_msg "ignoring unmerged: $_->{VALUE}\n"
+	error_msg sprintf __("ignoring unmerged: %s\n"), $_->{VALUE}
 		for grep { $_->{UNMERGED} } @all_mods;
 	@all_mods = grep { !$_->{UNMERGED} } @all_mods;
 
@@ -1407,11 +1407,13 @@ sub patch_update_file {
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-					error_msg "Invalid number: '$response'\n";
+					error_msg sprintf __("Invalid number: '%s'\n"),
+						      $response;
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					error_msg "Sorry, only $num hunks available.\n";
+					error_msg sprintf __("Sorry, only %s hunks available.\n"),
+						      $num;
 				}
 				next;
 			}
@@ -1449,7 +1451,7 @@ sub patch_update_file {
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
 					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					error_msg "Malformed search regexp $exp: $err\n";
+					error_msg sprintf __("Malformed search regexp %s: %s\n"), $exp, $err;
 					next;
 				}
 				my $iy = $ix;
@@ -1612,18 +1614,18 @@ sub process_args {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
 			} else {
-				die "unknown --patch mode: $1";
+				die sprintf __("unknown --patch mode: %s"), $1;
 			}
 		} else {
 			$patch_mode = 'stage';
 			$arg = shift @ARGV or die __("missing --");
 		}
-		die "invalid argument $arg, expecting --"
-		    unless $arg eq "--";
+		die sprintf __("invalid argument %s, expecting --"),
+			       $arg unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
 	}
 	elsif ($arg ne "--") {
-		die "invalid argument $arg, expecting --";
+		die sprintf __("invalid argument %s, expecting --"), $arg;
 	}
 }
 
-- 
2.6.6

