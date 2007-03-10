From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] fast-import: tree allocation cleanups
Date: Sat, 10 Mar 2007 14:21:14 -0500
Message-ID: <20070310192114.GA3875@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ787-0005vn-JI
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXCJTVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXCJTVR
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:21:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3016 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751638AbXCJTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:21:16 -0500
Received: (qmail 19230 invoked from network); 10 Mar 2007 14:21:36 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:21:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:21:14 -0500
Content-Disposition: inline
In-Reply-To: <<20070310191515.GA3416@coredump.intra.peff.net>>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41879>

These cleanups are in preparation for improving the
efficiency of the tree-construction code. There should be no
functionality changes.

1. Insert entries into tree_content _after_ they have a name
   assigned. This means that the insertion can use a smarter
   data structure than an unordered list.

2. Factor out the linear search for existing tree entries in
   tree_content_set, which will make it simpler to change.
   Most of the line changes here are simply indentation changes.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c |   65 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 81bc6ea..ac14a5a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -594,6 +594,15 @@ static struct tree_content *grow_tree_content(
 	return r;
 }
 
+static int find_tree_entry(struct tree_content *t, struct atom_str *s)
+{
+	int i;
+	for (i = 0; i < t->entry_count; i++)
+		if (!strcmp(t->entries[i]->name->str_dat, s->str_dat))
+			return i;
+	return -1;
+}
+
 static struct tree_entry *new_tree_entry(void)
 {
 	struct tree_entry *e;
@@ -1059,7 +1068,6 @@ static void load_tree(struct tree_entry *root)
 
 		if (t->entry_count == t->entry_capacity)
 			root->tree = t = grow_tree_content(t, t->entry_count);
-		t->entries[t->entry_count++] = e;
 
 		e->tree = NULL;
 		c = get_mode(c, &e->versions[1].mode);
@@ -1071,6 +1079,8 @@ static void load_tree(struct tree_entry *root)
 		hashcpy(e->versions[0].sha1, (unsigned char*)c);
 		hashcpy(e->versions[1].sha1, (unsigned char*)c);
 		c += 20;
+
+		t->entries[t->entry_count++] = e;
 	}
 	free(buf);
 }
@@ -1187,6 +1197,7 @@ static int tree_content_set(
 	const char *slash1;
 	unsigned int i, n;
 	struct tree_entry *e;
+	struct atom_str *name;
 
 	slash1 = strchr(p, '/');
 	if (slash1)
@@ -1194,40 +1205,40 @@ static int tree_content_set(
 	else
 		n = strlen(p);
 
-	for (i = 0; i < t->entry_count; i++) {
+	name = to_atom(p, n);
+	i = find_tree_entry(t, name);
+	if (i != -1) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
-			if (!slash1) {
-				if (e->versions[1].mode == mode
-						&& !hashcmp(e->versions[1].sha1, sha1))
-					return 0;
-				e->versions[1].mode = mode;
-				hashcpy(e->versions[1].sha1, sha1);
-				if (e->tree) {
-					release_tree_content_recursive(e->tree);
-					e->tree = NULL;
-				}
-				hashclr(root->versions[1].sha1);
-				return 1;
-			}
-			if (!S_ISDIR(e->versions[1].mode)) {
-				e->tree = new_tree_content(8);
-				e->versions[1].mode = S_IFDIR;
-			}
-			if (!e->tree)
-				load_tree(e);
-			if (tree_content_set(e, slash1 + 1, sha1, mode)) {
-				hashclr(root->versions[1].sha1);
-				return 1;
+		if (!slash1) {
+			if (e->versions[1].mode == mode
+					&& !hashcmp(e->versions[1].sha1, sha1))
+				return 0;
+			e->versions[1].mode = mode;
+			hashcpy(e->versions[1].sha1, sha1);
+			if (e->tree) {
+				release_tree_content_recursive(e->tree);
+				e->tree = NULL;
 			}
-			return 0;
+			hashclr(root->versions[1].sha1);
+			return 1;
+		}
+		if (!S_ISDIR(e->versions[1].mode)) {
+			e->tree = new_tree_content(8);
+			e->versions[1].mode = S_IFDIR;
+		}
+		if (!e->tree)
+			load_tree(e);
+		if (tree_content_set(e, slash1 + 1, sha1, mode)) {
+			hashclr(root->versions[1].sha1);
+			return 1;
 		}
+		return 0;
 	}
 
 	if (t->entry_count == t->entry_capacity)
 		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
-	e->name = to_atom(p, (unsigned short)n);
+	e->name = name;
 	e->versions[0].mode = 0;
 	hashclr(e->versions[0].sha1);
 	t->entries[t->entry_count++] = e;
-- 
1.5.0.3.931.g55c05
