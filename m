From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Fri, 06 May 2005 16:35:27 -0700
Message-ID: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:33:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCJq-0004jG-66
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVEFXjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVEFXiV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 19:38:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5625 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261370AbVEFXfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 19:35:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506233528.MOJE1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 19:35:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new environment variable, SHA1_FILE_DIRECTORIES, is
introduced.  This affects the routines that read existing
objects from the object database, but not creation of new
objects.

The environment variable, when exists, is a colon separated list of
directories.  If an object is not found in the usual location
SHA1_FILE_DIRECTORY (or .git/objects), this list is consulted and if
object is found there it is returned.

This is an implementation of the idea floated on the GIT list a couple
of days ago to archive really old history on a separate directory, even
on a read-only DVD ROM media.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

cache.h     |    5 +-
sha1_file.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
2 files changed, 112 insertions(+), 6 deletions(-)

--- a/cache.h
+++ b/cache.h
@@ -101,8 +101,7 @@ unsigned int active_nr, active_alloc;
 
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
-
-#define get_object_directory() (getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
+#define ALTERNATE_DB_ENVIRONMENT "SHA1_FILE_DIRECTORIES"
 
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define DEFAULT_INDEX_ENVIRONMENT ".git/index"
@@ -130,7 +129,7 @@ extern int index_fd(unsigned char *sha1,
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/* Return a statically allocated filename matching the sha1 signature */
+/* Return a statically allocated filename matching the sha1 signature. */
 extern char *sha1_file_name(const unsigned char *sha1);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -100,10 +100,19 @@ char * sha1_to_hex(const unsigned char *
 	return buffer;
 }
 
+static const char *get_object_directory(void)
+{
+	return getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+}
+
 /*
  * NOTE! This returns a statically allocated buffer, so you have to be
  * careful about using it. Do a "strdup()" if you need to save the
  * filename.
+ *
+ * Also note that this returns the location for creating.  Reading
+ * SHA1 file can happen from any alternate directory listed in the
+ * SHA1_FILE_DIRECTORIES environment variable.
  */
 char *sha1_file_name(const unsigned char *sha1)
 {
@@ -130,6 +139,99 @@ char *sha1_file_name(const unsigned char
 	return base;
 }
 
+static char *find_sha1_file(const unsigned char *sha1)
+{
+	struct stat st;
+	char *name = sha1_file_name(sha1);
+	static struct {
+		int pfxlen;
+		char *buf;
+	} *alternates = NULL;
+	static int num_alt = -1;
+	int i;
+
+	if (num_alt < 0) {
+		int cnt;
+		int totlen;
+		const char *cp, *last;
+		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+		void *buf;
+		char *op;
+
+		if (!alt || !alt[0]) {
+			num_alt = 0;
+			return name;
+		}
+
+		for (last = cp = alt, totlen = cnt = 0; *cp; cp++) {
+			/* We could strip the empty path which would result
+			 * in /xx/xxxxx from the filesystem root level,
+			 * but who cares.  We are only constructing list of
+			 * paths to attempt to read not write.
+			 */
+			if (*cp == ':') {
+				/* 40 bytes plus two / and terminating NUL */
+				totlen += cp - last + 43;
+				cnt++;
+				last = cp + 1;
+			}
+		}
+		if (cp != last) {
+			totlen += cp - last + 43;
+			cnt++;
+		}
+
+		if (!cnt) {
+			num_alt = 0;
+			return name;
+		}
+		num_alt = cnt;
+
+		buf = xmalloc(sizeof(*alternates) * (cnt + 1) + totlen);
+		alternates = buf;
+		alternates[num_alt].pfxlen = 0;
+		alternates[num_alt].buf = NULL;
+		op = (char*) (&alternates[cnt+1]);
+		for (last = cp = alt, i = 0; i < num_alt; cp++) {
+			if (*cp == ':' || *cp == 0) {
+				alternates[i].buf = op;
+				alternates[i].pfxlen = cp - last;
+				memcpy(op, last, cp - last);
+				op[cp - last] = 0;
+				op += (cp - last + 1);
+				last = cp + 1;
+				i++;
+			}
+		}
+		if (cp != last) {
+			alternates[i].buf = op;
+			alternates[i].pfxlen = last - cp;
+			memcpy(op, last, last - cp);
+			op[last-cp] = 0;
+		}
+	}
+	if (!stat(name, &st))
+		return name;
+	for (i = 0; i < num_alt; i++) {
+		char *alt = alternates[i].buf;
+		int len = alternates[i].pfxlen;
+		char *name = alt + len;
+		alt[len] = '/';
+		alt[len+3] = '/';
+		name = alt + len + 1;
+		for (i = 0; i < 20; i++) {
+			static char hex[] = "0123456789abcdef";
+			unsigned int val = sha1[i];
+			char *pos = name + i*2 + (i > 0);
+			*pos++ = hex[val >> 4];
+			*pos = hex[val & 0xf];
+		}
+		if (!stat(alt, &st))
+			return alt;
+	}
+	return NULL;
+}
+
 int check_sha1_signature(unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	char header[100];
@@ -145,10 +247,14 @@ int check_sha1_signature(unsigned char *
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	char *filename = sha1_file_name(sha1);
 	struct stat st;
 	void *map;
 	int fd;
+	char *filename = find_sha1_file(sha1);
+	if (!filename) {
+		error("cannot map sha1 file %s", sha1_to_hex(sha1));
+		return NULL;
+	}
 
 	fd = open(filename, O_RDONLY | sha1_file_open_flag);
 	if (fd < 0) {
@@ -442,8 +548,10 @@ int write_sha1_from_fd(const unsigned ch
 
 int has_sha1_file(const unsigned char *sha1)
 {
-	char *filename = sha1_file_name(sha1);
 	struct stat st;
+	char *filename = find_sha1_file(sha1);
+	if (!filename)
+		return 0;
 
 	if (!stat(filename, &st))
 		return 1;
----------------------------------------------------------------

