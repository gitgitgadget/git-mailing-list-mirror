From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/4] Switch "read_tree_recursive()" over to tree-walk
 functionality
Date: Sun, 28 May 2006 15:11:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281510080.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 00:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTTz-0005L6-Fv
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWE1WLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWE1WLc
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:11:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWE1WLc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:11:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SMBT2g030594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 15:11:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SMBSar015847;
	Sun, 28 May 2006 15:11:28 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20904>


Don't use the tree_entry list, it really had no major reason not to just
walk the raw tree instead.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 tree.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tree.c b/tree.c
index ba8742c..8a7fdd4 100644
--- a/tree.c
+++ b/tree.c
@@ -78,19 +78,26 @@ int read_tree_recursive(struct tree *tre
 			int stage, const char **match,
 			read_tree_fn_t fn)
 {
-	struct tree_entry_list *list;
+	struct tree_desc desc;
+
 	if (parse_tree(tree))
 		return -1;
-	list = tree->entries;
-	while (list) {
-		struct tree_entry_list *current = list;
-		list = list->next;
-		if (!match_tree_entry(base, baselen, current->name,
-				      current->mode, match))
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+
+		if (!match_tree_entry(base, baselen, name, mode, match))
 			continue;
 
-		switch (fn(current->sha1, base, baselen,
-			   current->name, current->mode, stage)) {
+		switch (fn(sha1, base, baselen, name, mode, stage)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -98,16 +105,16 @@ int read_tree_recursive(struct tree *tre
 		default:
 			return -1;
 		}
-		if (current->directory) {
+		if (S_ISDIR(mode)) {
 			int retval;
-			int pathlen = strlen(current->name);
+			int pathlen = strlen(name);
 			char *newbase;
 
 			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, current->name, pathlen);
+			memcpy(newbase + baselen, name, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree_recursive(lookup_tree(current->sha1),
+			retval = read_tree_recursive(lookup_tree(sha1),
 						     newbase,
 						     baselen + pathlen + 1,
 						     stage, match, fn);
