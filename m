From: Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 16:45:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 19 01:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVzss-0005sL-6N
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 01:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDRXpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDRXpW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 19:45:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbWDRXpV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 19:45:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3INjHtH026552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 16:45:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3INjG40031167;
	Tue, 18 Apr 2006 16:45:16 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18884>



[ NOTE! The reason I put "RFC" in the subject rather than "PATCH" is that 
  I'm not 100% sure this isn't just a "shiny object" of mine rather than a 
  really useful thing to do. What do people think? Have you ever wanted to 
  access individual files in some random revision? Do you think this is 
  useful? I think it's cool and _may_ be useful, but I'm not going to 
  really push this patch. Consider it a throw-away patch unless somebody 
  else finds it intriguing enough.. ]

This is a fairly straightforward patch to allow "get_sha1()" to also have 
shorthands for tree and blob objects.

The syntax is very simple and intuitive: you can specify a tree or a blob 
by simply specifying <revision>:<path>, and get_sha1() will do the SHA1 
lookup from the tree for you.

You can currently do it with "git ls-tree <rev> <path>" and parsing the 
output, but that's actually pretty awkward.

With this, you can do something like

	git cat-file blob v1.2.4:Makefile

to get the contents of "Makefile" at revision v1.2.4.

Now, this isn't necessarily something you really need all that often, but 
the concept itself is actually pretty powerful. We could, for example, 
allow things like

	git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh

to see the difference between two arbitrary files in two arbitrary 
revisions. To do that, the only thing we'd have to do is to make 
git-diff-tree accept two blobs to diff, in addition to the two trees it 
now expects.

[ IOW, don't get me wrong: the get_sha1() parsing is just the first step, 
  and does _not_ allow that "git diff" syntax to work yet. It parses the 
  object names fine, but git-diff-tree will currently exit with a "fatal: 
  unable to read source tree" error message because the objects aren't 
  tree objects ]

			Linus
---
diff --git a/sha1_name.c b/sha1_name.c
index 4f92e12..0cd1139 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -3,6 +3,7 @@ #include "tag.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "diff.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -449,12 +450,76 @@ static int get_sha1_1(const char *name, 
 	return get_short_sha1(name, len, sha1, 0);
 }
 
+static int get_tree_entry(const unsigned char *, const char *, unsigned char *);
+
+static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result)
+{
+	int namelen = strlen(name);
+	while (t->size) {
+		const char *entry;
+		const unsigned char *sha1;
+		int entrylen, cmp;
+		unsigned mode;
+
+		sha1 = tree_entry_extract(t, &entry, &mode);
+		update_tree_entry(t);
+		entrylen = strlen(entry);
+		if (entrylen > namelen)
+			continue;
+		cmp = memcmp(name, entry, entrylen);
+		if (cmp > 0)
+			continue;
+		if (cmp < 0)
+			break;
+		if (entrylen == namelen) {
+			memcpy(result, sha1, 20);
+			return 0;
+		}
+		if (name[entrylen] != '/')
+			continue;
+		if (!S_ISDIR(mode))
+			break;
+		if (++entrylen == namelen) {
+			memcpy(result, sha1, 20);
+			return 0;
+		}
+		return get_tree_entry(sha1, name + entrylen, result);
+	}
+	return -1;
+}
+
+static int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned char *sha1)
+{
+	int retval;
+	void *tree;
+	struct tree_desc t;
+
+	tree = read_object_with_reference(tree_sha1, tree_type, &t.size, NULL);
+	if (!tree)
+		return -1;
+	t.buf = tree;
+	retval = find_tree_entry(&t, name, sha1);
+	free(tree);
+	return retval;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
  */
 int get_sha1(const char *name, unsigned char *sha1)
 {
+	int ret;
+
 	prepare_alt_odb();
-	return get_sha1_1(name, strlen(name), sha1);
+	ret = get_sha1_1(name, strlen(name), sha1);
+	if (ret < 0) {
+		const char *cp = strchr(name, ':');
+		if (cp) {
+			unsigned char tree_sha1[20];
+			if (!get_sha1_1(name, cp-name, tree_sha1))
+				return get_tree_entry(tree_sha1, cp+1, sha1);
+		}
+	}
+	return ret;
 }
