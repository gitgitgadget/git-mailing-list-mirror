From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 1/9] Remove deprecated OPTION_BOOLEAN for parsing arguments
Date: Sat,  3 Aug 2013 13:51:18 +0200
Message-ID: <1375530686-2309-2-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aNM-0006I5-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab3HCLvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:10 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:38689 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab3HCLvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:03 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so766511eek.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AgjUxq/yk5i2QtrIlpEIPmg9NIO9Z9So5vGoFSyCh3I=;
        b=jVWIZ9ffT8Pzjm1uaDhsU+bWIa+Tu5RYCGBcyb+Td1s4WpXEx8LE6EEN/FBs8USUfA
         FaawvXHUbhOVVuPVojEqEJK2RJtLVM9IN5AE+z3BevT+o4Je2iAh6aJwjVBaUyVJXbJ9
         cO5/RQf1kfilvVNGr35MQXWOfibS8qJZNRe0HyLwENiDcMwBexH9CMoW3RhYg8bmr4cO
         MJF6DB37yf+7JQHDw9p/ppBAOln+Hhg1S/L92UAP+INdalMlVIxMtEp7257nhc2Pq9DP
         3ZqlKmI7ksHzsOzUyhBHSQ7Qbxz7leKvjyqElrtj9Kldf8l36w1xN281xihuTAvIHHxS
         TrXA==
X-Received: by 10.14.95.135 with SMTP id p7mr9375645eef.16.1375530661883;
        Sat, 03 Aug 2013 04:51:01 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id t6sm9452093eel.12.2013.08.03.04.51.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231589>

As of b04ba2bb4 OPTION_BOOLEAN was deprecated.
This commit removes all occurrences of OPTION_BOOLEAN.
In b04ba2bb4 Junio suggested to replace it with either
OPTION_SET_INT or OPTION_COUNTUP instead. However a pattern, which
occurred often with the OPTION_BOOLEAN was a hidden boolean parameter.
So I defined OPT_HIDDEN_BOOL as an additional possible parse option
in parse-options.h to make life easy.

The OPT_HIDDEN_BOOL was used in checkout, clone, commit, show-ref.
The only exception, where there was need to fiddle with OPTION_SET_INT
was log and notes. However in these two files there is also a pattern,
so we could think of introducing OPT_NONEG_BOOL.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/checkout.c |  5 ++---
 builtin/clone.c    |  7 +++----
 builtin/commit.c   | 10 ++++------
 builtin/log.c      |  4 ++--
 builtin/notes.c    |  8 ++++----
 builtin/show-ref.c |  5 ++---
 parse-options.h    |  5 ++---
 7 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7025938..646a475 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1073,9 +1073,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
-		  N_("second guess 'git checkout no-such-branch'"),
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
+				N_("second guess 'git checkout no-such-branch'")),
 		OPT_END(),
 	};
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 430307b..e7b0b13 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -64,10 +64,9 @@ static struct option builtin_clone_options[] = {
 		 N_("force progress reporting")),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    N_("don't create a checkout")),
-	OPT_BOOLEAN(0, "bare", &option_bare, N_("create a bare repository")),
-	{ OPTION_BOOLEAN, 0, "naked", &option_bare, NULL,
-		N_("create a bare repository"),
-		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
+	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
+			N_("create a bare repository")),
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
 		    N_("create a mirror repository (implies bare)")),
 	OPT_BOOL('l', "local", &option_local,
diff --git a/builtin/commit.c b/builtin/commit.c
index 003bd7d..b64a083 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1448,12 +1448,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
-		{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
-		  N_("ok to record an empty change"),
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-		{ OPTION_BOOLEAN, 0, "allow-empty-message", &allow_empty_message, NULL,
-		  N_("ok to record a change with an empty message"),
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
+				N_("ok to record an empty change")),
+		OPT_HIDDEN_BOOL(0, "allow-empty-message", &allow_empty_message,
+				N_("ok to record a change with an empty message")),
 
 		OPT_END()
 	};
diff --git a/builtin/log.c b/builtin/log.c
index 2625f98..05e374d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1183,9 +1183,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("don't output binary diffs")),
 		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			    N_("don't include a patch matching a commit upstream")),
-		{ OPTION_BOOLEAN, 'p', "no-stat", &use_patch_format, NULL,
+		{ OPTION_SET_INT, 'p', "no-stat", &use_patch_format, NULL,
 		  N_("show patch format instead of default (patch + stat)"),
-		  PARSE_OPT_NONEG | PARSE_OPT_NOARG },
+		  PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1},
 		OPT_GROUP(N_("Messaging")),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, N_("header"),
 			    N_("add email header"), 0, header_callback },
diff --git a/builtin/notes.c b/builtin/notes.c
index e4100c4..8f63cb2 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -739,13 +739,13 @@ static int merge(int argc, const char **argv, const char *prefix)
 			   N_("resolve notes conflicts using the given strategy "
 			      "(manual/ours/theirs/union/cat_sort_uniq)")),
 		OPT_GROUP(N_("Committing unmerged notes")),
-		{ OPTION_BOOLEAN, 0, "commit", &do_commit, NULL,
+		{ OPTION_SET_INT, 0, "commit", &do_commit, NULL,
 			N_("finalize notes merge by committing unmerged notes"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
 		OPT_GROUP(N_("Aborting notes merge resolution")),
-		{ OPTION_BOOLEAN, 0, "abort", &do_abort, NULL,
+		{ OPTION_SET_INT, 0, "abort", &do_abort, NULL,
 			N_("abort notes merge"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
 		OPT_END()
 	};
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 87806ad..18680bb 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -169,9 +169,8 @@ static const struct option show_ref_options[] = {
 	OPT_BOOLEAN(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
 	OPT_BOOLEAN(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
-	{ OPTION_BOOLEAN, 'h', NULL, &show_head, NULL,
-	  N_("show the HEAD reference, even if it would be filtered out"),
-	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+	OPT_HIDDEN_BOOL('h', NULL, &show_head,
+			N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOLEAN(0, "head", &show_head,
 	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOLEAN('d', "dereference", &deref_tags,
diff --git a/parse-options.h b/parse-options.h
index 2404e06..aeab9aa 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,9 +22,6 @@ enum parse_opt_type {
 	OPTION_FILENAME
 };
 
-/* Deprecated synonym */
-#define OPTION_BOOLEAN OPTION_COUNTUP
-
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
@@ -129,6 +126,8 @@ struct option {
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
-- 
1.8.4.rc0.16.g7fca822.dirty
