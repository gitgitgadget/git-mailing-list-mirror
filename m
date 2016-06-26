Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276452018B
	for <e@80x24.org>; Sun, 26 Jun 2016 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbcFZUqE (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 16:46:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35513 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 16:46:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so14044124pfb.2
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 13:46:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pkI70OzaBY7hZQmmZAasaOg0ihQiPD/ajHKO5RoRSyw=;
        b=jc84Bwtv4IbBXge0O6x3Go6B+M4IBF1LSaSy9Np5rljbo8VdHmzI1gUSPFU3QIn3tH
         B8EUy/UOQazvH5sEASnMM94dKBMHEIl0HKCPkFZ02r/JpuMXKSVVyHvMbzra5KOAsXiV
         gZDNnqF4chHiyRbGQ8XWk8PV2JKBGuFWGyjXNCxoTNE4DeFNLu2m4n1eIF6XpjBJjIwA
         3+tWKJWUDeSh+ZhQDIRjWMIag/BmfAKXOiRivZQXKtYKKDKZAG0JeFef6LQAjnbzpuNa
         NYFGQd4BfeYk9Nw7dDtk6+J85+24k7raygTjnrYCk0j90dXLzoYk4nwnhq6mzzuMx9tO
         OGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pkI70OzaBY7hZQmmZAasaOg0ihQiPD/ajHKO5RoRSyw=;
        b=PyFz8hjrUeDtmKZldqlEfbobf6rEINIFnh25V0EZQaymy9DvFGPVWcTEjHpFcCQcF5
         BYH/2sNX+S4tRO5vRC5cD+v1Pv34deoRrl/QJM/Joga5vhJgIUgQ+d19G5B/tHif1b7e
         EFBA6pDQw5SFv3EEd/QpkX4oDrQTTMXvbrDmfFF2lDYy+t/4cGH/P/b8Ycv9BlRk9Y58
         aEnrojH6ZKdBBKlXO+4xF9fEPIxh4K2WiuBQof8+secP9nyTzBV+tut0JLjbowbmRmaI
         WIxMQ+pGAY/CG58Y/WoUb+Ecv0L5ppviC0VTLzF0tebh6B/7jfEHZ6KQpUlJ+oaiT2O9
         vyPw==
X-Gm-Message-State: ALyK8tK3PLPVrEVU15wJ1gCouTThFfnA5KOgkkX/nVfMsIAlny1ZP7vlr5NQBATwlz6YFA==
X-Received: by 10.98.47.129 with SMTP id v123mr26998060pfv.71.1466973961477;
        Sun, 26 Jun 2016 13:46:01 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ot2sm1591749pac.29.2016.06.26.13.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 13:46:00 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, Matthie.Moy@grenoble-inp.fr,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	gitster@pobox.com
Subject: [RFC/PATCH 1/3] bisect--helper: `check_and_set_terms` shell function in C
Date:	Mon, 27 Jun 2016 02:14:09 +0530
Message-Id: <20160626204411.19919-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `check_and_set_terms` shell function in C and add
`check-and-set-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--check-and-set-terms` subcommand is a temporary measure to port
shell function in C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will be called
by some other methods.

check_and_set_terms() sets and receives two global variables namely
TERM_GOOD and TERM_BAD in the shell script. Luckily the file BISECT_TERMS
also contains the value of those variables so its appropriate to evoke the
method get_terms() after calling the subcommand so that it retrieves the
value of TERM_GOOD and TERM_BAD from the file BISECT_TERMS. The two
global variables are passed as arguments to the subcommand.

Also introduce bisect_terms_reinit() to release the previous memory of
struct bisect_terms and allocate new memory for it thus flushing out the
previous contents.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
This series applies on top of my previous patch series[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/298263

 builtin/bisect--helper.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++----------------------------
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e946ba9..c387697 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -45,6 +45,13 @@ static int bisect_terms_release(struct bisect_terms *term)
 	return 0;
 }
 
+static int bisect_terms_reinit(struct bisect_terms *term)
+{
+	bisect_terms_release(term);
+	bisect_terms_init(term);
+	return 0;
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -254,6 +261,40 @@ static int bisect_write(const char *state, const char *rev,
 	return 0;
 }
 
+static int check_and_set_terms(const char *cmd, struct bisect_terms *term)
+{
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (!is_empty_or_missing_file(git_path_bisect_write_terms()) &&
+	    strcmp(cmd, term->term_bad.buf) && strcmp(cmd, term->term_good.buf))
+		return error(_("Invalid command: you're currently in a"
+				"'%s' '%s' bisect"), term->term_bad.buf,
+				term->term_good.buf);
+
+	if (one_of(cmd, "bad", "good", NULL)) {
+		if (is_empty_or_missing_file(git_path_bisect_write_terms())) {
+			bisect_terms_reinit(term);
+			strbuf_addstr(&term->term_bad, "bad");
+			strbuf_addstr(&term->term_good, "good");
+			return write_terms(term->term_bad.buf,
+					   term->term_good.buf);
+		}
+	}
+
+	if (one_of(cmd, "new", "old", NULL)) {
+		if (is_empty_or_missing_file(git_path_bisect_write_terms())) {
+			bisect_terms_reinit(term);
+			strbuf_addstr(&term->term_bad, "new");
+			strbuf_addstr(&term->term_good, "old");
+			return write_terms(term->term_bad.buf,
+					   term->term_good.buf);
+		}
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -262,7 +303,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -278,6 +320,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -321,6 +365,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&state.term_bad, argv[3]);
 		res = bisect_write(argv[0], argv[1], &state, nolog);
 		break;
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			die(_("--check-and-set-terms requires 3 arguments"));
+		strbuf_addstr(&state.term_good, argv[1]);
+		strbuf_addstr(&state.term_bad, argv[2]);
+		res = check_and_set_terms(argv[0], &state);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index b9896a4..63ae742 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -239,7 +239,8 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
-	check_and_set_terms $state
+	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD
+	get_terms
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
@@ -390,7 +391,8 @@ bisect_replay () {
 			command="$bisect"
 		fi
 		get_terms
-		check_and_set_terms "$command"
+		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
+		get_terms
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
@@ -480,36 +482,6 @@ get_terms () {
 	fi
 }
 
-check_and_set_terms () {
-	cmd="$1"
-	case "$cmd" in
-	skip|start|terms) ;;
-	*)
-		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$TERM_BAD" && test "$cmd" != "$TERM_GOOD"
-		then
-			die "$(eval_gettext "Invalid command: you're currently in a \$TERM_BAD/\$TERM_GOOD bisect.")"
-		fi
-		case "$cmd" in
-		bad|good)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=bad
-				TERM_GOOD=good
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		new|old)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=new
-				TERM_GOOD=old
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		esac ;;
-	esac
-}
-
 bisect_voc () {
 	case "$1" in
 	bad) echo "bad|new" ;;
-- 
2.9.0

