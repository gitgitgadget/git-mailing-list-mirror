From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function in C
Date: Wed,  8 Jun 2016 02:24:51 +0530
Message-ID: <20160607205454.22576-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:55:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO2U-00043V-IR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbcFGUzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:55:50 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33158 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699AbcFGUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:55:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id di3so14910132pab.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZQM2ruCFZxF4+K0VkvkxjxvRkUutOyxYH2LSFZ0Qcgw=;
        b=rneac9/nng2oEmwnhti5BGD0tRj/kwQgE6C9lK7oTLY6Qho4mH+6vq+8L3zvKHzU5l
         M/Jz7aCChigX96QmFcGFv+U2K9SoqP1l2sI5VdDz0Awsr58D3A1huscDIuUKpxFhJw2/
         afmApEbm2R/77iIPhEC2JzTZNuJVxYvS3m0gK9XjZF+SaQQfwhrYQrVX7ss26qG8Bi0T
         zaR7ypfBg+xl66b+pMVUZBXMIIb5iAIKqPkkgCaZnHcLsKTQSoF3UtjCXI2+xAtKBNRB
         jUoOu36TPVvRZ19pI3E2vtJGrsyBW+SCXpfM26RQe5x/Bx0BPauYZPPRwRWtdaweg9oF
         4zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZQM2ruCFZxF4+K0VkvkxjxvRkUutOyxYH2LSFZ0Qcgw=;
        b=hXpBGXYugtQIdtf5ZyLiXO3R7iQ6XlmSi/Xibl97U2HhUmF3jmuB40phPuRyOfTLPq
         KtNkiNXeHOfz9i84z+Ii+zj05zYiEyRbfSSMEwq6elQpt1NL2RJ9yVMkY0SsQhQ/RY5o
         zqhStVdQ1RIGDhuQUby1y3z/4QK7bly358LOsF8nSTqzonx87nfQLWp9zV3tL2hdASmm
         GQrWbv/InljP/zV+/NJRbw3Wnmtdva/KaRj/7CW6lKA2RE22VBfIGr7UR/Ecz4lHonZg
         1K2SoF1MLzKLOHcxPHWupbmlQyf1o3oveo+xfv8lxoa6BrwAl5IvCc7OQi8nb89GobRE
         QSAQ==
X-Gm-Message-State: ALyK8tK8GA8n8mVzx+AIqM+14bolbokoqq74bUjgQd8JIFMVLgSVe2JphIqmpdPOsEis3A==
X-Received: by 10.66.251.72 with SMTP id zi8mr1426212pac.19.1465332948346;
        Tue, 07 Jun 2016 13:55:48 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.232])
        by smtp.gmail.com with ESMTPSA id hw10sm35183194pac.15.2016.06.07.13.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jun 2016 13:55:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296717>

Reimplement `bisect_clean_state` shell function in C and add a
`bisect-clean-state` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `bisect_clean_state` subcommand is a measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by
bisect_reset() and bisect_start().

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 26 +++----------------------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 91027b0..ad39181 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,12 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
 
 static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
+	N_("git bisect--helper --bisect-clean-state"),
 	NULL
 };
 
@@ -78,11 +87,43 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
+int mark_for_removal(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
+{
+	struct string_list *refs = cb_data;
+	char *ref = xstrfmt("refs/bisect/%s", refname);
+	string_list_append(refs, ref);
+	return 0;
+}
+
+int bisect_clean_state(void)
+{
+	int result = 0;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
+	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
+	string_list_append(&refs_for_removal, "BISECT_HEAD");
+	result |= delete_refs(&refs_for_removal);
+	string_list_clear(&refs_for_removal, 0);
+	remove_path(git_path_bisect_expected_rev());
+	remove_path(git_path_bisect_ancestors_ok());
+	remove_path(git_path_bisect_log());
+	remove_path(git_path_bisect_names());
+	remove_path(git_path_bisect_run());
+	remove_path(git_path_bisect_write_terms());
+	/* Cleanup head-name if it got left by an old version of git-bisect */
+	remove_path(git_path_head_name());
+	/* Cleanup BISECT_START last */
+	remove_path(git_path_bisect_start());
+
+	return result;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		WRITE_TERMS
+		WRITE_TERMS,
+		BISECT_CLEAN_STATE
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -90,6 +131,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
+			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -108,6 +151,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
+	case BISECT_CLEAN_STATE:
+		if (argc != 0)
+			die(_("--bisect-clean-state requires no arguments"));
+		return bisect_clean_state();
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index cd39bd0..bbc57d2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -187,7 +187,7 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state.
 	#
-	bisect_clean_state || exit
+	git bisect--helper --bisect-clean-state || exit
 
 	#
 	# Change state.
@@ -196,7 +196,7 @@ bisect_start() {
 	# We have to trap this to be able to clean up using
 	# "bisect_clean_state".
 	#
-	trap 'bisect_clean_state' 0
+	trap 'git bisect--helper --bisect-clean-state' 0
 	trap 'exit 255' 1 2 3 15
 
 	#
@@ -430,27 +430,7 @@ bisect_reset() {
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
 	fi
-	bisect_clean_state
-}
-
-bisect_clean_state() {
-	# There may be some refs packed during bisection.
-	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
-	while read ref hash
-	do
-		git update-ref -d $ref $hash || exit
-	done
-	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
-	rm -f "$GIT_DIR/BISECT_LOG" &&
-	rm -f "$GIT_DIR/BISECT_NAMES" &&
-	rm -f "$GIT_DIR/BISECT_RUN" &&
-	rm -f "$GIT_DIR/BISECT_TERMS" &&
-	# Cleanup head-name if it got left by an old version of git-bisect
-	rm -f "$GIT_DIR/head-name" &&
-	git update-ref -d --no-deref BISECT_HEAD &&
-	# clean up BISECT_START last
-	rm -f "$GIT_DIR/BISECT_START"
+	git bisect--helper --bisect-clean-state || exit
 }
 
 bisect_replay () {
-- 
2.8.3
