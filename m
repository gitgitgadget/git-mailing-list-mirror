From: Junio C Hamano <junkio@cox.net>
Subject: (rework) [PATCH 5/5] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:24:24 -0700
Message-ID: <7vr7h5geo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:21:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPQr-0003Eg-E7
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVDUAY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVDUAY5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:24:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32453 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261861AbVDUAYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:24:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421002424.XBTE4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:24:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updates read-tree to use read_tree_with_tree_or_commit_sha1()
function.  The command can take either tree or commit IDs with
this patch.

The change involves a slight modification of how it recurses down
the tree.  Earlier the caller only supplied SHA1 and the recurser
read the object using it, but now it is the caller's responsibility
to read the object and give it to the recurser.  This matches the
way recursive behaviour is done in other tree- related commands.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-tree.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

read-tree.c: 46747b5e99b102ed547e87f55a8ee734c9ddb074
--- a/read-tree.c
+++ b/read-tree.c
@@ -23,16 +23,11 @@ static int read_one_entry(unsigned char 
 	return add_cache_entry(ce, 1);
 }
 
-static int read_tree(unsigned char *sha1, const char *base, int baselen)
+static int read_tree_recursive(void *buffer, const char *type,
+			       unsigned long size,
+			       const char *base, int baselen)
 {
-	void *buffer;
-	unsigned long size;
-	char type[20];
-
-	buffer = read_sha1_file(sha1, type, &size);
-	if (!buffer)
-		return -1;
-	if (strcmp(type, "tree"))
+	if (!buffer || strcmp(type, "tree"))
 		return -1;
 	while (size) {
 		int len = strlen(buffer)+1;
@@ -50,10 +45,20 @@ static int read_tree(unsigned char *sha1
 			int retval;
 			int pathlen = strlen(path);
 			char *newbase = malloc(baselen + 1 + pathlen);
+			void *eltbuf;
+			char elttype[20];
+			unsigned long eltsize;
+
+			eltbuf = read_sha1_file(sha1, elttype, &eltsize);
+			if (!eltbuf)
+				return -1;
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, path, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree(sha1, newbase, baselen + pathlen + 1);
+			retval = read_tree_recursive(eltbuf, elttype, eltsize,
+						     newbase,
+						     baselen + pathlen + 1);
+			free(eltbuf);
 			free(newbase);
 			if (retval)
 				return -1;
@@ -65,6 +70,15 @@ static int read_tree(unsigned char *sha1
 	return 0;
 }
 
+static int read_tree(unsigned char *sha1, const char *base, int baselen)
+{
+	void *buffer;
+	unsigned long size;
+
+	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
+	return read_tree_recursive(buffer, "tree", size, base, baselen);
+}
+
 static int remove_lock = 0;
 
 static void remove_lock_file(void)

