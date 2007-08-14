From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 2/2] Use xmkstemp() instead of mkstemp()
Date: Tue, 14 Aug 2007 16:45:58 -0300
Organization: Mandriva
Message-ID: <20070814164558.1a627475@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2LN-0002V7-1C
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764198AbXHNTqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763769AbXHNTqM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 15:46:12 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:53575 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbXHNTqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 15:46:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B7FC81AB4D;
	Tue, 14 Aug 2007 16:46:07 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id vMWrh2ggBwdG; Tue, 14 Aug 2007 16:45:59 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B87721AB4B;
	Tue, 14 Aug 2007 16:45:59 -0300 (BRT)
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55852>


xmkstemp() performs error checking and prints a standard error message when
an error occur.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 builtin-pack-objects.c |    4 +---
 fast-import.c          |    8 ++------
 index-pack.c           |    2 +-
 merge-recursive.c      |    4 +---
 pack-write.c           |    2 +-
 unpack-file.c          |    4 +---
 6 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5e9d1fd..51a850e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -586,7 +586,7 @@ static off_t write_one(struct sha1file *f,
 static int open_object_dir_tmp(const char *path)
 {
     snprintf(tmpname, sizeof(tmpname), "%s/%s", get_object_directory(), path);
-    return mkstemp(tmpname);
+    return xmkstemp(tmpname);
 }
 
 /* forward declaration for write_pack_file */
@@ -612,8 +612,6 @@ static void write_pack_file(void)
 			f = sha1fd(1, "<stdout>");
 		} else {
 			int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
-			if (fd < 0)
-				die("unable to create %s: %s\n", tmpname, strerror(errno));
 			pack_tmp_name = xstrdup(tmpname);
 			f = sha1fd(fd, pack_tmp_name);
 		}
diff --git a/fast-import.c b/fast-import.c
index 99a19d8..170cccd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -663,9 +663,7 @@ static void start_packfile(void)
 
 	snprintf(tmpfile, sizeof(tmpfile),
 		"%s/tmp_pack_XXXXXX", get_object_directory());
-	pack_fd = mkstemp(tmpfile);
-	if (pack_fd < 0)
-		die("Can't create %s: %s", tmpfile, strerror(errno));
+	pack_fd = xmkstemp(tmpfile);
 	p = xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
 	strcpy(p->pack_name, tmpfile);
 	p->pack_fd = pack_fd;
@@ -727,9 +725,7 @@ static char *create_index(void)
 
 	snprintf(tmpfile, sizeof(tmpfile),
 		"%s/tmp_idx_XXXXXX", get_object_directory());
-	idx_fd = mkstemp(tmpfile);
-	if (idx_fd < 0)
-		die("Can't create %s: %s", tmpfile, strerror(errno));
+	idx_fd = xmkstemp(tmpfile);
 	f = sha1fd(idx_fd, tmpfile);
 	sha1write(f, array, 256 * sizeof(int));
 	SHA1_Init(&ctx);
diff --git a/index-pack.c b/index-pack.c
index 8403c36..db58e05 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -114,7 +114,7 @@ static const char *open_pack_file(const char *pack_name)
 			static char tmpfile[PATH_MAX];
 			snprintf(tmpfile, sizeof(tmpfile),
 				 "%s/tmp_pack_XXXXXX", get_object_directory());
-			output_fd = mkstemp(tmpfile);
+			output_fd = xmkstemp(tmpfile);
 			pack_name = xstrdup(tmpfile);
 		} else
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
diff --git a/merge-recursive.c b/merge-recursive.c
index f7d1b84..ca77cdb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -777,9 +777,7 @@ static void create_temp(mmfile_t *src, char *path)
 	int fd;
 
 	strcpy(path, ".merge_file_XXXXXX");
-	fd = mkstemp(path);
-	if (fd < 0)
-		die("unable to create temp-file");
+	fd = xmkstemp(path);
 	if (write_in_full(fd, src->ptr, src->size) != src->size)
 		die("unable to write temp-file");
 	close(fd);
diff --git a/pack-write.c b/pack-write.c
index 1cf5f7c..e59b197 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -45,7 +45,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		static char tmpfile[PATH_MAX];
 		snprintf(tmpfile, sizeof(tmpfile),
 			 "%s/tmp_idx_XXXXXX", get_object_directory());
-		fd = mkstemp(tmpfile);
+		fd = xmkstemp(tmpfile);
 		index_name = xstrdup(tmpfile);
 	} else {
 		unlink(index_name);
diff --git a/unpack-file.c b/unpack-file.c
index 25c56b3..65c66eb 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -14,9 +14,7 @@ static char *create_temp_file(unsigned char *sha1)
 		die("unable to read blob object %s", sha1_to_hex(sha1));
 
 	strcpy(path, ".merge_file_XXXXXX");
-	fd = mkstemp(path);
-	if (fd < 0)
-		die("unable to create temp-file");
+	fd = xmkstemp(path);
 	if (write_in_full(fd, buf, size) != size)
 		die("unable to write temp-file");
 	close(fd);
-- 
1.5.3.GIT



-- 
Luiz Fernando N. Capitulino
