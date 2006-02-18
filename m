From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: avoid delta chains that are too long.
Date: Fri, 17 Feb 2006 22:50:32 -0800
Message-ID: <7vpslltb2f.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
	<7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
	<7vlkwa6zk6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALvS-0007Ef-Um
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWBRGuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBRGuf
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:50:35 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22223 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750932AbWBRGue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:50:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218064901.VRT6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:49:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16393>

This tries to rework the solution for the excess delta chain
problem. An earlier commit worked it around ``cheaply'', but
repeated repacking risks unbound growth of delta chains.

This version counts the length of delta chain we are reusing
from the existing pack, and makes sure a base object that has
sufficiently long delta chain does not get deltified.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This solves the problem by doing exactly what the previous
   commit log suggested.  We limit the chain depth correctly, to
   save the user of the resulting pack from suffering runtime
   overhead.

   Will be in "next" tonight.

 pack-objects.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 35 insertions(+), 8 deletions(-)

e4c9327a77bd59e85d4b17a612e78977d68773ee
diff --git a/pack-objects.c b/pack-objects.c
index 38e1c99..0c9f4c9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -10,16 +10,22 @@ static const char pack_usage[] = "git-pa
 struct object_entry {
 	unsigned char sha1[20];
 	unsigned long size;	/* uncompressed size */
-	unsigned long offset;	/* offset into the final pack file (nonzero if already written) */
+	unsigned long offset;	/* offset into the final pack file;
+				 * nonzero if already written.
+				 */
 	unsigned int depth;	/* delta depth */
+	unsigned int delta_limit;	/* base adjustment for in-pack delta */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
-	unsigned char edge;	/* reused delta chain points at this entry. */
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
 	unsigned int in_pack_offset;
+	struct object_entry *delta_child; /* delitified objects who bases me */
+	struct object_entry *delta_sibling; /* other deltified objects who
+					     * uses the same base as me
+					     */
 };
 
 /*
@@ -470,7 +476,8 @@ static void check_object(struct object_e
 			entry->delta = base_entry;
 			entry->type = OBJ_DELTA;
 
-			base_entry->edge = 1;
+			entry->delta_sibling = base_entry->delta_child;
+			base_entry->delta_child = entry;
 
 			return;
 		}
@@ -513,15 +520,32 @@ static void hash_objects(void)
 	}
 }
 
+static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
+{
+	struct object_entry *child = me->delta_child;
+	unsigned int m = n;
+	while (child) {
+		unsigned int c = check_delta_limit(child, n + 1);
+		if (m < c)
+			m = c;
+		child = child->delta_sibling;
+	}
+	return m;
+}
+
 static void get_object_details(void)
 {
 	int i;
-	struct object_entry *entry = objects;
+	struct object_entry *entry;
 
 	hash_objects();
 	prepare_pack_ix();
-	for (i = 0; i < nr_objects; i++)
-		check_object(entry++);
+	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
+		check_object(entry);
+	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
+		if (!entry->delta && entry->delta_child)
+			entry->delta_limit =
+				check_delta_limit(entry, 1);
 }
 
 typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
@@ -598,8 +622,11 @@ static int try_delta(struct unpacked *cu
 	 * that depend on the current object into account -- otherwise
 	 * they would become too deep.
 	 */
-	if (cur_entry->edge)
-		max_depth /= 4;
+	if (cur_entry->delta_child) {
+		if (max_depth <= cur_entry->delta_limit)
+			return 0;
+		max_depth -= cur_entry->delta_limit;
+	}
 
 	size = cur_entry->size;
 	if (size < 50)
-- 
1.2.1.g9b132
