X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/5] am and rebase resolve states get picked up by status/commit
Date: Fri,  8 Dec 2006 02:49:28 -0800
Message-ID: <11655749741136-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:53 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33682>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdIe-0003Cg-2i for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425349AbWLHKtk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425352AbWLHKtk
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47167 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425349AbWLHKtg
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:36 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id B87BD2DC089; Fri,  8 Dec 2006 02:49:34 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:34 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This should help warn of accidental commits in the middle of a
rebase operation.  It also saves messages in $dotest/resolvemsg
and shows it in "git status" so the user can be reminded of
how to continue the am or rebase operation.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-am.sh     |   10 ++++++----
 git-commit.sh |   28 ++++++++++++++++++++++++++++
 git-rebase.sh |   35 ++++++++++++++++++++++-------------
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 28ccae3..179b967 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,7 +16,7 @@ stop_here () {
 
 stop_here_user_resolve () {
     if [ -n "$resolvemsg" ]; then
-	    echo "$resolvemsg"
+	    echo "$resolvemsg" | tee "$dotest/resolvemsg"
 	    stop_here $1
     fi
     cmdline=$(basename $0)
@@ -32,9 +32,11 @@ stop_here_user_resolve () {
     then
         cmdline="$cmdline -d=$dotest"
     fi
-    echo "When you have resolved this problem run \"$cmdline --resolved\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
-
+    cat > "$dotest/resolvemsg" <<EOF
+When you have resolved this problem run \"$cmdline --resolved\".
+If you would prefer to skip this patch, instead run \"$cmdline --skip\".
+EOF
+    cat "$dotest/resolvemsg"
     stop_here $1
 }
 
diff --git a/git-commit.sh b/git-commit.sh
index 9f6d1ef..4691835 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -32,6 +32,33 @@ save_index () {
 	cp -p "$THIS_INDEX" "$NEXT_INDEX"
 }
 
+check_dotest () {
+	if test -d .dotest
+	then
+		echo ''
+		if test -f .dotest/resolvemsg
+		then
+			cat .dotest/resolvemsg
+		else
+			echo 'A .dotest directory exists.'
+			echo 'Either a "git rebase" or "git am"' \
+					'operation is in progress'
+		fi
+	fi
+	if test -d "$GIT_DIR/.dotest-merge"
+	then
+		echo ''
+		if test -f "$GIT_DIR/.dotest-merge/resolvemsg"
+		then
+			cat "$GIT_DIR/.dotest-merge/resolvemsg"
+		else
+			echo "A $GIT_DIR/.dotest-merge/resolvemsg " \
+				'directory exists.'
+			echo 'A "git rebase --merge" operation is in progress'
+		fi
+	fi
+}
+
 run_status () {
 	# If TMP_INDEX is defined, that means we are doing
 	# "--only" partial commit, and that index file is used
@@ -64,6 +91,7 @@ run_status () {
 		echo  "#	$line"
 	    done
 	fi
+	check_dotest | sed -e 's/^/# /'
 	case "$status_only" in
 	t) color= ;;
 	*) color=--nocolor ;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 2b4f347..53f3919 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -41,6 +41,16 @@ dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
 
+die_msg () {
+	> "$dotest/resolvemsg"
+	for i in "$@"
+	do
+		echo "$i" | tee -a "$dotest/resolvemsg" >&2
+	done
+	echo "$RESOLVEMSG" >> "$dotest/resolvemsg"
+	die "$RESOLVEMSG"
+}
+
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$dotest" || die "$dotest directory does not exist"
@@ -48,18 +58,17 @@ continue_merge () {
 	unmerged=$(git-ls-files -u)
 	if test -n "$unmerged"
 	then
-		echo "You still have unmerged paths in your index"
-		echo "did you forget update-index?"
-		die "$RESOLVEMSG"
+		die_msg "You still have unmerged paths in your index" \
+				"did you forget update-index?"
 	fi
 
 	if test -n "`git-diff-index HEAD`"
 	then
 		if ! git-commit -C "`cat $dotest/current`"
 		then
-			echo "Commit failed, please do not call \"git commit\""
-			echo "directly, but instead do one of the following: "
-			die "$RESOLVEMSG"
+			die_msg \
+			"Commit failed, please do not call \"git commit\"" \
+			"directly, but instead do one of the following: "
 		fi
 		printf "Committed: %0${prec}d" $msgnum
 	else
@@ -73,6 +82,7 @@ continue_merge () {
 	echo "$prev_head" > "$dotest/prev_head"
 
 	# onto the next patch:
+	rm -f "$dotest/resolvemsg"
 	msgnum=$(($msgnum + 1))
 	echo "$msgnum" >"$dotest/msgnum"
 }
@@ -88,14 +98,13 @@ call_merge () {
 		;;
 	1)
 		test -d "$GIT_DIR/rr-cache" && git-rerere
-		die "$RESOLVEMSG"
+		die_msg
 		;;
 	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$RESOLVEMSG"
+		die_msg "Strategy: $rv $strategy failed, try another"
 		;;
 	*)
-		die "Unknown exit code ($rv) from command:" \
+		die_msg "Unknown exit code ($rv) from command:" \
 			"git-merge-$strategy $cmt^ -- HEAD $cmt"
 		;;
 	esac
@@ -112,9 +121,8 @@ do
 	--continue)
 		diff=$(git-diff-files)
 		case "$diff" in
-		?*)	echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git update-index"
-			exit 1
+		?*)	die_msg "You must edit all merge conflicts and then" \
+				"mark them as resolved using git update-index"
 			;;
 		esac
 		if test -d "$dotest"
@@ -143,6 +151,7 @@ do
 			then
 				git-rerere clear
 			fi
+			rm -f "$dotest/resolvemsg"
 			prev_head="`cat $dotest/prev_head`"
 			end="`cat $dotest/end`"
 			msgnum="`cat $dotest/msgnum`"
-- 
1.4.4.2.g860f4
