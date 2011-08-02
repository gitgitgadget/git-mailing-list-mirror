From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v14 8/8] bisect: change bisect function to update BISECT_HEAD, rather than HEAD.
Date: Wed,  3 Aug 2011 08:16:02 +1000
Message-ID: <1312323362-20096-9-git-send-email-jon.seymour@gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNHF-0004M6-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1HBWRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:17:03 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64645 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab1HBWQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:16:54 -0400
Received: by yia27 with SMTP id 27so157887yia.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3gAwcewql1IuFJXfsATbOpi6QMCreGdSCYZsQSXvnR8=;
        b=rYkjqURGvDa4up5EiY19esF8lBxJMYrwaJsb1RAM3TaVsZEh5z5bHysLX+GaHZ/KZR
         D3/2SXKo/Cy9/997duffy4lA0MZWCf14RMlakX9Jur5lQHVW1ZXndGlT4qRCvaROTnfL
         3AJ+/c7BiHjXbYEyUjx9PdsaYQe/ZN14DXVO8=
Received: by 10.68.2.134 with SMTP id 6mr22325pbu.368.1312323411964;
        Tue, 02 Aug 2011 15:16:51 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id d3sm269987pbg.44.2011.08.02.15.16.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 15:16:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.gb3ae7e
In-Reply-To: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178526>

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
 builtin/bisect--helper.c     |    2 +-
 git-bisect.sh                |   17 +++++++++++++----
 t/t6030-bisect-porcelain.sh  |   30 +++++++++++++++---------------
 5 files changed, 34 insertions(+), 25 deletions(-)

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
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d96a193..8d325a5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -16,7 +16,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
 		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
-			    "update HEAD instead of checking out the current commit"),
+			    "update BISECT_HEAD instead of checking out the current commit"),
 		OPT_END()
 	};
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 99a2637..9792a84 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,6 +36,15 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 BISECT_MODE=$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BISECT_MODE")
 
+bisect_head()
+{
+    if test "$BISECT_MODE" = "--no-checkout"; then
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
 		if test "$BISECT_MODE" = "--no-checkout"; then
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
 	if test "$BISECT_MODE" = "--no-checkout"; then
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
1.7.6.353.gb3ae7e
