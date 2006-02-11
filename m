From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] Optimization for git-rev-list --objects
Date: Sat, 11 Feb 2006 20:14:57 +0100
Message-ID: <87slqpg11q.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 11 20:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F80DF-00080i-VU
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWBKTPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 14:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWBKTPM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 14:15:12 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:1681 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S964775AbWBKTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 14:15:11 -0500
Received: from adsl-84-226-53-149.adslplus.ch ([84.226.53.149] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1F80Cy-0000nd-Ex
	for git@vger.kernel.org; Sat, 11 Feb 2006 13:15:10 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id F1A5D4F92A; Sat, 11 Feb 2006 20:14:57 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.53.149
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15960>


When building a large list of objects, most of the time is spent in
created_object() inserting the objects in the sorted list. This patch
splits the list in 256 sublists to reduce the impact of the O(n^2)
list insertion.

On the WineHQ repository (220,000 objects), the patch reduces the time
needed for a 'git-rev-list --objects HEAD' from 2 minutes to 20 seconds.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 fsck-objects.c |   66 +++++++++++++++++++++++++++++---------------------------
 name-rev.c     |    9 ++++----
 object.c       |   24 ++++++++++----------
 object.h       |    4 ++-
 4 files changed, 53 insertions(+), 50 deletions(-)

68f8fcb7f5883ecc44a80e822e0b78ee8efd9eb9
diff --git a/fsck-objects.c b/fsck-objects.c
index 9950be2..5bdb21e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -58,45 +58,47 @@ static int objwarning(struct object *obj
 
 static void check_connectivity(void)
 {
-	int i;
+	int i, j;
 
 	/* Look up all the requirements, warn about missing objects.. */
-	for (i = 0; i < nr_objs; i++) {
-		struct object *obj = objs[i];
+	for (i = 0; i < 256; i++) {
+		for (j = 0; j < nr_objs[i]; j++) {
+			struct object *obj = objs[i][j];
 
-		if (!obj->parsed) {
-			if (!standalone && has_sha1_file(obj->sha1))
-				; /* it is in pack */
-			else
-				printf("missing %s %s\n",
-				       obj->type, sha1_to_hex(obj->sha1));
-			continue;
-		}
+			if (!obj->parsed) {
+				if (!standalone && has_sha1_file(obj->sha1))
+					; /* it is in pack */
+				else
+					printf("missing %s %s\n",
+					       obj->type, sha1_to_hex(obj->sha1));
+				continue;
+			}
 
-		if (obj->refs) {
-			const struct object_refs *refs = obj->refs;
-			unsigned j;
-			for (j = 0; j < refs->count; j++) {
-				struct object *ref = refs->ref[j];
-				if (ref->parsed ||
-				    (!standalone && has_sha1_file(ref->sha1)))
-					continue;
-				printf("broken link from %7s %s\n",
-				       obj->type, sha1_to_hex(obj->sha1));
-				printf("              to %7s %s\n",
-				       ref->type, sha1_to_hex(ref->sha1));
+			if (obj->refs) {
+				const struct object_refs *refs = obj->refs;
+				unsigned k;
+				for (k = 0; k < refs->count; k++) {
+					struct object *ref = refs->ref[k];
+					if (ref->parsed ||
+					    (!standalone && has_sha1_file(ref->sha1)))
+						continue;
+					printf("broken link from %7s %s\n",
+					       obj->type, sha1_to_hex(obj->sha1));
+					printf("              to %7s %s\n",
+					       ref->type, sha1_to_hex(ref->sha1));
+				}
 			}
-		}
 
-		if (show_unreachable && !(obj->flags & REACHABLE)) {
-			printf("unreachable %s %s\n",
-			       obj->type, sha1_to_hex(obj->sha1));
-			continue;
-		}
+			if (show_unreachable && !(obj->flags & REACHABLE)) {
+				printf("unreachable %s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
+				continue;
+			}
 
-		if (!obj->used) {
-			printf("dangling %s %s\n", obj->type, 
-			       sha1_to_hex(obj->sha1));
+			if (!obj->used) {
+				printf("dangling %s %s\n", obj->type, 
+				       sha1_to_hex(obj->sha1));
+			}
 		}
 	}
 }
diff --git a/name-rev.c b/name-rev.c
index bbadb91..9a8d086 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -230,11 +230,12 @@ int main(int argc, char **argv)
 				fwrite(p_start, p - p_start, 1, stdout);
 		}
 	} else if (all) {
-		int i;
+		int i, j;
 
-		for (i = 0; i < nr_objs; i++)
-			printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
-					get_rev_name(objs[i]));
+		for (i = 0; i < 256; i++)
+			for (j = 0; j < nr_objs[i]; j++)
+				printf("%s %s\n", sha1_to_hex(objs[i][j]->sha1),
+						get_rev_name(objs[i][j]));
 	} else
 		for ( ; revs; revs = revs->next)
 			printf("%s %s\n", revs->name, get_rev_name(revs->item));
diff --git a/object.c b/object.c
index 1577f74..fcd4d0c 100644
--- a/object.c
+++ b/object.c
@@ -5,19 +5,19 @@
 #include "commit.h"
 #include "tag.h"
 
-struct object **objs;
-int nr_objs;
-static int obj_allocs;
+struct object **objs[256];
+int nr_objs[256];
+static int obj_allocs[256];
 
 int track_object_refs = 1;
 
 static int find_object(const unsigned char *sha1)
 {
-	int first = 0, last = nr_objs;
+	int first = 0, last = nr_objs[*sha1];
 
         while (first < last) {
                 int next = (first + last) / 2;
-                struct object *obj = objs[next];
+                struct object *obj = objs[*sha1][next];
                 int cmp;
 
                 cmp = memcmp(sha1, obj->sha1, 20);
@@ -36,7 +36,7 @@ struct object *lookup_object(const unsig
 {
 	int pos = find_object(sha1);
 	if (pos >= 0)
-		return objs[pos];
+		return objs[*sha1][pos];
 	return NULL;
 }
 
@@ -54,17 +54,17 @@ void created_object(const unsigned char 
 		die("Inserting %s twice\n", sha1_to_hex(sha1));
 	pos = -pos-1;
 
-	if (obj_allocs == nr_objs) {
-		obj_allocs = alloc_nr(obj_allocs);
-		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
+	if (obj_allocs[*sha1] == nr_objs[*sha1]) {
+		obj_allocs[*sha1] = alloc_nr(obj_allocs[*sha1]);
+		objs[*sha1] = xrealloc(objs[*sha1], obj_allocs[*sha1] * sizeof(struct object *));
 	}
 
 	/* Insert it into the right place */
-	memmove(objs + pos + 1, objs + pos, (nr_objs - pos) * 
+	memmove(objs[*sha1] + pos + 1, objs[*sha1] + pos, (nr_objs[*sha1] - pos) * 
 		sizeof(struct object *));
 
-	objs[pos] = obj;
-	nr_objs++;
+	objs[*sha1][pos] = obj;
+	nr_objs[*sha1]++;
 }
 
 struct object_refs *alloc_object_refs(unsigned count)
diff --git a/object.h b/object.h
index 0e76182..dcd6ac4 100644
--- a/object.h
+++ b/object.h
@@ -23,8 +23,8 @@ struct object {
 };
 
 extern int track_object_refs;
-extern int nr_objs;
-extern struct object **objs;
+extern int nr_objs[256];
+extern struct object **objs[256];
 
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
-- 
1.1.6.g68f8


-- 
Alexandre Julliard
julliard@winehq.org
