From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] sha1_name.c: prepare to make get_tree_entry() reusable from others.
Date: Wed, 19 Apr 2006 13:01:13 -0700
Message-ID: <7v8xq18hdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 19 22:02:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWIrX-0006wA-7h
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWDSUBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDSUBP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 16:01:15 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20120 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750893AbWDSUBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 16:01:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419200114.EDUM16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 16:01:14 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18937>

Make the mode information extracted from the tree available.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This comes on top of the extended SHA1 expression sha1:path
   patch Linus did.

 sha1_name.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 0cd1139..35e8dfb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -450,18 +450,17 @@ static int get_sha1_1(const char *name, 
 	return get_short_sha1(name, len, sha1, 0);
 }
 
-static int get_tree_entry(const unsigned char *, const char *, unsigned char *);
+static int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
 
-static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result)
+static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
 {
 	int namelen = strlen(name);
 	while (t->size) {
 		const char *entry;
 		const unsigned char *sha1;
 		int entrylen, cmp;
-		unsigned mode;
 
-		sha1 = tree_entry_extract(t, &entry, &mode);
+		sha1 = tree_entry_extract(t, &entry, mode);
 		update_tree_entry(t);
 		entrylen = strlen(entry);
 		if (entrylen > namelen)
@@ -477,18 +476,18 @@ static int find_tree_entry(struct tree_d
 		}
 		if (name[entrylen] != '/')
 			continue;
-		if (!S_ISDIR(mode))
+		if (!S_ISDIR(*mode))
 			break;
 		if (++entrylen == namelen) {
 			memcpy(result, sha1, 20);
 			return 0;
 		}
-		return get_tree_entry(sha1, name + entrylen, result);
+		return get_tree_entry(sha1, name + entrylen, result, mode);
 	}
 	return -1;
 }
 
-static int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned char *sha1)
+static int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned char *sha1, unsigned *mode)
 {
 	int retval;
 	void *tree;
@@ -498,7 +497,7 @@ static int get_tree_entry(const unsigned
 	if (!tree)
 		return -1;
 	t.buf = tree;
-	retval = find_tree_entry(&t, name, sha1);
+	retval = find_tree_entry(&t, name, sha1, mode);
 	free(tree);
 	return retval;
 }
@@ -510,6 +509,7 @@ static int get_tree_entry(const unsigned
 int get_sha1(const char *name, unsigned char *sha1)
 {
 	int ret;
+	unsigned unused;
 
 	prepare_alt_odb();
 	ret = get_sha1_1(name, strlen(name), sha1);
@@ -518,7 +518,8 @@ int get_sha1(const char *name, unsigned 
 		if (cp) {
 			unsigned char tree_sha1[20];
 			if (!get_sha1_1(name, cp-name, tree_sha1))
-				return get_tree_entry(tree_sha1, cp+1, sha1);
+				return get_tree_entry(tree_sha1, cp+1, sha1,
+						      &unused);
 		}
 	}
 	return ret;
-- 
1.3.0.g2c4a
