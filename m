From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 07/14] pull: check if in unresolved merge state
Date: Mon, 18 May 2015 23:06:04 +0800
Message-ID: <1431961571-20370-8-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMe8-0004Uz-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbbERPHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34727 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbbERPHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:49 -0400
Received: by pabru16 with SMTP id ru16so155830445pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eEn+cK95kRi+OKmScn7Ply3zVpwiaN4nZphrvQuCgZQ=;
        b=BNRmszqqLQnUxRZ3dgdaVLw8NcCKjIPNbTg+43V2fHfRswyQuPVFotUW7XnlX7WIfs
         5Tv/+dAasWH+sTVzH5W/tpF0YOUdwzZ7EGTNrw5059UgUK+1QQGKL5jFBJ7uoyVN7Iop
         g0/xR3SsRWUmkPGoNIBOoJ1LfXCea6n6rnoax8LcNtQfvStribt4JpbXI1mLiSzfHXMJ
         oX2OvaDj3BUfHRENoT+v68AZiUeMi6nHYUJElAZsYAQ/Ua6kIqAhmAIk4ue4t6F/15HA
         FUcnlGFwBJr+fAFqLaMmzYvXPe9mvl9DupYfyeEcZRbZdwqWqycN/EobusQBRUJDrN+7
         Svnw==
X-Received: by 10.70.103.200 with SMTP id fy8mr44493646pdb.136.1431961668535;
        Mon, 18 May 2015 08:07:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269266>

Since, commit d38a30d (Be more user-friendly when refusing to do
something because of conflict., 2010-01-12), git-pull will error out
with user-friendly advices if the user is in the middle of a merge or
has unmerged files.

Re-implement this behavior. While the "has unmerged files" case can be
handled by die_resolve_conflict(), we introduce a new function
die_conclude_merge() for printing a different error message for when
there are no unmerged files but the merge has not been finished.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 advice.c        | 8 ++++++++
 advice.h        | 1 +
 builtin/pull.c  | 9 +++++++++
 t/t5520-pull.sh | 2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 575bec2..4965686 100644
--- a/advice.c
+++ b/advice.c
@@ -96,6 +96,14 @@ void NORETURN die_resolve_conflict(const char *me)
 	die("Exiting because of an unresolved conflict.");
 }
 
+void NORETURN die_conclude_merge(void)
+{
+	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
+	if (advice_resolve_conflict)
+		advise(_("Please, commit your changes before you can merge."));
+	die(_("Exiting because of unfinished merge."));
+}
+
 void detach_advice(const char *new_name)
 {
 	const char fmt[] =
diff --git a/advice.h b/advice.h
index 5ecc6c1..b341a55 100644
--- a/advice.h
+++ b/advice.h
@@ -24,6 +24,7 @@ __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
+void NORETURN die_conclude_merge(void);
 void detach_advice(const char *new_name);
 
 #endif /* ADVICE_H */
diff --git a/builtin/pull.c b/builtin/pull.c
index b305a47..9b06dfa 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sha1-array.h"
 #include "remote.h"
+#include "dir.h"
 
 /**
  * Given an option opt, where opt->value points to a char* and opt->defval is a
@@ -471,6 +472,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	git_config(git_default_config, NULL);
+
+	if (read_cache_unmerged())
+		die_resolve_conflict("Pull");
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		die_conclude_merge();
+
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0ff5df3..4c52175 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -171,7 +171,7 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test "$(cat file)" = file
 '
 
-test_expect_failure 'fail if the index has unresolved entries' '
+test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
-- 
2.1.4
