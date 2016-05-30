From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [RFC/PATCH] bisect--helper: `bisect_clean_state` shell function in C
Date: Mon, 30 May 2016 23:51:48 +0530
Message-ID: <20160530182148.18801-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	mhagger@alum.mit.edu, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 20:22:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Rpg-0005eq-5r
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161746AbcE3SW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:22:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36605 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161631AbcE3SW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:22:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id 62so10413690pfd.3
        for <git@vger.kernel.org>; Mon, 30 May 2016 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=exoEyR6aovJMY1itGKy5irRWc2c0WezOPenNbZSgMB8=;
        b=uw1z/a1jLvA4Rd8i3G1Om/rRwjm97MZZ67jtaYJ9z+V01jJtuJT/chUUTMJcQmzw3L
         eGiZqtw5YTDC2cInAuqJkTfEY4qC8ceo7aHLQEmOJEKUkYxervWvM3bhySHZUv5vuUfI
         kexayQi37FTDxilnQETOs8YI+Xui374IuvJU4ABKcr28A3faaRPL+4j3QxIlv3tu996R
         Z/XEp/8F1Gp/zgqk+a0esTPd8bD4iiRE+rt+SH1JtolVyYZspA7xRszckdZ9Do9av76+
         KlT+pa4sJa1J4j3Q8gMEbMkvUVL1uHeXHuZizzNBBOZjAGANbNpQ/UmFX38C8C+MRtHk
         X5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=exoEyR6aovJMY1itGKy5irRWc2c0WezOPenNbZSgMB8=;
        b=mqEAB8QkacmQiOVThHgpNi5LtqPPxr+3/acij3K3x+PWbJOmllJUgy34H/daAP1Wg9
         g1j+18QioJeNqJd+H3BI/BCrjAfckq3svdnQbEMyXdVzA1dszCb6m6J/+ScLjZMO7sw4
         Nm2kWKSbzNnUo2oQjUhzxhkOGWOCdI6T0ihLOdEWgqlQy4i4eL/sqsgcA5i+GtShkfKY
         9Qg4i7NmL4DjDKGkDuVYD3pNzpqrwvga6DT15B3bbJaov4UgO2CN+pfNs+kLXvcrxwfW
         XNGAA87ngC25FWPB5/uiyuWYW38LjQcL1gk9uhpbQBkpe4sgFJh1zdYLN6iT0ab4e9cs
         7YSQ==
X-Gm-Message-State: ALyK8tKN9PhXKzbp4FuqPWf3RX9S3isgcyofy+W8yJgp42VXg56W6hpY2DvRkXXwGTkZiQ==
X-Received: by 10.98.102.205 with SMTP id s74mr45970978pfj.54.1464632545556;
        Mon, 30 May 2016 11:22:25 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id hw10sm49116666pac.15.2016.05.30.11.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 May 2016 11:22:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295917>

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
This patch contains a bug. I have tried to identify the bug and I suppose it
exists in do_for_each_entry_in_dir(). I have reproduced the debugging session
at this link[1]. I have seen that some patches in mailing list regarding
iterating over refs. Will those affect this? Or is this bug fixed in those
patches?

[1]: http://paste.ubuntu.com/16830752/

 builtin/bisect--helper.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 26 +++----------------------
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2b21c02..a20c9a5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,10 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
+
+static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
+static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
+	N_("git bisect--helper --bisect-clean-state"),
 	NULL
 };
 
@@ -79,11 +90,42 @@ int write_terms(const char *bad, const char *good)
 	strbuf_release(&content);
 	return (res < 0) ? -1 : 0;
 }
+
+int remove_bisect_ref(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
+{
+	char *ref;
+	ref = xstrfmt("refs/bisect/%s", refname);
+	if (delete_ref(ref, oid->hash, flag))
+		return error(_("couldn't delete the ref %s\n"), ref);
+	return 0;
+}
+
+int bisect_clean_state(void)
+{
+	for_each_ref_in("refs/bisect/", remove_bisect_ref, NULL);
+
+	remove_path(git_path_bisect_expected_rev());
+	remove_path(git_path_bisect_ancestors_ok());
+	remove_path(git_path_bisect_log());
+	remove_path(git_path_bisect_names());
+	remove_path(git_path_bisect_run());
+	remove_path(git_path_bisect_terms());
+	/* Cleanup head-name if it got left by an old version of git-bisect */
+	remove_path(git_path_head_name());
+	delete_ref("BISECT_HEAD", NULL, 0);
+	/* Cleanup BISECT_START last */
+	remove_path(git_path_bisect_start());
+
+	return 0;
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
@@ -91,6 +133,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
+			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -109,6 +153,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index 2dd7ec5..a937d1c 100755
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
