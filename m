From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 5/6] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
Date: Wed, 15 Jun 2016 19:30:25 +0530
Message-ID: <20160615140026.10519-6-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:02:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBOc-00076p-9k
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbcFOOCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 10:02:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32823 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161083AbcFOOCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:02:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so1878066pfb.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jupQ/v+Am5t1CRcxnVYqO1D+E0NKIREURYIz8EnYweY=;
        b=J5YM+dl4VG7a1pvKLKmrcqX0ulzMl5zjfJ4zLm18O9qAzISc5NqoMkqIdnJt2uv37s
         PK8W0XVCl5KT5qAjZzxjGNcO6+z10AD7CGw1h5tpqMCPtk0D83y6BKzEUwiZvBYsCwg2
         PN5Rq+EKoqM76FqlQu3PcOci7FN0nsU4Wo9BNgQmNyr/QECwBvSp5OAPaScXFzSvVTrz
         XVKhiq+ys7OAes84tE0U00a/25j2JGDM8jgrk6lzi33w81UIzmYKEZHYveEqh0Dbktjd
         AvOCm94nNKBspPqSRxnvAl3K+MN0Eacfm/xmLwIx3nXB2C7JVCYH9ngPG2dx30YYLDRq
         bcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jupQ/v+Am5t1CRcxnVYqO1D+E0NKIREURYIz8EnYweY=;
        b=HCxQAhTIJeqGWif/FDM1HiCniCl4qw6Qlaj0UdJaIZbecoViqgiOH/Wq1D6H1ryRRp
         JqSTJRpdaJhac/KeDbtPxpS/MBCBwwkZooiyTtqk8jBoaq9PbsZCbj36yobM29N5UbSX
         RAazyC5W2TPtTBodP42eijLtDcMwp7CN4VlZdr20STrWHwyup//A/HHbP27yNch5jAZJ
         Xvh14z2WLBd7VMl3z7Kihb1mcl9pbL0okPApkPddJozp178w0NXZpdX4mrg80YZxv7s0
         bn/2tP6Iwc1hHVbTSENXBZI15wI3vjQyQi1cPZADPwbQvk7KpA5vI/25O0rj3bJsrWcv
         ArdA==
X-Gm-Message-State: ALyK8tJCqJ1O0kWufF9NPlyeU0xm0D+pGR1jMqM5zbP1/pUwTNVwusuiIp08hypPY7NYNA==
X-Received: by 10.98.6.193 with SMTP id 184mr4170327pfg.109.1465999328314;
        Wed, 15 Jun 2016 07:02:08 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:02:07 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297376>

Reimplement `is_expected_rev` & `check_expected_revs` shell function in
C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
call it from git-bisect.sh .

Using `--check-expected-revs` subcommand is a temporary measure to port
shell functions to C so as to use the existing test suite. As more
functions are ported, this subcommand would be retired and will be
called by some other method.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 20 ++------------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 14043a8..f11c247 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static int is_expected_rev(const char *expected_hex)
+{
+	struct strbuf actual_hex = STRBUF_INIT;
+	int res;
+
+	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
+		strbuf_release(&actual_hex);
+		return 0;
+	}
+
+	strbuf_trim(&actual_hex);
+	res = !strcmp(actual_hex.buf, expected_hex);
+	strbuf_release(&actual_hex);
+	return res;
+}
+
+static int check_expected_revs(const char **revs, int rev_nr)
+{
+	int i;
+
+	for (i = 0; i < rev_nr; i++) {
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
@@ -180,6 +211,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
+			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -206,6 +239,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
2.9.0
