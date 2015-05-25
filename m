From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 11/56] name_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:37 +0000
Message-ID: <1432579162-411464-12-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKo-00025X-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbbEYSmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50596 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751291AbbEYSkK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3FACF2809C;
	Mon, 25 May 2015 18:40:09 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269902>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/name-rev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 41bdf0a..248a3eb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -138,9 +138,9 @@ static int tipcmp(const void *a_, const void *b_)
 	return hashcmp(a->sha1, b->sha1);
 }
 
-static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
+static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -160,7 +160,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		}
 	}
 
-	add_to_tip_table(sha1, path, can_abbreviate_output);
+	add_to_tip_table(oid->hash, path, can_abbreviate_output);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
@@ -305,8 +305,6 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, NULL };
-	struct each_ref_fn_sha1_adapter wrapped_name_ref =
-		{name_ref, &data};
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -379,7 +377,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff)
 		cutoff = cutoff - CUTOFF_DATE_SLOP;
-	for_each_ref(each_ref_fn_adapter, &wrapped_name_ref);
+	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
 		char buffer[2048];
-- 
2.4.0
