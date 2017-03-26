Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D6D20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdCZC0N (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:26:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35394 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751306AbdCZC0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:26:12 -0400
X-Greylist: delayed 1993 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Mar 2017 22:26:11 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89_RC6)
        (envelope-from <glandium@glandium.org>)
        id 1crxLo-00031Q-RH; Sun, 26 Mar 2017 10:52:12 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     johan@herland.net, gitster@pobox.com
Subject: [PATCH] notes: Fix note_tree_consolidate not to break the note_tree structure
Date:   Sun, 26 Mar 2017 10:52:12 +0900
Message-Id: <20170326015212.11578-1-mh@glandium.org>
X-Mailer: git-send-email 2.12.1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After a note is removed, note_tree_consolidate is called to eliminate
some useless nodes. The typical case is that if you had an int_node
with 2 PTR_TYPE_NOTEs in it, and remove one of them, then the
PTR_TYPE_INTERNAL pointer in the parent tree can be replaced with the
remaining PTR_TYPE_NOTE.

This works fine when PTR_TYPE_NOTEs are involved, but falls flat when
other types are involved.

To put things in more practical terms, let's say we start from an empty
notes tree, and add 3 notes:
- one for a sha1 that starts with 424
- one for a sha1 that starts with 428
- one for a sha1 that starts with 4c

To keep track of this, note_tree.root will have a PTR_TYPE_INTERNAL at
a[4], pointing to an int_node*.
In turn, that int_node* will have a PTR_TYPE_NOTE at a[0xc], pointing to
the leaf_node* with the key and value, and a PTR_TYPE_INTERNAL at a[2],
pointing to another int_node*.
That other int_node* will have 2 PTR_TYPE_NOTE, one at a[4] and the
other at a[8].

When looking for the note for the sha1 starting with 428, get_note() will
recurse through (simplified) root.a[4].a[2].a[8].

Now, if we remove the note for the sha1 that starts with 4c, we're left
with a int_node* with only one PTR_TYPE_INTERNAL entry in it. After
note_tree_consolidate runs, root.a[4] now points to what used to be
pointed at by root.a[4].a[2].

Which means looking up for the note for the sha1 starting with 428 now
fails because there is nothing at root.a[4].a[2] anymore: there is only
root.a[4].a[4] and root.a[4].a[8], which don't match the expected
structure for the lookup.

So if all there is left in an int_node* is a PTR_TYPE_INTERNAL pointer,
we can't safely remove it. I think the same applies for PTR_TYPE_SUBTREE
pointers. IOW, only PTR_TYPE_NOTEs are safe to be moved to the parent
int_node*.

This doesn't have a practical effect on git because all that happens
after a remove_note is a write_notes_tree, which just iterates the entire
note tree, but this affects anything using libgit.a that would try to do
lookups after removing notes.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 notes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 2bab961ac..542563b28 100644
--- a/notes.c
+++ b/notes.c
@@ -153,8 +153,8 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
  * How to consolidate an int_node:
  * If there are > 1 non-NULL entries, give up and return non-zero.
  * Otherwise replace the int_node at the given index in the given parent node
- * with the only entry (or a NULL entry if no entries) from the given tree,
- * and return 0.
+ * with the only NOTE entry (or a NULL entry if no entries) from the given
+ * tree, and return 0.
  */
 static int note_tree_consolidate(struct int_node *tree,
 	struct int_node *parent, unsigned char index)
@@ -173,6 +173,8 @@ static int note_tree_consolidate(struct int_node *tree,
 		}
 	}
 
+	if (p && (GET_PTR_TYPE(p) != PTR_TYPE_NOTE))
+		return -2;
 	/* replace tree with p in parent[index] */
 	parent->a[index] = p;
 	free(tree);
-- 
2.12.1.dirty

