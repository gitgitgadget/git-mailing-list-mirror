From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 34/56] add_one_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:00 +0000
Message-ID: <1432579162-411464-35-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxK4-0001jF-II
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbbEYSlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:55 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50701 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbbEYSkW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A8C152809A;
	Mon, 25 May 2015 18:40:21 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269887>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 reachable.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/reachable.c b/reachable.c
index acac86a..9cff25b 100644
--- a/reachable.c
+++ b/reachable.c
@@ -22,9 +22,10 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
-static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_one_ref(const char *path, const struct object_id *oid,
+		       int flag, void *cb_data)
 {
-	struct object *object = parse_object_or_die(sha1, path);
+	struct object *object = parse_object_or_die(oid->hash, path);
 	struct rev_info *revs = (struct rev_info *)cb_data;
 
 	add_pending_object(revs, object, "");
@@ -155,8 +156,6 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    struct progress *progress)
 {
 	struct connectivity_progress cp;
-	struct each_ref_fn_sha1_adapter wrapped_add_one_ref =
-		{add_one_ref, revs};
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -170,10 +169,10 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	add_index_objects_to_pending(revs, 0);
 
 	/* Add all external refs */
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_one_ref);
+	for_each_ref(add_one_ref, revs);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(each_ref_fn_adapter, &wrapped_add_one_ref);
+	head_ref(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
-- 
2.4.0
