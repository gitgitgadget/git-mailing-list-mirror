From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/5] bisect: introduce support for --no-checkout=<ref> option.
Date: Sat, 30 Jul 2011 18:28:28 +1000
Message-ID: <1312014511-7157-3-git-send-email-jon.seymour@gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:29:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4ut-0002JC-C6
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab1G3I2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:28:55 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36729 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab1G3I2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so7731148pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Wv0v8rT/Pf1Pg0Mfvmh3RqFuIySJSTPWMbcIvKg7Fdc=;
        b=c6pOEL/5xLYZOgUbVZ/ectgXf4MkMT6YAh2RaW+t3RpEBRHfRyEaTnxvc08cI6uU8R
         R+0QyCrPak7IO/0CH6DNyUg+NE4/3Gdb/OWIVOFITtqsaxNi1QvDKFkxLRP5SFxf/Oqm
         RzA82ooXLiGmWvhrf35rjlxNy0Fu8yXb8KZhE=
Received: by 10.68.19.193 with SMTP id h1mr3900700pbe.419.1312014529499;
        Sat, 30 Jul 2011 01:28:49 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178183>

If --no-checkout=<ref> is specified, then the bisection process uses

	git update-ref --no-deref <ref> <trial>

at each trial instead of:

	git checkout <trial>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |   26 ++++++++++++++++++++++----
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    7 +++++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..e6c99a0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,8 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", NULL, NULL, NULL};
+static const char *cursor_ref = 0;
 
 /* bits #0-15 in revision.h */
 
@@ -714,9 +716,19 @@ static int bisect_checkout(char *bisect_rev_hex)
 	mark_expected_rev(bisect_rev_hex);
 
 	argv_checkout[2] = bisect_rev_hex;
-	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
-	if (res)
-		exit(res);
+	if (!cursor_ref) {
+	  res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+	  if (res) {
+	    exit(res);
+	  }
+	} else {
+	    argv_update_ref[2] = cursor_ref;
+	    argv_update_ref[3] = bisect_rev_hex;
+	    res = run_command_v_opt(argv_update_ref, RUN_GIT_CMD);
+	    if (res) {
+	      die("update-ref --no-deref %s failed on %s", cursor_ref, bisect_rev_hex);
+	    }
+	}
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
@@ -908,8 +920,12 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
+ *
+ * If cursor_ref_param is not null, the bisection process does not
+ * checkout the trial commit but instead simply updates the specified
+ * cursor reference.
  */
-int bisect_next_all(const char *prefix)
+int bisect_next_all(const char *prefix, const char *cursor_ref_param)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -917,6 +933,8 @@ int bisect_next_all(const char *prefix)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[41];
 
+	cursor_ref = cursor_ref_param;
+
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
diff --git a/bisect.h b/bisect.h
index 0862ce5..4fd4565 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,7 +27,7 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix);
+extern int bisect_next_all(const char *prefix, const char *no_checkout);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5b22639..b3d9263 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,16 +4,19 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all",
+	"git bisect--helper --next-all [ --no-checkout=<ref> ]",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
+	char * no_checkout = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
+		OPT_STRING(0, "no-checkout", &no_checkout, "ref",
+			    "don't checkout but update <ref> instead."),
 		OPT_END()
 	};
 
@@ -24,5 +27,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, no_checkout);
 }
-- 
1.7.6.387.g991c2
