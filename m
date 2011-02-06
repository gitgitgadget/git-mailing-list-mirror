From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 02/31] rebase: refactor reading of state
Date: Sun,  6 Feb 2011 13:43:31 -0500
Message-ID: <1297017841-20678-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9e6-0005ZO-FF
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab1BFSps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:48 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1BFSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:47 -0500
Received: by qwa26 with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TppFb3uXedZpcijvo++cKPM2dBkFrgWyS+iy5xgPzgQ=;
        b=pfFUJbb/15QYMztx5N2csQ0TGWb4zfGCOPnoduQzUFHCUMOvq/mC1oK5z9p+cYguUC
         eyrwxtk/rQMJeKi1cDhoiQYrtcxArV6QHmBw96OOqYKfvG3YZbeMZtOcjyp25wStFDTa
         bytC22xmjcwmMgwAQpHfNze4FFutvl4+3+Fm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GpDjoG9sA+2wOXlmT2qK4uJ+nXYRJnWi0CWILM5m+FbNw8HP8/SWI9uvwuzWdEPtGq
         W6XAbq59dr33SJkrybzM9vwdLQDSrCuF7Psq1tWMhrxTrkONefxGJ5yT8D+1fA9FN4zh
         9kCvKX/pKoUNJN2kbVl7FvgndCipO1gLPQiYM=
Received: by 10.224.45.143 with SMTP id e15mr4310304qaf.32.1297017946767;
        Sun, 06 Feb 2011 10:45:46 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:45 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166170>

The code reading the state saved in $merge_dir or $rebase_dir is
currently spread out in many places, making it harder to read and to
introduce additional state. Extract this code into one method that
reads the state. Only extract the code associated with the state that
is written when the rebase is initiated. Leave the state that changes
for each commmit, at least for now.

Currently, when resuming a merge-based rebase using --continue or
--skip, move_to_original_branch (via finish_rb_merge) will be called
without head_name and orig_head set. These variables are then lazily
read in move_to_original_branch if head_name is not set (together with
onto, which is unnecessarily read again). Change this by always
eagerly reading the state, for both am-based and merge-based rebase,
in the --continue and --skip cases. Note that this does not change the
behavior for am-based rebase, which read the state eagerly even before
this commit.

Reading the state eagerly means that part of the state will sometimes
be read unnecessarily. One example is when the rebase is continued,
but stops again at another merge conflict. Another example is when the
rebase is aborted. However, since both of these cases involve user
interaction, the delay is hopefully not noticeable. The
call_merge/continue_merge loop is not affected.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   53 +++++++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 72696bf..63b5683 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -57,6 +57,22 @@ rebase_root=
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
@@ -138,10 +154,6 @@ call_merge () {
 }
 
 move_to_original_branch () {
-	test -z "$head_name" &&
-		head_name="$(cat "$merge_dir"/head-name)" &&
-		onto="$(cat "$merge_dir"/onto)" &&
-		orig_head="$(cat "$merge_dir"/orig-head)"
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -220,13 +232,9 @@ do
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
@@ -236,10 +244,6 @@ do
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
@@ -249,15 +253,11 @@ do
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
@@ -266,10 +266,6 @@ do
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
@@ -279,18 +275,15 @@ do
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
@@ -574,12 +567,12 @@ fi
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
1.7.4.rc2.33.g8a14f
