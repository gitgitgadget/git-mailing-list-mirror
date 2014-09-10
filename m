From: Jeff King <peff@peff.net>
Subject: [PATCH] refs: write packed_refs file using stdio
Date: Wed, 10 Sep 2014 06:03:52 -0400
Message-ID: <20140910100352.GA12164@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 12:04:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRekq-00021x-II
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 12:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaIJKD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 06:03:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:46437 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752250AbaIJKDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 06:03:55 -0400
Received: (qmail 17729 invoked by uid 102); 10 Sep 2014 10:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 05:03:55 -0500
Received: (qmail 15310 invoked by uid 107); 10 Sep 2014 10:04:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 06:04:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 06:03:52 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256729>

We write each line of a new packed-refs file individually
using a write() syscall (and sometimes 2, if the ref is
peeled). Since each line is only about 50-100 bytes long,
this creates a lot of system call overhead.

We can instead open a stdio handle around our descriptor and
use fprintf to write to it. The extra buffering is not a
problem for us, because nobody will read our new packed-refs
file until we call commit_lock_file (by which point we have
flushed everything).

On a pathological repository with 8.5 million refs, this
dropped the time to run `git pack-refs` from 20s to 6s.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously that repo is ridiculous (but a sad reality for me).

However, I think the benefits extend to smaller files, too. And it's
pretty easy to do (and I actually think the resulting write_packed_entry
is a lot easier to read, as well as lifting some arbitrary limits).

 cache.h        |  2 ++
 refs.c         | 39 ++++++++++++++++-----------------------
 write_or_die.c | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 4d5b76c..bc286ce 100644
--- a/cache.h
+++ b/cache.h
@@ -1395,6 +1395,8 @@ extern const char *git_mailmap_blob;
 
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
+__attribute__((format (printf, 2, 3)))
+extern void fprintf_or_die(FILE *, const char *fmt, ...);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
diff --git a/refs.c b/refs.c
index 27927f2..f08faed 100644
--- a/refs.c
+++ b/refs.c
@@ -2191,25 +2191,12 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
+static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
 			       unsigned char *peeled)
 {
-	char line[PATH_MAX + 100];
-	int len;
-
-	len = snprintf(line, sizeof(line), "%s %s\n",
-		       sha1_to_hex(sha1), refname);
-	/* this should not happen but just being defensive */
-	if (len > sizeof(line))
-		die("too long a refname '%s'", refname);
-	write_or_die(fd, line, len);
-
-	if (peeled) {
-		if (snprintf(line, sizeof(line), "^%s\n",
-			     sha1_to_hex(peeled)) != PEELED_LINE_LENGTH)
-			die("internal error");
-		write_or_die(fd, line, PEELED_LINE_LENGTH);
-	}
+	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
+	if (peeled)
+		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
 }
 
 /*
@@ -2217,13 +2204,12 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		error("internal error: %s is not a valid packed reference!",
 		      entry->name);
-	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
+	write_packed_entry(cb_data, entry->name, entry->u.value.sha1,
 			   peel_status == PEEL_PEELED ?
 			   entry->u.value.peeled : NULL);
 	return 0;
@@ -2259,15 +2245,22 @@ int commit_packed_refs(void)
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
 	int save_errno = 0;
+	FILE *out;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
-	write_or_die(packed_ref_cache->lock->fd,
-		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
+	out = fdopen(packed_ref_cache->lock->fd, "w");
+	if (!out)
+		die_errno("unable to fdopen packed-refs descriptor");
+
+	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 0, write_packed_entry_fn,
-				 &packed_ref_cache->lock->fd);
+				 0, write_packed_entry_fn, out);
+	if (fclose(out))
+		die_errno("write error");
+	packed_ref_cache->lock->fd = -1;
+
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
 		error = -1;
diff --git a/write_or_die.c b/write_or_die.c
index b50f99a..e7afe7a 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -49,6 +49,21 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 	}
 }
 
+void fprintf_or_die(FILE *f, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vfprintf(f, fmt, ap);
+	va_end(ap);
+
+	if (ret < 0) {
+		check_pipe(errno);
+		die_errno("write error");
+	}
+}
+
 void fsync_or_die(int fd, const char *msg)
 {
 	if (fsync(fd) < 0) {
-- 
2.1.0.373.g91ca799
