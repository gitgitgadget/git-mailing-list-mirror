Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524442078D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbcLaDN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:29 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55417 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754647AbcLaDN1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:27 -0500
X-AuditID: 1207440d-8b7ff700000009ba-9e-58672256c828
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DE.21.02490.65227685; Fri, 30 Dec 2016 22:13:26 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u7010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:25 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/23] log_ref_setup(): pass the open file descriptor back to the caller
Date:   Sat, 31 Dec 2016 04:12:53 +0100
Message-Id: <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqBumlB5hMPmnukXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MmbNECxYLV8x/+hW1gbGNxJdjJwcEgImEu///GDtYuTiEBK4zChx8MAidgjnOJPEn81f
        mECq2AR0JRb1NIPZIgJqEhPbDrGAFDELTGSUmLblElhCWCBaovdyFxuIzSKgKnH05XJ2EJtX
        IEpi2YR7jBDr5CQubfvCDGJzClhILP7UB9YrJGAusW7nJeYJjDwLGBlWMcol5pTm6uYmZuYU
        pybrFicn5uWlFuka6eVmluilppRuYoSEDu8Oxv/rZA4xCnAwKvHwPriRFiHEmlhWXJl7iFGS
        g0lJlNfSMjVCiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvQrn0CCHelMTKqtSifJiUNAeLkjiv
        2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvQkWgRsGi1PTUirTMnBKENBMHJ8hwHqDhvSA1vMUF
        ibnFmekQ+VOMilLivGsVgBICIImM0jy4Xlhsv2IUB3pFmLcWpJ0HmBbgul8BDWYCGqyWkwwy
        uCQRISXVwNjKsZg/5zNvmTOT4CExzmsRqzVY4nmKhG50np0Rqfhyf59+h/u+MLsrB/ZknW5b
        ZKoc7W0mprw9ljmsyKSfa5rII/uT9Z2zmSuVDT/0PC/9c1Jyb9GMWyXZT+dE+U3fMfteUL+/
        y72pnluU6y5ezNF6k/D++7tZx17Yc02zMnCSZXl/9/wDFyWW4oxEQy3mouJEAEA832rIAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will most often be called by log_ref_write_1(), which
wants to append to the reflog file. In that case, it is silly to close
the file only for the caller to reopen it immediately. So, in the case
that the file was opened, pass the open file descriptor back to the
caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 345f7c3..7f26cf8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2719,19 +2719,23 @@ static int open_or_create_logfile(const char *path, void *cb)
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
+ * failure, fill in *err, set *logfd to -1, and return -1.
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
-		if (raceproof_create_file(logfile->buf, open_or_create_logfile, &logfd)) {
+		if (raceproof_create_file(logfile->buf, open_or_create_logfile, logfd)) {
 			if (errno == ENOENT)
 				strbuf_addf(err, "unable to create directory for '%s': "
 					    "%s", logfile->buf, strerror(errno));
@@ -2745,8 +2749,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 			return -1;
 		}
 	} else {
-		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
-		if (logfd < 0) {
+		*logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
+		if (*logfd < 0) {
 			if (errno == ENOENT || errno == EISDIR) {
 				/*
 				 * The logfile doesn't already exist,
@@ -2762,10 +2766,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 		}
 	}
 
-	if (logfd >= 0) {
+	if (*logfd >= 0)
 		adjust_shared_perm(logfile->buf);
-		close(logfd);
-	}
 
 	return 0;
 }
@@ -2776,11 +2778,14 @@ static int files_create_reflog(struct ref_store *ref_store,
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
+	int fd;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "create_reflog");
 
-	ret = log_ref_setup(refname, &sb, err, force_create);
+	ret = log_ref_setup(refname, &sb, &fd, err, force_create);
+	if (fd >= 0)
+		close(fd);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -2816,17 +2821,17 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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
2.9.3

