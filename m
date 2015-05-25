From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 03/56] builtin/rev-parse: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:29 +0000
Message-ID: <1432579162-411464-4-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxL6-0002Fs-0N
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbbEYSmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50592 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255AbbEYSkG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:06 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9718A28094;
	Mon, 25 May 2015 18:40:05 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269905>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rev-parse.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e75ce75..b623239 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -190,17 +190,17 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
-	show_rev(NORMAL, sha1, refname);
+	show_rev(NORMAL, oid->hash, refname);
 	return 0;
 }
 
-static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	show_rev(REVERSED, sha1, refname);
+	show_rev(REVERSED, oid->hash, refname);
 	return 0;
 }
 
@@ -511,10 +511,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const char *name = NULL;
 	struct object_context unused;
-	struct each_ref_fn_sha1_adapter wrapped_show_reference =
-		{show_reference, NULL};
-	struct each_ref_fn_sha1_adapter wrapped_anti_reference =
-		{anti_reference, NULL};
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -656,7 +652,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(each_ref_fn_adapter, &wrapped_show_reference);
+				for_each_ref(show_reference, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--disambiguate=")) {
@@ -664,48 +660,45 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad",
-						each_ref_fn_adapter, &wrapped_show_reference);
-				for_each_ref_in("refs/bisect/good",
-						each_ref_fn_adapter, &wrapped_anti_reference);
+				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
+				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--branches=")) {
-				for_each_glob_ref_in(each_ref_fn_adapter, arg + 11,
-					"refs/heads/", &wrapped_show_reference);
+				for_each_glob_ref_in(show_reference, arg + 11,
+					"refs/heads/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(each_ref_fn_adapter, &wrapped_show_reference);
+				for_each_branch_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--tags=")) {
-				for_each_glob_ref_in(each_ref_fn_adapter, arg + 7,
-					"refs/tags/", &wrapped_show_reference);
+				for_each_glob_ref_in(show_reference, arg + 7,
+					"refs/tags/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(each_ref_fn_adapter, &wrapped_show_reference);
+				for_each_tag_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--glob=")) {
-				for_each_glob_ref(each_ref_fn_adapter, arg + 7,
-						  &wrapped_show_reference);
+				for_each_glob_ref(show_reference, arg + 7, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--remotes=")) {
-				for_each_glob_ref_in(each_ref_fn_adapter, arg + 10,
-					"refs/remotes/", &wrapped_show_reference);
+				for_each_glob_ref_in(show_reference, arg + 10,
+					"refs/remotes/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(each_ref_fn_adapter, &wrapped_show_reference);
+				for_each_remote_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-- 
2.4.0
