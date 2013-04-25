From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Thu, 25 Apr 2013 20:04:01 +0200
Message-ID: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQWh-0001Py-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193Ab3DYSEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:04:06 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19267 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab3DYSEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:04:05 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 20:03:59 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 20:04:01 +0200
X-Mailer: git-send-email 1.8.2.1.961.g06c38a5.dirty
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222402>

The existing obj_hash is really straightforward: it holds a struct
object * and spills into the subsequent slots (linear probing), which
is good enough because it doesn't need to support deletion.

However, this arrangement has pretty bad cache locality in the case of
collisions.  Because the sha1 is contained in the object itself, it
resides in a different memory region from the hash table.  So whenever
we have to process a hash collision, we need to access (and
potentially fetch from slower caches or memory) an object that we are
not going to use again.

And probing lookups happen a lot: some simple instrumentation shows
that 'git rev-list --all --objects' on my git.git,

* 19.4M objects are accessed in lookup_object and grow_object_hash
  combined, while

* the linear probing loops in lookup_object and insert_obj_hash run a
  total of 9.4M times.

So we take a slightly different approach, and trade some memory for
better cache locality.  Namely, we change the hash table slots to
contain

  struct object *obj;
  unsigned long sha1prefix;

We use this new 'sha1prefix' field to store the first part of the
object's sha1, from which its hash table slot is computed.  This
allows us to do two things with data that resides inside the hash
table:

* In lookup_object(), we can do a pre-filtering of the probed slots;
  the probability that we need to actually peek inside any colliding
  object(s) is very small.

* In grow_object_hash(), we actually do not need to look inside the
  objects at all.  This should give a substantial speedup during
  hashtable resizing.

The choice of 'long' makes it the same size as a pointer (to which any
smaller data type would be padded anyway) on x86 and x86_64 Linuxen,
and probably many others.  So the hash table will be twice as big as
before.

I get a decent speedup, for example using git.git as a test
repository:

Test                               before              after
---------------------------------------------------------------------------------
0001.1: rev-list --all             0.42(0.40+0.01)     0.41(0.39+0.01)   -1.5%**
0001.2: rev-list --all --objects   2.40(2.37+0.03)     2.28(2.25+0.03)   -5.0%***
---------------------------------------------------------------------------------

And even more in linux.git:

---------------------------------------------------------------------------------
0001.1: rev-list --all             3.31(3.19+0.12)     3.21(3.09+0.11)   -2.9%**
0001.2: rev-list --all --objects   27.99(27.70+0.26)   25.99(25.71+0.25) -7.1%***
---------------------------------------------------------------------------------

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

I expected the big win to be in grow_object_hash(), but perf says that
'git rev-list --all --objects' spends a whopping 33.6% of its time in
lookup_object(), and this change gets that down to 30.0%.

 object.c | 58 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/object.c b/object.c
index 20703f5..6b84c87 100644
--- a/object.c
+++ b/object.c
@@ -5,7 +5,12 @@
 #include "commit.h"
 #include "tag.h"
 
-static struct object **obj_hash;
+struct obj_hash_ent {
+	struct object *obj;
+	unsigned long sha1prefix;
+};
+
+static struct obj_hash_ent *obj_hash;
 static int nr_objs, obj_hash_size;
 
 unsigned int get_max_object_index(void)
@@ -15,7 +20,7 @@ unsigned int get_max_object_index(void)
 
 struct object *get_indexed_object(unsigned int idx)
 {
-	return obj_hash[idx];
+	return obj_hash[idx].obj;
 }
 
 static const char *object_type_strings[] = {
@@ -43,43 +48,52 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned long hash_sha1(const unsigned char *sha1)
 {
-	unsigned int hash;
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
-	return hash % n;
+	unsigned long sha1prefix;
+	memcpy(&sha1prefix, sha1, sizeof(unsigned long));
+	return sha1prefix;
 }
 
-static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
+static unsigned long hash_obj(struct object *obj)
 {
-	unsigned int j = hash_obj(obj, size);
+	return hash_sha1(obj->sha1);
+}
 
-	while (hash[j]) {
+static void insert_obj_hash_1(struct object *obj, struct obj_hash_ent *hash, unsigned int size,
+			      unsigned long sha1prefix)
+{
+	unsigned int j = (unsigned int) sha1prefix % size;
+
+	while (hash[j].obj) {
 		j++;
 		if (j >= size)
 			j = 0;
 	}
-	hash[j] = obj;
+	hash[j].obj = obj;
+	hash[j].sha1prefix = sha1prefix;
 }
 
-static unsigned int hashtable_index(const unsigned char *sha1)
+static void insert_obj_hash(struct object *obj, struct obj_hash_ent *table, unsigned int size)
 {
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return i % obj_hash_size;
+	unsigned long sha1prefix = hash_obj(obj);
+	insert_obj_hash_1(obj, table, size, sha1prefix);
 }
 
 struct object *lookup_object(const unsigned char *sha1)
 {
+	unsigned long sha1prefix;
 	unsigned int i;
 	struct object *obj;
 
 	if (!obj_hash)
 		return NULL;
 
-	i = hashtable_index(sha1);
-	while ((obj = obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->sha1))
+	sha1prefix = hash_sha1(sha1);
+	i = (unsigned int) sha1prefix % obj_hash_size;
+	while ((obj = obj_hash[i].obj) != NULL) {
+		if (obj_hash[i].sha1prefix == sha1prefix
+		    && !hashcmp(sha1, obj->sha1))
 			break;
 		i++;
 		if (i == obj_hash_size)
@@ -92,14 +106,14 @@ static void grow_object_hash(void)
 {
 	int i;
 	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
-	struct object **new_hash;
+	struct obj_hash_ent *new_hash;
 
-	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
+	new_hash = xcalloc(new_hash_size, sizeof(struct obj_hash_ent));
 	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+		struct object *obj = obj_hash[i].obj;
 		if (!obj)
 			continue;
-		insert_obj_hash(obj, new_hash, new_hash_size);
+		insert_obj_hash_1(obj, new_hash, new_hash_size, obj_hash[i].sha1prefix);
 	}
 	free(obj_hash);
 	obj_hash = new_hash;
@@ -302,7 +316,7 @@ void clear_object_flags(unsigned flags)
 	int i;
 
 	for (i=0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
+		struct object *obj = obj_hash[i].obj;
 		if (obj)
 			obj->flags &= ~flags;
 	}
-- 
1.8.2.1.961.g06c38a5.dirty
