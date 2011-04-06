From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add--interactive.perl: factor out repeated --recount option
Date: Wed, 06 Apr 2011 14:31:53 -0700
Message-ID: <7vy63ngj7a.fsf_-_@alter.siamese.dyndns.org>
References: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
 <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com>
 <7voc4ji23p.fsf@alter.siamese.dyndns.org>
 <7v4o6bi1lm.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 23:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aKn-0000xd-Jw
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab1DFVcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:32:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab1DFVcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EC6B53EE;
	Wed,  6 Apr 2011 17:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvDwGlVqpac7Dw16JXP1Ob2/6EQ=; b=TzWIRc
	dLqmWrOCtzOSmG2GuxqDOSNcpCK9Pak8FhgLUL/CrIdb952DDYxHiyAYyIBPPRL7
	BjApcHnMAZ1zmfgfSJvDf4zZvmOMDcG9pK4rWvnx2xpHUsUX2ACjYR49mA2O+ZMl
	znBkjZ9AdR1izaI1Y1Ur1BY26AlBcNLoNvi1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hx0k6aUy2Mzmp8vIK95zHua4S/LOmuT5
	iRF/9Hl3v2CcMu2yZ/+j0/+wYpW0nKRI7CUzTCq6cAUl792zhumsadf2zyWga3M/
	52JE+biZejy/6lS5f5AKwAGzeHbcb+yOCjXOVuz693CYFjlTCwqGhzyMIpDzXD37
	pm/w40Qy62I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C77B53ED;
	Wed,  6 Apr 2011 17:33:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3938953EC; Wed,  6 Apr 2011
 17:33:49 -0400 (EDT)
In-Reply-To: <7v4o6bi1lm.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Apr 2011 13:09:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91C0F7C4-6095-11E0-AF62-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171017>

Depending on the direction and the target of patch application, we would
need to pass --cached and --reverse to underlying "git apply".  Also we
only pass --check when we are not applying but just checking.

But we always pass --recount since 8cbd431 (git-add--interactive: replace
hunk recounting with apply --recount, 2008-07-02).  Instead of repeating
the same --recount over and over again, move it to a single place that
actually runs the command, namely, "run_git_apply" subroutine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies on top of 9d15860.  I tried to be careful but may have missed
   some calls.  Extra set of eyeballs appreciated.

 git-add--interactive.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a329c5a..6a439db 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -705,7 +705,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd;
+	open $fh, '| git ' . $cmd . " --recount";
 	print $fh @_;
 	return close $fh;
 }
@@ -1050,7 +1050,7 @@ sub edit_hunk_manually {
 
 sub diff_applies {
 	my $fh;
-	return run_git_apply($patch_mode_flavour{APPLY_CHECK} . ' --recount --check',
+	return run_git_apply($patch_mode_flavour{APPLY_CHECK} . ' --check',
 			     map { @{$_->{TEXT}} } @_);
 }
 
@@ -1139,7 +1139,7 @@ sub help_patch_cmd {
 
 sub apply_patch {
 	my $cmd = shift;
-	my $ret = run_git_apply $cmd . ' --recount', @_;
+	my $ret = run_git_apply $cmd, @_;
 	if (!$ret) {
 		print STDERR @_;
 	}
@@ -1148,17 +1148,17 @@ sub apply_patch {
 
 sub apply_patch_for_checkout_commit {
 	my $reverse = shift;
-	my $applies_index = run_git_apply 'apply '.$reverse.' --cached --recount --check', @_;
-	my $applies_worktree = run_git_apply 'apply '.$reverse.' --recount --check', @_;
+	my $applies_index = run_git_apply 'apply '.$reverse.' --cached --check', @_;
+	my $applies_worktree = run_git_apply 'apply '.$reverse.' --check', @_;
 
 	if ($applies_worktree && $applies_index) {
-		run_git_apply 'apply '.$reverse.' --cached --recount', @_;
-		run_git_apply 'apply '.$reverse.' --recount', @_;
+		run_git_apply 'apply '.$reverse.' --cached', @_;
+		run_git_apply 'apply '.$reverse, @_;
 		return 1;
 	} elsif (!$applies_index) {
 		print colored $error_color, "The selected hunks do not apply to the index!\n";
 		if (prompt_yesno "Apply them to the worktree anyway? ") {
-			return run_git_apply 'apply '.$reverse.' --recount', @_;
+			return run_git_apply 'apply '.$reverse, @_;
 		} else {
 			print colored $error_color, "Nothing was applied.\n";
 			return 0;
-- 
1.7.5.rc1
