From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 50/56] mark_complete_oid(): new function, taking an object_oid
Date: Mon, 25 May 2015 18:39:16 +0000
Message-ID: <1432579162-411464-51-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJW-0001Qj-9H
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbEYSlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:19 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50762 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbbEYSkf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37E472809B;
	Mon, 25 May 2015 18:40:33 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269875>

From: Michael Haggerty <mhagger@alum.mit.edu>

This function can be used with for_each_ref() without having to be
wrapped.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1e875cf..d7a4a48 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -490,6 +490,12 @@ static int mark_complete(const char *refname, const unsigned char *sha1, int fla
 	return 0;
 }
 
+static int mark_complete_oid(const char *refname, const struct object_id *oid,
+			     int flag, void *cb_data)
+{
+	return mark_complete(refname, oid->hash, flag, cb_data);
+}
+
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
 					 unsigned long cutoff)
 {
@@ -602,10 +608,7 @@ static int everything_local(struct fetch_pack_args *args,
 	}
 
 	if (!args->depth) {
-		struct each_ref_fn_sha1_adapter wrapped_mark_complete =
-			{mark_complete, NULL};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_mark_complete);
+		for_each_ref(mark_complete_oid, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
-- 
2.4.0
