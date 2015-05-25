From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 48/56] mark_complete(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:14 +0000
Message-ID: <1432579162-411464-49-git-send-email-sandals@crustytoothpaste.net>
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
	id 1YwxJc-0001Ul-DI
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbbEYSl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50739 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412AbbEYSkd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 53D6D28099;
	Mon, 25 May 2015 18:40:32 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269877>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 walker.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/walker.c b/walker.c
index bb2e0b9..44a936c 100644
--- a/walker.c
+++ b/walker.c
@@ -200,9 +200,11 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	return -1;
 }
 
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const char *path, const struct object_id *oid,
+			 int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
+
 	if (commit) {
 		commit->object.flags |= COMPLETE;
 		commit_list_insert(commit, &complete);
@@ -269,10 +271,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	}
 
 	if (!walker->get_recover) {
-		struct each_ref_fn_sha1_adapter wrapped_mark_complete =
-			{mark_complete, NULL};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_mark_complete);
+		for_each_ref(mark_complete, NULL);
 		commit_list_sort_by_date(&complete);
 	}
 
-- 
2.4.0
