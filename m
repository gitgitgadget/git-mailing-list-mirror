From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 18/56] show_reference(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:44 +0000
Message-ID: <1432579162-411464-19-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKZ-0001xX-4O
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbbEYSm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50642 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359AbbEYSkN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6FA502809A;
	Mon, 25 May 2015 18:40:12 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269896>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/replace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index bcf1508..0d52e7f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -35,7 +35,7 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname, const unsigned char *sha1,
+static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data = cb_data;
@@ -44,19 +44,19 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
-			printf("%s -> %s\n", refname, sha1_to_hex(sha1));
+			printf("%s -> %s\n", refname, oid_to_hex(oid));
 		else { /* data->format == REPLACE_FORMAT_LONG */
-			unsigned char object[20];
+			struct object_id object;
 			enum object_type obj_type, repl_type;
 
-			if (get_sha1(refname, object))
+			if (get_sha1(refname, object.hash))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = sha1_object_info(object, NULL);
-			repl_type = sha1_object_info(sha1, NULL);
+			obj_type = sha1_object_info(object.hash, NULL);
+			repl_type = sha1_object_info(oid->hash, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
-			       sha1_to_hex(sha1), typename(repl_type));
+			       oid_to_hex(oid), typename(repl_type));
 		}
 	}
 
@@ -66,8 +66,6 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 static int list_replace_refs(const char *pattern, const char *format)
 {
 	struct show_data data;
-	struct each_ref_fn_sha1_adapter wrapped_show_reference =
-		{show_reference, (void *) &data};
 
 	if (pattern == NULL)
 		pattern = "*";
@@ -84,7 +82,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    "valid formats are 'short', 'medium' and 'long'\n",
 		    format);
 
-	for_each_replace_ref(each_ref_fn_adapter, &wrapped_show_reference);
+	for_each_replace_ref(show_reference, (void *)&data);
 
 	return 0;
 }
-- 
2.4.0
