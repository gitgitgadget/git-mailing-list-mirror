Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6BD20285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbdHZI2f (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53228 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754316AbdHZI2d (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:33 -0400
X-AuditID: 12074413-3a3ff70000007929-7e-59a13130ef27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.ED.31017.03131A95; Sat, 26 Aug 2017 04:28:32 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHim004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/12] load_subtree(): check earlier whether an internal node is a tree entry
Date:   Sat, 26 Aug 2017 10:28:06 +0200
Message-Id: <22e8ace89f28fd2fae31c08b8e86e03a4833e694.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqGtguDDS4OpMFYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV8XDhTLaCq1wVC6a0MTUwbuPoYuTkkBAwkdg49xBjFyMXh5DADiaJ10/vMkE4p5gkZm98
        wgRSxSagK7GopxnMFhFQk5jYdogFpIhZYDmjRMfb82AJYYFYiRcrJ7CB2CwCqhJrt9xh72Lk
        4OAViJK4PqcQYpu8xK62i6wgNqeAhcSNrZ/ByoUEzCX6fi5imcDIs4CRYRWjXGJOaa5ubmJm
        TnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSOAI72DcdVLuEKMAB6MSD++G4gWRQqyJZcWVuYcY
        JTmYlER5HTQWRgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4V2hBJTjTUmsrEotyodJSXOwKInz
        qi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw/tEHahQsSk1PrUjLzClBSDNxcIIM5wEangFSw1tc
        kJhbnJkOkT/FqCglzusAkhAASWSU5sH1wiL7FaM40CvCvNMMgKp4gEkBrvsV0GAmoMGKgmCD
        SxIRUlINjOyTrgj8td2ZGqRw1fJcq4Xzer3LV1ImH6i7LiW+viE5ere0wvRpE0N5TY0Ob36S
        UjmT93zCccvyWTfK7ltM0HAt+mc/x+iZToiFfA/DSqktJ/TqFjRwt3w51M8rF+D7YtI8yRez
        7F8bxf5turH42OmXfEdUFvH2ndLbxtb4tPRXvfP+j6FrJyqxFGckGmoxFxUnAgDC16JOxwIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an entry is not a tree entry, then it cannot possibly be an
internal node. But the old code checked this condition only after
allocating a leaf_node object and therefore leaked that memory.
Instead, check before even entering this branch of the code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 768902055e..ac69c5aa18 100644
--- a/notes.c
+++ b/notes.c
@@ -449,6 +449,11 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			oidcpy(&l->val_oid, entry.oid);
 		} else if (path_len == 2) {
 			/* This is potentially an internal node */
+
+			if (!S_ISDIR(entry.mode))
+				/* internal nodes must be trees */
+				goto handle_non_note;
+
 			if (get_oid_hex_segment(entry.path, 2,
 						object_oid.hash + prefix_len,
 						GIT_SHA1_RAWSZ - prefix_len) < 0)
@@ -459,8 +464,6 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				xcalloc(1, sizeof(struct leaf_node));
 			oidcpy(&l->key_oid, &object_oid);
 			oidcpy(&l->val_oid, entry.oid);
-			if (!S_ISDIR(entry.mode))
-				goto handle_non_note; /* not subtree */
 			l->key_oid.hash[KEY_INDEX] = (unsigned char) (prefix_len + 1);
 		} else {
 			/* This can't be part of a note */
-- 
2.11.0

