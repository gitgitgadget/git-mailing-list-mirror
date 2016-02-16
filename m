From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/20] log_ref_setup(): pass the open file descriptor back to the caller
Date: Tue, 16 Feb 2016 14:22:22 +0100
Message-ID: <10ca076856c8695723f1f5fae1fee2f38fa778fd.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhr-0002qY-CB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbcBPNaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:08 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45673 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932330AbcBPNaG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:06 -0500
X-AuditID: 12074413-eefff7000000516b-77-56c322b4fe01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E1.2E.20843.4B223C65; Tue, 16 Feb 2016 08:23:00 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOV028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:59 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtV6XCYQcs3Nov5m04wWnRd6Way
	aOi9wmzxYe0hNoveyb2sFrdXzGe2+NHSw+zA7vH3/Qcmj6fbpzB7vDhf4fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+P0sbdMBS/lKm7+ec/cwLhZoouRk0NCwERi2qkv
	bF2MXBxCAlsZJboeHWSBcE4wSTyYeZQFpIpNQFdiUU8zE4gtIqAmMbHtEFgRs8AjoI792xlB
	EsICERJHts9hBbFZBFQlPl46zA5i8wpESexcdIMZYp2cRMuP3WA1nAIWEidbesEWCAmYS9z5
	sodpAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxghQSa8g3HXSblD
	jAIcjEo8vBweh8KEWBPLiitzDzFKcjApifLycB8OE+JLyk+pzEgszogvKs1JLT7EKMHBrCTC
	++8VUDlvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL3kyLQUMGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQFMQXA+MAJMUDtDcNpJ23uCAxFygK0XqKUVFK
	nHc/SEIAJJFRmgc3FpY6XjGKA30pzCsKTCRCPMC0A9f9CmgwE9DgnEsgDxWXJCKkpBoYU5aX
	r2dMV1u9ns9upnOc/eSFPy4oc0lMm/r/Im/zZE7774q3zvLtflxmk2C3ybUr9M3ZB648b3bJ
	OK11SzE875KonMkXU9LIpmfL9P7U5tMHeGfkTHimN60onWnf03nK/Ndt1NPa7q/N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286374>

This function will most often be called by log_ref_write_1(), which
wants to append to the reflog file. In that case, it is silly to close
the file only for the caller to reopen it immediately. So, in the case
that the file was opened, pass the open file descriptor back to the
caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0cfe1ce..78a6213 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2591,19 +2591,23 @@ static int open_or_create_logfile(const char *path, void *cb)
 }
 
 /*
- * Create a reflog for a ref.  If force_create = 0, the reflog will
- * only be created for certain refs (those for which
- * should_autocreate_reflog returns non-zero.  Otherwise, create it
- * regardless of the ref name.  Fill in *err and return -1 on failure.
+ * Create a reflog for a ref. Store its path to *logfile. If
+ * force_create = 0, only create the reflog for certain refs (those
+ * for which should_autocreate_reflog returns non-zero). Otherwise,
+ * create it regardless of the reference name. If the logfile already
+ * existed or was created, return 0 and set *logfd to the file
+ * descriptor opened for appending to the file. If no logfile exists
+ * and we decided not to create one, return 0 and set *logfd to -1. On
+ * failure, fill in *err and return -1.
  */
-static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
+static int log_ref_setup(const char *refname,
+			 struct strbuf *logfile, int *logfd,
+			 struct strbuf *err, int force_create)
 {
-	int logfd;
-
 	strbuf_git_path(logfile, "logs/%s", refname);
 
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (raceproof_create_file(logfile->buf, open_or_create_logfile, &logfd) < 0) {
+		if (raceproof_create_file(logfile->buf, open_or_create_logfile, logfd) < 0) {
 			if (errno == ENOENT) {
 				strbuf_addf(err, "unable to create directory for %s: "
 					    "%s", logfile->buf, strerror(errno));
@@ -2617,11 +2621,10 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 			return -1;
 		} else {
 			adjust_shared_perm(logfile->buf);
-			close(logfd);
 		}
 	} else {
-		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
-		if (logfd < 0) {
+		*logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
+		if (*logfd < 0) {
 			if (errno == ENOENT || errno == EISDIR) {
 				/*
 				 * The logfile doesn't already exist,
@@ -2636,7 +2639,6 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 			}
 		} else {
 			adjust_shared_perm(logfile->buf);
-			close(logfd);
 		}
 	}
 
@@ -2647,8 +2649,11 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
+	int fd;
 
-	ret = log_ref_setup(refname, &sb, err, force_create);
+	ret = log_ref_setup(refname, &sb, &fd, err, force_create);
+	if (!ret && fd >= 0)
+		close(fd);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -2684,17 +2689,17 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   struct strbuf *logfile, int flags,
 			   struct strbuf *err)
 {
-	int logfd, result, oflags = O_APPEND | O_WRONLY;
+	int logfd, result;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, logfile, err, flags & REF_FORCE_CREATE_REFLOG);
+	result = log_ref_setup(refname, logfile, &logfd, err,
+			       flags & REF_FORCE_CREATE_REFLOG);
 
 	if (result)
 		return result;
 
-	logfd = open(logfile->buf, oflags);
 	if (logfd < 0)
 		return 0;
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
-- 
2.7.0
