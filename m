From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Skip writing out sha1 files for objects in packed git.
Date: Mon, 27 Jun 2005 19:03:13 -0700
Message-ID: <7vr7eni6fy.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 03:59:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5Mn-00060h-M9
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 03:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVF1CFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVF1CFN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:05:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6834 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262376AbVF1CDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 22:03:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628020313.RWRL8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Jun 2005 22:03:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 19:01:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now, there's still a misfeature there, which is that when you
create a new object, it doesn't check whether that object
already exists in the pack-file, so you'll end up with a few
recent objects that you really don't need (notably tree
objects), and this patch fixes it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 apply.c          |    2 +-
 cache.h          |    2 +-
 commit-tree.c    |    2 +-
 convert-cache.c  |    6 +++---
 mktag.c          |    2 +-
 sha1_file.c      |   44 ++++++++++++++++++++++++++++++--------------
 unpack-objects.c |    4 ++--
 update-cache.c   |    2 +-
 write-tree.c     |    2 +-
 9 files changed, 41 insertions(+), 25 deletions(-)

f4f76b275cdabc038bcb4f3c7ca0d443638df88d
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1221,7 +1221,7 @@ static void add_index_file(const char *p
 	if (lstat(path, &st) < 0)
 		die("unable to stat newly created file %s", path);
 	fill_stat_cache_info(ce, &st);
-	if (write_sha1_file(buf, size, "blob", ce->sha1) < 0)
+	if (write_sha1_file(buf, size, "blob", ce->sha1, 0) < 0)
 		die("unable to create backing store for newly created file %s", path);
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 		die("unable to add cache entry for %s", path);
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -165,7 +165,7 @@ extern int parse_sha1_header(char *hdr, 
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
-extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1, int do_expand);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -191,7 +191,7 @@ int main(int argc, char **argv)
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
 		add_buffer(&buffer, &size, "%s", comment);
 
-	write_sha1_file(buffer, size, "commit", commit_sha1);
+	write_sha1_file(buffer, size, "commit", commit_sha1, 0);
 	printf("%s\n", sha1_to_hex(commit_sha1));
 	return 0;
 }
diff --git a/convert-cache.c b/convert-cache.c
--- a/convert-cache.c
+++ b/convert-cache.c
@@ -111,7 +111,7 @@ static int write_subdirectory(void *buff
 		buffer += len;
 	}
 
-	write_sha1_file(new, newlen, "tree", result_sha1);
+	write_sha1_file(new, newlen, "tree", result_sha1, 0);
 	free(new);
 	return used;
 }
@@ -251,7 +251,7 @@ static void convert_date(void *buffer, u
 	memcpy(new + newlen, buffer, size);
 	newlen += size;
 
-	write_sha1_file(new, newlen, "commit", result_sha1);
+	write_sha1_file(new, newlen, "commit", result_sha1, 0);
 	free(new);	
 }
 
@@ -286,7 +286,7 @@ static struct entry * convert_entry(unsi
 	memcpy(buffer, data, size);
 	
 	if (!strcmp(type, "blob")) {
-		write_sha1_file(buffer, size, "blob", entry->new_sha1);
+		write_sha1_file(buffer, size, "blob", entry->new_sha1, 0);
 	} else if (!strcmp(type, "tree"))
 		convert_tree(buffer, size, entry->new_sha1);
 	else if (!strcmp(type, "commit"))
diff --git a/mktag.c b/mktag.c
--- a/mktag.c
+++ b/mktag.c
@@ -123,7 +123,7 @@ int main(int argc, char **argv)
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
-	if (write_sha1_file(buffer, size, "tag", result_sha1) < 0)
+	if (write_sha1_file(buffer, size, "tag", result_sha1, 0) < 0)
 		die("unable to write tag file");
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -891,31 +891,47 @@ void *read_object_with_reference(const u
 	}
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+static char *write_sha1_file_prepare(void *buf,
+				     unsigned long len,
+				     const char *type,
+				     unsigned char *sha1,
+				     unsigned char *hdr,
+				     int *hdrlen)
 {
-	int size;
-	unsigned char *compressed;
-	z_stream stream;
-	unsigned char sha1[20];
 	SHA_CTX c;
-	char *filename;
-	static char tmpfile[PATH_MAX];
-	unsigned char hdr[50];
-	int fd, hdrlen, ret;
 
 	/* Generate the header */
-	hdrlen = sprintf((char *)hdr, "%s %lu", type, len)+1;
+	*hdrlen = sprintf((char *)hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, hdrlen);
+	SHA1_Update(&c, hdr, *hdrlen);
 	SHA1_Update(&c, buf, len);
 	SHA1_Final(sha1, &c);
 
+	return sha1_file_name(sha1);
+}
+
+int write_sha1_file(void *buf, unsigned long len, const char *type,
+		    unsigned char *returnsha1, int do_expand)
+{
+	int size;
+	unsigned char *compressed;
+	z_stream stream;
+	unsigned char sha1[20];
+	char *filename;
+	static char tmpfile[PATH_MAX];
+	unsigned char hdr[50];
+	int fd, hdrlen, ret;
+
+	/* Normally if we have it in the pack then we do not bother writing
+	 * it out into .git/objects/??/?{38} file.
+	 */
+	filename = write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		memcpy(returnsha1, sha1, 20);
-
-	filename = sha1_file_name(sha1);
+	if (!do_expand && has_sha1_file(sha1))
+		return 0;
 	fd = open(filename, O_RDONLY);
 	if (fd >= 0) {
 		/*
@@ -1082,7 +1098,7 @@ int index_fd(unsigned char *sha1, int fd
 	if ((int)(long)buf == -1)
 		return -1;
 
-	ret = write_sha1_file(buf, size, "blob", sha1);
+	ret = write_sha1_file(buf, size, "blob", sha1, 0);
 	if (size)
 		munmap(buf, size);
 	return ret;
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -126,7 +126,7 @@ static int unpack_non_delta_entry(struct
 	case 'B': type_s = "blob"; break;
 	default: goto err_finish;
 	}
-	if (write_sha1_file(buffer, size, type_s, sha1) < 0)
+	if (write_sha1_file(buffer, size, type_s, sha1, 1) < 0)
 		die("failed to write %s (%s)",
 		    sha1_to_hex(entry->sha1), type_s);
 	printf("%s %s\n", sha1_to_hex(sha1), type_s);
@@ -223,7 +223,7 @@ static int unpack_delta_entry(struct pac
 		die("failed to apply delta");
 	free(delta_data);
 
-	if (write_sha1_file(result, result_size, type, sha1) < 0)
+	if (write_sha1_file(result, result_size, type, sha1, 1) < 0)
 		die("failed to write %s (%s)",
 		    sha1_to_hex(entry->sha1), type);
 	free(result);
diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -77,7 +77,7 @@ static int add_file_to_cache(char *path)
 			free(target);
 			return -1;
 		}
-		if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
+		if (write_sha1_file(target, st.st_size, "blob", ce->sha1, 0))
 			return -1;
 		free(target);
 		break;
diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -76,7 +76,7 @@ static int write_tree(struct cache_entry
 		nr++;
 	}
 
-	write_sha1_file(buffer, offset, "tree", returnsha1);
+	write_sha1_file(buffer, offset, "tree", returnsha1, 0);
 	free(buffer);
 	return nr;
 }
------------
