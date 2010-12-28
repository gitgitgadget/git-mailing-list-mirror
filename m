From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 24/31] rebase: extract code for writing basic state
Date: Tue, 28 Dec 2010 10:30:41 +0100
Message-ID: <1293528648-21873-25-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYt-0005Wr-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab0L1Pdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:40 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0L1PdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:05 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n5ta/TRNgpDZIxkUBfoREAO6pxhk58bkHvVGqIEEP/g=;
        b=l8isqSd//Xauat0n7ZMqBtCAOE0LKryRnWUAtUHNkEFnHxOQpHv++/a4ngC2vNSA6b
         3RnFVOY+31IBZfincq5hgM3Q2S9DXw6G4ri+mdEqxpwZ/YVbD5RE0Do7+0mo8wxewtXG
         W5455MDshXfaWtctXkQDDKLq6/AWi7fDbugv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rNwmdj8hM+iRHbhsELSrIZH7EJRNxFQ4rhj2cJidFAHZAs/cIsTTRFQ/mExbTKeveO
         BrjMDETKG1FGDEqnCtixuN0VZEVfsrRAXdCu4fDT5BUvRV9/RP/eQ2wbz25QKS4TgoRg
         ArXpxLmESj6XBevr5+xD1L+HrLCMFoS9Ph35U=
Received: by 10.224.3.21 with SMTP id 21mr12834698qal.366.1293550384886;
        Tue, 28 Dec 2010 07:33:04 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164263>

Extrace the code for writing the state to rebase-apply/ or
rebase-merge/ when a rebase is initiated. This will make it easier to
later make both interactive and non-interactive rebase remember the
options used.

Note that non-interactive rebase stores the sha1 of the original head
in a file called orig-head, while interactive rebase stores it in a
file called head.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--am.sh          |    6 +-----
 git-rebase--interactive.sh |    5 +----
 git-rebase--merge.sh       |    5 +----
 git-rebase.sh              |   16 ++++++++++++++--
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 9316761..5acfa00 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -26,9 +26,5 @@ git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 move_to_original_branch
 ret=$?
-test 0 != $ret -a -d "$state_dir" &&
-	echo $head_name > "$state_dir/head-name" &&
-	echo $onto > "$state_dir/onto" &&
-	echo $orig_head > "$state_dir/orig-head" &&
-	echo "$GIT_QUIET" > "$state_dir/quiet"
+test 0 != $ret -a -d "$state_dir" && write_basic_state
 exit $ret
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1079994..a33b246 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -707,16 +707,13 @@ orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
 mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
-echo "$head_name" > "$state_dir"/head-name
-
-echo $orig_head > "$state_dir"/head
+write_basic_state
 case "$rebase_root" in
 '')
 	rm -f "$state_dir"/rebase-root ;;
 *)
 	: >"$state_dir"/rebase-root ;;
 esac
-echo $onto > "$state_dir"/onto
 test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
 test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 8cfdcf1..705d2f5 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -127,10 +127,7 @@ esac
 
 mkdir -p "$state_dir"
 echo "$onto_name" > "$state_dir/onto_name"
-echo "$head_name" > "$state_dir/head-name"
-echo "$onto" > "$state_dir/onto"
-echo "$orig_head" > "$state_dir/orig-head"
-echo "$GIT_QUIET" > "$state_dir/quiet"
+write_basic_state
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
diff --git a/git-rebase.sh b/git-rebase.sh
index 7e2e978..95c0d05 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -79,6 +79,18 @@ read_basic_state () {
 	GIT_QUIET=$(cat "$state_dir"/quiet)
 }
 
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	if test "$type" = interactive
+	then
+		echo "$orig_head" > "$state_dir"/head
+	else
+		echo "$orig_head" > "$state_dir"/orig-head
+	fi &&
+	echo "$GIT_QUIET" > "$state_dir"/quiet
+}
+
 output () {
 	case "$verbose" in
 	'')
@@ -113,8 +125,8 @@ run_specific_rebase () {
 	export onto autosquash strategy strategy_opts verbose rebase_root \
 	force_rebase action preserve_merges upstream switch_to head_name \
 	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
-	allow_rerere_autoupdate git_am_opt
-	export -f move_to_original_branch output
+	allow_rerere_autoupdate git_am_opt type
+	export -f move_to_original_branch output write_basic_state
 	exec git-rebase--$type
 }
 
-- 
1.7.3.2.864.gbbb96
