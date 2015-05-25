From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 05/56] register_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:31 +0000
Message-ID: <1432579162-411464-6-git-send-email-sandals@crustytoothpaste.net>
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
	id 1YwxIX-0000s9-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbbEYSkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:16 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50599 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbbEYSkH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91A6628096;
	Mon, 25 May 2015 18:40:06 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269856>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0848d91..03d5cd9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -400,16 +400,16 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static int register_ref(const char *refname, const unsigned char *sha1,
+static int register_ref(const char *refname, const struct object_id *oid,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
-		hashcpy(current_bad_oid->hash, sha1);
+		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, "good-")) {
-		sha1_array_append(&good_revs, sha1);
+		sha1_array_append(&good_revs, oid->hash);
 	} else if (starts_with(refname, "skip-")) {
-		sha1_array_append(&skipped_revs, sha1);
+		sha1_array_append(&skipped_revs, oid->hash);
 	}
 
 	return 0;
@@ -417,10 +417,7 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 
 static int read_bisect_refs(void)
 {
-	struct each_ref_fn_sha1_adapter wrapped_register_ref =
-		{register_ref, NULL};
-
-	return for_each_ref_in("refs/bisect/", each_ref_fn_adapter, &wrapped_register_ref);
+	return for_each_ref_in("refs/bisect/", register_ref, NULL);
 }
 
 static void read_bisect_paths(struct argv_array *array)
-- 
2.4.0
