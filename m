From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 05/10] bisect: simplify the addition of new bisect terms
Date: Mon, 29 Jun 2015 17:40:30 +0200
Message-ID: <1435592435-27914-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBW-0003Jj-AE
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbbF2PlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33128 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbbF2PlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:41:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefQu018376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehxN031678;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008Dk-3y; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Jun 2015 17:40:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefQu018376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197244.11239@YhvAAUORP+g3jp0IwrLJJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272964>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

We create a file BISECT_TERMS in the repository .git to be read during a
bisection. There's no user-interface yet, but "git bisect" works if terms
other than old/new or bad/good are set in .git/BISECT_TERMS. The
fonctions to be changed if we add new terms are quite few.

In git-bisect.sh:
	check_and_set_terms
	bisect_voc

Co-authored-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Tweaked-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 bisect.c      | 33 +++++++++++++++++++++++--
 git-bisect.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 revision.c    | 19 ++++++++++++--
 3 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index a96e485..857cf59 100644
--- a/bisect.c
+++ b/bisect.c
@@ -905,6 +905,36 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 }
 
 /*
+ * The terms used for this bisect session are stored in BISECT_TERMS.
+ * We read them and store them to adapt the messages accordingly.
+ * Default is bad/good.
+ */
+void read_bisect_terms(const char **read_bad, const char **read_good)
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path("BISECT_TERMS");
+	FILE *fp = fopen(filename, "r");
+
+	if (!fp) {
+		if (errno == ENOENT) {
+			*read_bad = "bad";
+			*read_good = "good";
+			return;
+		} else {
+			die("could not read file '%s': %s", filename,
+				strerror(errno));
+		}
+	} else {
+		strbuf_getline(&str, fp, '\n');
+		*read_bad = strbuf_detach(&str, NULL);
+		strbuf_getline(&str, fp, '\n');
+		*read_good = strbuf_detach(&str, NULL);
+	}
+	strbuf_release(&str);
+	fclose(fp);
+}
+
+/*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
@@ -920,8 +950,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
-	term_bad = "bad";
-	term_good = "good";
+	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
diff --git a/git-bisect.sh b/git-bisect.sh
index fcbed22..dcd7e59 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,6 +77,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	must_write_terms=0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -101,6 +102,14 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
+
+			# The user ran "git bisect start <sha1>
+			# <sha1>", hence did not explicitly specify
+			# the terms, but we are already starting to
+			# set references named with the default terms,
+			# and won't be able to change afterwards.
+			must_write_terms=1
+
 			case $bad_seen in
 			0) state=$TERM_BAD ; bad_seen=1 ;;
 			*) state=$TERM_GOOD ;;
@@ -172,6 +181,10 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
+	if test $must_write_terms -eq 1
+	then
+		write_terms "$TERM_BAD" "$TERM_GOOD"
+	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
@@ -232,6 +245,7 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
+	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
@@ -291,15 +305,17 @@ bisect_next_check() {
 		: bisect without $TERM_GOOD...
 		;;
 	*)
-
+		bad_syn=$(bisect_voc bad)
+		good_syn=$(bisect_voc good)
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			gettextln "You need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+
+			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
+(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
 		else
-			gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+			eval_gettextln "You need to start by \"git bisect start\".
+You then need to give me at least one \$good_syn and one \$bad_syn revision.
+(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
 		fi
 		exit 1 ;;
 	esac
@@ -402,6 +418,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_TERMS" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -422,11 +439,13 @@ bisect_replay () {
 			rev="$command"
 			command="$bisect"
 		fi
+		get_terms
+		check_and_set_terms "$command"
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
-		$TERM_GOOD|$TERM_BAD|skip)
+		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
@@ -499,18 +518,62 @@ bisect_log () {
 	cat "$GIT_DIR/BISECT_LOG"
 }
 
+get_terms () {
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		{
+		read TERM_BAD
+		read TERM_GOOD
+		} <"$GIT_DIR/BISECT_TERMS"
+	fi
+}
+
+write_terms () {
+	TERM_BAD=$1
+	TERM_GOOD=$2
+	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
+}
+
+check_and_set_terms () {
+	cmd="$1"
+	case "$cmd" in
+	skip|start|terms) ;;
+	*)
+		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$TERM_BAD" && test "$cmd" != "$TERM_GOOD"
+		then
+			die "$(eval_gettext "Invalid command: you're currently in a \$TERM_BAD/\$TERM_GOOD bisect.")"
+		fi
+		case "$cmd" in
+		bad|good)
+			if ! test -s "$GIT_DIR/BISECT_TERMS"
+			then
+				write_terms bad good
+			fi
+			;;
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
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good)
+	bad|good|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
diff --git a/revision.c b/revision.c
index 3ff8723..7b35c5c 100644
--- a/revision.c
+++ b/revision.c
@@ -21,6 +21,9 @@
 
 volatile show_early_output_fn_t show_early_output;
 
+static const char *term_bad;
+static const char *term_good;
+
 char *path_name(const struct name_path *path, const char *name)
 {
 	const struct name_path *p;
@@ -2076,14 +2079,25 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+extern void read_bisect_terms(const char **bad, const char **good);
+
+static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
+	struct strbuf bisect_refs = STRBUF_INIT;
+	int status;
+	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
+	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	strbuf_release(&bisect_refs);
+	return status;
+}
+
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
+	return for_each_bisect_ref(submodule, fn, cb_data, term_bad);
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
+	return for_each_bisect_ref(submodule, fn, cb_data, term_good);
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
@@ -2112,6 +2126,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
+		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
-- 
2.5.0.rc0.10.gd2bff5d
