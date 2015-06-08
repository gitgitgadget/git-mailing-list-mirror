From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Mon,  8 Jun 2015 22:22:09 +0200
Message-ID: <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 22:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23Yr-00079v-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbFHUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:22:16 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55203 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753326AbbFHUWO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 16:22:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B69692879;
	Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc3t3whCYQJU; Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A44102817;
	Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 63F7220E9;
	Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9a7rWzbTCDJE; Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 3490A20E6;
	Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271126>

We create a file BISECT_TERMS in the repository .git to be read during a
bisection. The fonctions to be changed if we add new terms are quite
few.
In git-bisect.sh :
	check_and_set_terms
	bisect_voc
In bisect.c :
	handle_bad_merge_base

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 bisect.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++---------------
 git-bisect.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 103 insertions(+), 20 deletions(-)

diff --git a/bisect.c b/bisect.c
index de92953..3b7df85 100644
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
 
@@ -403,7 +406,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
-	if (!strcmp(refname, "bad")) {
+	if (!strcmp(refname, name_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		hashcpy(current_bad_oid->hash, sha1);
 	} else if (starts_with(refname, "good-")) {
@@ -634,7 +637,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 		return;
 
 	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first bad commit could be any of:\n");
+	       "The first %s commit could be any of:\n", name_bad);
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
@@ -732,18 +735,19 @@ static void handle_bad_merge_base(void)
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
 
@@ -755,10 +759,10 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 
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
 
@@ -839,7 +843,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a bad revision is needed");
+		die("a %s revision is needed", name_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -890,6 +894,31 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 }
 
 /*
+ * The terms used for this bisect session are stocked in
+ * BISECT_TERMS: it can be bad/good or new/old.
+ * We read them and stock them to adapt the messages
+ * accordingly. Default is bad/good.
+ */
+void read_bisect_terms(void)
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path("BISECT_TERMS");
+	FILE *fp = fopen(filename, "r");
+
+	if (!fp) {
+		name_bad = "bad";
+		name_good = "good";
+	} else {
+		strbuf_getline(&str, fp, '\n');
+		name_bad = strbuf_detach(&str, NULL);
+		strbuf_getline(&str, fp, '\n');
+		name_good = strbuf_detach(&str, NULL);
+	}
+	strbuf_release(&str);
+	fclose(fp);
+}
+
+/*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
@@ -905,6 +934,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
+	read_bisect_terms();
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
@@ -926,8 +956,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
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
 
@@ -942,7 +974,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first bad commit\n", bisect_rev_hex);
+		printf("%s is the first %s commit\n", bisect_rev_hex,
+			name_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
diff --git a/git-bisect.sh b/git-bisect.sh
index 1f16aaf..529bb43 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,6 +77,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	start_bad_good=0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -101,6 +102,9 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
+
+			start_bad_good=1
+
 			case $bad_seen in
 			0) state='bad' ; bad_seen=1 ;;
 			*) state='good' ;;
@@ -172,6 +176,11 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
+	if test $start_bad_good -eq 1 -a ! -s "$GIT_DIR/BISECT_TERMS"
+	then
+		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
+		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
@@ -232,6 +241,7 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
+	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
@@ -294,12 +304,12 @@ bisect_next_check() {
 
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			gettextln "You need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+			gettextln "You need to give me at least one $(bisect_voc bad) and one $(bisect_voc good) revision.
+(You can use \"git bisect $(bisect_voc bad)\" and \"git bisect $(bisect_voc good)\" for that.)" >&2
 		else
 			gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+You then need to give me at least one $(bisect_voc good) and one $(bisect_voc bad) revision.
+(You can use \"git bisect $(bisect_voc bad)\" and \"git bisect $(bisect_voc good)\" for that.)" >&2
 		fi
 		exit 1 ;;
 	esac
@@ -402,6 +412,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_TERMS" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -422,6 +433,8 @@ bisect_replay () {
 			rev="$command"
 			command="$bisect"
 		fi
+		get_terms
+		check_and_set_terms "$command"
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
@@ -499,11 +512,48 @@ bisect_log () {
 	cat "$GIT_DIR/BISECT_LOG"
 }
 
+get_terms () {
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		NAME_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
+		NAME_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"
+	fi
+}
+
+check_and_set_terms () {
+	cmd="$1"
+	case "$cmd" in
+	bad|good)
+		if test -s "$GIT_DIR/BISECT_TERMS" -a "$cmd" != "$NAME_BAD" -a "$cmd" != "$NAME_GOOD"
+		then
+			die "$(eval_gettext "Invalid command : you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
+		fi
+		case "$cmd" in
+		bad|good)
+			if test ! -s "$GIT_DIR/BISECT_TERMS"
+			then
+				echo "bad" >"$GIT_DIR/BISECT_TERMS" &&
+				echo "good" >>"$GIT_DIR/BISECT_TERMS"
+			fi
+			NAME_BAD="bad"
+			NAME_GOOD="good" ;;
+		esac ;;
+	esac
+}
+
+bisect_voc () {
+	case "$1" in
+	bad) echo "bad" ;;
+	good) echo "good" ;;
+	esac
+}
+
 case "$#" in
 0)
 	usage ;;
 *)
 	cmd="$1"
+	get_terms
 	shift
 	case "$cmd" in
 	help)
-- 
2.4.1.414.ge7a9de3.dirty
