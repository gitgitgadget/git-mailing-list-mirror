From: shigeta@kanamei.co.jp
Subject: [PATCH] stash create: Add --include-untracked and --all option to stash create
Date: Fri, 27 Jun 2014 17:07:59 +0900
Message-ID: <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
Cc: Kazumasa Shigeta <shigeta@kanamei.co.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 10:10:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0RF2-0006W4-OF
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbaF0IKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 04:10:32 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:49417 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaF0IK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 04:10:26 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so4313492pbb.9
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oa8nkj7lQKrPPdAQSToaUJ1/nYWusEWK8PIXI29Rj2g=;
        b=LDWTns5RKA2U1Sv3qf+BfNLTb1MGkzZZ24lDkDrGtc8NwpTPPv1ReioqeGKS9jNGRz
         NVrWnRp97RmB5d8SurtqgxoGIlejpDe+WydlsyMEUNMn2L/WdiBpBsAs5mDfMF2tocTD
         hJp2HWk3TdFkwm2U89f+Ej3i9SYibs8KKtTK8YUUDrs41zZgqNZ5+Bx5y5WShT2iKsPc
         J5WB2DoHy1K9g2PjaqCauIU5u5u+vTPgzGdO//+v1A9zjBXfEnJFAY4FwHFOMse1puf9
         g9+GXY31u9RxSFG57KJkUvWaARm5iJ/OH9LfpOhAd3r1Pgb0HHSE+plzPv0Uos6S08X3
         yXYw==
X-Gm-Message-State: ALoCoQlRaHdFsOg1a0DFITDJb2BBu8ScsH2Cq/lpucNWz3ql6G1fRqM/d/gkPgbbZbiavNqeia0z
X-Received: by 10.69.19.203 with SMTP id gw11mr27581307pbd.25.1403856625961;
        Fri, 27 Jun 2014 01:10:25 -0700 (PDT)
Received: from localhost.localdomain (203.141.156.112.static.zoot.jp. [203.141.156.112])
        by mx.google.com with ESMTPSA id su8sm13454138pbc.72.2014.06.27.01.10.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 01:10:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252538>

From: Kazumasa Shigeta <shigeta@kanamei.co.jp>

The --include-untracked option acts like the normal "git stash save --include-untracked --all" but it does not change anything in working directory.
It is inconvenient stash create does not have --include-untracked option however stash save has --include-untracked option.
It fails when using message that start with dash. It is not compatible with now.

Signed-off-by: Kazumasa Shigeta <shigeta@kanamei.co.jp>
---
 Documentation/git-stash.txt               |   4 +-
 git-stash.sh                              |  52 +++++-
 t/t3907-stash-create-include-untracked.sh | 286 ++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+), 6 deletions(-)
 create mode 100755 t/t3907-stash-create-include-untracked.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..7ff9ce6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
-'git stash' create [<message>]
+'git stash' create [-u|--include-untracked] [-a|--all] [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
@@ -148,7 +148,7 @@ drop [-q|--quiet] [<stash>]::
 	`<stash>` must be a valid stash log reference of the form
 	`stash@{<revision>}`.
 
-create::
+create [-u|--include-untracked] [-a|--all] [<message>]::
 
 	Create a stash (which is a regular commit object) and return its
 	object name, without storing it anywhere in the ref namespace.
diff --git a/git-stash.sh b/git-stash.sh
index 4798bcf..d636651 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -57,8 +57,35 @@ clear_stash () {
 }
 
 create_stash () {
-	stash_msg="$1"
-	untracked="$2"
+    stash_msg=
+    untracked=
+
+	while test $# != 0
+	do
+		case "$1" in
+		-u|--include-untracked)
+			untracked=untracked
+			;;
+		-a|--all)
+			untracked=all
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			option="$1"
+			eval_gettextln "error: unknown option for 'stash create': \$option
+       To provide a message, use git stash create -- '\$option'"
+			exit 1
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	stash_msg="$*"
 
 	git update-index -q --refresh
 	if no_changes
@@ -260,8 +287,25 @@ save_stash () {
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
+    untracked_opt=
+    case "$untracked" in
+		untracked)
+			untracked_opt="--include-untracked"
+			break
+			;;
+		all)
+			untracked_opt="--all"
+			break
+			;;
+    esac
+
+	if test -z "$untracked_opt"
+	then
+		create_stash  -- "$stash_msg"
+	else
+		create_stash "$untracked_opt" -- "$stash_msg"
+	fi
 
-	create_stash "$stash_msg" $untracked
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say Saved working directory and index state "$stash_msg"
@@ -584,7 +628,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash "$@" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3907-stash-create-include-untracked.sh b/t/t3907-stash-create-include-untracked.sh
new file mode 100755
index 0000000..c28ed0f
--- /dev/null
+++ b/t/t3907-stash-create-include-untracked.sh
@@ -0,0 +1,286 @@
+#!/bin/sh
+#
+# File:   t3907-stash-create-include-untracked.sh
+# Author: shigeta
+#
+# Created on 2014/05/01, 13:13:15
+
+test_description='Test git stash create --include-untracked and --all'
+
+. ./test-lib.sh
+
+cat > .gitignore <<EOF
+.gitignore
+ignored
+ignored.d/
+EOF
+
+STASH_ID_U=
+STASH_ID__INCLUDE_UNTRACKED=
+STASH_ID_A=
+STASH_ID__ALL=
+
+test_expect_success 'stash create --include-untracked and --all some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	echo 1 > file2 &&
+	echo 1 > HEAD &&
+	mkdir untracked &&
+	echo untracked >untracked/untracked &&
+	echo ignored > ignored &&
+	mkdir ignored.d &&
+	echo ignored >ignored.d/untracked
+	STASH_ID_U=$(git stash create -u message1 message2 message3) &&
+	test_tick &&
+	STASH_ID__INCLUDE_UNTRACKED=$(git stash create --include-untracked message1 message2 message3) &&
+	test_tick &&
+	STASH_ID_A=$(git stash create -a message1 message2 message3) &&
+	test_tick &&
+	STASH_ID__ALL=$(git stash create --all message1 message2 message3)
+'
+
+cat > expect <<EOF
+MM file
+?? HEAD
+?? actual
+?? expect
+?? file2
+?? untracked/
+EOF
+test_expect_success 'stash create --include-untracked do not clean the untracked files' '
+	test_when_finished "rm expect actual"
+	git status --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash create --include-untracked should be equal to -u in created stash' '
+	test_when_finished "rm message.u message.untracked"
+	git diff-tree --exit-code "$STASH_ID_U:" "$STASH_ID__INCLUDE_UNTRACKED:" &&
+	git diff-tree --exit-code "$STASH_ID_U^:" "$STASH_ID__INCLUDE_UNTRACKED^:" &&
+	git diff-tree --exit-code "$STASH_ID_U^2:" "$STASH_ID__INCLUDE_UNTRACKED^2:" &&
+	git diff-tree --exit-code "$STASH_ID_U^3:" "$STASH_ID__INCLUDE_UNTRACKED^3:" &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID_U" >message.u &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID__INCLUDE_UNTRACKED" >message.untracked &&
+	test_cmp message.u message.untracked
+'
+
+test_expect_success 'stash create --all should be equal to -a in created stash' '
+	test_when_finished "rm message.a message.all"
+	git diff-tree --exit-code "$STASH_ID_A:" "$STASH_ID__ALL:" &&
+	git diff-tree --exit-code "$STASH_ID_A^:" "$STASH_ID__ALL^:" &&
+	git diff-tree --exit-code "$STASH_ID_A^2:" "$STASH_ID__ALL^2:" &&
+	git diff-tree --exit-code "$STASH_ID_A^3:" "$STASH_ID__ALL^3:" &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID_A" >message.a &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID__ALL" >message.all &&
+	test_cmp message.a message.all
+'
+
+cat > expect <<EOF
+A	.gitignore
+A	ignored
+A	ignored.d
+EOF
+test_expect_success 'stash create -a and -u difference about ignored files' '
+	test_when_finished "rm expect actual" &&
+	git diff --exit-code "$STASH_ID_U" "$STASH_ID_A" &&
+	git diff-tree --exit-code "$STASH_ID_U:" "$STASH_ID_A:" &&
+	git diff-tree --exit-code "$STASH_ID_U^:" "$STASH_ID_A^:" &&
+	git diff-tree --exit-code "$STASH_ID_U^2:" "$STASH_ID_A^2:" &&
+	git diff-tree --name-status "$STASH_ID_U^3:" "$STASH_ID_A^3:" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash save -u should be equal to stash create -u in created stash' '
+	test_when_finished "rm createmessage savemessage" &&
+	test_when_finished "git stash pop -q --index" &&
+	git stash save -u  message1 message2 message3 &&
+	git diff --exit-code $STASH_ID_U stash &&
+	git diff-tree --exit-code "$STASH_ID_U:" stash: &&
+	git diff-tree --exit-code "$STASH_ID_U^:" stash^: &&
+	git diff-tree --exit-code "$STASH_ID_U^2:" stash^2: &&
+	git diff-tree --exit-code "$STASH_ID_U^3:" stash^3: &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID_U" >createmessage &&
+	git show  --pretty=format:"%s%n%b" --no-patch stash >savemessage &&
+	test_cmp createmessage savemessage
+'
+
+test_expect_success 'stash create -a should be equal to stash save -a in created stash' '
+	test_when_finished "rm createmessage savemessage" &&
+	test_when_finished "git stash pop -q --index" &&
+	git stash save -a -q message1 message2 message3 &&
+	git diff --exit-code "$STASH_ID_U" stash &&
+	git diff-tree --exit-code "$STASH_ID_A:" stash: &&
+	git diff-tree --exit-code "$STASH_ID_A^:" stash^: &&
+	git diff-tree --exit-code "$STASH_ID_A^2:" stash^2: &&
+	git diff-tree --exit-code "$STASH_ID_A^3:" stash^3: &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID_U" >createmessage &&
+	git show  --pretty=format:"%s%n%b" --no-patch stash >savemessage &&
+	test_cmp createmessage savemessage
+'
+
+cat > expect.message <<EOF
+On master: message1 message2 message3
+
+EOF
+test_expect_success 'stash create -u recorded correctly  a message "message1 message2 message3"' '
+	test_when_finished "rm expect* actual*" &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID_U" >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.message
+?? expect.status
+?? file2
+?? untracked/
+EOF
+cat > expect.message <<EOF
+On master: message1 message2 message3
+
+EOF
+test_expect_success 'no effect to nomal stash create message' '
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_when_finished "rm expect* actual*" &&
+	STASH_ID=$(git stash create message1 message2 message3) &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID" >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.status
+?? file2
+?? untracked/
+EOF
+test_expect_success 'stash create -message-starting-with-dashs should be fail' '
+	test_when_finished "rm expect* actual*" &&
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_must_fail git stash create -message-starting-with-dash
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.status
+?? file2
+?? untracked/
+EOF
+test_expect_success 'stash create --message should be fail' '
+	test_when_finished "rm expect* actual*" &&
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_must_fail git stash create --message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.message
+?? expect.status
+?? file2
+?? untracked/
+EOF
+cat > expect.message <<EOF
+On master: -message-starting-with-dash
+
+EOF
+test_expect_success 'stash create -- -message-starting-with-dash should be success' '
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_when_finished "rm expect* actual*" &&
+	STASH_ID=$(git stash create -- -message-starting-with-dash ) &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID" >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.message
+?? expect.status
+?? file2
+?? untracked/
+EOF
+cat > expect.message <<EOF
+On master: message1 message2 message3
+
+EOF
+test_expect_success 'no effect to nomal stash save massage' '
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_when_finished "rm expect* actual*" &&
+	test_when_finished "git stash pop -q --index" &&
+	git stash save message1 message2 message3 &&
+	git show  --pretty=format:"%s%n%b" --no-patch stash >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.message
+?? expect.status
+?? file2
+?? untracked/
+EOF
+cat > expect.message <<EOF
+On master: --include-untracked
+
+EOF
+test_expect_success 'stash create -- --include-untracked recorded a stash message correctly' '
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_when_finished "rm expect* actual*"&&
+	STASH_ID= &&
+	STASH_ID=$(git stash create -- --include-untracked) &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID" >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+cat > expect.status <<EOF
+MM file
+?? HEAD
+?? expect.message
+?? expect.status
+?? file2
+?? untracked/
+EOF
+cat > expect.message <<EOF
+On master: -message-starting-with-dash
+
+EOF
+test_expect_success 'stash create --include-untracked -- -message-starting-with-dash recorded a stash message correctly' '
+	actual_status="$(git status --porcelain)" &&
+	echo "$actual_status" >actual.status &&
+	test_cmp expect.status actual.status &&
+	test_when_finished "rm expect* actual*" &&
+	STASH_ID= &&
+	STASH_ID=$(git stash create --include-untracked -- -message-starting-with-dash) &&
+	git show  --pretty=format:"%s%n%b" --no-patch "$STASH_ID" >actual.message &&
+	test_cmp expect.message actual.message
+'
+
+test_expect_success 'stash create should be fail on wrong parameter' '
+		test_must_fail git stash create -message-starting-with-dash &&
+		test_must_fail git stash create -u -message-starting-with-dash &&
+		test_must_fail git stash create --include-untracked -message-starting-with-dash
+'
+
+test_done
-- 
1.8.5.2 (Apple Git-48)
