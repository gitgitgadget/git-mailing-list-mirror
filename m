From: Jeff King <peff@peff.net>
Subject: [PATCH 47/68] write_loose_object: convert to strbuf
Date: Thu, 24 Sep 2015 17:07:49 -0400
Message-ID: <20150924210749.GR30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkZ-00028o-71
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbbIXVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754060AbbIXVHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:52 -0400
Received: (qmail 12088 invoked by uid 102); 24 Sep 2015 21:07:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:52 -0500
Received: (qmail 29392 invoked by uid 107); 24 Sep 2015 21:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:49 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278598>

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
 sha1_file.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c26fdcb..4211af1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3011,29 +3011,31 @@ static inline int directory_size(const char *filename)
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
+		 * Make sure the directory exists; note that the contents
+		 * of the buffer are undefined after mkstemp returns an
+		 * error, so we have to rewrite the whole buffer from
+		 * scratch.
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
@@ -3046,10 +3048,10 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
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
@@ -3098,12 +3100,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
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
2.6.0.rc3.454.g204ad51
