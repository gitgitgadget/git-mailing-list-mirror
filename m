From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: [PATCH 1/2] removes the artificial restriction tagsize < 8kb from
 git-mktag
Date: Mon, 22 May 2006 16:48:58 +0200
Message-ID: <4471CF5A.702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon May 22 16:49:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiBiJ-0005TD-GK
	for gcvg-git@gmane.org; Mon, 22 May 2006 16:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWEVOsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 10:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEVOsw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 10:48:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:37794 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750886AbWEVOsv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 10:48:51 -0400
Received: (qmail invoked by alias); 22 May 2006 14:48:50 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp042) with SMTP; 22 May 2006 16:48:50 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20509>


Signed-off-by: Bj=F6rn Engelmann <BjEngelmann@gmx.de>


---

5653af26c2cdb31e1f5646b8e563cc8fa27a8d43
 cache.h     |    1 +
 mktag.c     |   29 ++++++++++++++++-------------
 sha1_file.c |   46 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

5653af26c2cdb31e1f5646b8e563cc8fa27a8d43
diff --git a/cache.h b/cache.h
index 4b7a439..19e90eb 100644
--- a/cache.h
+++ b/cache.h
@@ -154,6 +154,7 @@ extern int ce_match_stat(struct cache_en
 extern int ce_modified(struct cache_entry *ce, struct stat *st, int);
 extern int ce_path_match(const struct cache_entry *ce, const char
**pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int
write_object, const char *type);
+extern int read_pipe(int fd, char** return_buf, unsigned long*
return_size);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type,
int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct
stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
diff --git a/mktag.c b/mktag.c
index 2328878..79c466c 100644
--- a/mktag.c
+++ b/mktag.c
@@ -45,7 +45,7 @@ static int verify_tag(char *buffer, unsi
     unsigned char sha1[20];
     const char *object, *type_line, *tag_line, *tagger_line;
=20
-    if (size < 64 || size > MAXSIZE-1)
+    if (size < 64)
         return -1;
     buffer[size] =3D 0;
=20
@@ -105,8 +105,8 @@ static int verify_tag(char *buffer, unsi
=20
 int main(int argc, char **argv)
 {
-    unsigned long size;
-    char buffer[MAXSIZE];
+    unsigned long size =3D 4096;
+    char *buffer =3D malloc(size);
     unsigned char result_sha1[20];
=20
     if (argc !=3D 1)
@@ -114,21 +114,24 @@ int main(int argc, char **argv)
=20
     setup_git_directory();
=20
-    // Read the signature
-    size =3D 0;
-    for (;;) {
-        int ret =3D xread(0, buffer + size, MAXSIZE - size);
-        if (ret <=3D 0)
-            break;
-        size +=3D ret;
+    if (read_pipe(0, &buffer, &size)) {
+        free(buffer);
+        die("could not read from stdin");
     }
-
+   =20
     // Verify it for some basic sanity: it needs to start with "object
<sha1>\ntype\ntagger "
-    if (verify_tag(buffer, size) < 0)
+    if (verify_tag(buffer, size) < 0) {
+        free(buffer);
         die("invalid tag signature file");
+    }
=20
-    if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
+    if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0) {
+        free(buffer);
         die("unable to write tag file");
+    }
+       =20
+    free(buffer);
+   =20
     printf("%s\n", sha1_to_hex(result_sha1));
     return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 2230010..ad02255 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1645,16 +1645,24 @@ int has_sha1_file(const unsigned char *s
     return find_sha1_file(sha1, &st) ? 1 : 0;
 }
=20
-int index_pipe(unsigned char *sha1, int fd, const char *type, int
write_object)
+/*
+ * reads from fd as long as possible into a supplied buffer of size by=
tes.
+ * If neccessary the buffer's size is increased using realloc()
+ *
+ * returns 0 if anything went fine and -1 otherwise
+ *
+ * NOTE: both buf and size may change, but even when -1 is returned
+ * you still have to free() it yourself.
+ */
+int read_pipe(int fd, char** return_buf, unsigned long* return_size)
 {
-    unsigned long size =3D 4096;
-    char *buf =3D malloc(size);
-    int iret, ret;
+    char* buf =3D *return_buf;
+    unsigned long size =3D *return_size;
+    int iret;
     unsigned long off =3D 0;
-    unsigned char hdr[50];
-    int hdrlen;
+   =20
     do {
-        iret =3D read(fd, buf + off, size - off);
+        iret =3D xread(fd, buf + off, size - off);
         if (iret > 0) {
             off +=3D iret;
             if (off =3D=3D size) {
@@ -1663,16 +1671,34 @@ int index_pipe(unsigned char *sha1, int
             }
         }
     } while (iret > 0);
-    if (iret < 0) {
+   =20
+    *return_buf =3D buf;
+    *return_size =3D off;
+   =20
+    if (iret < 0)
+        return -1;
+    return 0;
+}
+
+int index_pipe(unsigned char *sha1, int fd, const char *type, int
write_object)
+{
+    unsigned long size =3D 4096;
+    char *buf =3D malloc(size);
+    int ret;
+    unsigned char hdr[50];
+    int hdrlen;
+   =20
+    if (read_pipe(fd, &buf, &size)) {
         free(buf);
         return -1;
     }
+   =20
     if (!type)
         type =3D blob_type;
     if (write_object)
-        ret =3D write_sha1_file(buf, off, type, sha1);
+        ret =3D write_sha1_file(buf, size, type, sha1);
     else {
-        write_sha1_file_prepare(buf, off, type, sha1, hdr, &hdrlen);
+        write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
         ret =3D 0;
     }
     free(buf);
--=20
1.3.3.g5045-dirty
