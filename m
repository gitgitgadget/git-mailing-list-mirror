X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 14:28:09 -0800
Message-ID: <7vpsar2xom.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612101030390.12500@woody.osdl.org>
	<7vpsar4fcu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 22:28:34 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vpsar4fcu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 10 Dec 2006 13:21:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33943>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtX9b-0001zw-BN for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759147AbWLJW2M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759268AbWLJW2M
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:28:12 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64769 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759147AbWLJW2L (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 17:28:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210222810.WENL18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 17:28:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xATY1V00j1kojtg0000000; Sun, 10 Dec 2006
 17:27:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> So you could make "read_sha1_file()" just have a special case for known 
>> objects at the end. If the pack entry fails, the loose file case fails, 
>> then rather than returning NULL at the end, you could have a list of known 
>> fixed objects..
>
> That is fine by me.  We would benefit from an empty blob and an
> empty tree.

I think this might be fragile in the presense of older
implementation of git.

A new git may operate fine without having "well known" objects
in the repository, and would happily write result that points at
them; an older git would find the resulting repository corrupt.

We somehow need to force "well known" objects to be instantiated
in the object database when something else points at them.  I am
not absolutely sure if keeping has_sha1_file() unaware of this
magic is enough.

-- >8 --
Implement "well known" built-in objects.

Make read_sha1_file() aware of a handful "well known" objects
and use built-in copy when they are not found in the object
database.

Note that we do not hook this into has_sha1_file(), so it is
possible that has_sha1_file() says you do not have an empty tree
object in your repository but read_sha1_file() successfully
gives you an empty tree object back.

Otherwise write_sha1_file() would not create "well known"
objects in the repository, leaving the repository corrupt for
older implementations of git.

---

diff --git a/cache.h b/cache.h
index f2ec5c8..7ee40e8 100644
--- a/cache.h
+++ b/cache.h
@@ -241,6 +241,10 @@ int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 
+/* Well known object names */
+extern unsigned const char EMPTY_TREE_NAME[];
+extern unsigned const char EMPTY_BLOB_NAME[];
+
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
diff --git a/merge-recursive.c b/merge-recursive.c
index 32e186c..1c56fd3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1234,11 +1234,8 @@ static int merge(struct commit *h1,
 	merged_common_ancestors = pop_commit(&ca);
 	if (merged_common_ancestors == NULL) {
 		/* if there is no common ancestor, make an empty tree */
-		struct tree *tree = xcalloc(1, sizeof(struct tree));
-
-		tree->object.parsed = 1;
-		tree->object.type = OBJ_TREE;
-		write_sha1_file(NULL, 0, tree_type, tree->object.sha1);
+		struct tree *tree = lookup_tree(EMPTY_TREE_NAME);
+		parse_tree(tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/sha1_file.c b/sha1_file.c
index 63f416b..c6efe88 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1315,11 +1315,32 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
 	return unpack_entry(&e, type, size);
 }
 
-void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+unsigned const char EMPTY_TREE_NAME[20] = {
+	0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9,	0xa0, 0x60,
+	0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04,
+};
+
+unsigned const char EMPTY_BLOB_NAME[20] = {
+	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,
+	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91,
+};
+
+static struct well_known_objects {
+	char *type;
+	unsigned const char *sha1;
+	unsigned long size;
+	const char *data;
+} well_known_objects[] = {
+	{ "tree", EMPTY_TREE_NAME, 0UL, "" },
+	{ "blob", EMPTY_BLOB_NAME, 0UL, "" },
+};
+
+void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
 	struct pack_entry e;
+	int i;
 
 	if (find_pack_entry(sha1, &e, NULL))
 		return read_packed_sha1(sha1, type, size);
@@ -1332,6 +1353,17 @@ void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size
 	reprepare_packed_git();
 	if (find_pack_entry(sha1, &e, NULL))
 		return read_packed_sha1(sha1, type, size);
+
+	/* "well known" objects */
+	for (i = 0; i < ARRAY_SIZE(well_known_objects); i++) {
+		if (!hashcmp(well_known_objects[i].sha1, sha1)) {
+			*size = well_known_objects[i].size;
+			buf = xmalloc(*size);
+			strcpy(type, well_known_objects[i].type);
+			memcpy(buf, well_known_objects[i].data, *size);
+			return buf;
+		}
+	}
 	return NULL;
 }
 
