From: Linus Torvalds <torvalds@osdl.org>
Subject: git object hash cleanups
Date: Fri, 30 Jun 2006 11:20:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606301108440.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jun 30 20:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNbn-0002v5-Rk
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbWF3SUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWF3SUs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:20:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932079AbWF3SUq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 14:20:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5UIKYnW028208
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 11:20:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5UIKXmV017703;
	Fri, 30 Jun 2006 11:20:34 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23011>


This IMNSHO cleans up the object hashing.

The hash expansion is separated out into a function of its own, the hash 
array (and size) names are made more obvious, and the code is generally 
made to look a bit more like the object-ref hashing.

It also gets rid of "find_object()" returning an index (or negative 
position if no object is found), since that is made redundant by the 
simplified object rehashing. The basic operation is now "lookup_object()" 
which just returns the object itself.

There's an almost unmeasurable speed increase, but more importantly, I 
think the end result is more readable.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I tried to be really careful, and this should all be good, but I'm still 
embarrassed about my hash insertion bug in object-refs.c, so people should 
double- and triple-check this.

diff --git a/object.c b/object.c
index 31c77ea..37277f9 100644
--- a/object.c
+++ b/object.c
@@ -5,88 +5,97 @@ #include "tree.h"
 #include "commit.h"
 #include "tag.h"
 
-static struct object **objs;
-static int nr_objs, obj_allocs;
+static struct object **obj_hash;
+static int nr_objs, obj_hash_size;
 
 unsigned int get_max_object_index(void)
 {
-	return obj_allocs;
+	return obj_hash_size;
 }
 
 struct object *get_indexed_object(unsigned int idx)
 {
-	return objs[idx];
+	return obj_hash[idx];
 }
 
 const char *type_names[] = {
 	"none", "blob", "tree", "commit", "bad"
 };
 
+static unsigned int hash_obj(struct object *obj, unsigned int n)
+{
+	unsigned int hash = *(unsigned int *)obj->sha1;
+	return hash % n;
+}
+
+static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
+{
+	int j = hash_obj(obj, size);
+
+	while (hash[j]) {
+		j++;
+		if (j >= size)
+			j = 0;
+	}
+	hash[j] = obj;
+}
+
 static int hashtable_index(const unsigned char *sha1)
 {
 	unsigned int i;
 	memcpy(&i, sha1, sizeof(unsigned int));
-	return (int)(i % obj_allocs);
+	return (int)(i % obj_hash_size);
 }
 
-static int find_object(const unsigned char *sha1)
+struct object *lookup_object(const unsigned char *sha1)
 {
 	int i;
+	struct object *obj;
 
-	if (!objs)
-		return -1;
+	if (!obj_hash)
+		return NULL;
 
 	i = hashtable_index(sha1);
-	while (objs[i]) {
-		if (memcmp(sha1, objs[i]->sha1, 20) == 0)
-			return i;
+	while ((obj = obj_hash[i]) != NULL) {
+		if (!memcmp(sha1, obj->sha1, 20))
+			break;
 		i++;
-		if (i == obj_allocs)
+		if (i == obj_hash_size)
 			i = 0;
 	}
-	return -1 - i;
+	return obj;
 }
 
-struct object *lookup_object(const unsigned char *sha1)
+static void grow_object_hash(void)
 {
-	int pos = find_object(sha1);
-	if (pos >= 0)
-		return objs[pos];
-	return NULL;
+	int i;
+	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	struct object **new_hash;
+
+	new_hash = calloc(new_hash_size, sizeof(struct object *));
+	for (i = 0; i < obj_hash_size; i++) {
+		struct object *obj = obj_hash[i];
+		if (!obj)
+			continue;
+		insert_obj_hash(obj, new_hash, new_hash_size);
+	}
+	free(obj_hash);
+	obj_hash = new_hash;
+	obj_hash_size = new_hash_size;
 }
 
 void created_object(const unsigned char *sha1, struct object *obj)
 {
-	int pos;
-
 	obj->parsed = 0;
-	memcpy(obj->sha1, sha1, 20);
-	obj->type = TYPE_NONE;
 	obj->used = 0;
+	obj->type = TYPE_NONE;
+	obj->flags = 0;
+	memcpy(obj->sha1, sha1, 20);
 
-	if (obj_allocs - 1 <= nr_objs * 2) {
-		int i, count = obj_allocs;
-		obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs);
-		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
-		memset(objs + count, 0, (obj_allocs - count)
-				* sizeof(struct object *));
-		for (i = 0; i < obj_allocs; i++)
-			if (objs[i]) {
-				int j = find_object(objs[i]->sha1);
-				if (j != i) {
-					j = -1 - j;
-					objs[j] = objs[i];
-					objs[i] = NULL;
-				}
-			}
-	}
-
-	pos = find_object(sha1);
-	if (pos >= 0)
-		die("Inserting %s twice\n", sha1_to_hex(sha1));
-	pos = -pos-1;
+	if (obj_hash_size - 1 <= nr_objs * 2)
+		grow_object_hash();
 
-	objs[pos] = obj;
+	insert_obj_hash(obj, obj_hash, obj_hash_size);
 	nr_objs++;
 }
 
