From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 2/6] bisect: replace hardcoded "bad|good" by variables
Date: Mon, 22 Jun 2015 23:00:32 +0200
Message-ID: <1435006836-18182-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 23:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78pt-0005xf-JW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbFVVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:49 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48158 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbbFVVAk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BD4D128CB;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUgUcEKTpIS6; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 930D22890;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8923F20D2;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KN5uDvw3C28T; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3DA5820DC;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272414>

To add new tags like old/new and have keywords less confusing, the
first step is to avoid hardcoding the keywords.

The default mode is still bad/good.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 bisect.c      |   51 ++++++++++++++++++++++++++++++++++-----------------
 git-bisect.sh |   57 +++++++++++++++++++++++++++++++--------------------------
 2 files changed, 65 insertions(+), 43 deletions(-)
 mode change 100755 => 100644 git-bisect.sh

diff --git a/bisect.c b/bisect.c
index 5b8357d..cda30fa 100644
--- a/bisect.c
+++ b/bisect.c
@@ -21,6 +21,9 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
+static const char *name_bad;
+static const char *name_good;
+
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
@@ -403,15 +406,21 @@ struct commit_list *find_bisection(struct commit_list *list,
 static int register_ref(const char *refname, const struct object_id *oid,
 			int flags, void *cb_data)
 {
-	if (!strcmp(refname, "bad")) {
+	struct strbuf good_prefix = STRBUF_INIT;
+	strbuf_addstr(&good_prefix, name_good);
+	strbuf_addstr(&good_prefix, "-");
+
+	if (!strcmp(refname, name_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
-	} else if (starts_with(refname, "good-")) {
+	} else if (starts_with(refname, good_prefix.buf)) {
 		sha1_array_append(&good_revs, oid->hash);
 	} else if (starts_with(refname, "skip-")) {
 		sha1_array_append(&skipped_revs, oid->hash);
 	}
 
+	strbuf_release(&good_prefix);
+
 	return 0;
 }
 
@@ -634,7 +643,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 		return;
 
 	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first bad commit could be any of:\n");
+	       "The first %s commit could be any of:\n", name_bad);
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
@@ -732,18 +741,21 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-
-		fprintf(stderr, "The merge base %s is bad.\n"
-			"This means the bug has been fixed "
-			"between %s and [%s].\n",
-			bad_hex, bad_hex, good_hex);
-
+		if (!strcmp(name_bad, "bad")) {
+			fprintf(stderr, "The merge base %s is bad.\n"
+				"This means the bug has been fixed "
+				"between %s and [%s].\n",
+				bad_hex, bad_hex, good_hex);
+		} else {
+			die("BUG: terms %s/%s not managed", name_bad, name_good);
+		}
 		exit(3);
 	}
 
-	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
+	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistook good and bad revs?\n");
+		"Maybe you mistook %s and %s revs?\n",
+		name_good, name_bad, name_good, name_bad);
 	exit(1);
 }
 
@@ -755,10 +767,10 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 
 	warning("the merge base between %s and [%s] "
 		"must be skipped.\n"
-		"So we cannot be sure the first bad commit is "
+		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
 		"We continue anyway.",
-		bad_hex, good_hex, mb_hex, bad_hex);
+		bad_hex, good_hex, name_bad, mb_hex, bad_hex);
 	free(good_hex);
 }
 
@@ -839,7 +851,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a bad revision is needed");
+		die("a %s revision is needed", name_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -905,6 +917,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
+	name_bad="bad";
+	name_good="good";
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
@@ -926,8 +940,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		 */
 		exit_if_skipped_commits(tried, NULL);
 
-		printf("%s was both good and bad\n",
-		       oid_to_hex(current_bad_oid));
+		printf("%s was both %s and %s\n",
+		       oid_to_hex(current_bad_oid),
+		       name_good,
+		       name_bad);
 		exit(1);
 	}
 
@@ -942,7 +958,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first bad commit\n", bisect_rev_hex);
+		printf("%s is the first %s commit\n", bisect_rev_hex,
+			name_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
diff --git a/git-bisect.sh b/git-bisect.sh
old mode 100755
new mode 100644
index ae3fec2..ce6412f
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -32,6 +32,8 @@ OPTIONS_SPEC=
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+NAME_BAD=bad
+NAME_GOOD=good
 
 bisect_head()
 {
@@ -100,8 +102,8 @@ bisect_start() {
 				break
 			}
 			case $bad_seen in
-			0) state='bad' ; bad_seen=1 ;;
-			*) state='good' ;;
+			0) state=$NAME_BAD ; bad_seen=1 ;;
+			*) state=$NAME_GOOD ;;
 			esac
 			eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
 			shift
@@ -184,9 +186,12 @@ bisect_write() {
 	rev="$2"
 	nolog="$3"
 	case "$state" in
-		bad)		tag="$state" ;;
-		good|skip)	tag="$state"-"$rev" ;;
-		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
+		"$NAME_BAD")
+			tag="$state" ;;
+		"$NAME_GOOD"|skip)
+			tag="$state"-"$rev" ;;
+		*)
+			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -230,12 +235,12 @@ bisect_state() {
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
-	1,bad|1,good|1,skip)
+	1,"$NAME_BAD"|1,"$NAME_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
-	2,bad|*,good|*,skip)
+	2,"$NAME_BAD"|*,"$NAME_GOOD"|*,skip)
 		shift
 		hash_list=''
 		for rev in "$@"
@@ -249,8 +254,8 @@ bisect_state() {
 			bisect_write "$state" "$rev"
 		done
 		check_expected_revs $hash_list ;;
-	*,bad)
-		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
+	*,"$NAME_BAD")
+		die "$(eval_gettext "'git bisect \$NAME_BAD' can take only one argument.")" ;;
 	*)
 		usage ;;
 	esac
@@ -259,21 +264,21 @@ bisect_state() {
 
 bisect_next_check() {
 	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/bad || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
+	git show-ref -q --verify refs/bisect/$NAME_BAD || missing_bad=t
+	test -n "$(git for-each-ref "refs/bisect/$NAME_GOOD-*")" || missing_good=t
 
 	case "$missing_good,$missing_bad,$1" in
 	,,*)
-		: have both good and bad - ok
+		: have both $NAME_GOOD and $NAME_BAD - ok
 		;;
 	*,)
 		# do not have both but not asked to fail - just report.
 		false
 		;;
-	t,,good)
+	t,,"$NAME_GOOD")
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		gettextln "Warning: bisecting only with a bad commit." >&2
+		eval_gettextln "Warning: bisecting only with a \$NAME_BAD commit." >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -283,7 +288,7 @@ bisect_next_check() {
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
-		: bisect without good...
+		: bisect without $NAME_GOOD...
 		;;
 	*)
 
@@ -307,7 +312,7 @@ bisect_auto_next() {
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check good
+	bisect_next_check $NAME_GOOD
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -316,18 +321,18 @@ bisect_next() {
 	# Check if we should exit because bisection is finished
 	if test $res -eq 10
 	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
+		bad_rev=$(git show-ref --hash --verify refs/bisect/$NAME_BAD)
 		bad_commit=$(git show-branch $bad_rev)
-		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
+		echo "# first $NAME_BAD commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
 		exit 0
 	elif test $res -eq 2
 	then
 		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/good-*")
-		for skipped in $(git rev-list refs/bisect/bad --not $good_revs)
+		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$NAME_GOOD-*")
+		for skipped in $(git rev-list refs/bisect/$NAME_BAD --not $good_revs)
 		do
 			skipped_commit=$(git show-branch $skipped)
-			echo "# possible first bad commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
+			echo "# possible first $NAME_BAD commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
 		done
 		exit $res
 	fi
@@ -421,7 +426,7 @@ bisect_replay () {
 		start)
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
-		good|bad|skip)
+		$NAME_GOOD|$NAME_BAD|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
@@ -455,9 +460,9 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state='skip'
 		elif [ $res -gt 0 ]
 		then
-			state='bad'
+			state="$NAME_BAD"
 		else
-			state='good'
+			state="$NAME_GOOD"
 		fi
 
 		# We have to use a subshell because "bisect_state" can exit.
@@ -466,7 +471,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 
 		cat "$GIT_DIR/BISECT_RUN"
 
-		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+		if sane_grep "first $NAME_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
 			>/dev/null
 		then
 			gettextln "bisect run cannot continue any more" >&2
@@ -480,7 +485,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" >/dev/null
+		if sane_grep "is the first $NAME_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
 		then
 			gettextln "bisect run success"
 			exit 0;
-- 
1.7.1
