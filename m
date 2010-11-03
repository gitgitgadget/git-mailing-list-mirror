From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 2/5] rebase: refactor reading of state
Date: Wed,  3 Nov 2010 22:09:37 +0100
Message-ID: <1288818580-7576-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDT-0001u6-8D
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab0KDDKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36692 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0KDDKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:13 -0400
Received: by qwf7 with SMTP id 7so831090qwf.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FmQddVYFKW3mPpXebi8DjOwFkfWnsUdo/BTarr35piM=;
        b=I1G1G3ltxC7c7HnjlTS3/aDN5kuhqMLoc2Cia9JR/OrrzMCzeUgtpkGyg9layALgPn
         Cu2krfXUrxcJ7bczC/ZZeJCqzgoEdUWeeWfr0SXHw9+iI+5ab2V+r5Zkeq92hg/SBhki
         smL3PgIqfbltZbZ3sUhdosDFIfzBFiUe33gas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NBybL1GzKjpdY/poUCAXUp6TW43mTLe0/Tj9kkKZ8NYNb4gNIw+G917EidBt8j8MLK
         nXg0Ob3F1UIUa4Zdnqae5HGogmNPLPpb0lGnwrAH5sO+BKvYlRJs/Jgtg5jaVdoZYBB1
         yOYKxP8hjbQJiew9IkoNCEIMGzHHPqxC3awkI=
Received: by 10.229.84.203 with SMTP id k11mr111862qcl.56.1288840212711;
        Wed, 03 Nov 2010 20:10:12 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
In-Reply-To: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160684>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

The code reading the state saved in $merge_dir or $rebase_dir is
currently spread out in many places, making it harder to read and to
introduce additional state. Extract this code into one method that reads
the state.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   59 +++++++++++++++++++++++---------------------------------
 1 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8d5cf03..e0842e3 100755
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
@@ -137,10 +153,7 @@ call_merge () {
 }
 
 move_to_original_branch () {
-	test -z "$head_name" &&
-		head_name="$(cat "$merge_dir"/head-name)" &&
-		onto="$(cat "$merge_dir"/onto)" &&
-		orig_head="$(cat "$merge_dir"/orig-head)"
+	test -z "$head_name" && read_state
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -216,13 +229,9 @@ do
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
@@ -232,10 +241,6 @@ do
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
@@ -245,15 +250,11 @@ do
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
@@ -262,10 +263,6 @@ do
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
@@ -275,17 +272,9 @@ do
 			die "No rebase in progress?"
 
 		git rerere clear
-		if test -d "$merge_dir"
-		then
-			GIT_QUIET=$(cat "$merge_dir/quiet")
-			move_to_original_branch
-		else
-			merge_dir="$apply_dir"
-			GIT_QUIET=$(cat "$merge_dir/quiet")
-			move_to_original_branch
-		fi
-		git reset --hard $(cat "$merge_dir/orig-head")
-		rm -r "$merge_dir"
+		move_to_original_branch
+		git reset --hard $orig_head
+		rm -r "$state_dir"
 		exit
 		;;
 	--onto)
@@ -584,12 +573,12 @@ fi
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
1.7.3.rc1.4.g5879b6
