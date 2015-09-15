From: Jeff King <peff@peff.net>
Subject: [PATCH 46/67] write_loose_object: convert to strbuf
Date: Tue, 15 Sep 2015 12:00:44 -0400
Message-ID: <20150915160044.GT29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsf4-00007E-CT
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbbIOQAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:00:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:59420 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753963AbbIOQAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:00:47 -0400
Received: (qmail 13604 invoked by uid 102); 15 Sep 2015 16:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:00:46 -0500
Received: (qmail 7692 invoked by uid 107); 15 Sep 2015 16:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:00:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:00:44 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277950>

When creating a loose object tempfile, we use a fixed
PATH_MAX-sized buffer, and strcpy directly into it. This
isn't buggy, because we do a rough check of the size, but
there's no verification that our guesstimate of the required
space is enough (in fact, it's several bytes too big for the
current naming scheme).

Let's switch to a strbuf, which makes this much easier to
verify. The allocation overhead should be negligible, since
we are replacing a static buffer with a static strbuf, and
we'll only need to allocate on the first call.

While we're here, we can also document a subtle interaction
with mkstemp that would be easy to overlook.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9d87b69..374a996 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3007,29 +3007,30 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
+static int create_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
-	if (dirlen + 20 > bufsiz) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
-	memcpy(buffer, filename, dirlen);
-	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
-	fd = git_mkstemp_mode(buffer, 0444);
+	strbuf_reset(tmp);
+	strbuf_add(tmp, filename, dirlen);
+	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
+	fd = git_mkstemp_mode(tmp->buf, 0444);
 	if (fd < 0 && dirlen && errno == ENOENT) {
-		/* Make sure the directory exists */
-		memcpy(buffer, filename, dirlen);
-		buffer[dirlen-1] = 0;
-		if (mkdir(buffer, 0777) && errno != EEXIST)
+		/*
+		 * Make sure the directory exists; note that mkstemp will have
+		 * put a NUL in our buffer, so we have to rewrite the path,
+		 * rather than just chomping the length.
+		 */
+		strbuf_reset(tmp);
+		strbuf_add(tmp, filename, dirlen - 1);
+		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
 			return -1;
-		if (adjust_shared_perm(buffer))
+		if (adjust_shared_perm(tmp->buf))
 			return -1;
 
 		/* Try again */
-		strcpy(buffer + dirlen - 1, "/tmp_obj_XXXXXX");
-		fd = git_mkstemp_mode(buffer, 0444);
+		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
+		fd = git_mkstemp_mode(tmp->buf, 0444);
 	}
 	return fd;
 }
@@ -3042,10 +3043,10 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_zstream stream;
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
-	static char tmp_file[PATH_MAX];
+	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
-	fd = create_tmpfile(tmp_file, sizeof(tmp_file), filename);
+	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
@@ -3094,12 +3095,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 		struct utimbuf utb;
 		utb.actime = mtime;
 		utb.modtime = mtime;
-		if (utime(tmp_file, &utb) < 0)
+		if (utime(tmp_file.buf, &utb) < 0)
 			warning("failed utime() on %s: %s",
-				tmp_file, strerror(errno));
+				tmp_file.buf, strerror(errno));
 	}
 
-	return finalize_object_file(tmp_file, filename);
+	return finalize_object_file(tmp_file.buf, filename);
 }
 
 static int freshen_loose_object(const unsigned char *sha1)
-- 
2.6.0.rc2.408.ga2926b9
