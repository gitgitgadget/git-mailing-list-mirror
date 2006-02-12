From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 02:57:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87slqpg11q.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 02:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F86VA-0001bF-Es
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 02:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBLB57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 20:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWBLB57
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 20:57:59 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27045 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932117AbWBLB56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 20:57:58 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9FDB5146543; Sun, 12 Feb 2006 02:57:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 91948A07;
	Sun, 12 Feb 2006 02:57:57 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 37E3E146543; Sun, 12 Feb 2006 02:57:57 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <87slqpg11q.fsf@wine.dyndns.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15968>


In a simple test, this brings down the CPU time from 47 sec to 22 sec.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Sat, 11 Feb 2006, Alexandre Julliard wrote:

	> When building a large list of objects, most of the time is spent in
	> created_object() inserting the objects in the sorted list. This patch
	> splits the list in 256 sublists to reduce the impact of the O(n^2)
	> list insertion.

	Your patch brought down the CPU time to 27 sec in my test.

 fsck-objects.c |    5 +++-
 name-rev.c     |    7 +++---
 object.c       |   67 +++++++++++++++++++++++++++++++++-----------------------
 object.h       |    2 +-
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
index 9950be2..6439d55 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -61,9 +61,12 @@ static void check_connectivity(void)
 	int i;
 
 	/* Look up all the requirements, warn about missing objects.. */
-	for (i = 0; i < nr_objs; i++) {
+	for (i = 0; i < obj_allocs; i++) {
 		struct object *obj = objs[i];
 
+		if (!obj)
+			continue;
+
 		if (!obj->parsed) {
 			if (!standalone && has_sha1_file(obj->sha1))
 				; /* it is in pack */
diff --git a/name-rev.c b/name-rev.c
index bdaa59b..08faa54 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -303,9 +303,10 @@ int main(int argc, char **argv)
 	} else if (all) {
 		int i;
 
-		for (i = 0; i < nr_objs; i++)
-			printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
-					get_rev_name(objs[i]));
+		for (i = 0; i < obj_allocs; i++)
+			if (objs[i])
+				printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
+						get_rev_name(objs[i]));
 	} else
 		for ( ; revs; revs = revs->next)
 			printf("%s %s\n", revs->name, get_rev_name(revs->item));
diff --git a/object.c b/object.c
index 1577f74..3259862 100644
--- a/object.c
+++ b/object.c
@@ -6,30 +6,32 @@
 #include "tag.h"
 
 struct object **objs;
-int nr_objs;
-static int obj_allocs;
+static int nr_objs;
+int obj_allocs;
 
 int track_object_refs = 1;
 
+static int hashtable_index(const unsigned char *sha1)
+{
+	unsigned int i = *(unsigned int *)sha1;
+	return (int)(i % obj_allocs);
+}
+
 static int find_object(const unsigned char *sha1)
 {
-	int first = 0, last = nr_objs;
+	int i = hashtable_index(sha1);
+
+	if (!objs)
+		return -1;
 
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
+	while (objs[i]) {
+		if (memcmp(sha1, objs[i]->sha1, 20) == 0)
+			return i;
+		i++;
+		if (i == obj_allocs)
+			i = 0;
+	}
+	return -1 - i;
 }
 
 struct object *lookup_object(const unsigned char *sha1)
@@ -42,7 +44,7 @@ struct object *lookup_object(const unsig
 
 void created_object(const unsigned char *sha1, struct object *obj)
 {
-	int pos = find_object(sha1);
+	int pos;
 
 	obj->parsed = 0;
 	memcpy(obj->sha1, sha1, 20);
@@ -50,18 +52,27 @@ void created_object(const unsigned char 
 	obj->refs = NULL;
 	obj->used = 0;
 
-	if (pos >= 0)
-		die("Inserting %s twice\n", sha1_to_hex(sha1));
-	pos = -pos-1;
-
-	if (obj_allocs == nr_objs) {
-		obj_allocs = alloc_nr(obj_allocs);
+	if (obj_allocs - 1 <= nr_objs * 2) {
+		int i, count = obj_allocs;
+		obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs);
 		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
+		memset(objs + count, 0, (obj_allocs - count)
+				* sizeof(struct object *));
+		for (i = 0; i < count; i++)
+			if (objs[i]) {
+				int j = find_object(objs[i]->sha1);
+				if (j != i) {
+					j = -1 - j;
+					objs[j] = objs[i];
+					objs[i] = NULL;
+				}
+			}
 	}
 
-	/* Insert it into the right place */
-	memmove(objs + pos + 1, objs + pos, (nr_objs - pos) * 
-		sizeof(struct object *));
+	pos = find_object(sha1);
+	if (pos >= 0)
+		die("Inserting %s twice\n", sha1_to_hex(sha1));
+	pos = -pos-1;
 
 	objs[pos] = obj;
 	nr_objs++;
diff --git a/object.h b/object.h
index 0e76182..e08afbd 100644
--- a/object.h
+++ b/object.h
@@ -23,7 +23,7 @@ struct object {
 };
 
 extern int track_object_refs;
-extern int nr_objs;
+extern int obj_allocs;
 extern struct object **objs;
 
 /** Internal only **/
