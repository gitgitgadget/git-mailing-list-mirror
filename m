From: Linus Torvalds <torvalds@osdl.org>
Subject: Abstract out accesses to object hash array
Date: Thu, 29 Jun 2006 21:38:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606292122570.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jun 30 06:39:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwAmX-0007WK-3r
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 06:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWF3EjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 00:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWF3EjA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 00:39:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932573AbWF3EjA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 00:39:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5U4cunW016617
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 21:38:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5U4ctap025364;
	Thu, 29 Jun 2006 21:38:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22953>


There are a few special places where some programs accessed the object 
hash array directly, which bothered me because I wanted to play with some 
simple re-organizations.

So this patch makes the object hash array data structures all entirely 
local to object.c, and the few users who wanted to look at it now get to 
use a function to query how many object index entries there can be, and to 
actually access the array.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

It turns out that "lookup_object()" and "memcmp()" are the two hottest 
routines by far in git-rev-list, and the problem is that the object array 
grows pretty big. On its own, the object array would generally fit pretty 
well in the CPU caches, but when it ends up only containing a pointer, and 
we then do a memory compare on the result, the CPU cache ends up being 
toast.

Now, the object array actually has two bits free, and I was going to hide 
two bits of the SHA1 name in there, allowing me to avoid doing a memcmp() 
for 75% of the collision cases.

Sadly, my crazy evil scheme doesn't actually help (the hashes work so well 
that we have comparatively few collisions), but this cleanup seemed a 
worthwhile result of my temporary insanity.

diff --git a/fsck-objects.c b/fsck-objects.c
index 769bb2a..ef54a8a 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -60,12 +60,13 @@ static int objwarning(struct object *obj
 
 static void check_connectivity(void)
 {
-	int i;
+	int i, max;
 
 	/* Look up all the requirements, warn about missing objects.. */
-	for (i = 0; i < obj_allocs; i++) {
+	max = get_max_object_index();
+	for (i = 0; i < max; i++) {
 		const struct object_refs *refs;
-		struct object *obj = objs[i];
+		struct object *obj = get_indexed_object(i);
 
 		if (!obj)
 			continue;
diff --git a/name-rev.c b/name-rev.c
index 3a5ac35..6a23f2d 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -234,12 +234,15 @@ #define ishex(x) (isdigit((x)) || ((x) >
 				fwrite(p_start, p - p_start, 1, stdout);
 		}
 	} else if (all) {
-		int i;
+		int i, max;
 
-		for (i = 0; i < obj_allocs; i++)
-			if (objs[i])
-				printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
-						get_rev_name(objs[i]));
+		max = get_max_object_index();
+		for (i = 0; i < max; i++) {
+			struct object * obj = get_indexed_object(i);
+			if (!obj)
+				continue;
+			printf("%s %s\n", sha1_to_hex(obj->sha1), get_rev_name(obj));
+		}
 	} else {
 		int i;
 		for (i = 0; i < revs.nr; i++)
diff --git a/object.c b/object.c
index 37784ce..31c77ea 100644
--- a/object.c
+++ b/object.c
@@ -5,9 +5,18 @@ #include "tree.h"
 #include "commit.h"
 #include "tag.h"
 
-struct object **objs;
-static int nr_objs;
-int obj_allocs;
+static struct object **objs;
+static int nr_objs, obj_allocs;
+
+unsigned int get_max_object_index(void)
+{
+	return obj_allocs;
+}
+
+struct object *get_indexed_object(unsigned int idx)
+{
+	return objs[idx];
+}
 
 const char *type_names[] = {
 	"none", "blob", "tree", "commit", "bad"
diff --git a/object.h b/object.h
index 6f23a9a..e0125e1 100644
--- a/object.h
+++ b/object.h
@@ -40,10 +40,11 @@ struct object {
 };
 
 extern int track_object_refs;
-extern int obj_allocs;
-extern struct object **objs;
 extern const char *type_names[];
 
+extern unsigned int get_max_object_index(void);
+extern struct object *get_indexed_object(unsigned int);
+
 static inline const char *typename(unsigned int type)
 {
 	return type_names[type > TYPE_TAG ? TYPE_BAD : type];
