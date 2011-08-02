From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11->v13] bisect: patch bisect-no-checkout in pu to
Date: Tue,  2 Aug 2011 21:41:43 +1000
Message-ID: <1312285303-9125-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDMe-0001SZ-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab1HBLmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:42:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57505 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab1HBLmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:42:18 -0400
Received: by gwaa12 with SMTP id a12so1946720gwa.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZyO2FrF+w+5jVfD0Jj6BtCvJ7ZcFg9OCa7m0PiDS8pI=;
        b=DVpVpCZv12JpB7gXUl/ymDoEwbiD/k/wwL1FHl6vP4OpO9Ozev1uhxw+QSwfG05fZt
         BJrjDHVW0Yj2o6/K6kRSv1JBtp/pnprP18s+ZNiDDcRPtXimTjJvWOFWf3TWfRxJGytH
         gMZRT3lRVmVHwZAS+sUG79vb9UWZm+fCTVqUY=
Received: by 10.68.63.233 with SMTP id j9mr2563030pbs.508.1312285337349;
        Tue, 02 Aug 2011 04:42:17 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id u6sm6672623pbh.80.2011.08.02.04.42.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:42:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.359.g2d20bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178461>

This patch can be applied on top of the version of bisect-no-checkout currently
in pu to:

* change the internal control file from BISECT_NO_CHECKOUT to BISECT_MODE
* change bisect--helper option from --no-checkout to --bisect-mode
* change the reference used to track bisection cursor from HEAD to BISECT_HEAD
* update documentation and tests to match.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |    8 ++++----
 bisect.c                     |    2 +-
 builtin/bisect--helper.c     |    8 +++++---
 git-bisect.sh                |   41 ++++++++++++++++++++++++-----------------
 t/t6030-bisect-porcelain.sh  |   30 +++++++++++++++---------------
 5 files changed, 49 insertions(+), 40 deletions(-)

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
index d96a193..5cfac13 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,7 +4,7 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all [--no-checkout]",
+	"git bisect--helper --next-all [--bisect-mode=checkout|update-ref]",
 	NULL
 };
 
@@ -12,11 +12,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
 	int no_checkout = 0;
+	char *bisect_mode=NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
-		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
-			    "update HEAD instead of checking out the current commit"),
+		OPT_STRING(0, "bisect-mode", &bisect_mode, "mode",
+			    "the bisection mode either checkout or update-ref. defaults to checkout."),
 		OPT_END()
 	};
 
@@ -26,6 +27,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (!next_all)
 		usage_with_options(git_bisect_helper_usage, options);
 
+	no_checkout = bisect_mode && !strcmp(bisect_mode, "update-ref");
 	/* next-all */
 	return bisect_next_all(prefix, no_checkout);
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 81d2344..c9aabc0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,7 +34,16 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
-BISECT_NO_CHECKOUT=$(test -f "$GIT_DIR/BISECT_NO_CHECKOUT" && cat "$GIT_DIR/BISECT_NO_CHECKOUT")
+BISECT_MODE=$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BISECT_MODE")
+
+bisect_head()
+{
+    if test "$BISECT_MODE" = "update-ref"; then
+	echo BISECT_HEAD;
+    else
+	echo HEAD
+    fi
+}
 
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
@@ -71,7 +80,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
-	BISECT_NO_CHECKOUT=
+	BISECT_MODE=checkout
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -80,7 +89,7 @@ bisect_start() {
 		break
 		;;
 	    --no-checkout)
-		BISECT_NO_CHECKOUT=$arg;
+		BISECT_MODE=update-ref;
 		shift ;;
 	    --*)
 		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
@@ -115,10 +124,10 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		if test -z "$BISECT_NO_CHECKOUT"; then
-		    git checkout "$start_head" --
+		if test "$BISECT_MODE" = "update-ref"; then
+		    git update-ref --no-deref $(bisect_head) "$start_head"
 		else
-		    git update-ref --no-deref HEAD "$start_head"
+		    git checkout "$start_head" --
 		fi
 	else
 		# Get rev from where we start.
@@ -156,10 +165,8 @@ bisect_start() {
 	# Write new start state.
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" && {
-	    test -z "$BISECT_NO_CHECKOUT" ||
-	    echo "$BISECT_NO_CHECKOUT" > "$GIT_DIR/BISECT_NO_CHECKOUT"
-	} &&
+	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES"
+	echo "$BISECT_MODE" > "$GIT_DIR/BISECT_MODE" &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -221,8 +228,8 @@ bisect_state() {
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
@@ -306,7 +313,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all ${BISECT_NO_CHECKOUT}
+	git bisect--helper --next-all ${BISECT_MODE:+--bisect-mode=}${BISECT_MODE}
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -355,15 +362,15 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if test -z "$BISECT_NO_CHECKOUT"; then
+	if test "$BISECT_MODE" = "update-ref"; then
+		git symbolic-ref $(bisect_head) $(git rev-parse --symbolic-full-name "${branch}")
+	else
 		if git checkout "$branch" --; then
 			bisect_clean_state
 		else
 			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
 		fi
-	else
-	    git symbolic-ref HEAD $(git rev-parse --symbolic-full-name "${branch}")
 	fi
 }
 
@@ -379,7 +386,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
-	rm -f "$GIT_DIR/BISECT_NO_CHECKOUT" &&
+	rm -f "$GIT_DIR/BISECT_MODE" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
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
1.7.6.359.g2d20bc
