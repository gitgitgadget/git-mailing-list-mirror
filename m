From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 31/56] add_ref_decoration(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:57 +0000
Message-ID: <1432579162-411464-32-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKB-0001mx-JV
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbEYSl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:58 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50690 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428AbbEYSkV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5EAB22809E;
	Mon, 25 May 2015 18:40:20 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269890>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1a0e170..abf5cc3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -89,7 +89,8 @@ const struct name_decoration *get_name_decoration(const struct object *obj)
 	return lookup_decoration(&name_decoration, obj);
 }
 
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int add_ref_decoration(const char *refname, const struct object_id *oid,
+			      int flags, void *cb_data)
 {
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
@@ -110,7 +111,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 		return 0;
 	}
 
-	obj = parse_object(sha1);
+	obj = parse_object(oid->hash);
 	if (!obj)
 		return 0;
 
@@ -149,13 +150,11 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 void load_ref_decorations(int flags)
 {
 	if (!decoration_loaded) {
-		struct each_ref_fn_sha1_adapter wrapped_add_ref_decoration =
-			{add_ref_decoration, NULL};
 
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(each_ref_fn_adapter, &wrapped_add_ref_decoration);
-		head_ref(each_ref_fn_adapter, &wrapped_add_ref_decoration);
+		for_each_ref(add_ref_decoration, NULL);
+		head_ref(add_ref_decoration, NULL);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
-- 
2.4.0
