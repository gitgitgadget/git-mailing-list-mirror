From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed,  8 Jun 2016 02:24:54 +0530
Message-ID: <20160607205454.22576-4-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:56:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO2t-0004Lu-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422836AbcFGU4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:56:14 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33224 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161206AbcFGU4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:56:13 -0400
Received: by mail-pa0-f66.google.com with SMTP id di3so14910707pab.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iIp72IXs25ZRCeYBXXvpIEZng2aqL5cYzvWXCif+wUk=;
        b=suFxuBFWvsQ7csGqel0cC6LnSRFbVmkabQFlivXs5rqG5jnaCFXM4f1d6x0SJtFp1W
         MY6EK3gT3KVQp2WcpCz9IMUf/AqDEZVoYDHv+QycAwx+Pb6Vz7XcT+BjUpTX6+/GLX+r
         R2EXL85yG5NbtqcloxQTOu+6ZsQcl9XmJqY/tUT82XgtY/SSyiW52EEecfLBZVnCqHKV
         UGEQNftI+24w5x8vjyzhLRToAGDzDtmyn947sQFz9C8YxDSZI9Xz5oQCxkdC9zSRuSxm
         5PTEWkTWwSs/UO6EaoxEt/SouGKHCWyJ0ishD7koNWNSaqcFQujIjfY2xzOhcQt8noYk
         C9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iIp72IXs25ZRCeYBXXvpIEZng2aqL5cYzvWXCif+wUk=;
        b=ch8uciw3HjHHSpmRoBA3CFhA8cN6uvSJ01jypknwWWIwBMfXG2/XdxQeFwXqPw5WQZ
         jWIyv3M/x0L4o0TFPFEECNZ8sSgRrr2NnY3DSc183WsBNGjpfaqisSZ5tJACZsBFF/3o
         /+Vkp/ff4pOXh0hbJe01IR/lJBiGnvk4ojFgdb0Ma9gM2/J8WCiFwf5c0k73jAv1h6gy
         Gpp49uuG7R0HMnleEZ9spDtUFvVYct8iOoPFQgSFTH/OVpIJJXbHv1q7Vrbrpr/5ITeQ
         bf4JMmRoRfK56uFuNyrgbfFKSLNbHM2MCm4df8hbQwR7hIipHpRH4nIlDAGkCipUbND8
         beZg==
X-Gm-Message-State: ALyK8tIHagXiSL2fik7hJeOklXZ/O4FfQpw5IvuJNNgoYr9FbPrzCNYlyw+Qt7EM1TKEqg==
X-Received: by 10.66.84.74 with SMTP id w10mr1428937pay.140.1465332972066;
        Tue, 07 Jun 2016 13:56:12 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.232])
        by smtp.gmail.com with ESMTPSA id hw10sm35183194pac.15.2016.06.07.13.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jun 2016 13:56:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296720>

Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
subcommand to `git bisect--helper` to call it from git-bisect.sh .

Using `bisect_reset` subcommand is a temporary measure to port shell
functions to C so as to use the existing test suite. As more functions
are ported, this subcommand would be retired and will be called by some
other method.

Note: --bisect-clean-state subcommand has not been retired as there are
still a function namely `bisect_start()` which still uses this
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++------------------------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ad39181..4153e8a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,6 +4,8 @@
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -13,11 +15,13 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -118,12 +122,51 @@ int bisect_clean_state(void)
 	return result;
 }
 
+int bisect_reset(const char *commit)
+{
+	struct strbuf branch = STRBUF_INIT;
+	int status = 0;
+
+	if (file_size(git_path_bisect_start()) < 1) {
+		printf("We are not bisecting.\n");
+		return 0;
+	}
+
+	if (!commit) {
+		strbuf_read_file(&branch, git_path_bisect_start(), 0);
+		strbuf_rtrim(&branch);
+	} else {
+		struct object_id oid;
+		if (get_oid(commit, &oid))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addf(&branch, "%s", commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
+		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+		argv_array_clear(&argv);
+	}
+
+	if (status) {
+		error(_("Could not check out original HEAD '%s'. "
+				"Try 'git bisect reset <commit>'."), branch.buf);
+		strbuf_release(&branch);
+		return -1;
+	}
+
+	strbuf_release(&branch);
+	return bisect_clean_state();
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE
+		BISECT_CLEAN_STATE,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -133,6 +176,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -155,6 +200,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
 		return bisect_clean_state();
+	case BISECT_RESET:
+		if (argc > 1)
+			die(_("--bisect-reset requires either zero or one arguments"));
+		return bisect_reset(argc ? argv[0] : NULL);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index bbc57d2..18580b7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -409,35 +409,11 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_reset() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "We are not bisecting."
-		return
-	}
-	case "$#" in
-	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
-			invalid="$1"
-			die "$(eval_gettext "'\$invalid' is not a valid commit")"
-		}
-		branch="$1" ;;
-	*)
-		usage ;;
-	esac
-
-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
-	then
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
-Try 'git bisect reset <commit>'.")"
-	fi
-	git bisect--helper --bisect-clean-state || exit
-}
-
 bisect_replay () {
 	file="$1"
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	bisect_reset
+	git bisect--helper --bisect-reset || exit
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -627,7 +603,7 @@ case "$#" in
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-		bisect_reset "$@" ;;
+		git bisect--helper --bisect-reset "$@" ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)
-- 
2.8.3
