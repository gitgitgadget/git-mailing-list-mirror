Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02711F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933926AbcHaMcz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:32:55 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:51869 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMcz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:32:55 -0400
Received: (qmail 3001 invoked from network); 31 Aug 2016 12:32:53 -0000
Received: (qmail 5324 invoked from network); 31 Aug 2016 12:32:53 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:32:48 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 03/11] i18n: add--interactive: mark strings with interpolation for translation
Date:   Wed, 31 Aug 2016 12:31:22 +0000
Message-Id: <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use of sprintf following die or error_msg is necessary for placeholder
substitution take place.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e11a33d..4e1e857 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -612,12 +612,12 @@ sub list_and_choose {
 			else {
 				$bottom = $top = find_unique($choice, @stuff);
 				if (!defined $bottom) {
-					error_msg "Huh ($choice)?\n";
+					error_msg sprintf(__("Huh (%s)?\n"), $choice);
 					next TOPLOOP;
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				error_msg "Huh ($choice)?\n";
+				error_msg sprintf(__("Huh (%s)?\n"), $choice);
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -1048,7 +1048,7 @@ sub edit_hunk_manually {
 	my $hunkfile = $repo->repo_path . "/addp-hunk-edit.diff";
 	my $fh;
 	open $fh, '>', $hunkfile
-		or die "failed to open hunk edit file for writing: " . $!;
+		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
 	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
 	print $fh @$oldtext;
 	my $participle = $patch_mode_flavour{PARTICIPLE};
@@ -1075,7 +1075,7 @@ EOF
 	}
 
 	open $fh, '<', $hunkfile
-		or die "failed to open hunk edit file for reading: " . $!;
+		or die sprintf(__("failed to open hunk edit file for reading: %s"), $!);
 	my @newtext = grep { !/^#/ } <$fh>;
 	close $fh;
 	unlink $hunkfile;
@@ -1225,7 +1225,7 @@ sub apply_patch_for_checkout_commit {
 
 sub patch_update_cmd {
 	my @all_mods = list_modified($patch_mode_flavour{FILTER});
-	error_msg "ignoring unmerged: $_->{VALUE}\n"
+	error_msg sprintf(__("ignoring unmerged: %s\n"), $_->{VALUE})
 		for grep { $_->{UNMERGED} } @all_mods;
 	@all_mods = grep { !$_->{UNMERGED} } @all_mods;
 
@@ -1407,11 +1407,13 @@ sub patch_update_file {
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-					error_msg "Invalid number: '$response'\n";
+					error_msg sprintf(__("Invalid number: '%s'\n"),
+							     $response);
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					error_msg "Sorry, only $num hunks available.\n";
+					error_msg sprintf(__("Sorry, only %s hunks available.\n"),
+							     $num);
 				}
 				next;
 			}
@@ -1449,7 +1451,7 @@ sub patch_update_file {
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
 					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					error_msg "Malformed search regexp $exp: $err\n";
+					error_msg sprintf(__("Malformed search regexp %s: %s\n"), $exp, $err);
 					next;
 				}
 				my $iy = $ix;
@@ -1612,18 +1614,18 @@ sub process_args {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
 			} else {
-				die "unknown --patch mode: $1";
+				die sprintf(__("unknown --patch mode: %s"), $1);
 			}
 		} else {
 			$patch_mode = 'stage';
 			$arg = shift @ARGV or die __("missing --");
 		}
-		die "invalid argument $arg, expecting --"
-		    unless $arg eq "--";
+		die sprintf(__("invalid argument %s, expecting --"),
+			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
 	}
 	elsif ($arg ne "--") {
-		die "invalid argument $arg, expecting --";
+		die sprintf(__("invalid argument %s, expecting --"), $arg);
 	}
 }
 
-- 
2.7.4

