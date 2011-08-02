From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 8/8] bisect: change bisect function to update BISECT_HEAD, rather than HEAD.
Date: Tue,  2 Aug 2011 21:29:05 +1000
Message-ID: <1312284545-2426-9-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDBT-0004o4-Bw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab1HBLam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:42 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46092 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1HBLaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:35 -0400
Received: by gxk21 with SMTP id 21so3980890gxk.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0jx2IMV8ARAgqYfiXqV1FXN66uw8aZmcM9Xe+PW0HFQ=;
        b=o2MvbRaJGzTDYmiHXSdoE5XnxV0PB6Gk6QxtjghSgttrLLV/5rUIku307ToWMpofP+
         R40panJhwiX4VDgz8x4y/JedIHoonJDrcZN1PDb/7KSmL/RoPWkZEIulr9iLthdynYgp
         m0ceOTyieGBba+tTjG+7nk5n3g0cWG6qzyH8U=
Received: by 10.142.215.10 with SMTP id n10mr3419175wfg.290.1312284634706;
        Tue, 02 Aug 2011 04:30:34 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.30.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:30:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178459>

This function modifies git-bisect so that the --no-checkout option
uses BISECT_HEAD rather than HEAD to record the current bisection
head.

The intent is to reduce the confusion that uses of --no-checkout
may experience when using the --no-checkout option since the bisection
process will no longer introduce spurious differences between the
HEAD reference and the working tree and index.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |    8 ++++----
 bisect.c                     |    2 +-
 git-bisect.sh                |   17 +++++++++++++----
 t/t6030-bisect-porcelain.sh  |   30 +++++++++++++++---------------
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 2014894..a9b217b 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -267,9 +267,9 @@ OPTIONS
 -------
 --no-checkout::
 +
-This option is used to specify that 'git bisect' should not modify the working
-tree or index on each iteration of the bisection process but should
-update HEAD instead.
+This option is used to specify that 'git bisect' should not checkout the
+new working tree at each iteration of the bisection process but should
+instead update BISECT_HEAD.
 +
 This option is useful in circumstances in which checkout is either not
 possible (because of a damaged respository) or is otherwise not required.
@@ -360,7 +360,7 @@ on a single line.
 $ git bisect start HEAD <known-good-commit> [ <boundary-commit> ... ] --no-checkout
 $ git bisect run eval '
 rc=1;
-if git rev-list --objects HEAD >tmp.$$; then
+if git rev-list --objects BISECT_HEAD >tmp.$$; then
    git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
 fi;
 rm tmp.$$;
diff --git a/bisect.c b/bisect.c
index 0427117..46874be 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,7 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
-static const char *argv_update_ref[] = {"update-ref", "--no-deref", "HEAD", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
 /* bits #0-15 in revision.h */
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 5f3c2c4..c9aabc0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,6 +36,15 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 BISECT_MODE=$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BISECT_MODE")
 
+bisect_head()
+{
+    if test "$BISECT_MODE" = "update-ref"; then
+	echo BISECT_HEAD;
+    else
+	echo HEAD
+    fi
+}
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -116,7 +125,7 @@ bisect_start() {
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
 		if test "$BISECT_MODE" = "update-ref"; then
-		    git update-ref --no-deref HEAD "$start_head"
+		    git update-ref --no-deref $(bisect_head) "$start_head"
 		else
 		    git checkout "$start_head" --
 		fi
@@ -219,8 +228,8 @@ bisect_state() {
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
 	1,bad|1,good|1,skip)
-		rev=$(git rev-parse --verify HEAD) ||
-			die "$(gettext "Bad rev input: HEAD")"
+		rev=$(git rev-parse --verify $(bisect_head)) ||
+			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
@@ -354,7 +363,7 @@ bisect_reset() {
 	    usage ;;
 	esac
 	if test "$BISECT_MODE" = "update-ref"; then
-		git symbolic-ref HEAD $(git rev-parse --symbolic-full-name "${branch}")
+		git symbolic-ref $(bisect_head) $(git rev-parse --symbolic-full-name "${branch}")
 	else
 		if git checkout "$branch" --; then
 			bisect_clean_state
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1e0ddc..ef422a1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -641,24 +641,24 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 test_expect_success 'bisect: --no-checkout - start commit bad' '
 	git bisect reset &&
 	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 HEAD &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
 	git bisect reset
 '
 
 test_expect_success 'bisect: --no-checkout - trial commit bad' '
 	git bisect reset &&
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 HEAD &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
 	git bisect reset
 '
 
 test_expect_success 'bisect: --no-checkout - target before breakage' '
 	git bisect reset &&
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 HEAD &&
-	git bisect bad HEAD &&
-	check_same BROKEN_HASH5 HEAD &&
-	git bisect bad HEAD &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
+	check_same BROKEN_HASH5 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
 	check_same BROKEN_HASH5 bisect/bad &&
 	git bisect reset
 '
@@ -666,10 +666,10 @@ test_expect_success 'bisect: --no-checkout - target before breakage' '
 test_expect_success 'bisect: --no-checkout - target in breakage' '
 	git bisect reset &&
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 HEAD &&
-	git bisect bad HEAD &&
-	check_same BROKEN_HASH5 HEAD &&
-	git bisect good HEAD &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect bad BISECT_HEAD &&
+	check_same BROKEN_HASH5 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH6 bisect/bad &&
 	git bisect reset
 '
@@ -677,10 +677,10 @@ test_expect_success 'bisect: --no-checkout - target in breakage' '
 test_expect_success 'bisect: --no-checkout - target after breakage' '
 	git bisect reset &&
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
-	check_same BROKEN_HASH6 HEAD &&
-	git bisect good HEAD &&
-	check_same BROKEN_HASH8 HEAD &&
-	git bisect good HEAD &&
+	check_same BROKEN_HASH6 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
+	check_same BROKEN_HASH8 BISECT_HEAD &&
+	git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH9 bisect/bad &&
 	git bisect reset
 '
@@ -691,7 +691,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect start broken master --no-checkout &&
 	git bisect run eval '
 rc=1;
-if git rev-list --objects HEAD >tmp.$$; then
+if git rev-list --objects BISECT_HEAD >tmp.$$; then
    git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
 fi;
 rm tmp.$$;
-- 
1.7.6.353.g3461
