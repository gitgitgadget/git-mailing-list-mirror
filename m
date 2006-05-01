From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] Transitively read alternatives
Date: Mon, 1 May 2006 22:36:33 +0200
Message-ID: <20060501203631.GH20847@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 01 22:36:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Faf8I-0003c4-QG
	for gcvg-git@gmane.org; Mon, 01 May 2006 22:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWEAUgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEAUgf
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 16:36:35 -0400
Received: from admingilde.org ([213.95.32.146]:16356 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932233AbWEAUgf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 16:36:35 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Faf8D-0004R4-Rp
	for git@vger.kernel.org; Mon, 01 May 2006 22:36:33 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19386>

When adding an alternate object store then add entries from its
info/alternates files, too.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 sha1_file.c |  165 +++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 93 insertions(+), 72 deletions(-)

7fabfb214a971b8b45ec36dcf47929f4bf0917eb
diff --git a/sha1_file.c b/sha1_file.c
index f2d33af..ff9c989 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -216,6 +216,8 @@ char *sha1_pack_index_name(const unsigne
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
+static void read_info_alternates(const char * alternates);
+
 /*
  * Prepare alternate object database registry.
  *
@@ -231,13 +233,77 @@ static struct alternate_object_database 
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
+static int link_alt_odb_entry(const char * entry, int len, const char * relative_base)
+{
+	struct stat st;
+	const char *objdir = get_object_directory();
+	struct alternate_object_database *ent;
+	struct alternate_object_database *alt;
+	/* 43 = 40-byte + 2 '/' + terminating NUL */
+	int pfxlen = len;
+	int entlen = pfxlen + 43;
+	int base_len = -1;
+
+	if (*entry != '/' && relative_base) {
+		/* Relative alt-odb */
+		if (base_len < 0)
+			base_len = strlen(relative_base) + 1;
+		entlen += base_len;
+		pfxlen += base_len;
+	}
+	ent = xmalloc(sizeof(*ent) + entlen);
+
+	if (*entry != '/' && relative_base) {
+		memcpy(ent->base, relative_base, base_len - 1);
+		ent->base[base_len - 1] = '/';
+		memcpy(ent->base + base_len, entry, len);
+	}
+	else
+		memcpy(ent->base, entry, pfxlen);
+
+	ent->name = ent->base + pfxlen + 1;
+	ent->base[pfxlen + 3] = '/';
+	ent->base[pfxlen] = ent->base[entlen-1] = 0;
+
+	/* Detect cases where alternate disappeared */
+	if (stat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
+		error("object directory %s does not exist; "
+		      "check .git/objects/info/alternates.",
+		      ent->base);
+		free(ent);
+		return -1;
+	}
+
+	/* Prevent the common mistake of listing the same
+	 * thing twice, or object directory itself.
+	 */
+	for (alt = alt_odb_list; alt; alt = alt->next)
+		if (!memcmp(ent->base, alt->base, pfxlen)) {
+			free(ent);
+			return -1;
+		}
+	if (!memcmp(ent->base, objdir, pfxlen)) {
+		free(ent);
+		return -1;
+	}
+
+	/* recursively add alternates */
+	read_info_alternates(ent->base);
+
+	ent->base[pfxlen] = '/';
+
+	/* add the alternate entry */
+	*alt_odb_tail = ent;
+	alt_odb_tail = &(ent->next);
+	ent->next = NULL;
+
+	return 0;
+}
+
 static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 				 const char *relative_base)
 {
 	const char *cp, *last;
-	struct alternate_object_database *ent;
-	const char *objdir = get_object_directory();
-	int base_len = -1;
 
 	last = alt;
 	while (last < ep) {
@@ -248,61 +314,10 @@ static void link_alt_odb_entries(const c
 			last = cp + 1;
 			continue;
 		}
-		for ( ; cp < ep && *cp != sep; cp++)
-			;
+		while (cp < ep && *cp != sep)
+			cp++;
 		if (last != cp) {
-			struct stat st;
-			struct alternate_object_database *alt;
-			/* 43 = 40-byte + 2 '/' + terminating NUL */
-			int pfxlen = cp - last;
-			int entlen = pfxlen + 43;
-
-			if (*last != '/' && relative_base) {
-				/* Relative alt-odb */
-				if (base_len < 0)
-					base_len = strlen(relative_base) + 1;
-				entlen += base_len;
-				pfxlen += base_len;
-			}
-			ent = xmalloc(sizeof(*ent) + entlen);
-
-			if (*last != '/' && relative_base) {
-				memcpy(ent->base, relative_base, base_len - 1);
-				ent->base[base_len - 1] = '/';
-				memcpy(ent->base + base_len,
-				       last, cp - last);
-			}
-			else
-				memcpy(ent->base, last, pfxlen);
-
-			ent->name = ent->base + pfxlen + 1;
-			ent->base[pfxlen + 3] = '/';
-			ent->base[pfxlen] = ent->base[entlen-1] = 0;
-
-			/* Detect cases where alternate disappeared */
-			if (stat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
-				error("object directory %s does not exist; "
-				      "check .git/objects/info/alternates.",
-				      ent->base);
-				goto bad;
-			}
-			ent->base[pfxlen] = '/';
-
-			/* Prevent the common mistake of listing the same
-			 * thing twice, or object directory itself.
-			 */
-			for (alt = alt_odb_list; alt; alt = alt->next)
-				if (!memcmp(ent->base, alt->base, pfxlen))
-					goto bad;
-			if (!memcmp(ent->base, objdir, pfxlen)) {
-			bad:
-				free(ent);
-			}
-			else {
-				*alt_odb_tail = ent;
-				alt_odb_tail = &(ent->next);
-				ent->next = NULL;
-			}
+			link_alt_odb_entry(last, cp - last, relative_base);
 		}
 		while (cp < ep && *cp == sep)
 			cp++;
@@ -310,23 +325,14 @@ static void link_alt_odb_entries(const c
 	}
 }
 
-void prepare_alt_odb(void)
+static void read_info_alternates(const char * relative_base)
 {
-	char path[PATH_MAX];
 	char *map;
-	int fd;
 	struct stat st;
-	char *alt;
-
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-	if (!alt) alt = "";
-
-	if (alt_odb_tail)
-		return;
-	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL);
+	char path[PATH_MAX];
+	int fd;
 
-	sprintf(path, "%s/info/alternates", get_object_directory());
+	sprintf(path, "%s/info/alternates", relative_base);
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return;
@@ -339,11 +345,26 @@ void prepare_alt_odb(void)
 	if (map == MAP_FAILED)
 		return;
 
-	link_alt_odb_entries(map, map + st.st_size, '\n',
-			     get_object_directory());
+	link_alt_odb_entries(map, map + st.st_size, '\n', relative_base);
+
 	munmap(map, st.st_size);
 }
 
+void prepare_alt_odb(void)
+{
+	char *alt;
+
+	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+	if (!alt) alt = "";
+
+	if (alt_odb_tail)
+		return;
+	alt_odb_tail = &alt_odb_list;
+	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL);
+
+	read_info_alternates(get_object_directory());
+}
+
 static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 {
 	char *name = sha1_file_name(sha1);
-- 
1.3.1.gc585-dirty

-- 
Martin Waitz
