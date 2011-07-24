From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/9] bisect: introduce a --ignore-checkout-failure option to bisect--helper.
Date: Sun, 24 Jul 2011 15:57:47 +1000
Message-ID: <1311487074-25070-3-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhw-0007mm-FP
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1GXF6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:16 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1GXF6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:12 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=828JC7U5vQ6ldJhMHS+j+Th1/MenZeOLOXvoNJNrI3E=;
        b=PXhX6sNYJOiKwqoG+tyYhfkIJ/TT5Phle2td9AqnzKwuiaohkb6QAm3XQoWSKKrfoM
         Itqlig6CVN16p/mWLPSR9tz5TSyJ6p6tcX17QitDo/wa0o98AWGQlHNwqH5VqsXj4mIc
         hD60/+xC4DP/sQqKm3HAKUuMbpTCc2Z1yQOG4=
Received: by 10.68.47.165 with SMTP id e5mr5065461pbn.471.1311487092322;
        Sat, 23 Jul 2011 22:58:12 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177721>

This commit introduces an option --ignore-checkout-failure which will
allow git-bisect to tolerate checkout failures.

This commit simply parses the option, but does not otherwise process it.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |    5 ++++-
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    8 ++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..ce04092 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static int module_ignore_checkout_failure = 0;
 
 /* bits #0-15 in revision.h */
 
@@ -909,7 +910,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
  */
-int bisect_next_all(const char *prefix)
+int bisect_next_all(const char *prefix, const int ignore_checkout_failure)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -917,6 +918,8 @@ int bisect_next_all(const char *prefix)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[41];
 
+	module_ignore_checkout_failure = ignore_checkout_failure;
+
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
diff --git a/bisect.h b/bisect.h
index 0862ce5..4851310 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,7 +27,7 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix);
+extern int bisect_next_all(const char *prefix, const int ignore_checkout_failure);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5b22639..f531458 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,17 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 
+
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all",
+	"git bisect--helper --next-all [ --ignore-checkout-failure ]",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
+	int ignore_checkout_failure = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
+		OPT_BOOLEAN(0, "ignore-checkout-failure", &ignore_checkout_failure,
+			    "ignore checkout failure"),
 		OPT_END()
 	};
 
@@ -24,5 +28,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, ignore_checkout_failure);
 }
-- 
1.7.6.347.g96e0b.dirty
