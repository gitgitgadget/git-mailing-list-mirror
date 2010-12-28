From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 02/31] rebase: refactor reading of state
Date: Tue, 28 Dec 2010 10:30:19 +0100
Message-ID: <1293528648-21873-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYv-0005Wr-MJ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab0L1Pc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:27 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0L1PcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:25 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aOcstNnxjqimx4yXM0MJ8cuRGx+kLVOKBzlIsSA1fqE=;
        b=hFEQr9TSG8eFpWpToDCyH9I50vwukLUCAnRhkM4YQT/BVq771toVhHghg+1v0tbLbv
         wY3AMaMGxkTWJE99HqShbpaYxPc3A8k7mwZkMqZ+dJ14g6tUasAS3ly1zYy+ICQZAlZh
         c7VkwUMellW93bP3rHiw7DxRb8BXYo7O9hm9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Xdal+XyTXHE5yqeJbB0CThY54EbNK2XdMUAuXY4O5RNuPXlmyggFQXx4S4dOqq0w+S
         925P17aFoq0C7JY31yoN+JK+SLkn1DK5QCYFFyIDnZIODCP1xmYuuAw3RuIz8B1+Mbqr
         PsusmvMz6o0cEBPDL4C0zZcL65NqT2SS5vACc=
Received: by 10.229.236.203 with SMTP id kl11mr11451416qcb.131.1293550344908;
        Tue, 28 Dec 2010 07:32:24 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:24 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164261>

The code reading the state saved in $merge_dir or $rebase_dir is
currently spread out in many places, making it harder to read and to
introduce additional state. Extract this code into one method that reads
the state.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   53 +++++++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 79f8008..bf144dc 100755
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
@@ -573,12 +566,12 @@ fi
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
