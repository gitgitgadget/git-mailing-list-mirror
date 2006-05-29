From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 6/10] fsck-objects: avoid unnecessary tree_entry_list usage
Date: Mon, 29 May 2006 12:19:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291218390.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:19:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknGy-0000bC-8V
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWE2TTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWE2TTZ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:19:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWE2TTY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:19:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJJ52g015109
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:19:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJJ2SO015536;
	Mon, 29 May 2006 12:19:04 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20961>


Prime example of where the raw tree parser is easier for everybody.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 fsck-objects.c |   55 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
index 42778e8..a9680dc 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -9,6 +9,7 @@ #include "tag.h"
 #include "refs.h"
 #include "pack.h"
 #include "cache-tree.h"
+#include "tree-walk.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -116,15 +117,15 @@ static void check_connectivity(void)
 #define TREE_UNORDERED (-1)
 #define TREE_HAS_DUPS  (-2)
 
-static int verify_ordered(struct tree_entry_list *a, struct tree_entry_list *b)
+static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, const char *name2)
 {
-	int len1 = strlen(a->name);
-	int len2 = strlen(b->name);
+	int len1 = strlen(name1);
+	int len2 = strlen(name2);
 	int len = len1 < len2 ? len1 : len2;
 	unsigned char c1, c2;
 	int cmp;
 
-	cmp = memcmp(a->name, b->name, len);
+	cmp = memcmp(name1, name2, len);
 	if (cmp < 0)
 		return 0;
 	if (cmp > 0)
@@ -135,8 +136,8 @@ static int verify_ordered(struct tree_en
 	 * Now we need to order the next one, but turn
 	 * a '\0' into a '/' for a directory entry.
 	 */
-	c1 = a->name[len];
-	c2 = b->name[len];
+	c1 = name1[len];
+	c2 = name2[len];
 	if (!c1 && !c2)
 		/*
 		 * git-write-tree used to write out a nonsense tree that has
@@ -144,9 +145,9 @@ static int verify_ordered(struct tree_en
 		 * sure we do not have duplicate entries.
 		 */
 		return TREE_HAS_DUPS;
-	if (!c1 && a->directory)
+	if (!c1 && S_ISDIR(mode1))
 		c1 = '/';
-	if (!c2 && b->directory)
+	if (!c2 && S_ISDIR(mode2))
 		c2 = '/';
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
@@ -159,15 +160,30 @@ static int fsck_tree(struct tree *item)
 	int has_bad_modes = 0;
 	int has_dup_entries = 0;
 	int not_properly_sorted = 0;
-	struct tree_entry_list *entry, *last;
+	struct tree_desc desc;
+	unsigned o_mode;
+	const char *o_name;
+	const unsigned char *o_sha1;
 
-	last = NULL;
-	for (entry = create_tree_entry_list(item); entry; entry = entry->next) {
-		if (strchr(entry->name, '/'))
+	desc.buf = item->buffer;
+	desc.size = item->size;
+
+	o_mode = 0;
+	o_name = NULL;
+	o_sha1 = NULL;
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+
+		if (strchr(name, '/'))
 			has_full_path = 1;
-		has_zero_pad |= entry->zeropad;
+		has_zero_pad |= *(char *)desc.buf = '0';
+		update_tree_entry(&desc);
 
-		switch (entry->mode) {
+		switch (mode) {
 		/*
 		 * Standard modes.. 
 		 */
@@ -188,8 +204,8 @@ static int fsck_tree(struct tree *item)
 			has_bad_modes = 1;
 		}
 
-		if (last) {
-			switch (verify_ordered(last, entry)) {
+		if (o_name) {
+			switch (verify_ordered(o_mode, o_name, mode, name)) {
 			case TREE_UNORDERED:
 				not_properly_sorted = 1;
 				break;
@@ -199,13 +215,12 @@ static int fsck_tree(struct tree *item)
 			default:
 				break;
 			}
-			free(last);
 		}
 
-		last = entry;
+		o_mode = mode;
+		o_name = name;
+		o_sha1 = sha1;
 	}
-	if (last)
-		free(last);
 	free(item->buffer);
 	item->buffer = NULL;
 
-- 
1.3.3.gcd01d
