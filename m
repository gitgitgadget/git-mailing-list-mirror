From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 49/56] clear_marks(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:15 +0000
Message-ID: <1432579162-411464-50-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJb-0001Ul-RF
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbbEYSl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50758 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751500AbbEYSkd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BF8E8280A0;
	Mon, 25 May 2015 18:40:32 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269879>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 5380b1b..1e875cf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -70,9 +70,10 @@ static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, i
 	return 0;
 }
 
-static int clear_marks(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int clear_marks(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(sha1), refname, 0);
+	struct object *o = deref_tag(parse_object(oid->hash), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -261,12 +262,8 @@ static int find_common(struct fetch_pack_args *args,
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die("--stateless-rpc requires multi_ack_detailed");
-	if (marked) {
-		struct each_ref_fn_sha1_adapter wrapped_clear_marks =
-			{clear_marks, NULL};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_clear_marks);
-	}
+	if (marked)
+		for_each_ref(clear_marks, NULL);
 	marked = 1;
 
 	for_each_ref(each_ref_fn_adapter, &wrapped_rev_list_insert_ref);
-- 
2.4.0
