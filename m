From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix packname hash generation.
Date: Wed, 12 Oct 2005 16:57:06 -0700
Message-ID: <7vslv6b86l.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051012173426.56fd5c1c.vsu@altlinux.ru>
	<20051012135405.CDE55E005E3@center4.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 01:58:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPqTN-0008Ng-0o
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 01:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVJLX5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 19:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVJLX5J
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 19:57:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59352 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964822AbVJLX5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 19:57:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012235650.IETM29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 19:56:50 -0400
To: git@vger.kernel.org
In-Reply-To: <20051012135405.CDE55E005E3@center4.mivlgu.local> (Sergey
	Vlasov's message of "Wed, 12 Oct 2005 17:54:05 +0400 (MSD)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10056>

This changes the generation of hash packfiles have in their names, from
"hash of object names as fed to us" to "hash of object names in the
resulting pack, in the order they appear in the index file".  The new
"git-index-pack" command is taught to output the computed hash value
to its standard output.

With this, we can store downloaded pack in a temporary file without
knowing its final name, run git-index-pack to generate idx for it
while finding out its final name, and then rename the pack and idx to
their final names.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Right now, the pack "hash" name only serves the collision
   avoidance purposes, but not true identification.  The same
   set of objects can be fed to pack-objects in different order,
   produce the same pack, and still end up with different
   names.

   This will be used in the next experiment, "git-clone not
   exploding the downloaded pack".

 index-pack.c   |   15 +++++++++++++--
 pack-objects.c |   14 ++++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

applies-to: ea37b42d53264d65f746b3e42577349e8a44d5c4
3b97470e3711d7af3505baddc34428a0d9bd8214
diff --git a/index-pack.c b/index-pack.c
index badbeab..785fe71 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -349,7 +349,7 @@ static int sha1_compare(const void *_a, 
 	return memcmp(a->sha1, b->sha1, 20);
 }
 
-static void write_index_file(const char *index_name)
+static void write_index_file(const char *index_name, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct object_entry **sorted_by_sha =
@@ -358,6 +358,7 @@ static void write_index_file(const char 
 	struct object_entry **last = sorted_by_sha + nr_objects;
 	unsigned int array[256];
 	int i;
+	SHA_CTX ctx;
 
 	for (i = 0; i < nr_objects; ++i)
 		sorted_by_sha[i] = &objects[i];
@@ -385,6 +386,11 @@ static void write_index_file(const char 
 	}
 	sha1write(f, array, 256 * sizeof(int));
 
+	/* recompute the SHA1 hash of sorted object names.
+	 * currently pack-objects does not do this, but that
+	 * can be fixed.
+	 */
+	SHA1_Init(&ctx);
 	/*
 	 * Write the actual SHA1 entries..
 	 */
@@ -394,10 +400,12 @@ static void write_index_file(const char 
 		unsigned int offset = htonl(obj->offset);
 		sha1write(f, &offset, 4);
 		sha1write(f, obj->sha1, 20);
+		SHA1_Update(&ctx, obj->sha1, 20);
 	}
 	sha1write(f, pack_base + pack_size - 20, 20);
 	sha1close(f, NULL, 1);
 	free(sorted_by_sha);
+	SHA1_Final(sha1, &ctx);
 }
 
 int main(int argc, char **argv)
@@ -405,6 +413,7 @@ int main(int argc, char **argv)
 	int i;
 	char *index_name = NULL;
 	char *index_name_buf = NULL;
+	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -443,9 +452,11 @@ int main(int argc, char **argv)
 	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects();
 	free(deltas);
-	write_index_file(index_name);
+	write_index_file(index_name, sha1);
 	free(objects);
 	free(index_name_buf);
 
+	printf("%s\n", sha1_to_hex(sha1));
+
 	return 0;
 }
diff --git a/pack-objects.c b/pack-objects.c
index 3d62278..ef55cab 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -393,6 +393,7 @@ int main(int argc, char **argv)
 	SHA_CTX ctx;
 	char line[PATH_MAX + 20];
 	int window = 10, depth = 10, pack_to_stdout = 0;
+	struct object_entry **list;
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -435,7 +436,6 @@ int main(int argc, char **argv)
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
 
-	SHA1_Init(&ctx);
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		unsigned int hash;
 		char *p;
@@ -451,10 +451,8 @@ int main(int argc, char **argv)
 				continue;
 			hash = hash * 11 + c;
 		}
-		if (add_object_entry(sha1, hash))
-			SHA1_Update(&ctx, sha1, 20);
+		add_object_entry(sha1, hash);
 	}
-	SHA1_Final(object_list_sha1, &ctx);
 	if (non_empty && !nr_objects)
 		return 0;
 	get_object_details();
@@ -462,6 +460,14 @@ int main(int argc, char **argv)
 	fprintf(stderr, "Packing %d objects\n", nr_objects);
 
 	sorted_by_sha = create_sorted_list(sha1_sort);
+	SHA1_Init(&ctx);
+	list = sorted_by_sha;
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *entry = *list++;
+		SHA1_Update(&ctx, entry->sha1, 20);
+	}
+	SHA1_Final(object_list_sha1, &ctx);
+
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
---
0.99.8.GIT
