From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 25/56] builtin/show-ref: rewrite to use object_id
Date: Mon, 25 May 2015 18:38:51 +0000
Message-ID: <1432579162-411464-26-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIq-00013c-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbbEYSkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50667 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412AbbEYSkR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 870C228099;
	Mon, 25 May 2015 18:40:16 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269859>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-ref.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8e25536..18f84fb 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -17,16 +17,17 @@ static int deref_tags, show_head, tags_only, heads_only, found_match, verify,
 static const char **pattern;
 static const char *exclude_existing_arg;
 
-static void show_one(const char *refname, const unsigned char *sha1)
+static void show_one(const char *refname, const struct object_id *oid)
 {
-	const char *hex = find_unique_abbrev(sha1, abbrev);
+	const char *hex = find_unique_abbrev(oid->hash, abbrev);
 	if (hash_only)
 		printf("%s\n", hex);
 	else
 		printf("%s %s\n", hex, refname);
 }
 
-static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int show_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cbdata)
 {
 	const char *hex;
 	unsigned char peeled[20];
@@ -69,14 +70,14 @@ match:
 	 * detect and return error if the repository is corrupt and
 	 * ref points at a nonexistent object.
 	 */
-	if (!has_sha1_file(sha1))
+	if (!has_sha1_file(oid->hash))
 		die("git show-ref: bad ref %s (%s)", refname,
-		    sha1_to_hex(sha1));
+		    oid_to_hex(oid));
 
 	if (quiet)
 		return 0;
 
-	show_one(refname, sha1);
+	show_one(refname, oid);
 
 	if (!deref_tags)
 		return 0;
@@ -88,7 +89,8 @@ match:
 	return 0;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int add_existing(const char *refname, const struct object_id *oid,
+			int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
@@ -109,10 +111,8 @@ static int exclude_existing(const char *match)
 	static struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
-	struct each_ref_fn_sha1_adapter wrapped_add_existing =
-		{add_existing, &existing_refs};
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
+	for_each_ref(add_existing, &existing_refs);
 	while (fgets(buf, sizeof(buf), stdin)) {
 		char *ref;
 		int len = strlen(buf);
@@ -193,9 +193,6 @@ static const struct option show_ref_options[] = {
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	struct each_ref_fn_sha1_adapter wrapped_show_ref =
-		{show_ref, NULL};
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(show_ref_usage, show_ref_options);
 
@@ -213,12 +210,12 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		if (!pattern)
 			die("--verify requires a reference");
 		while (*pattern) {
-			unsigned char sha1[20];
+			struct object_id oid;
 
 			if (starts_with(*pattern, "refs/") &&
-			    !read_ref(*pattern, sha1)) {
+			    !read_ref(*pattern, oid.hash)) {
 				if (!quiet)
-					show_one(*pattern, sha1);
+					show_one(*pattern, &oid);
 			}
 			else if (!quiet)
 				die("'%s' - not a valid ref", *pattern);
@@ -230,8 +227,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_head)
-		head_ref(each_ref_fn_adapter, &wrapped_show_ref);
-	for_each_ref(each_ref_fn_adapter, &wrapped_show_ref);
+		head_ref(show_ref, NULL);
+	for_each_ref(show_ref, NULL);
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
-- 
2.4.0
