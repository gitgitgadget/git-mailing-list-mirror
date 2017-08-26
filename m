Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4645420285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbdHZI2z (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:55 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54564 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754488AbdHZI2i (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:38 -0400
X-AuditID: 1207440e-bf9ff70000007085-ea-59a131353edd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DC.7B.28805.53131A95; Sat, 26 Aug 2017 04:28:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHip004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/12] load_subtree(): combine some common code
Date:   Sat, 26 Aug 2017 10:28:09 +0200
Message-Id: <f0077bb814ea465dbd5c0b8b2e7fe36fdde56070.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqGtquDDSYP5PWYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVsXLTNeaCFt6K/QuPsTQwzuXqYuTkkBAwkfj6/ScriC0ksINJoveTURcjF5B9ikli5Ypl
        LCAJNgFdiUU9zUwgtoiAmsTEtkMsIEXMAssZJTrengdLCAvYS7RufcEIYrMIqEp8aXwA1swr
        ECXRd2o5M8Q2eYldbRfBtnEKWEjc2PqZDWKzuUTfz0UsExh5FjAyrGKUS8wpzdXNTczMKU5N
        1i1OTszLSy3SNdbLzSzRS00p3cQICRy+HYzt62UOMQpwMCrx8G4oXhApxJpYVlyZe4hRkoNJ
        SZTXQWNhpBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3hVKQDnelMTKqtSifJiUNAeLkjiv2hJ1
        PyGB9MSS1OzU1ILUIpisDAeHkgRvhz5Qo2BRanpqRVpmTglCmomDE2Q4D9DwDJAa3uKCxNzi
        zHSI/ClGRSlxXgeQhABIIqM0D64XFtmvGMWBXhHmfQ1SxQNMCnDdr4AGMwENVhQEG1ySiJCS
        amDkufBvU8QlR7PJtns2MOW92vX6+p290b8lxc67dHCm3LrEr7FE0SZFSTjsJKvY796qV4uc
        4p/8ymnfsIlnScvOuk3zFi/YvGRbNsNitu55e1eszrnweKlW0df9muVT95zx2Kt6v3yqdoqv
        VVC5a9G8phCzu3yLH+tXGMxvexRjb8h0c+6zXuF2JZbijERDLeai4kQABdgXhccCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the length into `object_oid` (before copying) rather than
`l->key_oid` (after copying). Then combine some code from the two `if`
blocks.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/notes.c b/notes.c
index 6ce71bfedb..534fda007e 100644
--- a/notes.c
+++ b/notes.c
@@ -447,10 +447,6 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_NOTE;
-			l = (struct leaf_node *)
-				xcalloc(1, sizeof(struct leaf_node));
-			oidcpy(&l->key_oid, &object_oid);
-			oidcpy(&l->val_oid, entry.oid);
 		} else if (path_len == 2) {
 			/* This is potentially an internal node */
 
@@ -463,17 +459,17 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 						GIT_SHA1_RAWSZ - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
+			object_oid.hash[KEY_INDEX] = (unsigned char) (prefix_len + 1);
+
 			type = PTR_TYPE_SUBTREE;
-			l = (struct leaf_node *)
-				xcalloc(1, sizeof(struct leaf_node));
-			oidcpy(&l->key_oid, &object_oid);
-			oidcpy(&l->val_oid, entry.oid);
-			l->key_oid.hash[KEY_INDEX] = (unsigned char) (prefix_len + 1);
 		} else {
 			/* This can't be part of a note */
 			goto handle_non_note;
 		}
 
+		l = xcalloc(1, sizeof(*l));
+		oidcpy(&l->key_oid, &object_oid);
+		oidcpy(&l->val_oid, entry.oid);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
-- 
2.11.0

