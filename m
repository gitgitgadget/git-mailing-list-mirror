From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] add--interactive: refactor patch mode argument processing
Date: Wed, 27 Jul 2011 02:05:07 -0600
Message-ID: <20110727080506.GA14002@sigill.intra.peff.net>
References: <20110727080303.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz7I-0005Fn-Sk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab1G0IFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:05:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab1G0IFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:05:10 -0400
Received: (qmail 28369 invoked by uid 107); 27 Jul 2011 08:05:40 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:05:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:05:07 -0600
Content-Disposition: inline
In-Reply-To: <20110727080303.GA8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177939>

The existing parser was very inflexible and tree-like;
seeing "--patch=$mode" would put us into a conditional for
parsing the options for that particular $mode. That made it
very difficult to add additional options that would work for
all patch modes.

This cleanup turns the argument processing into a proper
loop ready to handle multiple arguments. To replace the
mode-specific parsing, we restructure the mode definitions
to better reflect the various cases (i.e., no revision given
versus "HEAD" versus an arbitrary revision).

As a bonus, our parsing is now a little more robust. For
example, we catch the bogus "add--interactive --patch HEAD
--", which is meaningless, but was silently accepted before.
In practice this probably doesn't matter, since we are
always called by other parts of git, but it might catch a
bug in another part of git.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |  212 ++++++++++++++++++++++++---------------------
 1 files changed, 112 insertions(+), 100 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..c5cd300 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -93,74 +93,86 @@ sub apply_patch_for_stash;
 
 my %patch_modes = (
 	'stage' => {
-		DIFF => 'diff-files -p',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
-		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stage',
-		TARGET => '',
-		PARTICIPLE => 'staging',
-		FILTER => 'file-only',
-		IS_REVERSE => 0,
+		default => 'index',
+		index => {
+			DIFF => 'diff-files -p',
+			APPLY => sub { apply_patch 'apply --cached', @_; },
+			APPLY_CHECK => 'apply --cached',
+			VERB => 'Stage',
+			TARGET => '',
+			PARTICIPLE => 'staging',
+			FILTER => 'file-only',
+			IS_REVERSE => 0,
+		},
 	},
 	'stash' => {
-		DIFF => 'diff-index -p HEAD',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
-		APPLY_CHECK => 'apply --cached',
-		VERB => 'Stash',
-		TARGET => '',
-		PARTICIPLE => 'stashing',
-		FILTER => undef,
-		IS_REVERSE => 0,
+		default => 'head',
+		head => {
+			DIFF => 'diff-index -p',
+			APPLY => sub { apply_patch 'apply --cached', @_; },
+			APPLY_CHECK => 'apply --cached',
+			VERB => 'Stash',
+			TARGET => '',
+			PARTICIPLE => 'stashing',
+			FILTER => undef,
+			IS_REVERSE => 0,
+		},
 	},
-	'reset_head' => {
-		DIFF => 'diff-index -p --cached',
-		APPLY => sub { apply_patch 'apply -R --cached', @_; },
-		APPLY_CHECK => 'apply -R --cached',
-		VERB => 'Unstage',
-		TARGET => '',
-		PARTICIPLE => 'unstaging',
-		FILTER => 'index-only',
-		IS_REVERSE => 1,
+	'reset' => {
+		default => 'head',
+		head => {
+			DIFF => 'diff-index -p --cached',
+			APPLY => sub { apply_patch 'apply -R --cached', @_; },
+			APPLY_CHECK => 'apply -R --cached',
+			VERB => 'Unstage',
+			TARGET => '',
+			PARTICIPLE => 'unstaging',
+			FILTER => 'index-only',
+			IS_REVERSE => 1,
+		},
+		nothead => {
+			DIFF => 'diff-index -R -p --cached',
+			APPLY => sub { apply_patch 'apply --cached', @_; },
+			APPLY_CHECK => 'apply --cached',
+			VERB => 'Apply',
+			TARGET => ' to index',
+			PARTICIPLE => 'applying',
+			FILTER => 'index-only',
+			IS_REVERSE => 0,
+		},
 	},
-	'reset_nothead' => {
-		DIFF => 'diff-index -R -p --cached',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
-		APPLY_CHECK => 'apply --cached',
-		VERB => 'Apply',
-		TARGET => ' to index',
-		PARTICIPLE => 'applying',
-		FILTER => 'index-only',
-		IS_REVERSE => 0,
-	},
-	'checkout_index' => {
-		DIFF => 'diff-files -p',
-		APPLY => sub { apply_patch 'apply -R', @_; },
-		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from worktree',
-		PARTICIPLE => 'discarding',
-		FILTER => 'file-only',
-		IS_REVERSE => 1,
-	},
-	'checkout_head' => {
-		DIFF => 'diff-index -p',
-		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
-		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from index and worktree',
-		PARTICIPLE => 'discarding',
-		FILTER => undef,
-		IS_REVERSE => 1,
-	},
-	'checkout_nothead' => {
-		DIFF => 'diff-index -R -p',
-		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
-		APPLY_CHECK => 'apply',
-		VERB => 'Apply',
-		TARGET => ' to index and worktree',
-		PARTICIPLE => 'applying',
-		FILTER => undef,
-		IS_REVERSE => 0,
+	'checkout' => {
+		default => 'index',
+		index => {
+			DIFF => 'diff-files -p',
+			APPLY => sub { apply_patch 'apply -R', @_; },
+			APPLY_CHECK => 'apply -R',
+			VERB => 'Discard',
+			TARGET => ' from worktree',
+			PARTICIPLE => 'discarding',
+			FILTER => 'file-only',
+			IS_REVERSE => 1,
+		},
+		head => {
+			DIFF => 'diff-index -p',
+			APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
+			APPLY_CHECK => 'apply -R',
+			VERB => 'Discard',
+			TARGET => ' from index and worktree',
+			PARTICIPLE => 'discarding',
+			FILTER => undef,
+			IS_REVERSE => 1,
+		},
+		nothead => {
+			DIFF => 'diff-index -R -p',
+			APPLY => sub { apply_patch_for_checkout_commit '', @_ },
+			APPLY_CHECK => 'apply',
+			VERB => 'Apply',
+			TARGET => ' to index and worktree',
+			PARTICIPLE => 'applying',
+			FILTER => undef,
+			IS_REVERSE => 0,
+		},
 	},
 );
 
@@ -1546,45 +1558,45 @@ EOF
 
 sub process_args {
 	return unless @ARGV;
-	my $arg = shift @ARGV;
-	if ($arg =~ /--patch(?:=(.*))?/) {
-		if (defined $1) {
-			if ($1 eq 'reset') {
-				$patch_mode = 'reset_head';
+
+	while (@ARGV) {
+		if ($ARGV[0] =~ /--patch(?:=(.*))?/) {
+			$patch_mode = defined $1 ? $1 : 'stage';
+		}
+		else {
+			last;
+		}
+		shift @ARGV;
+	}
+
+	if (@ARGV && $ARGV[0] ne '--') {
+		$patch_mode_revision = shift @ARGV;
+	}
+	@ARGV or die "missing --";
+	shift @ARGV;
+
+	if (defined $patch_mode) {
+		my $mode = $patch_modes{$patch_mode}
+			or die "unknown --patch mode: $patch_mode";
+
+		my $submode;
+		if (!defined $patch_mode_revision) {
+			$submode = $mode->{default};
+			if ($submode eq 'head') {
 				$patch_mode_revision = 'HEAD';
-				$arg = shift @ARGV or die "missing --";
-				if ($arg ne '--') {
-					$patch_mode_revision = $arg;
-					$patch_mode = ($arg eq 'HEAD' ?
-						       'reset_head' : 'reset_nothead');
-					$arg = shift @ARGV or die "missing --";
-				}
-			} elsif ($1 eq 'checkout') {
-				$arg = shift @ARGV or die "missing --";
-				if ($arg eq '--') {
-					$patch_mode = 'checkout_index';
-				} else {
-					$patch_mode_revision = $arg;
-					$patch_mode = ($arg eq 'HEAD' ?
-						       'checkout_head' : 'checkout_nothead');
-					$arg = shift @ARGV or die "missing --";
-				}
-			} elsif ($1 eq 'stage' or $1 eq 'stash') {
-				$patch_mode = $1;
-				$arg = shift @ARGV or die "missing --";
-			} else {
-				die "unknown --patch mode: $1";
 			}
-		} else {
-			$patch_mode = 'stage';
-			$arg = shift @ARGV or die "missing --";
 		}
-		die "invalid argument $arg, expecting --"
-		    unless $arg eq "--";
-		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
-	}
-	elsif ($arg ne "--") {
-		die "invalid argument $arg, expecting --";
+		elsif ($patch_mode_revision eq 'HEAD') {
+			$submode = 'head';
+		}
+		else {
+			$submode = 'nothead';
+		}
+
+		if (!exists $mode->{$submode}) {
+			die "mode '$patch_mode' cannot handle '$submode'";
+		}
+		%patch_mode_flavour = %{$mode->{$submode}};
 	}
 }
 
-- 
1.7.5.4.31.ge4d5e
