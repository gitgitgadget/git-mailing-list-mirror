From: Jeff King <peff@peff.net>
Subject: [PATCH] fast-import: use binary search in tree_content_remove
Date: Sat, 10 Mar 2007 14:40:13 -0500
Message-ID: <20070310194012.GA5126@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ7QX-0005vY-FD
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXCJTkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXCJTkR
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:40:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2026 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932095AbXCJTkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:40:15 -0500
Received: (qmail 19784 invoked from network); 10 Mar 2007 14:40:35 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:40:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:40:13 -0500
Content-Disposition: inline
In-Reply-To: <20070310192304.GB3416@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41882>


Signed-off-by: Jeff King <peff@peff.net>
---
> I should note that this patch doesn't handle removing entries from
> tree_content structs; I will work up a patch for that momentarily.

And here it is. However, I should note that this patch is _not_
necessary. I had originally thought that removal might destroy the
sorting that I added in the last patch, but it looks like the entry
isn't actually removed. Shawn, can you sanity check this?

This patch still has value, though, because it improves performance when
deleting entries from a large tree (I just didn't do that in my test
case, so it wasn't a problem before).

 fast-import.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4cd01ee..4322216 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1295,6 +1295,7 @@ static int tree_content_remove(struct tree_entry *root, const char *p)
 	const char *slash1;
 	unsigned int i, n;
 	struct tree_entry *e;
+	struct atom_str *name;
 
 	slash1 = strchr(p, '/');
 	if (slash1)
@@ -1302,24 +1303,24 @@ static int tree_content_remove(struct tree_entry *root, const char *p)
 	else
 		n = strlen(p);
 
-	for (i = 0; i < t->entry_count; i++) {
-		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
-			if (!slash1 || !S_ISDIR(e->versions[1].mode))
-				goto del_entry;
-			if (!e->tree)
-				load_tree(e);
-			if (tree_content_remove(e, slash1 + 1)) {
-				for (n = 0; n < e->tree->entry_count; n++) {
-					if (e->tree->entries[n]->versions[1].mode) {
-						hashclr(root->versions[1].sha1);
-						return 1;
-					}
-				}
-				goto del_entry;
+	name = to_atom(p, n);
+	i = find_tree_entry(t, name);
+	if(i == -1)
+		return 0;
+	e = t->entries[i];
+
+	if (!slash1 || !S_ISDIR(e->versions[1].mode))
+		goto del_entry;
+	if (!e->tree)
+		load_tree(e);
+	if (tree_content_remove(e, slash1 + 1)) {
+		for (n = 0; n < e->tree->entry_count; n++) {
+			if (e->tree->entries[n]->versions[1].mode) {
+				hashclr(root->versions[1].sha1);
+				return 1;
 			}
-			return 0;
 		}
+		goto del_entry;
 	}
 	return 0;
 
-- 
1.5.0.3.931.g55c05
