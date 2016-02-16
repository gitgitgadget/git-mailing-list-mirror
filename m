From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/20] log_ref_setup(): manage the name of the reflog file internally
Date: Tue, 16 Feb 2016 14:22:24 +0100
Message-ID: <86533578d4205742b8158be7ce8e8e2f8697f9bd.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjE-00047S-0B
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbcBPNbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:31:04 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48662 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351AbcBPNaj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:39 -0500
X-AuditID: 12074414-8b3ff70000005020-ea-56c322b89451
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9A.1E.20512.8B223C65; Tue, 16 Feb 2016 08:23:04 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOX028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:02 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLtD6XCYwbbLUhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bP7gtsBf/VK/62rGFvYOyU72Lk5JAQMJFY1N/J
	3MXIxSEksJVRYs23djYI5wSTxKFLv5lBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQs8YpTo2r+d
	sYuRg0NYIFRi6cNwkBoWAVWJro5ZrCA2r0CUxNmfa1ghtslJtPzYDWZzClhInGzpZQGxhQTM
	Je582cM0gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQEBPZwXjk
	pNwhRgEORiUeXg6PQ2FCrIllxZW5hxglOZiURHl5uA+HCfEl5adUZiQWZ8QXleakFh9ilOBg
	VhLh/fcKqJw3JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYL3kyLQUMGi
	1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMQXA6MAJMUDtDcNpJ23uCAxFygK0XqK
	UVFKnHc/SEIAJJFRmgc3FpY4XjGKA30pzNsNUsUDTDpw3a+ABjMBDc65BPJQcUkiQkqqgbGI
	5f6W5UV/Nqydv8J/sYMVX+v9P7um5FREOBdtUlHZfi25mTvrufK5hWcXJLEwuEyPKK9crBVY
	7xb85XHqkjsLctP2sekJXNy7ZkPh/Oi4Pic5k9f2bk8zDXYembLZO4H5eteUjacX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286391>

Instead of writing the name of the reflog file into a strbuf that is
supplied by the caller but not needed there, write it into a local
temporary buffer and remove the strbuf parameter entirely.

And while we're adjusting the function signature, reorder the arguments
to move the input parameters before the output parameters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 66 +++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dcd19ee..120189c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2591,39 +2591,38 @@ static int open_or_create_logfile(const char *path, void *cb)
 }
 
 /*
- * Create a reflog for a ref. Store its path to *logfile. If
- * force_create = 0, only create the reflog for certain refs (those
- * for which should_autocreate_reflog returns non-zero). Otherwise,
- * create it regardless of the reference name. If the logfile already
- * existed or was created, return 0 and set *logfd to the file
- * descriptor opened for appending to the file. If no logfile exists
- * and we decided not to create one, return 0 and set *logfd to -1. On
- * failure, fill in *err and return -1.
+ * Create a reflog for a ref. If force_create = 0, only create the
+ * reflog for certain refs (those for which should_autocreate_reflog
+ * returns non-zero). Otherwise, create it regardless of the reference
+ * name. If the logfile already existed or was created, return 0 and
+ * set *logfd to the file descriptor opened for appending to the file.
+ * If no logfile exists and we decided not to create one, return 0 and
+ * set *logfd to -1. On failure, fill in *err and return -1.
  */
-static int log_ref_setup(const char *refname,
-			 struct strbuf *logfile, int *logfd,
-			 struct strbuf *err, int force_create)
+static int log_ref_setup(const char *refname, int force_create,
+			 int *logfd, struct strbuf *err)
 {
-	strbuf_git_path(logfile, "logs/%s", refname);
+	char *logfile = git_pathdup("logs/%s", refname);
+	int ret = 0;
 
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (raceproof_create_file(logfile->buf, open_or_create_logfile, logfd) < 0) {
+		if (raceproof_create_file(logfile, open_or_create_logfile, logfd) < 0) {
 			if (errno == ENOENT) {
 				strbuf_addf(err, "unable to create directory for %s: "
-					    "%s", logfile->buf, strerror(errno));
+					    "%s", logfile, strerror(errno));
 			} else if (errno == EISDIR) {
 				strbuf_addf(err, "there are still logs under %s",
-					    logfile->buf);
+					    logfile);
 			} else {
 				strbuf_addf(err, "unable to append to %s: %s",
-					    logfile->buf, strerror(errno));
+					    logfile, strerror(errno));
 			}
-			return -1;
+			ret = -1;
 		} else {
-			adjust_shared_perm(logfile->buf);
+			adjust_shared_perm(logfile);
 		}
 	} else {
-		*logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
+		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
 		if (*logfd < 0) {
 			if (errno == ENOENT || errno == EISDIR) {
 				/*
@@ -2634,27 +2633,25 @@ static int log_ref_setup(const char *refname,
 				 */
 			} else {
 				strbuf_addf(err, "unable to append to %s: %s",
-					    logfile->buf, strerror(errno));
-				return -1;
+					    logfile, strerror(errno));
+				ret = -1;
 			}
 		} else {
-			adjust_shared_perm(logfile->buf);
+			adjust_shared_perm(logfile);
 		}
 	}
 
-	return 0;
+	free(logfile);
+	return ret;
 }
 
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
 {
-	int ret;
-	struct strbuf sb = STRBUF_INIT;
-	int fd;
+	int ret, fd;
 
-	ret = log_ref_setup(refname, &sb, &fd, err, force_create);
+	ret = log_ref_setup(refname, force_create, &fd, err);
 	if (!ret && fd >= 0)
 		close(fd);
-	strbuf_release(&sb);
 	return ret;
 }
 
@@ -2686,16 +2683,15 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
 static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
-			   struct strbuf *logfile, int flags,
-			   struct strbuf *err)
+			   int flags, struct strbuf *err)
 {
 	int logfd, result;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, logfile, &logfd, err,
-			       flags & REF_FORCE_CREATE_REFLOG);
+	result = log_ref_setup(refname, flags & REF_FORCE_CREATE_REFLOG,
+			       &logfd, err);
 
 	if (result)
 		return result;
@@ -2730,11 +2726,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
 {
-	struct strbuf sb = STRBUF_INIT;
-	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
-				  err);
-	strbuf_release(&sb);
-	return ret;
+	return log_ref_write_1(refname, old_sha1, new_sha1, msg, flags, err);
 }
 
 /*
-- 
2.7.0
