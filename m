From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 23/31] rebase: factor out sub command handling
Date: Tue, 28 Dec 2010 10:30:40 +0100
Message-ID: <1293528648-21873-24-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYn-0005Wr-62
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab0L1PdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab0L1PdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:03 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GO8ZAo4EhTYVW3wrLhliIXzlfgBF4clJJU9k5pfCeMs=;
        b=eQ+LDW0oaWAKbIWNhmlWl320T6aAZR4YMssAFbRZ9W+CrIfJYozLprLDN3XFCK6gMj
         Jsiu1ybCBWJVWVorROEmzZB48Ax7FGmNo7yEIrz8skKdnKOFmyEAxP+fXQjaBTu0Hdm5
         Cv6u+Z40lZANHJmevKo+K87XoStvkFLzNPyW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bRDkx6iADEtRfdXryxtwf6BHDky0PoGa/6oxKlai6qtvWcsafeFYmMXap8zi03DkZf
         hmc1ItbCGlDfnWfcKAHrHc/gRP49S2ZAldkkmKAqkHGeJqfQJIciuqktjfoWJIK064qi
         83dCAA4rqz3AX1fckv/FYoHOxSUD5eZu/T1Zg=
Received: by 10.224.37.20 with SMTP id v20mr12891901qad.216.1293550383373;
        Tue, 28 Dec 2010 07:33:03 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164255>

Factor out the common parts of the handling of the sub commands
'--continue', '--skip' and '--abort'. The '--abort' handling can
handled completely in git-rebase.sh.

After this refactoring, the calls to git-rebase--am.sh,
git-rebase--merge.sh and git-rebase--interactive.sh will be better
aligned. There will only be one call to interactive rebase that will
shortcut the very last part of git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   34 +++-------------------------------
 git-rebase.sh              |   17 +++++++++++++++--
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acd0258..1079994 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -509,9 +509,7 @@ do_next () {
 	test -s "$TODO" && return
 
 	comment_for_reflog finish &&
-	head_name=$(cat "$state_dir"/head-name) &&
-	orig_head=$(cat "$state_dir"/head) &&
-	SHORTONTO=$(git rev-parse --short $(cat "$state_dir"/onto)) &&
+	SHORTONTO=$(git rev-parse --short $onto) &&
 	NEWHEAD=$(git rev-parse HEAD) &&
 	case $head_name in
 	refs/*)
@@ -521,7 +519,7 @@ do_next () {
 		;;
 	esac && {
 		test ! -f "$state_dir"/verbose ||
-			git diff-tree --stat $(cat "$state_dir"/head)..HEAD
+			git diff-tree --stat $orig_head..HEAD
 	} &&
 	{
 		test -s "$REWRITTEN_LIST" &&
@@ -655,14 +653,6 @@ rearrange_squash () {
 case "$action" in
 continue)
 	get_saved_options
-	comment_for_reflog continue
-
-	# Sanity check
-	git rev-parse --verify HEAD >/dev/null ||
-		die "Cannot read HEAD"
-	git update-index --ignore-submodules --refresh &&
-		git diff-files --quiet --ignore-submodules ||
-		die "Working tree is dirty"
 
 	# do we have anything to commit?
 	if git diff-index --cached --quiet --ignore-submodules HEAD --
@@ -693,30 +683,12 @@ first and then run 'git rebase --continue' again."
 	require_clean_work_tree "rebase"
 	do_rest
 	;;
-abort)
-	get_saved_options
-	comment_for_reflog abort
-
-	git rerere clear
-
-	head_name=$(cat "$state_dir"/head-name)
-	orig_head=$(cat "$state_dir"/head)
-	case $head_name in
-	refs/*)
-		git symbolic-ref HEAD $head_name
-		;;
-	esac &&
-	output git reset --hard $orig_head &&
-	rm -rf "$state_dir"
-	exit
-	;;
 skip)
 	get_saved_options
-	comment_for_reflog skip
 
 	git rerere clear
 
-	output git reset --hard && do_rest
+	do_rest
 	;;
 esac
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 0322f27..7e2e978 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -70,7 +70,12 @@ test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
-	orig_head=$(cat "$state_dir"/orig-head) &&
+	if test "$type" = interactive
+	then
+		orig_head=$(cat "$state_dir"/head)
+	else
+		orig_head=$(cat "$state_dir"/orig-head)
+	fi &&
 	GIT_QUIET=$(cat "$state_dir"/quiet)
 }
 
@@ -267,11 +272,19 @@ test $# -gt 2 && usage
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
-	test "$type" = interactive && run_specific_rebase
+	# Only interactive rebase uses detailed reflog messages
+	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
+	then
+		GIT_REFLOG_ACTION="rebase -i ($action)"
+		export GIT_REFLOG_ACTION
+	fi
 fi
 
 case "$action" in
 continue)
+	# Sanity check
+	git rev-parse --verify HEAD >/dev/null ||
+		die "Cannot read HEAD"
 	git update-index --ignore-submodules --refresh &&
 	git diff-files --quiet --ignore-submodules || {
 		echo "You must edit all merge conflicts and then"
-- 
1.7.3.2.864.gbbb96
