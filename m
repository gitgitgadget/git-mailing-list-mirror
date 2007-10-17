From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/6] pack-objects.c: fix some global variable abuse and memory
 leaks
Date: Tue, 16 Oct 2007 21:55:48 -0400
Message-ID: <1192586150-13743-5-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <1192586150-13743-3-git-send-email-nico@cam.org>
 <1192586150-13743-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9S-0003Wi-CA
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935966AbXJQB4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935959AbXJQB4E
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:56:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936203AbXJQBz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:58 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61310>

To keep things well layered, sha1close() now returns the file descriptor
when it doesn't close the file.

An ugly cast was added to the return of write_idx_file() to avoid a
warning.  A proper fix will come separately.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   29 +++++++++++++++--------------
 csum-file.c            |   23 ++++++++++++++---------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d729cb7..933c252 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -65,8 +65,6 @@ static int no_reuse_delta, no_reuse_object, keep_unreachable;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
-static const char *pack_tmp_name, *idx_tmp_name;
-static char tmpname[PATH_MAX];
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
@@ -587,12 +585,6 @@ static off_t write_one(struct sha1file *f,
 	return offset + size;
 }
 
-static int open_object_dir_tmp(const char *path)
-{
-    snprintf(tmpname, sizeof(tmpname), "%s/%s", get_object_directory(), path);
-    return xmkstemp(tmpname);
-}
-
 /* forward declaration for write_pack_file */
 static int adjust_perm(const char *path, mode_t mode);
 
@@ -611,11 +603,16 @@ static void write_pack_file(void)
 
 	do {
 		unsigned char sha1[20];
+		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout) {
 			f = sha1fd(1, "<stdout>");
 		} else {
-			int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
+			char tmpname[PATH_MAX];
+			int fd;
+			snprintf(tmpname, sizeof(tmpname),
+				 "%s/tmp_pack_XXXXXX", get_object_directory());
+			fd = xmkstemp(tmpname);
 			pack_tmp_name = xstrdup(tmpname);
 			f = sha1fd(fd, pack_tmp_name);
 		}
@@ -643,19 +640,21 @@ static void write_pack_file(void)
 		if (pack_to_stdout || nr_written == nr_remaining) {
 			sha1close(f, sha1, 1);
 		} else {
-			sha1close(f, sha1, 0);
-			fixup_pack_header_footer(f->fd, sha1, pack_tmp_name, nr_written);
-			close(f->fd);
+			int fd = sha1close(f, NULL, 0);
+			fixup_pack_header_footer(fd, sha1, pack_tmp_name, nr_written);
+			close(fd);
 		}
 
 		if (!pack_to_stdout) {
 			mode_t mode = umask(0);
+			char *idx_tmp_name, tmpname[PATH_MAX];
 
 			umask(mode);
 			mode = 0444 & ~mode;
 
-			idx_tmp_name = write_idx_file(NULL,
-				(struct pack_idx_entry **) written_list, nr_written, sha1);
+			idx_tmp_name = (char *) write_idx_file(NULL,
+					(struct pack_idx_entry **) written_list,
+					nr_written, sha1);
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(pack_tmp_name, mode))
@@ -672,6 +671,8 @@ static void write_pack_file(void)
 			if (rename(idx_tmp_name, tmpname))
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
+			free(idx_tmp_name);
+			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
 
diff --git a/csum-file.c b/csum-file.c
index 9ab9971..9929991 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -31,22 +31,27 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 
 int sha1close(struct sha1file *f, unsigned char *result, int final)
 {
+	int fd;
 	unsigned offset = f->offset;
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
 		f->offset = 0;
 	}
-	if (!final)
-		return 0;	/* only want to flush (no checksum write, no close) */
-	SHA1_Final(f->buffer, &f->ctx);
-	if (result)
-		hashcpy(result, f->buffer);
-	sha1flush(f, 20);
-	if (close(f->fd))
-		die("%s: sha1 file error on close (%s)", f->name, strerror(errno));
+	if (final) {
+		/* write checksum and close fd */
+		SHA1_Final(f->buffer, &f->ctx);
+		if (result)
+			hashcpy(result, f->buffer);
+		sha1flush(f, 20);
+		if (close(f->fd))
+			die("%s: sha1 file error on close (%s)",
+			    f->name, strerror(errno));
+		fd = 0;
+	} else
+		fd = f->fd;
 	free(f);
-	return 0;
+	return fd;
 }
 
 int sha1write(struct sha1file *f, void *buf, unsigned int count)
-- 
1.5.3.4.1212.gdb015
