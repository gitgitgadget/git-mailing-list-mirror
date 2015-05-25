From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 39/56] handle_one_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:05 +0000
Message-ID: <1432579162-411464-40-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJr-0001dP-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbbEYSlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50720 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbbEYSk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B3B6A28093;
	Mon, 25 May 2015 18:40:24 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269884>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 1aad0a322..1cb8108 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -831,11 +831,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 /* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
 
-static int handle_one_ref(const char *path,
-		const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_ref(const char *path, const struct object_id *oid,
+			  int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
-	struct object *object = parse_object(sha1);
+	struct object *object = parse_object(oid->hash);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
@@ -1371,10 +1371,8 @@ static int get_sha1_with_context_1(const char *name,
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
 			struct commit_list *list = NULL;
-			struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
-				{handle_one_ref, &list};
 
-			for_each_ref(each_ref_fn_adapter, &wrapped_handle_one_ref);
+			for_each_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
 			return get_sha1_oneline(name + 2, sha1, list);
 		}
-- 
2.4.0
