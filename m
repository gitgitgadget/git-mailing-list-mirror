From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 1/6] bisect--helper: `bisect_clean_state` shell function in C
Date: Wed, 15 Jun 2016 19:30:21 +0530
Message-ID: <20160615140026.10519-2-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:01:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBOA-0006q9-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbcFOOBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 10:01:44 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34882 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbcFOOBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:01:43 -0400
Received: by mail-pa0-f67.google.com with SMTP id hf6so1637890pac.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6KVntUjD4Vg/Z99+p5lwbj4hcY1u58Ns+olyEEZ6BWs=;
        b=Z26X8NEMisYDGeZ8B9osfLqj+6jtGGtwsHKgTKCol60xaWZkOvEwm5x9uJRLc1x7Ci
         wUBRgmfUZj1HxRI2nZiCv/izmw6cpIaWQ2tNvIS8CyZ6aZ145gx0L9b34x0XaZ/+3kvy
         wgngzJv1yGK6zn0Zaqx2DwY0G59nVi7mkp3NA7RBudOIssvHxq7RCsjbh0RPMwthSyxh
         Y16Obn3OJUex5myhKQ9WXQIT4qvm8IH/y1cocfllABHdWt3eR3lZJcN3iPJ9OemxUX2w
         5psFOUG7tCpqoZKPqyjfC1YeLtjCUFeLNLB69OVeh8bhhSUIAgfYzds4Fo3jh0p8Oyyu
         lVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6KVntUjD4Vg/Z99+p5lwbj4hcY1u58Ns+olyEEZ6BWs=;
        b=UJRv6pHNshX9e7y+ZX+1atRd1zDbt/QYViJ5g66wD3CvtddmhSD+6t13zgdyUSUUfh
         inkw8V6+aaSClxl9NbEwuRkh4wCmlMH8ABCHEL+uB5VOU/uHmxAbnslfjG17YDP101V+
         pPEFOY2HxeZI1raTmrBQGKGCRNGVJNJKvR7K72itwN1aSXni/1Ol5f25mIBYtzx4YXeI
         eOe43dXdRmk1myDvy3mOb6VpiemFdpx8Z4kx8Qx3MxUJmyU9ZbaHKxxF3xAo7ClpI3RG
         nAGIgkA8FFmChtsapopePbSw7xjN0cdAYSV9Nj9XSJvvW/WGziWBTe0CIVbeQoR8szct
         PEPA==
X-Gm-Message-State: ALyK8tLljOTsCrwVdWLgGOGX46fR4meVBZyfCMu5Snp3sQiK+xZdUM4RVskYFPmoFFyz4g==
X-Received: by 10.66.245.111 with SMTP id xn15mr4147121pac.76.1465999302550;
        Wed, 15 Jun 2016 07:01:42 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:01:41 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297373>

Reimplement `bisect_clean_state` shell function in C and add a
`bisect-clean-state` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-clean-state` subcommand is a measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by
bisect_reset() and bisect_start().

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 26 +++--------------------
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 91027b0..3e4a458 100644
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
 
@@ -78,11 +87,48 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
+static int mark_for_removal(const char *refname, const struct object_id *oid,
+			    int flag, void *cb_data)
+{
+	struct string_list *refs = cb_data;
+	char *ref = xstrfmt("refs/bisect/%s", refname);
+	string_list_append(refs, ref);
+	return 0;
+}
+
+static int bisect_clean_state(void)
+{
+	int result = 0;
+
+	/* There may be some refs packed during bisection */
+	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
+	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
+	result = delete_refs(&refs_for_removal);
+	string_list_clear(&refs_for_removal, 0);
+	remove_path(git_path_bisect_expected_rev());
+	remove_path(git_path_bisect_ancestors_ok());
+	remove_path(git_path_bisect_log());
+	remove_path(git_path_bisect_names());
+	remove_path(git_path_bisect_run());
+	remove_path(git_path_bisect_write_terms());
+	/* Cleanup head-name if it got left by an old version of git-bisect */
+	remove_path(git_path_head_name());
+	/*
+	 * Cleanup BISECT_START last to support the --no-checkout option
+	 * introduced in the commit 4796e823a.
+	 */
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
@@ -90,6 +136,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
+			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -108,6 +156,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
2.9.0
