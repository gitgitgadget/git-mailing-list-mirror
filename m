From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] add--interactive.perl: factor out repeated --recount
 option
Date: Fri, 29 Apr 2011 15:49:32 -0700
Message-ID: <1304117373-592-3-git-send-email-gitster@pobox.com>
References: <1304117373-592-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwVa-00084m-0C
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533Ab1D2Wtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:49:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab1D2Wtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:49:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 646535552
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FpKX
	gr06DhC1eotvR6lEWd+FDkk=; b=OY40RU9UMzg7XQenV1wKHJ4z/e2gt0H1RJQT
	EEssXwogpreOI+E+F6H6EACkZtN737yiA0z6mC5+y8TicXQ2ltIjjfYZqDq11bSp
	Xp3bdyFqHqgp4hqSC81j9rjsUNTk0zTmwkg3znr7YILe4PaibURU1sFXqUVsiMzg
	TgHyavk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BxRNdE
	7FTjEVXsaxveq6WsLrx12JmCHSnvWBkgjGVdxSD2SgQzY8jPS/YpTcgl5I5DF9Dr
	S8nQzI8ta+C2t+ri3rRdpTTUfvDetGinB2yTz6cKO8KK41o4MMs+F9hI3DdxfmJp
	bbFm8L9fFM7jFp10Nxx120xSkGGcGMqCDVPFw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 610395551
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2BFA5550 for
 <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.252.g565191
In-Reply-To: <1304117373-592-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 44F49308-72B3-11E0-AA61-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172508>

Depending on the direction and the target of patch application, we would
need to pass --cached and --reverse to underlying "git apply".  Also we
only pass --check when we are not applying but just checking.

But we always pass --recount since 8cbd431 (git-add--interactive: replace
hunk recounting with apply --recount, 2008-07-02).  Instead of repeating
the same --recount over and over again, move it to a single place that
actually runs the command, namely, "run_git_apply" subroutine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4fb8cd0..fced0ce 100755
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
1.7.5.252.g565191
