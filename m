Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777DE20248
	for <e@80x24.org>; Tue,  2 Apr 2019 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfDBL5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 07:57:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42074 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBL5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 07:57:14 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:37657)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hBI2T-0005zI-5W
        for git@vger.kernel.org; Tue, 02 Apr 2019 07:57:13 -0400
Received: from localhost ([127.0.0.1]:43046 helo=lola.localdomain)
        by fencepost.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hBI2S-0001Jn-FH; Tue, 02 Apr 2019 07:57:12 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
        id 113216484D; Tue,  2 Apr 2019 13:56:44 +0200 (CEST)
From:   David Kastrup <dak@gnu.org>
To:     git@vger.kernel.org
Cc:     David Kastrup <dak@gnu.org>
Subject: [PATCH] blame.c: don't drop origin blobs as eagerly
Date:   Tue,  2 Apr 2019 13:56:25 +0200
Message-Id: <20190402115625.21427-1-dak@gnu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a parent blob already has chunks queued up for blaming, dropping
the blob at the end of one blame step will cause it to get reloaded
right away, doubling the amount of I/O and unpacking when processing a
linear history.

Keeping such parent blobs in memory seems like a reasonable optimization
that should incur additional memory pressure mostly when processing the
merges from old branches.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index 5c07dec190..c11c516921 100644
--- a/blame.c
+++ b/blame.c
@@ -1562,7 +1562,8 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	}
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
+			if (!sg_origin[i]->suspects)
+				drop_origin_blob(sg_origin[i]);
 			blame_origin_decref(sg_origin[i]);
 		}
 	}
-- 
2.20.1

