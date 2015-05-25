From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 13/56] show_ref_cb(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:39 +0000
Message-ID: <1432579162-411464-14-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIZ-0000s9-FU
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbbEYSkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:20 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbbEYSkK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A6D728097;
	Mon, 25 May 2015 18:40:10 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269853>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 12ecacd..94d0571 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -197,7 +197,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	}
 }
 
-static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *unused)
+static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
 {
 	path = strip_namespace(path);
 	/*
@@ -210,7 +210,7 @@ static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, vo
 	 */
 	if (!path)
 		path = ".have";
-	show_ref(path, sha1);
+	show_ref(path, oid->hash);
 	return 0;
 }
 
@@ -228,13 +228,11 @@ static void collect_one_alternate_ref(const struct ref *ref, void *data)
 static void write_head_info(void)
 {
 	struct sha1_array sa = SHA1_ARRAY_INIT;
-	struct each_ref_fn_sha1_adapter wrapped_show_ref_cb =
-		{show_ref_cb, NULL};
 
 	for_each_alternate_ref(collect_one_alternate_ref, &sa);
 	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
 	sha1_array_clear(&sa);
-	for_each_ref(each_ref_fn_adapter, &wrapped_show_ref_cb);
+	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
 
-- 
2.4.0
