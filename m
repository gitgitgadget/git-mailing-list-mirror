Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C512B1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfHZCpN (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:45:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39320 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbfHZCpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:45:12 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i250G-0002Cx-Ot; Mon, 26 Aug 2019 11:45:08 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] packfile: free packed_git memory when closing object store
Date:   Mon, 26 Aug 2019 11:45:08 +0900
Message-Id: <20190826024508.8444-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 packfile.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Note, I'm not sure this is the right place to do it.

diff --git a/packfile.c b/packfile.c
index fc43a6c52c..b0cb84adda 100644
--- a/packfile.c
+++ b/packfile.c
@@ -339,13 +339,16 @@ void close_pack(struct packed_git *p)
 
 void close_object_store(struct raw_object_store *o)
 {
-	struct packed_git *p;
+	struct packed_git *p = o->packed_git;
 
-	for (p = o->packed_git; p; p = p->next)
+	while (p) {
+		struct packed_git *current = p;
 		if (p->do_not_close)
 			BUG("want to close pack marked 'do-not-close'");
-		else
-			close_pack(p);
+		close_pack(p);
+		p = p->next;
+		free(current);
+	}
 
 	if (o->multi_pack_index) {
 		close_midx(o->multi_pack_index);
-- 
2.23.0

