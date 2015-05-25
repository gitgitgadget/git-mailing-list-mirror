From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 24/56] fsck: change functions to use object_id
Date: Mon, 25 May 2015 18:38:50 +0000
Message-ID: <1432579162-411464-25-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJk-0001Zq-Je
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbEYSk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50663 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbbEYSkR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C9F492809B;
	Mon, 25 May 2015 18:40:15 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269882>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 48d0c2e..4e8e2ee 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -25,7 +25,7 @@ static int include_reflogs = 1;
 static int check_full = 1;
 static int check_strict;
 static int keep_cache_objects;
-static unsigned char head_sha1[20];
+static struct object_id head_oid;
 static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
@@ -476,19 +476,21 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
+			      int flag, void *cb_data)
 {
 	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
 	return 0;
 }
 
-static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_ref(const char *refname, const struct object_id *oid,
+			   int flag, void *cb_data)
 {
 	struct object *obj;
 
-	obj = parse_object(sha1);
+	obj = parse_object(oid->hash);
 	if (!obj) {
-		error("%s: invalid sha1 pointer %s", refname, sha1_to_hex(sha1));
+		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
 		return 0;
@@ -504,16 +506,11 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 
 static void get_default_heads(void)
 {
-	struct each_ref_fn_sha1_adapter wrapped_fsck_handle_ref =
-		{fsck_handle_ref, NULL};
-	struct each_ref_fn_sha1_adapter wrapped_fsck_handle_reflog =
-		{fsck_handle_reflog, NULL};
-
-	if (head_points_at && !is_null_sha1(head_sha1))
-		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
-	for_each_rawref(each_ref_fn_adapter, &wrapped_fsck_handle_ref);
+	if (head_points_at && !is_null_oid(&head_oid))
+		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
+	for_each_rawref(fsck_handle_ref, NULL);
 	if (include_reflogs)
-		for_each_reflog(each_ref_fn_adapter, &wrapped_fsck_handle_reflog);
+		for_each_reflog(fsck_handle_reflog, NULL);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -561,7 +558,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, head_sha1, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
@@ -570,7 +567,7 @@ static int fsck_head_link(void)
 	else if (!starts_with(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
-	if (is_null_sha1(head_sha1)) {
+	if (is_null_oid(&head_oid)) {
 		if (null_is_error)
 			return error("HEAD: detached HEAD points at nothing");
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-- 
2.4.0
