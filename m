Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0331720285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbdHZI24 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60463 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751868AbdHZI2b (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:31 -0400
X-AuditID: 1207440c-7fdff7000000143e-99-59a1312e72f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 61.4A.05182.E2131A95; Sat, 26 Aug 2017 04:28:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHil004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/12] load_subtree(): separate logic for internal vs. terminal entries
Date:   Sat, 26 Aug 2017 10:28:05 +0200
Message-Id: <b76c9b2596b4385ee40ea4da7f56190cf6d225f2.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqKtvuDDSYOs7douuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVMe+IR8ELiYpLM+awNDDuF+5i5OSQEDCReHb7A1sXIxeHkMAOJoll8z5DOaeYJF7cnskE
        UsUmoCuxqKcZzBYRUJOY2HaIBaSIWWA5o0TH2/NgCWGBcIk/626xdzFycLAIqErcnsEJYvIK
        REnsWx4HsUxeYlfbRVYQm1PAQuLGVpBdnEC7zCX6fi5imcDIs4CRYRWjXGJOaa5ubmJmTnFq
        sm5xcmJeXmqRrqFebmaJXmpK6SZGSNDw7GD8tk7mEKMAB6MSD29E4YJIIdbEsuLK3EOMkhxM
        SqK8DhoLI4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8K5QAsrxpiRWVqUW5cOkpDlYlMR5VZeo
        +wkJpCeWpGanphakFsFkZTg4lCR4O/SBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGZ4DU8BYXJOYW
        Z6ZD5E8xKkqJ8zqAJARAEhmleXC9sKh+xSgO9Iowr5wBUBUPMCHAdb8CGswENFhREGxwSSJC
        SqqBUW+B3/3JbBPYBDX12Ao0+JwlRPV1/nwxXanXcmraQs7Tzzk4vm5avOmUdU7/35VfHFhm
        vQjiPLdC45rIfa95pe8OvN1vFj4lL0Hrab/XQ/+tmxKmZH+TNK1UL5hTcs19dqy/uJ7UvJSM
        2BAl7cDNh/itfBJFl2x9sKW7yvL817X+4tZTTrM5KrEUZyQaajEXFScCANDEDOXFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are only two legitimate notes path components:

* A hexadecimal string that fills the rest of the SHA-1

* A two-digit hexadecimal string that constitutes another internal
  node.

So handle those two cases at the top level, and reject others as
non-notes without trying to parse them. The logic separation also
simplifies upcoming changes.

This prevents us from leaking memory for a leaf_node in the case of
wrong-sized paths. There are still memory leaks in this code; they will
be fixed in upcoming commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 52 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/notes.c b/notes.c
index 62ab3f4ce3..768902055e 100644
--- a/notes.c
+++ b/notes.c
@@ -433,30 +433,40 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
 		struct leaf_node *l;
-		int len, path_len = strlen(entry.path);
+		int path_len = strlen(entry.path);
+
+		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
+			/* This is potentially the remainder of the SHA-1 */
+			if (get_oid_hex_segment(entry.path, path_len,
+						object_oid.hash + prefix_len,
+						GIT_SHA1_RAWSZ - prefix_len) < 0)
+				goto handle_non_note; /* entry.path is not a SHA1 */
+
+			type = PTR_TYPE_NOTE;
+			l = (struct leaf_node *)
+				xcalloc(1, sizeof(struct leaf_node));
+			oidcpy(&l->key_oid, &object_oid);
+			oidcpy(&l->val_oid, entry.oid);
+		} else if (path_len == 2) {
+			/* This is potentially an internal node */
+			if (get_oid_hex_segment(entry.path, 2,
+						object_oid.hash + prefix_len,
+						GIT_SHA1_RAWSZ - prefix_len) < 0)
+				goto handle_non_note; /* entry.path is not a SHA1 */
 
-		len = get_oid_hex_segment(entry.path, path_len,
-				object_oid.hash + prefix_len, GIT_SHA1_RAWSZ - prefix_len);
-		if (len < 0)
-			goto handle_non_note; /* entry.path is not a SHA1 */
-		len += prefix_len;
-
-		/*
-		 * If object SHA1 is complete (len == 20), assume note object
-		 * If object SHA1 is incomplete (len < 20), and current
-		 * component consists of 2 hex chars, assume note subtree
-		 */
-		type = PTR_TYPE_NOTE;
-		l = (struct leaf_node *)
-			xcalloc(1, sizeof(struct leaf_node));
-		oidcpy(&l->key_oid, &object_oid);
-		oidcpy(&l->val_oid, entry.oid);
-		if (len < GIT_SHA1_RAWSZ) {
-			if (!S_ISDIR(entry.mode) || path_len != 2)
-				goto handle_non_note; /* not subtree */
-			l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
 			type = PTR_TYPE_SUBTREE;
+			l = (struct leaf_node *)
+				xcalloc(1, sizeof(struct leaf_node));
+			oidcpy(&l->key_oid, &object_oid);
+			oidcpy(&l->val_oid, entry.oid);
+			if (!S_ISDIR(entry.mode))
+				goto handle_non_note; /* not subtree */
+			l->key_oid.hash[KEY_INDEX] = (unsigned char) (prefix_len + 1);
+		} else {
+			/* This can't be part of a note */
+			goto handle_non_note;
 		}
+
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
-- 
2.11.0

