From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Mon, 9 Apr 2007 21:15:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7ld-0006oj-L5
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbXDJEPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbXDJEPi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:15:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42998 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964974AbXDJEPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:15:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4FWPD025650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:15:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4FTaG031077;
	Mon, 9 Apr 2007 21:15:30 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44110>


Since the subprojects don't necessarily even exist in the current tree,
much less in the current git repository (they are totally independent
repositories), we do not want to try to follow the chain from one git
repository to another through a gitlink.

This involves teaching fsck to ignore references to gitlink objects from
a tree and from the current index.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-fsck.c |    9 ++++++++-
 tree.c         |   15 ++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 4d8b66c..f22de8d 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -253,6 +253,7 @@ static int fsck_tree(struct tree *item)
 		case S_IFREG | 0644:
 		case S_IFLNK:
 		case S_IFDIR:
+		case S_IFDIRLNK:
 			break;
 		/*
 		 * This is nonstandard, but we had a few of these
@@ -695,8 +696,14 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 		int i;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
-			struct blob *blob = lookup_blob(active_cache[i]->sha1);
+			unsigned int mode;
+			struct blob *blob;
 			struct object *obj;
+
+			mode = ntohl(active_cache[i]->ce_mode);
+			if (S_ISDIRLNK(mode))
+				continue;
+			blob = lookup_blob(active_cache[i]->sha1);
 			if (!blob)
 				continue;
 			obj = &blob->object;
diff --git a/tree.c b/tree.c
index d188c0f..dbb63fc 100644
--- a/tree.c
+++ b/tree.c
@@ -143,6 +143,14 @@ struct tree *lookup_tree(const unsigned char *sha1)
 	return (struct tree *) obj;
 }
 
+/*
+ * NOTE! Tree refs to external git repositories
+ * (ie gitlinks) do not count as real references.
+ *
+ * You don't have to have those repositories
+ * available at all, much less have the objects
+ * accessible from the current repository.
+ */
 static void track_tree_refs(struct tree *item)
 {
 	int n_refs = 0, i;
@@ -152,8 +160,11 @@ static void track_tree_refs(struct tree *item)
 
 	/* Count how many entries there are.. */
 	init_tree_desc(&desc, item->buffer, item->size);
-	while (tree_entry(&desc, &entry))
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIRLNK(entry.mode))
+			continue;
 		n_refs++;
+	}
 
 	/* Allocate object refs and walk it again.. */
 	i = 0;
@@ -162,6 +173,8 @@ static void track_tree_refs(struct tree *item)
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj;
 
+		if (S_ISDIRLNK(entry.mode))
+			continue;
 		if (S_ISDIR(entry.mode))
 			obj = &lookup_tree(entry.sha1)->object;
 		else
-- 
1.5.1.110.g1e4c
