From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 04/56] handle_one_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:30 +0000
Message-ID: <1432579162-411464-5-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKQ-0001uq-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbbEYSkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50596 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257AbbEYSkH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1328528095;
	Mon, 25 May 2015 18:40:06 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269894>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 93b23a6..cfe3876 100644
--- a/revision.c
+++ b/revision.c
@@ -1218,7 +1218,8 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 	return 0;
 }
 
-static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_ref(const char *path, const struct object_id *oid,
+			  int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
@@ -1226,9 +1227,9 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	if (ref_excluded(cb->all_revs->ref_excludes, path))
 	    return 0;
 
-	object = get_reference(cb->all_revs, path, sha1, cb->all_flags);
+	object = get_reference(cb->all_revs, path, oid->hash, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
-	add_pending_sha1(cb->all_revs, path, sha1, cb->all_flags);
+	add_pending_sha1(cb->all_revs, path, oid->hash, cb->all_flags);
 	return 0;
 }
 
@@ -1261,11 +1262,8 @@ static void handle_refs(const char *submodule, struct rev_info *revs, unsigned f
 		int (*for_each)(const char *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
-	struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-		{handle_one_ref, &cb};
-
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(submodule, each_ref_fn_adapter, &wrapped_handle_one_ref);
+	for_each(submodule, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
@@ -2126,11 +2124,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
-		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-			{handle_one_ref, &cb};
-
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(each_ref_fn_adapter, optarg, &wrapped_handle_one_ref);
+		for_each_glob_ref(handle_one_ref, optarg, &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
@@ -2138,30 +2133,18 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		return argcount;
 	} else if (starts_with(arg, "--branches=")) {
 		struct all_refs_cb cb;
-		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-			{handle_one_ref, &cb};
-
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(each_ref_fn_adapter, arg + 11, "refs/heads/",
-				     &wrapped_handle_one_ref);
+		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--tags=")) {
 		struct all_refs_cb cb;
-		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-			{handle_one_ref, &cb};
-
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(each_ref_fn_adapter, arg + 7, "refs/tags/",
-				     &wrapped_handle_one_ref);
+		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--remotes=")) {
 		struct all_refs_cb cb;
-		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-			{handle_one_ref, &cb};
-
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(each_ref_fn_adapter, arg + 10, "refs/remotes/",
-				     &wrapped_handle_one_ref);
+		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
-- 
2.4.0
