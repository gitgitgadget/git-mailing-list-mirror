From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] add a force_object_loose() function
Date: Wed, 14 May 2008 01:32:48 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805140130090.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 07:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw9cj-0005ni-F0
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 07:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYENFcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 01:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYENFcu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 01:32:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35128 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYENFct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 01:32:49 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0U00CPMFEOXM20@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 May 2008 01:32:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82072>


This is meant to force the creation of a loose object even if it
already exists packed.  Needed for the next commit.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/cache.h b/cache.h
index a23d1ac..c761915 100644
--- a/cache.h
+++ b/cache.h
@@ -527,6 +527,7 @@ extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type,
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
diff --git a/sha1_file.c b/sha1_file.c
index d21e23b..206ea2d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2114,26 +2114,16 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
+			      void *buf, unsigned long len, time_t mtime)
 {
-	int size, ret;
+	int fd, size, ret;
 	unsigned char *compressed;
 	z_stream stream;
-	unsigned char sha1[20];
 	char *filename;
 	static char tmpfile[PATH_MAX];
-	char hdr[32];
-	int fd, hdrlen;
 
-	/* Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
-	 */
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	filename = sha1_file_name(sha1);
-	if (returnsha1)
-		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
-		return 0;
 	fd = open(filename, O_RDONLY);
 	if (fd >= 0) {
 		/*
@@ -2194,9 +2184,53 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		die("unable to write sha1 file");
 	free(compressed);
 
+	if (mtime) {
+		struct utimbuf utb;
+		utb.actime = mtime;
+		utb.modtime = mtime;
+		if (utime(tmpfile, &utb) < 0)
+			warning("failed utime() on %s: %s",
+				tmpfile, strerror(errno));
+	}
+
 	return move_temp_to_file(tmpfile, filename);
 }
 
+int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+{
+	unsigned char sha1[20];
+	char hdr[32];
+	int hdrlen;
+
+	/* Normally if we have it in the pack then we do not bother writing
+	 * it out into .git/objects/??/?{38} file.
+	 */
+	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (returnsha1)
+		hashcpy(returnsha1, sha1);
+	if (has_sha1_file(sha1))
+		return 0;
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+}
+
+int force_object_loose(const unsigned char *sha1, time_t mtime)
+{
+	struct stat st;
+	void *buf;
+	unsigned long len;
+	enum object_type type;
+	char hdr[32];
+	int hdrlen;
+
+	if (find_sha1_file(sha1, &st))
+		return 0;
+	buf = read_packed_sha1(sha1, &type, &len);
+	if (!buf)
+		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
+	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+}
+
 /*
  * We need to unpack and recompress the object for writing
  * it out to a different file.
