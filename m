From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 15/56] add_branch_for_removal(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:41 +0000
Message-ID: <1432579162-411464-16-git-send-email-sandals@crustytoothpaste.net>
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
	id 1YwxKo-00025X-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbEYSmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50596 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbbEYSkM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 04E412809E;
	Mon, 25 May 2015 18:40:11 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269901>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/remote.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 27a611b..1986e98 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -509,7 +509,7 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec refspec;
@@ -545,7 +545,7 @@ static int add_branch_for_removal(const char *refname,
 
 	item = string_list_append(branches->branches, refname);
 	item->util = xmalloc(20);
-	hashcpy(item->util, sha1);
+	hashcpy(item->util, oid->hash);
 
 	return 0;
 }
@@ -783,8 +783,6 @@ static int rm(int argc, const char **argv)
 	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
 	int i, result;
-	struct each_ref_fn_sha1_adapter wrapped_add_branch_for_removal =
-		{add_branch_for_removal, &cb_data};
 
 	memset(&cb_data, 0, sizeof(cb_data));
 	cb_data.branches = &branches;
@@ -825,7 +823,7 @@ static int rm(int argc, const char **argv)
 	 * refs, which are invalidated when deleting a branch.
 	 */
 	cb_data.remote = remote;
-	result = for_each_ref(each_ref_fn_adapter, &wrapped_add_branch_for_removal);
+	result = for_each_ref(add_branch_for_removal, &cb_data);
 	strbuf_release(&buf);
 
 	if (!result)
-- 
2.4.0
