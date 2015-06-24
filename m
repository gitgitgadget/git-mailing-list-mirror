From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v8 3/5] bisect: simplify the addition of new bisect terms
Date: Wed, 24 Jun 2015 17:17:40 +0200
Message-ID: <1435159062-23468-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
 <1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 24 17:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7mRQ-0008JF-HC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbFXPSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 11:18:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43550 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbbFXPSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 11:18:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5OFHsmQ009857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2015 17:17:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5OFHuhM030615;
	Wed, 24 Jun 2015 17:17:56 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z7mR2-0006YF-8K; Wed, 24 Jun 2015 17:17:56 +0200
X-Mailer: git-send-email 2.4.4.414.g59d82e6
In-Reply-To: <1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Jun 2015 17:17:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5OFHsmQ009857
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435763876.63285@CZM5ySlCW+sVDl2TDZfByw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272558>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

We create a file BISECT_TERMS in the repository .git to be read during a
bisection. The fonctions to be changed if we add new terms are quite
few.
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
 bisect.c      | 38 +++++++++++++++++++++++++++++---
 git-bisect.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 revision.c    | 20 +++++++++++++++--
 3 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2d3dbdc..08be634 100644
--- a/bisect.c
+++ b/bisect.c
@@ -747,7 +747,10 @@ static void handle_bad_merge_base(void)
 				"between %s and [%s].\n",
 				bad_hex, bad_hex, good_hex);
 		} else {
-			die("BUG: terms %s/%s not managed", name_bad, name_good);
+			fprintf(stderr, "The merge base %s is %s.\n"
+				"This means the first commit marked %s is "
+				"between %s and [%s].\n",
+				bad_hex, name_bad, name_bad, bad_hex, good_hex);
 		}
 		exit(3);
 	}
@@ -902,6 +905,36 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
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
@@ -917,8 +950,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
-	name_bad = "bad";
-	name_good = "good";
+	read_bisect_terms(&name_bad, &name_good);
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ce6412f..7bb18db 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,6 +77,9 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	# revision_seen is true if a git bisect start
+	# has revision as arguments
+	revision_seen=0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -101,6 +104,9 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
+
+			revision_seen=1
+
 			case $bad_seen in
 			0) state=$NAME_BAD ; bad_seen=1 ;;
 			*) state=$NAME_GOOD ;;
@@ -172,6 +178,11 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
+	if test $revision_seen -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
+	then
+		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
+		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
@@ -232,6 +243,7 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
+	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
@@ -291,15 +303,17 @@ bisect_next_check() {
 		: bisect without $NAME_GOOD...
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
@@ -402,6 +416,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_TERMS" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -422,11 +437,13 @@ bisect_replay () {
 			rev="$command"
 			command="$bisect"
 		fi
+		get_terms
+		check_and_set_terms "$command"
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
-		$NAME_GOOD|$NAME_BAD|skip)
+		"$NAME_GOOD"|"$NAME_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
@@ -499,11 +516,50 @@ bisect_log () {
 	cat "$GIT_DIR/BISECT_LOG"
 }
 
+get_terms () {
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		{
+		read NAME_BAD
+		read NAME_GOOD
+		} <"$GIT_DIR/BISECT_TERMS"
+	fi
+}
+
+check_and_set_terms () {
+	cmd="$1"
+	case "$cmd" in
+	bad|good)
+		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
+		then
+			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
+		fi
+		case "$cmd" in
+		bad|good)
+			if ! test -s "$GIT_DIR/BISECT_TERMS"
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
diff --git a/revision.c b/revision.c
index 3ff8723..24ce842 100644
--- a/revision.c
+++ b/revision.c
@@ -21,6 +21,9 @@
 
 volatile show_early_output_fn_t show_early_output;
 
+static const char *name_bad;
+static const char *name_good;
+
 char *path_name(const struct name_path *path, const char *name)
 {
 	const struct name_path *p;
@@ -2076,14 +2079,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+extern void read_bisect_terms(const char **bad, const char **good);
+
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
+	struct strbuf bisect_refs = STRBUF_INIT;
+	int status;
+	strbuf_addf(&bisect_refs, "refs/bisect/%s", name_bad);
+	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	strbuf_release(&bisect_refs);
+	return status;
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
+	struct strbuf bisect_refs = STRBUF_INIT;
+	int status;
+	strbuf_addf(&bisect_refs, "refs/bisect/%s", name_good);
+	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	strbuf_release(&bisect_refs);
+	return status;
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
@@ -2112,6 +2127,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
+		read_bisect_terms(&name_bad, &name_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
-- 
2.4.4.414.g59d82e6
