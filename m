From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 52/56] rev_list_insert_ref_oid(): new function, taking an object_oid
Date: Mon, 25 May 2015 18:39:18 +0000
Message-ID: <1432579162-411464-53-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJV-0001Qj-1R
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbbEYSlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50770 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504AbbEYSkf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3339F2809A;
	Mon, 25 May 2015 18:40:34 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269872>

From: Michael Haggerty <mhagger@alum.mit.edu>

This function can be used with for_each_ref() without having to be
wrapped.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 13a5000..28c54c3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -70,6 +70,12 @@ static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, i
 	return 0;
 }
 
+static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
+				   int flag, void *cb_data)
+{
+	return rev_list_insert_ref(refname, oid->hash, flag, cb_data);
+}
+
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
@@ -257,8 +263,6 @@ static int find_common(struct fetch_pack_args *args,
 	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
-	struct each_ref_fn_sha1_adapter wrapped_rev_list_insert_ref =
-		{rev_list_insert_ref, NULL};
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die("--stateless-rpc requires multi_ack_detailed");
@@ -266,7 +270,7 @@ static int find_common(struct fetch_pack_args *args,
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_rev_list_insert_ref);
+	for_each_ref(rev_list_insert_ref_oid, NULL);
 	for_each_alternate_ref(insert_one_alternate_ref, NULL);
 
 	fetching = 0;
-- 
2.4.0
