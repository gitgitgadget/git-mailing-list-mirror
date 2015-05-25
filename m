From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 08/56] get_name(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:34 +0000
Message-ID: <1432579162-411464-9-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKw-0002Ab-Po
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbEYSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:10 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50609 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbbEYSkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D296228099;
	Mon, 25 May 2015 18:40:07 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269903>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rewrite to take an object_id argument and convert the local variable
"peeled" object_id.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/describe.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7d0c855..a36c829 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -119,10 +119,10 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	int is_tag = starts_with(path, "refs/tags/");
-	unsigned char peeled[20];
+	struct object_id peeled;
 	int is_annotated, prio;
 
 	/* Reject anything outside refs/tags/ unless --all */
@@ -134,10 +134,10 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 		return 0;
 
 	/* Is it annotated? */
-	if (!peel_ref(path, peeled)) {
-		is_annotated = !!hashcmp(sha1, peeled);
+	if (!peel_ref(path, peeled.hash)) {
+		is_annotated = !!oidcmp(oid, &peeled);
 	} else {
-		hashcpy(peeled, sha1);
+		oidcpy(&peeled, oid);
 		is_annotated = 0;
 	}
 
@@ -154,7 +154,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	else
 		prio = 0;
 
-	add_to_known_names(all ? path + 5 : path + 10, peeled, prio, sha1);
+	add_to_known_names(all ? path + 5 : path + 10, peeled.hash, prio, oid->hash);
 	return 0;
 }
 
@@ -413,8 +413,6 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
 		OPT_END(),
 	};
-	struct each_ref_fn_sha1_adapter wrapped_get_name =
-		{get_name, NULL};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
@@ -453,7 +451,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	}
 
 	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
-	for_each_rawref(each_ref_fn_adapter, &wrapped_get_name);
+	for_each_rawref(get_name, NULL);
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
-- 
2.4.0
