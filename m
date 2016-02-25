From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/20] log_ref_setup(): manage the name of the reflog file internally
Date: Thu, 25 Feb 2016 14:16:10 +0100
Message-ID: <9597542b805c7d1e1a1b0a89560d539e5ac02cb9.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmp-0003nQ-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760398AbcBYNQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:50 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61053 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760327AbcBYNQt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:49 -0500
X-AuditID: 1207440d-6a3ff7000000068f-61-56cefec0739d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CF.94.01679.0CEFEC65; Thu, 25 Feb 2016 08:16:48 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrp024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:47 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHvg37kwg5u3lS3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozH318wFfxXrzi/fwlrA2OnfBcjJ4eEgInE7Umz
	WLsYuTiEBLYySkz5N58JwjnBJLFp+lYWkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCjxgluvZv
	ZwRJCAtESHy4dw7MZhFQlbj6ZxGYzSsQJfHz7SE2iHVyEi0/drOC2JwCFhIXT05nBrGFBMwl
	Vt3Ywz6BkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAg493B+H+d
	zCFGAQ5GJR7eiN9nw4RYE8uKK3MPMUpyMCmJ8u55fi5MiC8pP6UyI7E4I76oNCe1+BCjBAez
	kgjvir9AOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8mkEbBotT0
	1Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UBTEFwPjACTFA7Q3F2xvcUFiLlAUovUUo6KU
	OO9ykIQASCKjNA9uLCx1vGIUB/pSmPcVSBUPMO3Adb8CGswENHjmBrDBJYkIKakGRvHS9bkZ
	Grr3xUyrJwoF5e/488hb43mrzSbZNb55bIdME9/ftf9xgftcyc63u/PjpEtmv3GeO+fhwqNF
	otabr0/581H45Q2Xe9NVp3K2zUg6Jvb+uZ18/u17JeVXoj6evjk7YVZ09BMxduMe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287370>

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
index 4f25932..49713b3 100644
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
