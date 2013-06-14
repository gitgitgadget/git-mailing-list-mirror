From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] stash: introduce 'git stash store'
Date: Fri, 14 Jun 2013 16:02:03 +0530
Message-ID: <1371205924-8982-5-git-send-email-artagnon@gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHP-0000Tc-GB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3FNKah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:37 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41500 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3FNKaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:21 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so438953pbc.39
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fhEavKWMJj7KDCEtXjkDRmirZsHU8jGxYXx67wqMOaA=;
        b=X6Xhxq8tLJ6ujKZ89m1la6qyOTKHsVTpNO+tKuNKi3Ry2TGLsWUE1md7IKk6XCkr9j
         OR/yM7kiOk/Nw6UfVraCPb++SKlmkOOtgGC9AMn8lX6eo15lWWqd7PZnsyHX9Lrp4va1
         DPbMjOpBDq/W5qQAfdCxO8s+zUUKrvJLnbo035U/5eyJB/QwV9Jx88gcn2NwLr7Lst19
         po+Xy+cbNEV+0ROPAU1OobWvkcUv5eMX+TPl3A/T39vkoaq7xqWIwZoZWqjZJhIyZZTw
         5niUZbQJD7A4XWiP9NoSN9ifHEDQXE7RamjgsbiYJCKziBaPZpMD7lU7KCztk2duOdgI
         zeLw==
X-Received: by 10.66.118.79 with SMTP id kk15mr1860757pab.193.1371205821476;
        Fri, 14 Jun 2013 03:30:21 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227807>

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
 git-stash.sh                | 48 +++++++++++++++++++++++++++++++++++++++------
 t/t3903-stash.sh            | 19 ++++++++++++++++++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 08cdf2f..ec3a9a3 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
+'git stash' store [-m|--message <message>] [-e|--error <message>] <commit>
 
 DESCRIPTION
 -----------
@@ -153,6 +154,12 @@ create::
 	object name, without storing it anywhere in the ref namespace.
 	This is probably not what you want to use; see "save" above.
 
+store::
+
+	Store a given stash created via 'git stash create' (which is a
+	dangling merge commit) in the stash ref, updating the stash
+	reflog.  This is probably not what you want to use; see
+	"save" above.
 
 DISCUSSION
 ----------
diff --git a/git-stash.sh b/git-stash.sh
index 64800b8..7985473 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -156,6 +156,43 @@ create_stash () {
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
+		-e|--error)
+			shift
+			error_msg="$1"
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
+	if test -z "$error_msg"
+	then
+		error_msg="Cannot update $ref_stash with $w_commit."
+	fi
+
+	# Make sure the reflog for stash is kept.
+	: >>"$GIT_DIR/logs/$ref_stash"
+	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
+	die "$(eval_gettext "$error_msg")"
+}
+
 save_stash () {
 	keep_index=
 	patch_mode=
@@ -227,12 +264,7 @@ save_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
-
-	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
-
-	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-		die "$(gettext "Cannot save the current status")"
+	store_stash -m "$stash_msg" -e "Cannot save the current status." $w_commit
 	say Saved working directory and index state "$stash_msg"
 
 	if test -z "$patch_mode"
@@ -549,6 +581,10 @@ create)
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
1.8.3.1.383.g0d5ad6b
