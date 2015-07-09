From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] fast-import: Do less work when given "from" matches current branch head
Date: Thu,  9 Jul 2015 15:50:09 +0900
Message-ID: <1436424609-26159-1-git-send-email-mh@glandium.org>
References: <20150709055227.GA32360@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 08:50:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD5f4-0001yX-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 08:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbbGIGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 02:50:18 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41508 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbbGIGuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 02:50:16 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZD5er-0006oa-Ne; Thu, 09 Jul 2015 15:50:09 +0900
X-Mailer: git-send-email 2.4.3.2.gf0a024e.dirty
In-Reply-To: <20150709055227.GA32360@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273729>

When building a fast-import stream, it's easy to forget the fact that
for non-merge commits happening on top of the current branch head, there
is no need for a "from" command. That is corroborated by the fact that
at least git-p4, hg-fast-export and felipec's git-remote-hg all
unconditionally use a "from" command.

Unfortunately, giving a "from" command always resets the branch tree,
forcing it to be re-read, and in many cases, the pack is also closed
and reopened through gfi_unpack_entry. Both are extra unwanted overhead,
and the latter is particularly slow at least on OSX.

So, avoid resetting the tree when it's unmodified, and avoid calling
gfi_unpack_entry when the given mark points to the same commit as the
current branch head.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 fast-import.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e78ca10..372d63a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2588,14 +2588,12 @@ static int parse_from(struct branch *b)
 {
 	const char *from;
 	struct branch *s;
+	unsigned char sha1[20];
 
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		return 0;
 
-	if (b->branch_tree.tree) {
-		release_tree_content_recursive(b->branch_tree.tree);
-		b->branch_tree.tree = NULL;
-	}
+	hashcpy(sha1, b->branch_tree.versions[1].sha1);
 
 	s = lookup_branch(from);
 	if (b == s)
@@ -2610,14 +2608,16 @@ static int parse_from(struct branch *b)
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		hashcpy(b->sha1, oe->idx.sha1);
-		if (oe->pack_id != MAX_PACK_ID) {
-			unsigned long size;
-			char *buf = gfi_unpack_entry(oe, &size);
-			parse_from_commit(b, buf, size);
-			free(buf);
-		} else
-			parse_from_existing(b);
+		if (hashcmp(b->sha1, oe->idx.sha1)) {
+			hashcpy(b->sha1, oe->idx.sha1);
+			if (oe->pack_id != MAX_PACK_ID) {
+				unsigned long size;
+				char *buf = gfi_unpack_entry(oe, &size);
+				parse_from_commit(b, buf, size);
+				free(buf);
+			} else
+				parse_from_existing(b);
+		}
 	} else if (!get_sha1(from, b->sha1)) {
 		parse_from_existing(b);
 		if (is_null_sha1(b->sha1))
@@ -2626,6 +2626,11 @@ static int parse_from(struct branch *b)
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
+	if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].sha1)) {
+		release_tree_content_recursive(b->branch_tree.tree);
+		b->branch_tree.tree = NULL;
+	}
+
 	read_next_command();
 	return 1;
 }
-- 
2.4.3.2.gf0a024e.dirty
