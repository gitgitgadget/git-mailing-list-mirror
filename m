From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 38/56] add_info_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:04 +0000
Message-ID: <1432579162-411464-39-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJA-0001F8-7I
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbEYSkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50695 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452AbbEYSkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 35A872809E;
	Mon, 25 May 2015 18:40:24 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269867>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 server-info.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/server-info.c b/server-info.c
index 317dda8..c82e9ee 100644
--- a/server-info.c
+++ b/server-info.c
@@ -47,14 +47,15 @@ out:
 	return ret;
 }
 
-static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_info_ref(const char *path, const struct object_id *oid,
+			int flag, void *cb_data)
 {
 	FILE *fp = cb_data;
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	if (!o)
 		return -1;
 
-	if (fprintf(fp, "%s	%s\n", sha1_to_hex(sha1), path) < 0)
+	if (fprintf(fp, "%s	%s\n", oid_to_hex(oid), path) < 0)
 		return -1;
 
 	if (o->type == OBJ_TAG) {
@@ -69,10 +70,7 @@ static int add_info_ref(const char *path, const unsigned char *sha1, int flag, v
 
 static int generate_info_refs(FILE *fp)
 {
-	struct each_ref_fn_sha1_adapter wrapped_add_info_ref =
-		{add_info_ref, fp};
-
-	return for_each_ref(each_ref_fn_adapter, &wrapped_add_info_ref);
+	return for_each_ref(add_info_ref, fp);
 }
 
 static int update_info_refs(int force)
-- 
2.4.0
