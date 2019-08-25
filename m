Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3C11F461
	for <e@80x24.org>; Sun, 25 Aug 2019 05:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfHYFSX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 01:18:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33160 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfHYFSX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 01:18:23 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i1kuw-0002Vw-Mc; Sun, 25 Aug 2019 14:18:18 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] notes: avoid leaking duplicate entries
Date:   Sun, 25 Aug 2019 14:18:18 +0900
Message-Id: <20190825051818.9621-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When add_note is called multiple times with the same key/value pair, the
leaf_node it creates is leaked by notes_tree_insert.
---
 notes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 75c028b300..ec35f5b551 100644
--- a/notes.c
+++ b/notes.c
@@ -269,8 +269,10 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 		case PTR_TYPE_NOTE:
 			if (oideq(&l->key_oid, &entry->key_oid)) {
 				/* skip concatenation if l == entry */
-				if (oideq(&l->val_oid, &entry->val_oid))
+				if (oideq(&l->val_oid, &entry->val_oid)) {
+					free(entry);
 					return 0;
+				}
 
 				ret = combine_notes(&l->val_oid,
 						    &entry->val_oid);
-- 
2.23.0

