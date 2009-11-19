From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] {checkout,reset} -p: make patch direction configurable
Date: Thu, 19 Nov 2009 23:03:57 +0100
Message-ID: <527e9296b638eb4c9993b3fb0d1c6f51b64f4c2c.1258667920.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBF7n-0007Fn-GP
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbZKSWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbZKSWE6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:04:58 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:12864 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194AbZKSWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:04:58 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 19 Nov
 2009 23:05:02 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 19 Nov
 2009 23:04:41 +0100
X-Mailer: git-send-email 1.6.5.3.439.g7a64a6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133260>

When we implemented the -p mode for checkout, reset and stash, some
discussion revolved around the involved patch direction.

Make this configurable for reset and checkout with the following
choices:

             index/HEAD       other
  forward    undo addition    undo addition
  mixed      undo addition    apply removal
  reverse    apply removal    apply removal

Where for added lines, 'undo addition' means that you will see a '+'
patch and can reverse-apply it; 'apply removal' means you will see a
'-' patch and can forward-apply it.

The default is 'mixed', to keep the behaviour consistent with that
from before the patch.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This patch is much easier to read with --color-words.

ISTR that Peff wanted this, and maybe some others.  I'm not too
interested because I'm still convinced 'mixed' is the Right Option,
but it was somewhere deep on my todo stack and maybe you like it ;-)

We could do the same for stash, but I don't really see the use there;
it does not have any of the direction-switching issues because it does
not support a rev argument.

 Documentation/config.txt  |   12 +++++
 git-add--interactive.perl |  100 +++++++++++++++++++++++++++++++-------------
 2 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb73d75..f5f9b80 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1146,6 +1146,18 @@ interactive.singlekey::
 	linkgit:git-add[1].  Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
+interactive.reset.direction::
+interactive.checkout.direction::
+	Direction of diffs used in `git reset -p` and `git checkout
+	-p`.  Must be one of 'forward', 'mixed' (default), or
+	'reverse'.
++
+With 'forward', diffs are taken forward and applied in reverse, i.e.,
+if you added a block of code you see an addition patch and are asked
+if you want to remove it.  'reverse' instead shows a removal patch
+and asks if you to apply it.  'mixed' is the same as 'forward' when
+comparing to HEAD or the index, and 'reverse' otherwise.
+
 log.date::
 	Set default date-time mode for the log command. Setting log.date
 	value is similar to using 'git-log'\'s --date option. The value is one of the
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8ce1ec9..051e47e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -74,6 +74,25 @@
 my $patch_mode;
 my $patch_mode_revision;
 
+sub get_patch_direction_config {
+	my ($key, $default, $forward, $reverse) = @_;
+	my $value = $repo->config($key, $default) || $default;
+	if ($value =~ /^forward$/i) {
+		return (0, 0);
+	} elsif ($value =~ /^mixed$/i) {
+		return (0, 1);
+	} elsif ($value =~ /^reverse?/i) {
+		return (1, 1);
+	} else {
+		die "$key must be one of 'forward', 'mixed' or 'reverse'";
+	}
+}
+
+my ($reset_reverse_head, $reset_reverse_nothead)
+	= get_patch_direction_config("interactive.reset.direction", "mixed");
+my ($checkout_reverse_head, $checkout_reverse_nothead)
+	= get_patch_direction_config("interactive.checkout.direction", "mixed");
+
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
 sub apply_patch_for_stash;
@@ -98,48 +117,69 @@
 		FILTER => undef,
 	},
 	'reset_head' => {
-		DIFF => 'diff-index -p --cached',
-		APPLY => sub { apply_patch 'apply -R --cached', @_; },
-		APPLY_CHECK => 'apply -R --cached',
-		VERB => 'Unstage',
-		TARGET => '',
-		PARTICIPLE => 'unstaging',
+		DIFF => 'diff-index -p --cached '
+			. ($reset_reverse_head ? '-R' : ''),
+		APPLY => sub {
+			apply_patch 'apply --cached '
+				. ($reset_reverse_head ? '' : '-R'), @_;
+		},
+		APPLY_CHECK => 'apply --cached '
+			. ($reset_reverse_head ? '' : '-R'),
+		VERB => $reset_reverse_head ? 'Apply' : 'Unstage',
+		TARGET => $reset_reverse_head ? ' to index' : '',
+		PARTICIPLE => $reset_reverse_head ? 'applying' : 'unstaging',
 		FILTER => 'index-only',
 	},
 	'reset_nothead' => {
-		DIFF => 'diff-index -R -p --cached',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
-		APPLY_CHECK => 'apply --cached',
-		VERB => 'Apply',
-		TARGET => ' to index',
-		PARTICIPLE => 'applying',
+		DIFF => 'diff-index -p --cached '
+			. ($reset_reverse_nothead ? '-R' : ''),
+		APPLY => sub {
+			apply_patch 'apply --cached '
+				. ($reset_reverse_nothead ? '' : '-R'), @_;
+		},
+		APPLY_CHECK => 'apply --cached '
+			. ($reset_reverse_nothead ? '' : '-R'),
+		VERB => $reset_reverse_nothead ? 'Apply' : 'Unstage',
+		TARGET => $reset_reverse_nothead ? ' to index' : '',
+		PARTICIPLE => $reset_reverse_nothead ? 'applying' : 'unstaging',
 		FILTER => 'index-only',
 	},
 	'checkout_index' => {
-		DIFF => 'diff-files -p',
-		APPLY => sub { apply_patch 'apply -R', @_; },
-		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from worktree',
-		PARTICIPLE => 'discarding',
+		DIFF => 'diff-files -p ' . ($checkout_reverse_head ? '-R' : ''),
+		APPLY => sub {
+			apply_patch 'apply '
+				. ($checkout_reverse_head ? '' : '-R'), @_;
+		},
+		APPLY_CHECK => 'apply ' . ($checkout_reverse_head ? '' : '-R'),
+		VERB => $checkout_reverse_head ? 'Apply' : 'Discard',
+		TARGET => $checkout_reverse_head ? ' to worktree' : ' from worktree',
+		PARTICIPLE => $checkout_reverse_head ? 'applying' : 'discarding',
 		FILTER => 'file-only',
 	},
 	'checkout_head' => {
-		DIFF => 'diff-index -p',
-		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
-		APPLY_CHECK => 'apply -R',
-		VERB => 'Discard',
-		TARGET => ' from index and worktree',
-		PARTICIPLE => 'discarding',
+		DIFF => 'diff-index -p ' . ($checkout_reverse_head ? '-R' : ''),
+		APPLY => sub {
+			apply_patch_for_checkout_commit
+				$checkout_reverse_head ? '' : '-R', @_;
+		},
+		APPLY_CHECK => 'apply ' . ($checkout_reverse_head ? '' : '-R'),
+		VERB => $checkout_reverse_head ? 'Apply' : 'Discard',
+		TARGET => ($checkout_reverse_head ? ' to index and worktree'
+			   : ' from index and worktree'),
+		PARTICIPLE => $checkout_reverse_head ? 'applying' : 'discarding',
 		FILTER => undef,
 	},
 	'checkout_nothead' => {
-		DIFF => 'diff-index -R -p',
-		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
-		APPLY_CHECK => 'apply',
-		VERB => 'Apply',
-		TARGET => ' to index and worktree',
-		PARTICIPLE => 'applying',
+		DIFF => 'diff-index -p ' . ($checkout_reverse_nothead ? '-R' : ''),
+		APPLY => sub {
+			apply_patch_for_checkout_commit
+				$checkout_reverse_nothead ? '' : '-R', @_;
+		},
+		APPLY_CHECK => 'apply ' . ($checkout_reverse_nothead ? '' : '-R'),
+		VERB => $checkout_reverse_nothead ? 'Apply' : 'Discard',
+		TARGET => ($checkout_reverse_nothead ? ' to index and worktree'
+			   : ' from index and worktree'),
+		PARTICIPLE => $checkout_reverse_nothead ? 'applying' : 'discarding',
 		FILTER => undef,
 	},
 );
-- 
1.6.5.3.439.g7a64a6.dirty
