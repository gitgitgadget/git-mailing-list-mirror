From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/11] object: try naive cuckoo hashing
Date: Thu, 11 Aug 2011 10:53:12 -0700
Message-ID: <1313085196-13249-8-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSU-0000IQ-2w
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1HKRxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab1HKRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA1E419E
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KkT0
	9hUCzQWkYV69neyBzUMSpms=; b=rKuOPYWTD2s6ALeFnSL/QXFZiudwhwx9PQCR
	9ZeTbkcR4tK11GLIhcbDOt4yGwKr60NUed6ZfvcUem0WaGfhKgUQfapMUpIGAJiT
	7KAfK4ZO4SLUlYKXEUthlg2d4erNF8xW+eCSN/l7VI+QZc0Ic/nzhqaDEaKGVn8Q
	gDrSHj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OaIhar
	vVLm6l3IjpO2dFguqE8Av5recvA53IqNm9j56irAL7t553MQMqQtyQRyn85sOgPY
	6M2fScA3vl15V7DfyfTc5Q5R6Si6UD2LJwToSPniBN9uDQ3NtO+yscBHU2xGzu8j
	WrrLzCN/6lX7hzqh9bRSbK5OaeThHzdGBGbIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9518D4197
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0CCF4193 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D4D3CA6C-C442-11E0-BC67-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179119>

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
../+v/65c71a61547aecd8a6830391fda31ed5d18e0529/git-pack-objects
Counting objects: 2139209, done.
32.04user 3.43system 0:35.58elapsed 99%CPU (0avgtext+0avgdata 8178672maxresident)k
0inputs+0outputs (0major+1206546minor)pagefaults 0swaps
Counting objects: 2139209, done.
33.41user 3.15system 0:36.67elapsed 99%CPU (0avgtext+0avgdata 8178688maxresident)k
0inputs+0outputs (0major+1206547minor)pagefaults 0swaps
Counting objects: 2139209, done.
32.24user 3.17system 0:35.51elapsed 99%CPU (0avgtext+0avgdata 8179968maxresident)k
0inputs+0outputs (0major+1206598minor)pagefaults 0swaps
---
 object.c |   99 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/object.c b/object.c
index c2c0a7d..7624c48 100644
--- a/object.c
+++ b/object.c
@@ -50,33 +50,52 @@ static unsigned int hash_val(const unsigned char *sha1)
 	return hash;
 }
 
-static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
-{
-	unsigned int j = hash_val(obj->sha1) & (size-1);
 
-	while (hash[j]) {
-		j++;
-		if (j >= size)
-			j = 0;
-	}
-	hash[j] = obj;
-}
+#define H1(sha1) (hash_val(sha1) % obj_hash_size)
+#define H2(sha1) (hash_val((sha1) + sizeof(unsigned int)) % obj_hash_size)
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	unsigned int i;
 	struct object *obj;
 
 	if (!obj_hash)
 		return NULL;
 
-	i = hash_val(sha1) & (obj_hash_size-1);
-	while ((obj = obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->sha1))
-			break;
-		i++;
-		if (i == obj_hash_size)
-			i = 0;
+	if ((obj = obj_hash[H1(sha1)]) && !hashcmp(sha1, obj->sha1))
+		return obj;
+	if ((obj = obj_hash[H2(sha1)]) && !hashcmp(sha1, obj->sha1))
+		return obj;
+	return NULL;
+}
+
+static void grow_object_hash(void); /* forward */
+
+/*
+ * A naive single-table cuckoo hashing implementation.
+ * Return NULL when "obj" is successfully inserted. Otherwise
+ * return a pointer to the object to be inserted (which may
+ * be different from the original obj). The caller is expected
+ * to grow the hash table and re-insert the returned object.
+ */
+static struct object *insert_obj_hash(struct object *obj)
+{
+	int loop;
+
+	for (loop = obj_hash_size / 2; 0 <= loop; loop--) {
+		struct object *tmp_obj;
+		unsigned int ix;
+
+		ix = H1(obj->sha1);
+		if (!obj_hash[ix]) {
+			obj_hash[ix] = obj;
+			return NULL;
+		}
+		ix = H2(obj->sha1);
+		tmp_obj = obj_hash[ix];
+		obj_hash[ix] = obj;
+		if (!tmp_obj)
+			return NULL;
+		obj = tmp_obj;
 	}
 	return obj;
 }
@@ -89,25 +108,36 @@ static int next_size(int sz)
 
 static void grow_object_hash(void)
 {
-	int i;
-	int new_hash_size = next_size(obj_hash_size);
-	struct object **new_hash;
-
-	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
-		if (!obj)
+	struct object **current_hash;
+	int current_size;
+
+	current_hash = obj_hash;
+	current_size = obj_hash_size;
+	while (1) {
+		int i;
+		obj_hash_size = next_size(obj_hash_size);
+		obj_hash = xcalloc(obj_hash_size, sizeof(struct object *));
+
+		for (i = 0; i < current_size; i++) {
+			if (!current_hash[i])
+				continue;
+			if (insert_obj_hash(current_hash[i]))
+				break;
+		}
+		if (i < current_size) {
+			/* too small - grow and retry */
+			free(obj_hash);
 			continue;
-		insert_obj_hash(obj, new_hash, new_hash_size);
+		}
+		free(current_hash);
+		return;
 	}
-	free(obj_hash);
-	obj_hash = new_hash;
-	obj_hash_size = new_hash_size;
 }
 
 void *create_object(const unsigned char *sha1, int type, void *o)
 {
 	struct object *obj = o;
+	struct object *to_insert;
 
 	obj->parsed = 0;
 	obj->used = 0;
@@ -117,8 +147,13 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 
 	if (obj_hash_size - 1 <= nr_objs * 2)
 		grow_object_hash();
-
-	insert_obj_hash(obj, obj_hash, obj_hash_size);
+	to_insert = obj;
+	while (1) {
+		to_insert = insert_obj_hash(to_insert);
+		if (!to_insert)
+			break;
+		grow_object_hash();
+	}
 	nr_objs++;
 	return obj;
 }
-- 
1.7.6.433.g1421f
