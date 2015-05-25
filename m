From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 36/56] register_replace_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:02 +0000
Message-ID: <1432579162-411464-37-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJy-0001g0-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbbEYSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50709 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184AbbEYSkY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0CC00280A0;
	Mon, 25 May 2015 18:40:23 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269885>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 replace_object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index a8a2da9..f0b39f0 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -53,7 +53,7 @@ static int register_replace_object(struct replace_object *replace,
 }
 
 static int register_replace_ref(const char *refname,
-				const unsigned char *sha1,
+				const struct object_id *oid,
 				int flag, void *cb_data)
 {
 	/* Get sha1 from refname */
@@ -68,7 +68,7 @@ static int register_replace_ref(const char *refname,
 	}
 
 	/* Copy sha1 from the read ref */
-	hashcpy(repl_obj->replacement, sha1);
+	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
 	if (register_replace_object(repl_obj, 1))
@@ -80,13 +80,11 @@ static int register_replace_ref(const char *refname,
 static void prepare_replace_object(void)
 {
 	static int replace_object_prepared;
-	struct each_ref_fn_sha1_adapter wrapped_register_replace_ref =
-		{register_replace_ref, NULL};
 
 	if (replace_object_prepared)
 		return;
 
-	for_each_replace_ref(each_ref_fn_adapter, &wrapped_register_replace_ref);
+	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
 	if (!replace_object_nr)
 		check_replace_refs = 0;
-- 
2.4.0
