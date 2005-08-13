From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Alternate object pool mechanism updates.
Date: Sat, 13 Aug 2005 02:09:13 -0700
Message-ID: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 11:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3s10-0004yw-N2
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 11:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVHMJJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 05:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVHMJJP
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 05:09:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:13001 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932139AbVHMJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 05:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813090913.GCDC550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 05:09:13 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It was a mistake to use GIT_ALTERNATE_OBJECT_DIRECTORIES
environment variable to specify what alternate object pools to
look for missing objects when working with an object database.
It is not a property of the process running the git commands,
but a property of the object database that is partial and needs
other object pools to complete the set of objects it lacks.

This patch allows you to have $GIT_OBJECT_DIRECTORY/info/alt
file whose contents is in exactly the same format as the
environment variable, to let an object database name alternate
object pools it depends on.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h      |    5 +-
 fsck-cache.c |    8 ++-
 sha1_file.c  |  146 ++++++++++++++++++++++++++++++++--------------------------
 3 files changed, 88 insertions(+), 71 deletions(-)

8150a422f79cc461316052b52263289b851d4820
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -278,9 +278,10 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, struct checkout *state);
 
 extern struct alternate_object_database {
-	char *base;
+	struct alternate_object_database *next;
 	char *name;
-} *alt_odb;
+	char base[0]; /* more */
+} *alt_odb_list;
 extern void prepare_alt_odb(void);
 
 extern struct packed_git {
diff --git a/fsck-cache.c b/fsck-cache.c
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -456,13 +456,13 @@ int main(int argc, char **argv)
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
 	if (check_full) {
-		int j;
+		struct alternate_object_database *alt;
 		struct packed_git *p;
 		prepare_alt_odb();
-		for (j = 0; alt_odb[j].base; j++) {
+		for (alt = alt_odb_list; alt; alt = alt->next) {
 			char namebuf[PATH_MAX];
-			int namelen = alt_odb[j].name - alt_odb[j].base;
-			memcpy(namebuf, alt_odb[j].base, namelen);
+			int namelen = alt->name - alt->base;
+			memcpy(namebuf, alt->base, namelen);
 			namebuf[namelen - 1] = 0;
 			fsck_object_dir(namebuf);
 		}
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -222,84 +222,100 @@ char *sha1_pack_index_name(const unsigne
 	return base;
 }
 
-struct alternate_object_database *alt_odb;
+struct alternate_object_database *alt_odb_list;
+static struct alternate_object_database **alt_odb_tail;
 
 /*
  * Prepare alternate object database registry.
- * alt_odb points at an array of struct alternate_object_database.
- * This array is terminated with an element that has both its base
- * and name set to NULL.  alt_odb[n] comes from n'th non-empty
- * element from colon separated ALTERNATE_DB_ENVIRONMENT environment
- * variable, and its base points at a statically allocated buffer
- * that contains "/the/directory/corresponding/to/.git/objects/...",
- * while its name points just after the slash at the end of
- * ".git/objects/" in the example above, and has enough space to hold
- * 40-byte hex SHA1, an extra slash for the first level indirection,
- * and the terminating NUL.
- * This function allocates the alt_odb array and all the strings
- * pointed by base fields of the array elements with one xmalloc();
- * the string pool immediately follows the array.
+ *
+ * The variable alt_odb_list points at the list of struct
+ * alternate_object_database.  The elements on this list come from
+ * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
+ * environment variable, and $GIT_OBJECT_DIRECTORY/info/alt file,
+ * whose contents is exactly in the same format as that environment
+ * variable.  Its base points at a statically allocated buffer that
+ * contains "/the/directory/corresponding/to/.git/objects/...", while
+ * its name points just after the slash at the end of ".git/objects/"
+ * in the example above, and has enough space to hold 40-byte hex
+ * SHA1, an extra slash for the first level indirection, and the
+ * terminating NUL.
  */
-void prepare_alt_odb(void)
+static void link_alt_odb_entries(const char *alt, const char *ep)
 {
-	int pass, totlen, i;
 	const char *cp, *last;
-	char *op = NULL;
-	const char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
+	struct alternate_object_database *ent;
+
+	last = alt;
+	do {
+		for (cp = last; cp < ep && *cp != ':'; cp++)
+			;
+		if (last != cp) {
+			/* 43 = 40-byte + 2 '/' + terminating NUL */
+			int pfxlen = cp - last;
+			int entlen = pfxlen + 43;
+
+			ent = xmalloc(sizeof(*ent) + entlen);
+			*alt_odb_tail = ent;
+			alt_odb_tail = &(ent->next);
+			ent->next = NULL;
+
+			memcpy(ent->base, last, pfxlen);
+			ent->name = ent->base + pfxlen + 1;
+			ent->base[pfxlen] = ent->base[pfxlen + 3] = '/';
+			ent->base[entlen-1] = 0;
+		}
+		while (cp < ep && *cp == ':')
+			cp++;
+		last = cp;
+	} while (cp < ep);
+}
+
+void prepare_alt_odb(void)
+{
+	char path[PATH_MAX];
+	char *map, *ep;
+	int fd;
+	struct stat st;
+	char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
 
-	if (alt_odb)
+	sprintf(path, "%s/info/alt", get_object_directory());
+	if (alt_odb_tail)
+		return;
+	alt_odb_tail = &alt_odb_list;
+	link_alt_odb_entries(alt, alt + strlen(alt));
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+	if (fstat(fd, &st) || (st.st_size == 0)) {
+		close(fd);
 		return;
-	/* The first pass counts how large an area to allocate to
-	 * hold the entire alt_odb structure, including array of
-	 * structs and path buffers for them.  The second pass fills
-	 * the structure and prepares the path buffers for use by
-	 * fill_sha1_path().
-	 */
-	for (totlen = pass = 0; pass < 2; pass++) {
-		last = alt;
-		i = 0;
-		do {
-			cp = strchr(last, ':') ? : last + strlen(last);
-			if (last != cp) {
-				/* 43 = 40-byte + 2 '/' + terminating NUL */
-				int pfxlen = cp - last;
-				int entlen = pfxlen + 43;
-				if (pass == 0)
-					totlen += entlen;
-				else {
-					alt_odb[i].base = op;
-					alt_odb[i].name = op + pfxlen + 1;
-					memcpy(op, last, pfxlen);
-					op[pfxlen] = op[pfxlen + 3] = '/';
-					op[entlen-1] = 0;
-					op += entlen;
-				}
-				i++;
-			}
-			while (*cp && *cp == ':')
-				cp++;
-			last = cp;
-		} while (*cp);
-		if (pass)
-			break;
-		alt_odb = xmalloc(sizeof(*alt_odb) * (i + 1) + totlen);
-		alt_odb[i].base = alt_odb[i].name = NULL;
-		op = (char*)(&alt_odb[i+1]);
 	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (map == MAP_FAILED)
+		return;
+
+	/* Remove the trailing newline */
+	for (ep = map + st.st_size - 1; map < ep && ep[-1] == '\n'; ep--)
+		;
+	link_alt_odb_entries(map, ep);
+	munmap(map, st.st_size);
 }
 
 static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 {
-	int i;
 	char *name = sha1_file_name(sha1);
+	struct alternate_object_database *alt;
 
 	if (!stat(name, st))
 		return name;
 	prepare_alt_odb();
-	for (i = 0; (name = alt_odb[i].name) != NULL; i++) {
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		name = alt->name;
 		fill_sha1_path(name, sha1);
-		if (!stat(alt_odb[i].base, st))
-			return alt_odb[i].base;
+		if (!stat(alt->base, st))
+			return alt->base;
 	}
 	return NULL;
 }
@@ -522,18 +538,18 @@ static void prepare_packed_git_one(char 
 
 void prepare_packed_git(void)
 {
-	int i;
 	static int run_once = 0;
+	struct alternate_object_database *alt;
 
-	if (run_once++)
+	if (run_once)
 		return;
-
 	prepare_packed_git_one(get_object_directory());
 	prepare_alt_odb();
-	for (i = 0; alt_odb[i].base != NULL; i++) {
-		alt_odb[i].name[0] = 0;
-		prepare_packed_git_one(alt_odb[i].base);
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		alt->name[0] = 0;
+		prepare_packed_git_one(alt->base);
 	}
+	run_once = 1;
 }
 
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
