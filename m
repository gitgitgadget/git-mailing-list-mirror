From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Sat, 07 May 2005 12:51:04 -0700
Message-ID: <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
	<2637.10.10.10.24.1115425225.squirrel@linux1>
	<7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
	<2721.10.10.10.24.1115425962.squirrel@linux1>
	<7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 21:44:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUVEG-0003uL-7B
	for gcvg-git@gmane.org; Sat, 07 May 2005 21:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVEGTva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 15:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVEGTva
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 15:51:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57501 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262747AbVEGTvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 15:51:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507195106.BXWV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 15:51:06 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 06 May 2005 23:31:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> Perhaps I'm just missing something in your code,...
JCH> Thankfully I think Linus had rejected this part in the series.
JCH> I'll fix it up.

Here is the fixed one.  The previous one was ugly and
inconvenient to use (thanks for noticing, Sean).

I'll keep it in the git-jc repository until Linus returns.

------------

Author: Junio C Hamano <junkio@cox.net>
Date:   Sat May 7 00:38:04 2005 -0700
    
Introduce SHA1_FILE_DIRECTORIES to support multiple object databases.

SHA1_FILE_DIRECTORIES environment variable is a colon separated paths
used when looking for SHA1 files not found in the usual place for
reading.  Creating a new SHA1 file does not use this alternate object
database location mechanism.  This is useful to archive older, rarely
used objects into separate directories.

Signed-off-by: Junio C Hamano <junkio@cox.net>

--- a/cache.h
+++ b/cache.h
@@ -101,6 +101,7 @@ unsigned int active_nr, active_alloc, ac
 
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
+#define ALTERNATE_DB_ENVIRONMENT "SHA1_FILE_DIRECTORIES"
 
 #define get_object_directory() (getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
 
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -306,7 +306,7 @@ int main(int argc, char **argv)
 			usage("fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
 	}
 
-	sha1_dir = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+	sha1_dir = get_object_directory();
 	for (i = 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", sha1_dir, i);
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -100,18 +100,34 @@ char * sha1_to_hex(const unsigned char *
 	return buffer;
 }
 
+static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
+{
+	int i;
+	for (i = 0; i < 20; i++) {
+		static char hex[] = "0123456789abcdef";
+		unsigned int val = sha1[i];
+		char *pos = pathbuf + i*2 + (i > 0);
+		*pos++ = hex[val >> 4];
+		*pos = hex[val & 0xf];
+	}
+}
+
 /*
  * NOTE! This returns a statically allocated buffer, so you have to be
  * careful about using it. Do a "strdup()" if you need to save the
  * filename.
+ *
+ * Also note that this returns the location for creating.  Reading
+ * SHA1 file can happen from any alternate directory listed in the
+ * SHA1_FILE_DIRECTORIES environment variable if it is not found in
+ * the primary object database.
  */
 char *sha1_file_name(const unsigned char *sha1)
 {
-	int i;
 	static char *name, *base;
 
 	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+		char *sha1_file_directory = get_object_directory();
 		int len = strlen(sha1_file_directory);
 		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
@@ -120,16 +136,74 @@ char *sha1_file_name(const unsigned char
 		base[len+3] = '/';
 		name = base + len + 1;
 	}
-	for (i = 0; i < 20; i++) {
-		static char hex[] = "0123456789abcdef";
-		unsigned int val = sha1[i];
-		char *pos = name + i*2 + (i > 0);
-		*pos++ = hex[val >> 4];
-		*pos = hex[val & 0xf];
-	}
+	fill_sha1_path(name, sha1);
 	return base;
 }
 
+static struct alternate_object_database
+{
+	char *base;
+	char *name;
+} *alt_odb;
+
+static void prepare_alt_odb(void)
+{
+	int pass, totlen, i;
+	void *buf;
+	const char *cp, *last;
+	char *op = 0;
+	const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
+
+	for (totlen = pass = 0; pass < 2; pass++) {
+		last = alt;
+		i = 0;
+		do {
+			cp = strchr(last, ':') ? : last + strlen(last);
+			if (last != cp) {
+				/* 43 = 40-byte + 2 '/' + terminating NUL */
+				int pfxlen = cp - last;
+				int entlen = pfxlen + 43;
+				if (pass == 0)
+					totlen += entlen;
+				else {
+					alt_odb[i].base = op;
+					alt_odb[i].name = op + pfxlen + 1;
+					memcpy(op, last, pfxlen);
+					op[pfxlen] = op[pfxlen + 3] = '/';
+					op[entlen-1] = 0;
+					op += entlen;
+				}
+				i++;
+			}
+			while (*cp && *cp == ':')
+				cp++;
+			last = cp;
+		} while (*cp);
+		if (pass)
+			break;
+		alt_odb = buf = xmalloc(sizeof(*alt_odb) * (i + 1) + totlen);
+		alt_odb[i].base = alt_odb[i].name = 0;
+		op = (char*)(&alt_odb[i+1]);
+	}
+}
+
+static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
+{
+	int i;
+	char *name = sha1_file_name(sha1);
+
+	if (!stat(name, st))
+		return name;
+	if (!alt_odb)
+		prepare_alt_odb();
+	for (i = 0; (name = alt_odb[i].name) != NULL; i++) {
+		fill_sha1_path(name, sha1);
+		if (!stat(alt_odb[i].base, st))
+			return alt_odb[i].base;
+	}
+	return NULL;
+}
+
 int check_sha1_signature(unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	char header[100];
@@ -145,10 +219,15 @@ int check_sha1_signature(unsigned char *
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	char *filename = sha1_file_name(sha1);
 	struct stat st;
 	void *map;
 	int fd;
+	char *filename = find_sha1_file(sha1, &st);
+
+	if (!filename) {
+		error("cannot map sha1 file %s", sha1_to_hex(sha1));
+		return NULL;
+	}
 
 	fd = open(filename, O_RDONLY | sha1_file_open_flag);
 	if (fd < 0) {
@@ -167,10 +246,6 @@ void *map_sha1_file(const unsigned char 
 		/* If it failed once, it will probably fail again. Stop using O_NOATIME */
 		sha1_file_open_flag = 0;
 	}
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return NULL;
-	}
 	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (-1 == (int)(long)map)
@@ -315,6 +390,7 @@ int write_sha1_file(char *buf, unsigned 
 	}
 
 	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+
 	fd = mkstemp(tmpfile);
 	if (fd < 0) {
 		fprintf(stderr, "unable to create temporary sha1 filename %s: %s", tmpfile, strerror(errno));
@@ -442,12 +518,8 @@ int write_sha1_from_fd(const unsigned ch
 
 int has_sha1_file(const unsigned char *sha1)
 {
-	char *filename = sha1_file_name(sha1);
 	struct stat st;
-
-	if (!stat(filename, &st))
-		return 1;
-	return 0;
+	return !!find_sha1_file(sha1, &st);
 }
 
 int index_fd(unsigned char *sha1, int fd, struct stat *st)




