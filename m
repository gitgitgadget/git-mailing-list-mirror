From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sat, 12 May 2007 23:35:10 +0200
Message-ID: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 23:35:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmzFH-0005g1-OO
	for gcvg-git@gmane.org; Sat, 12 May 2007 23:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXELVfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 17:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXELVfO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 17:35:14 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:47521 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753395AbXELVfN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2007 17:35:13 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id BB8353F302; Sat, 12 May 2007 23:35:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47097>

This patch moves two inline functions from a header file to the corresponding c
file. Otherwise forte12 refuses to compile git with the following error:

    LINK git-convert-objects
ld: fatal: symbol `tree_entry_extract' is multiply-defined:
        (file libgit.a(sha1_name.o) type=FUNC; file libgit.a(tree.o) type=FUNC);
ld: fatal: symbol `tree_entry_extract' is multiply-defined:
        (file libgit.a(sha1_name.o) type=FUNC; file libgit.a(tree-walk.o) type=FUNC);
ld: fatal: File processing errors. No output written to git-convert-objects
gmake[1]: *** [git-convert-objects] Error 1

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
---
 tree-walk.c |   14 ++++++++++++++
 tree-walk.h |   13 +------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index cbb24eb..ef57951 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,20 @@
 #include "tree-walk.h"
 #include "tree.h"
 
+inline int tree_entry_len(const char *name, const unsigned char *sha1)
+{
+	return (char *)sha1 - (char *)name - 1;
+}
+
+inline const unsigned char *tree_entry_extract(struct tree_desc *desc,
+                                     const char **pathp, unsigned int *modep)
+{
+	*pathp = desc->entry.path;
+	*modep = canon_mode(desc->entry.mode);
+	return desc->entry.sha1;
+}
+
+
 static const char *get_mode(const char *str, unsigned int *modep)
 {
 	unsigned char c;
diff --git a/tree-walk.h b/tree-walk.h
index 43458cf..984f19e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -13,21 +13,10 @@ struct tree_desc {
 	unsigned int size;
 };
 
-static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
-{
-	*pathp = desc->entry.path;
-	*modep = canon_mode(desc->entry.mode);
-	return desc->entry.sha1;
-}
-
-static inline int tree_entry_len(const char *name, const unsigned char *sha1)
-{
-	return (char *)sha1 - (char *)name - 1;
-}
-
 void update_tree_entry(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
+int tree_entry_len(const char *name, const unsigned char *sha1);
 
 /* Helper function that does both of the above and returns true for success */
 int tree_entry(struct tree_desc *, struct name_entry *);
-- 
1.5.1.3
