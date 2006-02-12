From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 20:11:49 -0800
Message-ID: <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
	<7vslqpi9mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 05:12:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F88aj-00078E-O7
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 05:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBLELw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWBLELw
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 23:11:52 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16586 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750965AbWBLELv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 23:11:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212040911.EULI26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 23:09:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 11 Feb 2006 18:39:03 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15979>

This implements Linus' idea to keep objects in a binary tree,
instead of using the linear array as we currently do.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I haven't benched this seriously yet.  One datapoint:

	time git-rev-list --objects v2.6.15..linus | wc -l

   are 53sec vs 22sec improvement with the same output.

 fsck-objects.c |   36 +++++++++++++++++----------------
 name-rev.c     |   17 +++++++++++-----
 object.c       |   61 +++++++++++++++++++++-----------------------------------
 object.h       |    3 ++-
 4 files changed, 55 insertions(+), 62 deletions(-)

3c160f4d94cf16db5dc9c603e98ebacbe9ac4ca7
diff --git a/fsck-objects.c b/fsck-objects.c
index 9950be2..28a7c1b 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -56,23 +56,21 @@ static int objwarning(struct object *obj
 }
 
 
-static void check_connectivity(void)
+static void check_connectivity(struct object *obj)
 {
-	int i;
-
 	/* Look up all the requirements, warn about missing objects.. */
-	for (i = 0; i < nr_objs; i++) {
-		struct object *obj = objs[i];
-
-		if (!obj->parsed) {
-			if (!standalone && has_sha1_file(obj->sha1))
-				; /* it is in pack */
-			else
-				printf("missing %s %s\n",
-				       obj->type, sha1_to_hex(obj->sha1));
-			continue;
-		}
+ again:
+	if (!obj)
+		return;
 
+	if (!obj->parsed) {
+		if (!standalone && has_sha1_file(obj->sha1))
+			; /* it is in pack */
+		else
+			printf("missing %s %s\n",
+			       obj->type, sha1_to_hex(obj->sha1));
+	}
+	else {
 		if (obj->refs) {
 			const struct object_refs *refs = obj->refs;
 			unsigned j;
@@ -91,14 +89,16 @@ static void check_connectivity(void)
 		if (show_unreachable && !(obj->flags & REACHABLE)) {
 			printf("unreachable %s %s\n",
 			       obj->type, sha1_to_hex(obj->sha1));
-			continue;
 		}
-
-		if (!obj->used) {
+		else if (!obj->used) {
 			printf("dangling %s %s\n", obj->type, 
 			       sha1_to_hex(obj->sha1));
 		}
 	}
+	if (obj->left && obj->right)
+		check_connectivity(obj->left);
+	obj = obj->right ? obj->right : obj->left;
+	goto again;
 }
 
 /*
@@ -556,6 +556,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	check_connectivity();
+	check_connectivity(objs_root);
 	return 0;
 }
diff --git a/name-rev.c b/name-rev.c
index bbadb91..a4fecfb 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -120,6 +120,17 @@ static const char* get_rev_name(struct o
 	return buffer;
 }
 	
+void show_all_names(struct object *obj)
+{
+	while (obj) {
+		printf("%s %s\n", sha1_to_hex(obj->sha1), get_rev_name(obj));
+		if (obj->left && obj->right)
+			show_all_names(obj->left);
+		obj = obj->right ? obj->right : obj->left;
+	}
+}
+
+
 int main(int argc, char **argv)
 {
 	struct object_list *revs = NULL;
@@ -230,11 +241,7 @@ int main(int argc, char **argv)
 				fwrite(p_start, p - p_start, 1, stdout);
 		}
 	} else if (all) {
-		int i;
-
-		for (i = 0; i < nr_objs; i++)
-			printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
-					get_rev_name(objs[i]));
+		show_all_names(objs_root);
 	} else
 		for ( ; revs; revs = revs->next)
 			printf("%s %s\n", revs->name, get_rev_name(revs->item));
diff --git a/object.c b/object.c
index 1577f74..a1b0729 100644
--- a/object.c
+++ b/object.c
@@ -5,65 +5,50 @@
 #include "commit.h"
 #include "tag.h"
 
-struct object **objs;
+struct object *objs_root;
 int nr_objs;
-static int obj_allocs;
 
 int track_object_refs = 1;
 
-static int find_object(const unsigned char *sha1)
+static struct object **lookup_object_position(const unsigned char *sha1)
 {
-	int first = 0, last = nr_objs;
+	struct object **p = &objs_root;
 
-        while (first < last) {
-                int next = (first + last) / 2;
-                struct object *obj = objs[next];
-                int cmp;
-
-                cmp = memcmp(sha1, obj->sha1, 20);
-                if (!cmp)
-                        return next;
-                if (cmp < 0) {
-                        last = next;
-                        continue;
-                }
-                first = next+1;
-        }
-        return -first-1;
+	for (;;) {
+		struct object *object = *p;
+		int sign;
+
+		if (!object)
+			break;
+		sign = memcmp(sha1, object->sha1, 20);
+		if (!sign)
+			break;
+		p = &object->left;
+		if (sign < 0)
+			continue;
+		p = &object->right;
+	}
+	return p;
 }
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	int pos = find_object(sha1);
-	if (pos >= 0)
-		return objs[pos];
-	return NULL;
+	return *lookup_object_position(sha1);
 }
 
 void created_object(const unsigned char *sha1, struct object *obj)
 {
-	int pos = find_object(sha1);
+	struct object **op = lookup_object_position(sha1);
 
 	obj->parsed = 0;
 	memcpy(obj->sha1, sha1, 20);
 	obj->type = NULL;
 	obj->refs = NULL;
 	obj->used = 0;
-
-	if (pos >= 0)
+	obj->left = obj->right = NULL;
+	if (*op)
 		die("Inserting %s twice\n", sha1_to_hex(sha1));
-	pos = -pos-1;
-
-	if (obj_allocs == nr_objs) {
-		obj_allocs = alloc_nr(obj_allocs);
-		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
-	}
-
-	/* Insert it into the right place */
-	memmove(objs + pos + 1, objs + pos, (nr_objs - pos) * 
-		sizeof(struct object *));
-
-	objs[pos] = obj;
+	*op = obj;
 	nr_objs++;
 }
 
diff --git a/object.h b/object.h
index 0e76182..32b276d 100644
--- a/object.h
+++ b/object.h
@@ -19,12 +19,13 @@ struct object {
 	unsigned char sha1[20];
 	const char *type;
 	struct object_refs *refs;
+	struct object *left, *right;
 	void *util;
 };
 
 extern int track_object_refs;
 extern int nr_objs;
-extern struct object **objs;
+extern struct object *objs_root;
 
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
-- 
1.1.6.g69c5
