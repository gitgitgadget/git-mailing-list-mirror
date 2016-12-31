Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6952078D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbcLaDNe (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:34 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51914 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754661AbcLaDNc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:32 -0500
X-AuditID: 1207440c-e3bff700000009a1-6a-58672259f8c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A8.34.02465.95227685; Fri, 30 Dec 2016 22:13:30 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u9010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/23] log_ref_setup(): manage the name of the reflog file internally
Date:   Sat, 31 Dec 2016 04:12:55 +0100
Message-Id: <18e824188fd9254d4649cd692aabb11ce6cd1c03.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqBullB5h8G2uqUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mu4tkSi4plmx+c9vpgbGDQpdjJwcEgImEgdPr2cBsYUELjNKbHyUAGEfZ5I4vIkDxGYT
        0JVY1NPMBGKLCKhJTGw7BFTPxcEsMJFRYtqWS2AJYYEIiS/TXzGD2CwCqhLr2o6zgdi8AlES
        /We2sEMsk5O4tO0LWA2ngIXE4k99TBDLzCXW7bzEPIGRZwEjwypGucSc0lzd3MTMnOLUZN3i
        5MS8vNQiXUO93MwSvdSU0k2MkLDh2cH4bZ3MIUYBDkYlHt6Oa2kRQqyJZcWVuYcYJTmYlER5
        LS1TI4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8C6US48Q4k1JrKxKLcqHSUlzsCiJ86ouUfcT
        EkhPLEnNTk0tSC2CycpwcChJ8C5UBGoULEpNT61Iy8wpQUgzcXCCDOcBGt4LUsNbXJCYW5yZ
        DpE/xagoJc67VgEoIQCSyCjNg+uFxfUrRnGgV4R5nUDaeYApAa77FdBgJqDBajnJIINLEhFS
        Ug2MnWzTf6q27r/07+7kk0HrH57iXlN47ITynCmBAj75Bo++yc3a67dM16b34f7u74L/9T83
        bft2Qca4+FHxeqdEDaOMqdpl67wvTk1KyOA62incM71PpSSIrdroVe/0oppfX+tcbswyMfY0
        fndO6FBJ5v7Enue+k6/6WKvotPUECIlcL544adYrJZbijERDLeai4kQAxe05O8YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of writing the name of the reflog file into a strbuf that is
supplied by the caller but not needed there, write it into a local
temporary buffer and remove the strbuf parameter entirely.

And while we're adjusting the function signature, reorder the arguments
to move the input parameters before the output parameters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5a96424..455652c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2719,37 +2719,36 @@ static int open_or_create_logfile(const char *path, void *cb)
 }
 
 /*
- * Create a reflog for a ref. Store its path to *logfile. If
- * force_create = 0, only create the reflog for certain refs (those
- * for which should_autocreate_reflog returns non-zero). Otherwise,
- * create it regardless of the reference name. If the logfile already
- * existed or was created, return 0 and set *logfd to the file
- * descriptor opened for appending to the file. If no logfile exists
- * and we decided not to create one, return 0 and set *logfd to -1. On
- * failure, fill in *err, set *logfd to -1, and return -1.
+ * Create a reflog for a ref. If force_create = 0, only create the
+ * reflog for certain refs (those for which should_autocreate_reflog
+ * returns non-zero). Otherwise, create it regardless of the reference
+ * name. If the logfile already existed or was created, return 0 and
+ * set *logfd to the file descriptor opened for appending to the file.
+ * If no logfile exists and we decided not to create one, return 0 and
+ * set *logfd to -1. On failure, fill in *err, set *logfd to -1, and
+ * return -1.
  */
-static int log_ref_setup(const char *refname,
-			 struct strbuf *logfile, int *logfd,
-			 struct strbuf *err, int force_create)
+static int log_ref_setup(const char *refname, int force_create,
+			 int *logfd, struct strbuf *err)
 {
-	strbuf_git_path(logfile, "logs/%s", refname);
+	char *logfile = git_pathdup("logs/%s", refname);
 
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (raceproof_create_file(logfile->buf, open_or_create_logfile, logfd)) {
+		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
 			if (errno == ENOENT)
 				strbuf_addf(err, "unable to create directory for '%s': "
-					    "%s", logfile->buf, strerror(errno));
+					    "%s", logfile, strerror(errno));
 			else if (errno == EISDIR)
 				strbuf_addf(err, "there are still logs under '%s'",
-					    logfile->buf);
+					    logfile);
 			else
 				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile->buf, strerror(errno));
+					    logfile, strerror(errno));
 
-			return -1;
+			goto error;
 		}
 	} else {
-		*logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
+		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
 		if (*logfd < 0) {
 			if (errno == ENOENT || errno == EISDIR) {
 				/*
@@ -2760,34 +2759,39 @@ static int log_ref_setup(const char *refname,
 				 */
 			} else {
 				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile->buf, strerror(errno));
-				return -1;
+					    logfile, strerror(errno));
+				goto error;
 			}
 		}
 	}
 
 	if (*logfd >= 0)
-		adjust_shared_perm(logfile->buf);
+		adjust_shared_perm(logfile);
 
+	free(logfile);
 	return 0;
+
+error:
+	free(logfile);
+	return -1;
 }
 
 static int files_create_reflog(struct ref_store *ref_store,
 			       const char *refname, int force_create,
 			       struct strbuf *err)
 {
-	int ret;
-	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "create_reflog");
 
-	ret = log_ref_setup(refname, &sb, &fd, err, force_create);
+	if (log_ref_setup(refname, force_create, &fd, err))
+		return -1;
+
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&sb);
-	return ret;
+
+	return 0;
 }
 
 static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
@@ -2818,16 +2822,15 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
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
@@ -2858,11 +2861,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
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
2.9.3

