Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA79201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbdBUXsS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:18 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39906 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753536AbdBUXsH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:48:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C20B280BA;
        Tue, 21 Feb 2017 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720865;
        bh=0vgCHK+UWBA203Hq9P6hTvw0bInp1bYAKflUgZLwyFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ltewr8pXQWybNHO01yHX0lD9WbC9lWbjp1dX2HzPQyNSe4kAahN9RsW2vHfTmeQAz
         1YVdB3YWkaJoiX9CUuQWecTQVg4LQQqTayElu+dxCpiOrPGu+7Q26NyQcZ1/gdQlRe
         gs/qzM5Ofuc8xsljLzejpIkihzkfoklON6RoPVUnTtZcR0pa/5Qaq8zCsJupyqO2pp
         z1ORWimbrKyLm/49PhtR2Z6AspqfHK3myetKSkgGjJc0juf2p21qLZhflMQvtq6TMx
         sHHHYLnGWSU3zgtEOzsrZtlzMtYjb4ItBclgQ9U3Ao4jG+dWTXBk+DhXzF+g7zFn57
         dcjenuWcV6/R66JgERQcquGgz6wI4zWwfhvTBKO7npNFe/zJhwxgRb6SUVSPP2VIQa
         29QWbxFboLeKXP81+0amTbrIsKxO9COSEvpX0/oi0OgUhkuMtL41k6EhySToDqryQK
         Za/iQN2tDRhnmuRpPFzZN5Ob9WwUd/2jDrU5kOlyGj8U3HWGN05
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 13/19] reflog-walk: convert struct reflog_info to struct object_id
Date:   Tue, 21 Feb 2017 23:47:31 +0000
Message-Id: <20170221234737.894681-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
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

