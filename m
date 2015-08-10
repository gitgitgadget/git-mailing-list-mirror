From: Jeff King <peff@peff.net>
Subject: [PATCH 11/17] refs.c: simplify strbufs in reflog setup and writing
Date: Mon, 10 Aug 2015 05:36:39 -0400
Message-ID: <20150810093638.GK30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjVg-0004r3-85
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbHJJgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:36:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:42844 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421AbbHJJgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:36:43 -0400
Received: (qmail 30987 invoked by uid 102); 10 Aug 2015 09:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:36:44 -0500
Received: (qmail 3203 invoked by uid 107); 10 Aug 2015 09:36:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:36:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:36:39 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275577>

Commit 1a83c24 (git_snpath(): retire and replace with
strbuf_git_path(), 2014-11-30) taught log_ref_setup and
log_ref_write_1 to take a strbuf parameter, rather than a
bare string. It then makes an alias to the strbuf's "buf"
field under the original name.

This made the original diff much shorter, but the resulting
code is more complicated that it needs to be. Since we've
aliased the pointer, we drop our reference to the strbuf to
ensure we don't accidentally change it. But if we simply
drop our alias and use "logfile.buf" directly, we do not
have to worry about this aliasing. It's a larger diff, but
the resulting code is simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 06f95c4..3666132 100644
--- a/refs.c
+++ b/refs.c
@@ -3150,46 +3150,42 @@ static int should_autocreate_reflog(const char *refname)
  * should_autocreate_reflog returns non-zero.  Otherwise, create it
  * regardless of the ref name.  Fill in *err and return -1 on failure.
  */
-static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
+static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
-	char *logfile;
 
-	strbuf_git_path(sb_logfile, "logs/%s", refname);
-	logfile = sb_logfile->buf;
-	/* make sure the rest of the function can't change "logfile" */
-	sb_logfile = NULL;
+	strbuf_git_path(logfile, "logs/%s", refname);
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (safe_create_leading_directories(logfile) < 0) {
+		if (safe_create_leading_directories(logfile->buf) < 0) {
 			strbuf_addf(err, "unable to create directory for %s: "
-				    "%s", logfile, strerror(errno));
+				    "%s", logfile->buf, strerror(errno));
 			return -1;
 		}
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(logfile, oflags, 0666);
+	logfd = open(logfile->buf, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && (errno == ENOENT || errno == EISDIR))
 			return 0;
 
 		if (errno == EISDIR) {
-			if (remove_empty_directories(logfile)) {
+			if (remove_empty_directories(logfile->buf)) {
 				strbuf_addf(err, "There are still logs under "
-					    "'%s'", logfile);
+					    "'%s'", logfile->buf);
 				return -1;
 			}
-			logfd = open(logfile, oflags, 0666);
+			logfd = open(logfile->buf, oflags, 0666);
 		}
 
 		if (logfd < 0) {
 			strbuf_addf(err, "unable to append to %s: %s",
-				    logfile, strerror(errno));
+				    logfile->buf, strerror(errno));
 			return -1;
 		}
 	}
 
-	adjust_shared_perm(logfile);
+	adjust_shared_perm(logfile->buf);
 	close(logfd);
 	return 0;
 }
@@ -3233,36 +3229,32 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
 static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
-			   struct strbuf *sb_log_file, int flags,
+			   struct strbuf *log_file, int flags,
 			   struct strbuf *err)
 {
 	int logfd, result, oflags = O_APPEND | O_WRONLY;
-	char *log_file;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file, err, flags & REF_FORCE_CREATE_REFLOG);
+	result = log_ref_setup(refname, log_file, err, flags & REF_FORCE_CREATE_REFLOG);
 
 	if (result)
 		return result;
-	log_file = sb_log_file->buf;
-	/* make sure the rest of the function can't change "log_file" */
-	sb_log_file = NULL;
 
-	logfd = open(log_file, oflags);
+	logfd = open(log_file->buf, oflags);
 	if (logfd < 0)
 		return 0;
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to %s: %s", log_file,
+		strbuf_addf(err, "unable to append to %s: %s", log_file->buf,
 			    strerror(errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to %s: %s", log_file,
+		strbuf_addf(err, "unable to append to %s: %s", log_file->buf,
 			    strerror(errno));
 		return -1;
 	}
-- 
2.5.0.414.g670f2a4
