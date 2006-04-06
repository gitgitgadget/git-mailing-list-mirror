From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Thin pack generation: optimization.
Date: Wed, 05 Apr 2006 23:58:19 -0700
Message-ID: <7vu097ur5g.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060402105258.GX14022@suse.de>
	<7vd5fzlnyt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 06 08:58:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRORw-0004p3-7c
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 08:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDFG6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 02:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDFG6X
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 02:58:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16862 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750835AbWDFG6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 02:58:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060406065820.HLLW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Apr 2006 02:58:20 -0400
To: git@vger.kernel.org
In-Reply-To: <7vd5fzlnyt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 02 Apr 2006 13:30:34 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18467>

Jens Axboe noticed that recent "git push" has become very slow
since we made --thin transfer the default.

Thin pack generation to push a handful revisions that touch
relatively small number of paths out of huge tree was stupid; it
registered _everything_ from the excluded revisions.  As a
result, "Counting objects" phase was unnecessarily expensive.

This changes the logic to register the blobs and trees from
excluded revisions only for paths we are actually going to send
to the other end.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 pack-objects.c |  119 +++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 79 insertions(+), 40 deletions(-)

b5026f319fc873d03a02f15992b7e431b4b5ad03
diff --git a/pack-objects.c b/pack-objects.c
index 9346392..f1bd8a6 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -505,24 +505,17 @@ static unsigned name_hash(struct name_pa
 	 * but close enough.
 	 */
 	hash = (name_hash<<DIRBITS) | (hash & ((1U<<DIRBITS )-1));
-
-	if (0) { /* debug */
-		n = name + strlen(name);
-		if (n != name && n[-1] == '\n')
-			n--;
-		while (name <= --n)
-			fputc(*n, stderr);
-		for (p = path; p; p = p->up) {
-			fputc('/', stderr);
-			n = p->elem + p->len;
-			while (p->elem <= --n)
-				fputc(*n, stderr);
-		}
-		fprintf(stderr, "\t%08x\n", hash);
-	}
 	return hash;
 }
+
+static struct pbase_tree {
+	struct pbase_tree *next;
 
+	unsigned char sha1[20];
+	void *tree_data;
+	unsigned long tree_size;
+} *pbase_tree;
+
 static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclude)
 {
 	unsigned int idx = nr_objects;
@@ -585,58 +578,99 @@ static int add_object_entry(const unsign
 		}
 	}
 	return status;
+}
+
+static int name_cmp_len(const char *name)
+{
+	int i;
+	for (i = 0; name[i] && name[i] != '\n' && name[i] != '/'; i++)
+		;
+	return i;
 }
 
-static void add_pbase_tree(struct tree_desc *tree, struct name_path *up)
+static void add_pbase_object(struct tree_desc *tree,
+			     struct name_path *up,
+			     const char *name,
+			     int cmplen)
 {
 	while (tree->size) {
 		const unsigned char *sha1;
-		const char *name;
-		unsigned mode, hash;
+		const char *entry_name;
+		int entry_len;
+		unsigned mode;
 		unsigned long size;
 		char type[20];
 
-		sha1 = tree_entry_extract(tree, &name, &mode);
+		sha1 = tree_entry_extract(tree, &entry_name, &mode);
 		update_tree_entry(tree);
-		if (!has_sha1_file(sha1))
-			continue;
-		if (sha1_object_info(sha1, type, &size))
-			continue;
-
-		hash = name_hash(up, name);
-		if (!add_object_entry(sha1, hash, 1))
+		entry_len = strlen(entry_name);
+		if (entry_len != cmplen ||
+		    memcmp(entry_name, name, cmplen) ||
+		    !has_sha1_file(sha1) ||
+		    sha1_object_info(sha1, type, &size))
 			continue;
-
+		if (name[cmplen] != '/') {
+			unsigned hash = name_hash(up, name);
+			add_object_entry(sha1, hash, 1);
+			return;
+		}
 		if (!strcmp(type, tree_type)) {
 			struct tree_desc sub;
 			void *elem;
 			struct name_path me;
 
+			/* We probably should cache these
+			 * intermediate tree buffers...
+			 */
 			elem = read_sha1_file(sha1, type, &sub.size);
 			sub.buf = elem;
 			if (sub.buf) {
+				const char *down = name+cmplen+1;
+				int downlen = name_cmp_len(down);
+
 				me.up = up;
-				me.elem = name;
-				me.len = strlen(name);
-				add_pbase_tree(&sub, &me);
+				me.elem = entry_name;
+				me.len = entry_len;
+				add_pbase_object(&sub, &me, down, downlen);
 				free(elem);
 			}
 		}
 	}
 }
+
+static void add_preferred_base_object(char *name)
+{
+	struct pbase_tree *it;
+	int cmplen = name_cmp_len(name);
 
+	for (it = pbase_tree; it; it = it->next) {
+		if (cmplen == 0) {
+			unsigned hash = name_hash(NULL, "");
+			add_object_entry(it->sha1, hash, 1);
+		}
+		else {
+			struct tree_desc tree;
+			tree.buf = it->tree_data;
+			tree.size = it->tree_size;
+			add_pbase_object(&tree, NULL, name, cmplen);
+		}
+	}
+}
+
 static void add_preferred_base(unsigned char *sha1)
 {
-	struct tree_desc tree;
-	void *elem;
+	struct pbase_tree *it;
 
-	elem = read_object_with_reference(sha1, tree_type, &tree.size, NULL);
-	tree.buf = elem;
-	if (!tree.buf)
+	for (it = pbase_tree; it && memcmp(it->sha1, sha1, 20); it = it->next)
+		;
+	if (it)
 		return;
-	if (add_object_entry(sha1, name_hash(NULL, ""), 1))
-		add_pbase_tree(&tree, NULL);
-	free(elem);
+	it = xcalloc(1, sizeof(*it));
+	it->next = pbase_tree;
+	pbase_tree = it;
+	memcpy(it->sha1, sha1, 20);
+	it->tree_data = read_object_with_reference(sha1, tree_type,
+						   &it->tree_size, NULL);
 }
 
 static void check_object(struct object_entry *entry)
@@ -1051,6 +1085,7 @@ int main(int argc, char **argv)
 	char line[PATH_MAX + 20];
 	int window = 10, depth = 10, pack_to_stdout = 0;
 	struct object_entry **list;
+	int num_preferred_base = 0;
 	int i;
 
 	setup_git_directory();
@@ -1116,6 +1151,7 @@ int main(int argc, char **argv)
 
 	for (;;) {
 		unsigned char sha1[20];
+		unsigned hash;
 
 		if (!fgets(line, sizeof(line), stdin)) {
 			if (feof(stdin))
@@ -1132,12 +1168,15 @@ int main(int argc, char **argv)
 			if (get_sha1_hex(line+1, sha1))
 				die("expected edge sha1, got garbage:\n %s",
 				    line+1);
-			add_preferred_base(sha1);
+			if (num_preferred_base++ < window)
+				add_preferred_base(sha1);
 			continue;
 		}
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
-		add_object_entry(sha1, name_hash(NULL, line+41), 0);
+		add_preferred_base_object(line+41);
+		hash = name_hash(NULL, line+41);
+		add_object_entry(sha1, hash, 0);
 	}
 	if (progress)
 		fprintf(stderr, "Done counting %d objects.\n", nr_objects);
-- 
1.3.0.rc2.g9cda
