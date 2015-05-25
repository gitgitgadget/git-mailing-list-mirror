From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 07/56] add_pending_uninteresting_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:33 +0000
Message-ID: <1432579162-411464-8-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKi-00023F-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbbEYSkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50587 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbbEYSkI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 74E7928098;
	Mon, 25 May 2015 18:40:07 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269899>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9416aa2..9b49f0e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -702,10 +702,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 }
 
 static int add_pending_uninteresting_ref(const char *refname,
-					 const unsigned char *sha1,
+					 const struct object_id *oid,
 					 int flags, void *cb_data)
 {
-	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
+	add_pending_sha1(cb_data, refname, oid->hash, UNINTERESTING);
 	return 0;
 }
 
@@ -784,8 +784,6 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	struct rev_info revs;
 	struct object *object = &old->object;
 	struct object_array refs;
-	struct each_ref_fn_sha1_adapter wrapped_add_pending_uninteresting_ref =
-		{add_pending_uninteresting_ref, &revs};
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -793,7 +791,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	object->flags &= ~UNINTERESTING;
 	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_pending_uninteresting_ref);
+	for_each_ref(add_pending_uninteresting_ref, &revs);
 	add_pending_sha1(&revs, "HEAD", new->object.sha1, UNINTERESTING);
 
 	refs = revs.pending;
-- 
2.4.0
