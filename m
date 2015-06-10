From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 3/7] bisect: simplify the addition of new bisect terms
Date: Wed, 10 Jun 2015 18:24:28 +0200
Message-ID: <1433953472-32572-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 18:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2io8-0007I6-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbbFJQYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:24:46 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:33938 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932918AbbFJQYg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 12:24:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1B5C84888B;
	Wed, 10 Jun 2015 18:24:34 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMckxGM-C1SI; Wed, 10 Jun 2015 18:24:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 084BA48876;
	Wed, 10 Jun 2015 18:24:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F37C920DC;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-axbCPbWTOo; Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7DAD720E4;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271322>

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
 bisect.c      |   33 +++++++++++++++++++++++++--
 git-bisect.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index eb2f555..827d2f3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -745,7 +745,10 @@ static void handle_bad_merge_base(void)
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
@@ -900,6 +903,31 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 }
 
 /*
+ * The terms used for this bisect session are stored in
+ * BISECT_TERMS: it can be bad/good or new/old.
+ * We read them and store them to adapt the messages
+ * accordingly. Default is bad/good.
+ */
+void read_bisect_terms(void)
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path("BISECT_TERMS");
+	FILE *fp = fopen(filename, "r");
+
+	if (!fp) {
+		die("could not read file '%s': %s", filename,
+			strerror(errno));
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
@@ -915,8 +943,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
-	name_bad="bad";
-	name_good="good";
+	read_bisect_terms();
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ce6412f..d63b4b0 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,6 +77,9 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	# start_bad_good is used to detect if we did a 
+	# 'git bisect start bad_rev good_rev'
+	start_bad_good=0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -101,6 +104,9 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
+
+			start_bad_good=1
+
 			case $bad_seen in
 			0) state=$NAME_BAD ; bad_seen=1 ;;
 			*) state=$NAME_GOOD ;;
@@ -172,6 +178,11 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
+	if test $start_bad_good -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
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
@@ -422,6 +437,8 @@ bisect_replay () {
 			rev="$command"
 			command="$bisect"
 		fi
+		get_terms
+		check_and_set_terms "$command"
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
@@ -499,11 +516,48 @@ bisect_log () {
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
-- 
1.7.1
