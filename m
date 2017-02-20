Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A4F201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdBTALd (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:11:33 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36326 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751470AbdBTAKr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Feb 2017 19:10:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9DB9F280BA;
        Mon, 20 Feb 2017 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487549446;
        bh=0vgCHK+UWBA203Hq9P6hTvw0bInp1bYAKflUgZLwyFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCEewHTxA8eoFYRorwsp8+d6R1JXsmcCxKlw1xf7vp0oSLkN2ZAnAzg9TFnCJeqWI
         iF3184qMVy1T/VK1EN30dOL9mI62A0i2eoGAXC4wr5o3ni75o/xTRP+v3VpngBJ6M7
         aBYaBh3DzsnmssApGZxBVq7E4Qr++Gdkox7OKrHaifZYpGjGow1Eh9vv0yBXNTbmJa
         sZ3B+dvU7936zMy7sS+VVNSXEnFVUJ2OEeqPlCy4IxXvhby/th0AsiQ5lVi47SMooP
         18e7CP/WOtJC4mHYYp+KJUZFUOEkkBo4UXI7Y57JZDQ6U5bnuLu+LZSucJYeu6+bc2
         ASnKBqWtKV/nyEAbBZ0e58SHS8K2gOHvuESBXCzbiriQzmc8sbnf3p7z0ywLgV2zNM
         CHJBESrvF2BFOmVgfzzUmKIdIxs7ZSbAlXph5ePq2B7TU9kjAFZ7stR+LeYDgE2xLR
         hVW1zKZBMlxaQU9ihTcL/i4brDe2aX6w2t7QO1Z9HQP0TwOyWqk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 13/19] reflog-walk: convert struct reflog_info to struct object_id
Date:   Mon, 20 Feb 2017 00:10:25 +0000
Message-Id: <20170220001031.559931-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170220001031.559931-1-sandals@crustytoothpaste.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct reflog_info to use struct object_id by changing the
structure definition and applying the following semantic patch:

@@
struct reflog_info E1;
@@
- E1.osha1
+ E1.ooid.hash

@@
struct reflog_info *E1;
@@
- E1->osha1
+ E1->ooid.hash

@@
struct reflog_info E1;
@@
- E1.nsha1
+ E1.noid.hash

@@
struct reflog_info *E1;
@@
- E1->nsha1
+ E1->noid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 reflog-walk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index f98748e2ae..fe5be41471 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -10,7 +10,7 @@ struct complete_reflogs {
 	char *ref;
 	const char *short_ref;
 	struct reflog_info {
-		unsigned char osha1[20], nsha1[20];
+		struct object_id ooid, noid;
 		char *email;
 		unsigned long timestamp;
 		int tz;
@@ -28,8 +28,8 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 
 	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
 	item = array->items + array->nr;
-	hashcpy(item->osha1, osha1);
-	hashcpy(item->nsha1, nsha1);
+	hashcpy(item->ooid.hash, osha1);
+	hashcpy(item->noid.hash, nsha1);
 	item->email = xstrdup(email);
 	item->timestamp = timestamp;
 	item->tz = tz;
@@ -238,13 +238,13 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	do {
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 		commit_reflog->recno--;
-		logobj = parse_object(reflog->osha1);
+		logobj = parse_object(reflog->ooid.hash);
 	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
 
-	if (!logobj && commit_reflog->recno >= 0 && is_null_sha1(reflog->osha1)) {
+	if (!logobj && commit_reflog->recno >= 0 && is_null_sha1(reflog->ooid.hash)) {
 		/* a root commit, but there are still more entries to show */
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
-		logobj = parse_object(reflog->nsha1);
+		logobj = parse_object(reflog->noid.hash);
 	}
 
 	if (!logobj || logobj->type != OBJ_COMMIT) {
-- 
2.11.0

