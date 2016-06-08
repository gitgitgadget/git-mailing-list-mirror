From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 2/2] bisect--helper: `check_expected_revs` shell function in C
Date: Wed,  8 Jun 2016 20:54:15 +0530
Message-ID: <20160608152415.7770-2-pranit.bauva@gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 17:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAfMi-0000Bs-GP
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 17:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476AbcFHPZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 11:25:51 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35998 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbcFHPZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 11:25:51 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so772926pad.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VC1QxFLRtfWdfMTklN0tfLj2avAAaF5nL6MfH0lGOhI=;
        b=qKQowMBpIgtN3+nYKoFLlp05nCe2Kb9G7Y8rTC9IrkcmfZAPQHZCYju/yvJbScrzia
         xeFHd/g0e16ZthNdqfbL6QrWCszlq5mya/htEVo2gBtIv38Xr4NItZ3+BhI+ciWxaNKl
         4LHdwTB8FcmvdX8fGaU8Edx3Lqce9yfZKn5GsMOhK6xYVewngSjR2aKwDNLjCEfH8Qol
         AQ/02VPDwtWmP9/60ruBsiL1XibxAcg8HTG2YGpHjgIQA/Voab5btW1gVag4OxEx/EFd
         i3BAJYPtssaoTrHyohShje/n4CgquJzOp7Tb4KTPD4HU2Rm7AIngMUy8bLxHc+Cqib66
         9OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VC1QxFLRtfWdfMTklN0tfLj2avAAaF5nL6MfH0lGOhI=;
        b=gyUPC4oeolB9s8ks1yl/8nFQZgNKR9qc65lO+t2ATSrKeiRbtNFBkQkpCnC8HTTv3j
         HlR89gUr7xWLjpz05XSlzYgiNiXlhclX+T50qudV4x6DtPZgrZUlnVLciuGLDZuqEsO6
         OkncK1OwFGusYnxEYIXbhVAKhM2GfKfJ/OgL0XYIFZbtaQoNgLUs2C+dnA+Hm8op7wV/
         4mGRhWtaEBlNCMkS6YkMN8cxMqN2OCrVa4jhIU4R3he11mYF2d3zwApwcra1xKxO2m2y
         d2dy5H08bYme9A6dDGCCfUDpBQvy4M6DeUTwozLQqYheUc43FKT9Hh8hTTSGDNS6HNEv
         jahA==
X-Gm-Message-State: ALyK8tIrT/9Xk+occXrGL1VWohxQvN9TOhLXfK3MGo+nbID1ew8f1rmDlBPm+6VgnV2MIw==
X-Received: by 10.66.220.168 with SMTP id px8mr6306971pac.83.1465399549944;
        Wed, 08 Jun 2016 08:25:49 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ce8sm3190089pad.44.2016.06.08.08.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jun 2016 08:25:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160608152415.7770-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296803>

Reimplement the `check_expected_revs` shell function in C and add a
`--check-expected-revs` subcommand to `git bisect--helper` to call it
from git-bisect.sh .

Using `--check-expected-revs` subcommand is a temporary measure to port
shell function in C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will be called
by some other method namely `bisect_state()`.

Note: Previously is_expected_rev() was converted but not added as a
subcommand. Now since we have converted check_expected_rev() and we are
calling is_expected_rev()'s C implementation, we can safely delete the
shell implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 21 ++++++++++++++++++++-
 git-bisect.sh            | 20 ++------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 06bc9b8..500efd5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -174,13 +174,28 @@ static int is_expected_rev(const char *expected_hex)
 	return !strcmp(actual_hex.buf, expected_hex);
 }
 
+static int check_expected_revs(const char **revs, int no)
+{
+	int i;
+
+	for (i = 0; i < no; i++) {
+		if (!is_expected_rev(revs[i])) {
+			remove_path(git_path_bisect_ancestors_ok());
+			remove_path(git_path_bisect_expected_rev());
+			return 0;
+		}
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
-		BISECT_RESET
+		BISECT_RESET,
+		CHECK_EXPECTED_REVS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -192,6 +207,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
+			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -218,6 +235,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		return bisect_reset(argc ? argv[0] : NULL);
+	case CHECK_EXPECTED_REVS:
+		return check_expected_revs(argv, argc);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 18580b7..4f6545e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -238,22 +238,6 @@ bisect_write() {
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-is_expected_rev() {
-	test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
-}
-
-check_expected_revs() {
-	for _rev in "$@"; do
-		if ! is_expected_rev "$_rev"
-		then
-			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
-			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
-			return
-		fi
-	done
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -280,7 +264,7 @@ bisect_state() {
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
-		check_expected_revs "$rev" ;;
+		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
 		hash_list=''
@@ -294,7 +278,7 @@ bisect_state() {
 		do
 			bisect_write "$state" "$rev"
 		done
-		check_expected_revs $hash_list ;;
+		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
 		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
 	*)
-- 
2.8.3
