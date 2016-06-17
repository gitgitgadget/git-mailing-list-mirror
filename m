Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8493720179
	for <e@80x24.org>; Fri, 17 Jun 2016 13:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933558AbcFQNgM (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 09:36:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33921 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcFQNgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 09:36:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id 66so6300074pfy.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 06:36:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yxLZlrYq7KB2Bu4VClry4hAFiE50i+az5Kfbazw9T+0=;
        b=XkVo9T0EMXqAHaKSvUAct4/fcFo2nfzQgUFhbE3mL434Ho0vGvDNCC7Kx2+EPizRz8
         E+rGIoqtkuxQ3jz05YOaO7e8J91N8QKNxuqlUDcujU1idXSBlWZfwNKnVJPrONmj9EL5
         Kad1UpGEc0u6Gp85DLQgnbusNkZj2fJw3Y9cTq5+AdVxikxrHbVe8Wg//n604uR3lCRT
         PawTME6kvfH8Pn+XuKCP2xhzGy+xzRzjr0HQSR57D4tpiOnae3rEUpyisEG48U4F94Nx
         FfKN87JuDsMQkMmYJaDeXnokZ004AACD5dJ28CNzfuaNuAbn+HA6rFUDCth8GKEcL7j6
         uEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yxLZlrYq7KB2Bu4VClry4hAFiE50i+az5Kfbazw9T+0=;
        b=Y9+5azqG8gG2fvMXGmap9dgyxDj+ahza5u35eVZte2zE0A8rdgCzoIXMPyiQ4S4W7b
         xMJw4TARtouDvNcfK52X79B8POcNXPLFMQeoHw0lVhjDq54theZ1lzAOP7zknP6xGxgH
         VcsBMnIANhphyaBg/QkHu3gxywsCdn9IEe5WWfn5kbwRY7lBWhj0BJUdnPFPdULPOZnG
         DLNrw8B5TJsH0C0rgfhaTj0WAuIsp8orqvqisCTu6aFnUvemUQEMVxg1Q67yK/Tzuybc
         uIJDxNXbmK2LPgiYhPLiDrjUXKhUiFAeVuLmfQ2GILXaw9XAg/PplqarST7i9kfzdWQY
         fFAQ==
X-Gm-Message-State: ALyK8tLqFYv9bEnY+zeNEt5uc+bK8LQn8j28iP44mIBwaZU2CPZYV4CaLw1hXmPdyJX0eA==
X-Received: by 10.98.77.65 with SMTP id a62mr2505586pfb.128.1466170567755;
        Fri, 17 Jun 2016 06:36:07 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.229])
        by smtp.gmail.com with ESMTPSA id fd8sm68737811pac.23.2016.06.17.06.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jun 2016 06:36:07 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org
Subject: [RFC/PATCH] bisect--helper: `check_and_set_terms` shell function in C
Date:	Fri, 17 Jun 2016 19:04:57 +0530
Message-Id: <20160617133457.10336-1-pranit.bauva@gmail.com>
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
global variables are passed as arguments to the subcommand. A struct is
also introduced to be used as a C counter part of the global variables.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
Collecting reviews. This patch is based on my previous series. I will also
include this the next time I reroll the series.

 builtin/bisect--helper.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++--------------------------------
 2 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index eebfcf0..69cbc93 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,6 +26,11 @@ static const char * const git_bisect_helper_usage[] = {
 	NULL
 };
 
+static struct bisect_term {
+	char term_good[10];
+	char term_bad[10];
+} terms;
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -242,6 +247,36 @@ static int bisect_write(const char *state, const char *rev,
 	return 0;
 }
 
+static int check_and_set_terms(const char *cmd, const char *term_good,
+			       const char *term_bad)
+{
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (!is_empty_file(git_path_bisect_write_terms()) &&
+	    strcmp(cmd, term_bad) && strcmp(cmd, term_good))
+		return error(_("Invalid command: you're currently in a"
+				"'%s' '%s' bisect"), term_bad, term_good);
+
+	if (one_of(cmd, "bad", "good", NULL)) {
+		if (is_empty_file(git_path_bisect_write_terms())) {
+			strcpy(terms.term_bad, "bad");
+			strcpy(terms.term_good, "good");
+			return write_terms(terms.term_bad, terms.term_good);
+		}
+	}
+
+	if (one_of(cmd, "new", "old", NULL)) {
+		if (is_empty_file(git_path_bisect_write_terms())) {
+			strcpy(terms.term_bad, "new");
+			strcpy(terms.term_good, "old");
+			return write_terms(terms.term_bad, terms.term_good);
+		}
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -250,7 +285,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -266,6 +302,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -300,6 +338,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-write requires either 4 or 5 arguments"));
 		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
 		return bisect_write(argv[0], argv[1], argv[2], argv[3], nolog);
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			die(_("--check-and-set-terms requires 3 arguments"));
+		return check_and_set_terms(argv[0], argv[1], argv[2]);
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

