From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 27/56] builtin/show-ref: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:53 +0000
Message-ID: <1432579162-411464-28-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKI-0001pW-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbbEYSmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50674 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418AbbEYSkT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:19 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9DC8E2809A;
	Mon, 25 May 2015 18:40:17 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269892>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/tag.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 7d8cd8c..5f6cdc5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -176,7 +176,7 @@ static enum contains_result contains(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
-static void show_tag_lines(const unsigned char *sha1, int lines)
+static void show_tag_lines(const struct object_id *oid, int lines)
 {
 	int i;
 	unsigned long size;
@@ -184,14 +184,14 @@ static void show_tag_lines(const unsigned char *sha1, int lines)
 	char *buf, *sp, *eol;
 	size_t len;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
-		die_errno("unable to read object %s", sha1_to_hex(sha1));
+		die_errno("unable to read object %s", oid_to_hex(oid));
 	if (type != OBJ_COMMIT && type != OBJ_TAG)
 		goto free_return;
 	if (!size)
 		die("an empty %s object %s?",
-		    typename(type), sha1_to_hex(sha1));
+		    typename(type), oid_to_hex(oid));
 
 	/* skip header */
 	sp = strstr(buf, "\n\n");
@@ -215,7 +215,7 @@ free_return:
 	free(buf);
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1,
+static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
@@ -224,14 +224,14 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (filter->with_commit) {
 			struct commit *commit;
 
-			commit = lookup_commit_reference_gently(sha1, 1);
+			commit = lookup_commit_reference_gently(oid->hash, 1);
 			if (!commit)
 				return 0;
 			if (!contains(commit, filter->with_commit))
 				return 0;
 		}
 
-		if (points_at.nr && !match_points_at(refname, sha1))
+		if (points_at.nr && !match_points_at(refname, oid->hash))
 			return 0;
 
 		if (!filter->lines) {
@@ -242,7 +242,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			return 0;
 		}
 		printf("%-15s ", refname);
-		show_tag_lines(sha1, filter->lines);
+		show_tag_lines(oid, filter->lines);
 		putchar('\n');
 	}
 
@@ -260,8 +260,6 @@ static int list_tags(const char **patterns, int lines,
 		     struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;
-	struct each_ref_fn_sha1_adapter wrapped_show_reference =
-		{show_reference, (void *)&filter};
 
 	filter.patterns = patterns;
 	filter.lines = lines;
@@ -270,7 +268,7 @@ static int list_tags(const char **patterns, int lines,
 	memset(&filter.tags, 0, sizeof(filter.tags));
 	filter.tags.strdup_strings = 1;
 
-	for_each_tag_ref(each_ref_fn_adapter, &wrapped_show_reference);
+	for_each_tag_ref(show_reference, (void *)&filter);
 	if (sort) {
 		int i;
 		if ((sort & SORT_MASK) == VERCMP_SORT)
-- 
2.4.0
