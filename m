From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 23/31] rebase: factor out sub command handling
Date: Sun,  6 Feb 2011 13:43:52 -0500
Message-ID: <1297017841-20678-24-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eE-0005ZO-KL
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1BFSqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:30 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1BFSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:28 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=D32d20YIKETfQe7BaPEckPBp9FBblw64GCCNNHLvpdg=;
        b=o6KQ6u1z7PHfa8Rc2PmxAvDs1jbXKJxU6oNhTJFULxEz0s6SGLT6rjnleYOGCclP8v
         CVglVLBh4roqUZHP4HuNv23tTUiLWpqd0KIljFbtJFBqg32Hbrm6DK1vW5XeZaBTNLtp
         cthP4+vpILuKQPJUDUmK33+7/dkCrMCQcLxgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o87OoHiWe26vipn4/ak0H3ZyEXkFM3OZXDHlrdnVj+FYvqK9taZ87ZC59WwOzXiJwV
         w2TcILxnzoTHrpNX494y8v6vGSWqmYHE0g6MMJrAbgzquxNdVNHelSbCBdFq0ovw1vhE
         ws5fccJkS7Er40DxtDUyUCy97fFRr5OA1KPLQ=
Received: by 10.224.2.133 with SMTP id 5mr13443620qaj.68.1297017987661;
        Sun, 06 Feb 2011 10:46:27 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:26 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166183>

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
index affa467..4af0bc6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -509,9 +509,7 @@ do_next () {
 	test -s "$todo" && return
 
 	comment_for_reflog finish &&
-	head_name=$(cat "$state_dir"/head-name) &&
-	orig_head=$(cat "$state_dir"/head) &&
-	shortonto=$(git rev-parse --short $(cat "$state_dir"/onto)) &&
+	shortonto=$(git rev-parse --short $onto) &&
 	newhead=$(git rev-parse HEAD) &&
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
 		test -s "$rewritten_list" &&
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
index 42d635b..21bb027 100755
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
 
@@ -262,11 +267,19 @@ test $# -gt 2 && usage
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
1.7.4.rc2.33.g8a14f
