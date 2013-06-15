From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 4/5] stash: introduce 'git stash store'
Date: Sat, 15 Jun 2013 18:43:25 +0530
Message-ID: <1371302006-29775-5-git-send-email-artagnon@gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:15:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqKc-0007oc-UN
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab3FONPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:15:33 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59196 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab3FONPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:30 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so1476455pab.13
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UyTOztkD7n0C4imMO+Em3RxKwoLW2QypARg/cGq8M+M=;
        b=swPFTULtW9jxnrOQc9qyAAEedpPzuWvc/07w7M1ceBGtqfvRw8ZtHAn5QGfvCd3WG2
         OHCmAwRixTSIzbpAJMQByZAnjaB2gH42NJVzP/SCNxT7gXeX9H4E5YdJCIQoMoZSntRq
         gPs4mStdzIMV9w8MA7L+cCQssxJKA76IhEVc6I4NVl8sNNI3xAZZP3orBQC5bq6r3neu
         ePvBCuj6YzSmla6YEHSUCTwpfyUY2E1iLFxEbecZPFZxm4DpSIJyao1XnCF8Jlq9cksw
         HYIP799sjkBbI/jVZu8E+QvBqfw2BJCYEXNstwRpf67pGRMIy4Thfi9z4zAhiWtb4juo
         HNvw==
X-Received: by 10.66.149.66 with SMTP id ty2mr6319771pab.58.1371302129501;
        Sat, 15 Jun 2013 06:15:29 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227950>

save_stash() contains the logic for doing two potentially independent
operations; the first is preparing the stash merge commit, and the
second is updating the stash ref/ reflog accordingly.  While the first
operation is abstracted out into a create_stash() for callers to access
via 'git stash create', the second one is not.  Fix this by factoring
out the logic for storing the stash into a store_stash() that callers
can access via 'git stash store'.

Like create, store is not intended for end user interactive use, but for
callers in other scripts.  We can simplify the logic in the
rebase.autostash feature using this new subcommand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt |  7 +++++++
 git-stash.sh                | 47 +++++++++++++++++++++++++++++++++++++++------
 t/t3903-stash.sh            | 19 ++++++++++++++++++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 632d4fb..db7e803 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
+'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
 -----------
@@ -154,6 +155,12 @@ create::
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "save" above.
 
+store::
+
+	Store a given stash created via 'git stash create' (which is a
+	dangling merge commit) in the stash ref, updating the stash
+	reflog.  This is intended to be useful for scripts.  It is
+	probably not the command you want to use; see "save" above.
 
 DISCUSSION
 ----------
diff --git a/git-stash.sh b/git-stash.sh
index 64800b8..62e8cb6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -156,6 +156,41 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
+store_stash () {
+	while test $# != 0
+	do
+		case "$1" in
+		-m|--message)
+			shift
+			stash_msg="$1"
+			;;
+		-q|--quiet)
+			quiet=t
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test $# == 1 ||
+	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
+
+	w_commit="$1"
+	if test -z "$stash_msg"
+	then
+		stash_msg="Created via \"git stash store\"."
+	fi
+
+	# Make sure the reflog for stash is kept.
+	: >>"$GIT_DIR/logs/$ref_stash"
+	git update-ref -m "$stash_msg" $ref_stash $w_commit
+	ret=$?
+	test $ret != 0 && test -z $quiet &&
+	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
+	return $ret
+}
+
 save_stash () {
 	keep_index=
 	patch_mode=
@@ -227,12 +262,8 @@ save_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
-
-	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
-
-	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-		die "$(gettext "Cannot save the current status")"
+	store_stash -m "$stash_msg" -q $w_commit ||
+	die "$(gettext "Cannot save the current status")"
 	say Saved working directory and index state "$stash_msg"
 
 	if test -z "$patch_mode"
@@ -549,6 +580,10 @@ create)
 	shift
 	create_stash "$*" && echo "$w_commit"
 	;;
+store)
+	shift
+	store_stash "$@"
+	;;
 drop)
 	shift
 	drop_stash "$@"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..75189ec 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -637,4 +637,23 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	test_cmp output expect
 '
 
+test_expect_success 'store called with invalid commit' '
+	test_must_fail git stash store foo
+'
+
+test_expect_success 'store updates stash ref and reflog' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >bazzy &&
+	git add bazzy &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	! grep quux bazzy &&
+	git stash store -m quuxery $STASH_ID &&
+	test $(cat .git/refs/stash) = $STASH_ID &&
+	grep $STASH_ID .git/logs/refs/stash &&
+	git stash pop &&
+	grep quux bazzy
+'
+
 test_done
-- 
1.8.3.1.441.gd7d6b72.dirty
