From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 02/20] rebase: refactor reading of state
Date: Thu, 25 Nov 2010 20:57:45 +0100
Message-ID: <1290715083-16919-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna4-0001kp-Hw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab0KZB6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:10 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab0KZB6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:08 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=g7lBY4w7Wsa5HaQ2T30is5XPKvCXE3ILyC0B7DVvuHs=;
        b=Dr7wesu2GFPqOlM5d4MjoQZokWMopISlP7PzOibGJj4BJhyBD37fx/pB2zwhk7XbuU
         1HLdnmnxZ8SfLvL8Xy9N2aifRgYjDJDCGdN5Zog2q4qtnfN2dDm/tu3XJxGogyF93TI5
         5DdiulOf2Cu8uI/ZNirQeYrDExn95QPk1oNMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uGAbpfpg73tDAibclkuODR5fBJkRzyVw1vnNmCs0QUVSxolyDpWcB2RGwTOAHBZcAQ
         6UAt3fseNiVvg6ijVatJRKkhL1HuUmF6Z7bzoQ2JdraWI+lC8vR1Z2FPsyzdiUoyinWY
         dXZdSMRwp9XDTn4/bcQKzNi/mKenG/xWvlpzY=
Received: by 10.220.193.68 with SMTP id dt4mr381537vcb.198.1290736687273;
        Thu, 25 Nov 2010 17:58:07 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162161>

The code reading the state saved in $merge_dir or $rebase_dir is
currently spread out in many places, making it harder to read and to
introduce additional state. Extract this code into one method that reads
the state.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   53 +++++++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a529bab..a325dd9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -56,6 +56,22 @@ rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
 
+read_state () {
+	if test -d "$merge_dir"
+	then
+		state_dir="$merge_dir"
+		prev_head=$(cat "$merge_dir"/prev_head) &&
+		end=$(cat "$merge_dir"/end) &&
+		msgnum=$(cat "$merge_dir"/msgnum)
+	else
+		state_dir="$apply_dir"
+	fi &&
+	head_name=$(cat "$state_dir"/head-name) &&
+	onto=$(cat "$state_dir"/onto) &&
+	orig_head=$(cat "$state_dir"/orig-head) &&
+	GIT_QUIET=$(cat "$state_dir"/quiet)
+}
+
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$merge_dir" || die "$merge_dir directory does not exist"
@@ -137,10 +153,6 @@ call_merge () {
 }
 
 move_to_original_branch () {
-	test -z "$head_name" &&
-		head_name="$(cat "$merge_dir"/head-name)" &&
-		onto="$(cat "$merge_dir"/onto)" &&
-		orig_head="$(cat "$merge_dir"/orig-head)"
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -219,13 +231,9 @@ do
 			echo "mark them as resolved using git add"
 			exit 1
 		}
+		read_state
 		if test -d "$merge_dir"
 		then
-			prev_head=$(cat "$merge_dir/prev_head")
-			end=$(cat "$merge_dir/end")
-			msgnum=$(cat "$merge_dir/msgnum")
-			onto=$(cat "$merge_dir/onto")
-			GIT_QUIET=$(cat "$merge_dir/quiet")
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -235,10 +243,6 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$apply_dir"/head-name) &&
-		onto=$(cat "$apply_dir"/onto) &&
-		orig_head=$(cat "$apply_dir"/orig-head) &&
-		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -248,15 +252,11 @@ do
 			die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
+		read_state
 		if test -d "$merge_dir"
 		then
 			git rerere clear
-			prev_head=$(cat "$merge_dir/prev_head")
-			end=$(cat "$merge_dir/end")
-			msgnum=$(cat "$merge_dir/msgnum")
 			msgnum=$(($msgnum + 1))
-			onto=$(cat "$merge_dir/onto")
-			GIT_QUIET=$(cat "$merge_dir/quiet")
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
@@ -265,10 +265,6 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$apply_dir"/head-name) &&
-		onto=$(cat "$apply_dir"/onto) &&
-		orig_head=$(cat "$apply_dir"/orig-head) &&
-		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -278,18 +274,15 @@ do
 			die "No rebase in progress?"
 
 		git rerere clear
-
-		test -d "$merge_dir" || merge_dir="$apply_dir"
-
-		head_name="$(cat "$merge_dir"/head-name)" &&
+		read_state
 		case "$head_name" in
 		refs/*)
 			git symbolic-ref HEAD $head_name ||
 			die "Could not move back to $head_name"
 			;;
 		esac
-		git reset --hard $(cat "$merge_dir/orig-head")
-		rm -r "$merge_dir"
+		git reset --hard $orig_head
+		rm -r "$state_dir"
 		exit
 		;;
 	--onto)
@@ -572,12 +565,12 @@ fi
 # this is rename-aware if the recursive (default) strategy is used
 
 mkdir -p "$merge_dir"
-echo "$onto" > "$merge_dir/onto"
 echo "$onto_name" > "$merge_dir/onto_name"
 prev_head=$orig_head
 echo "$prev_head" > "$merge_dir/prev_head"
-echo "$orig_head" > "$merge_dir/orig-head"
 echo "$head_name" > "$merge_dir/head-name"
+echo "$onto" > "$merge_dir/onto"
+echo "$orig_head" > "$merge_dir/orig-head"
 echo "$GIT_QUIET" > "$merge_dir/quiet"
 
 msgnum=0
-- 
1.7.3.2.864.gbbb96
