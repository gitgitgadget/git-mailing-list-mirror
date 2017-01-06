Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8341D1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967523AbdAFQYF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:24:05 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47452 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967396AbdAFQX0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:26 -0500
X-AuditID: 1207440d-8cfff700000009ba-f2-586fc474ccae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E1.7A.02490.474CF685; Fri,  6 Jan 2017 11:23:16 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX4023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:15 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 14/23] log_ref_setup(): pass the open file descriptor back to the caller
Date:   Fri,  6 Jan 2017 17:22:34 +0100
Message-Id: <500171920606ec6b58b603882a98b8d47739ccb7.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqFtyJD/C4PMrFYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKmLl6LVPBavmKs6ePMTYwvpHoYuTkkBAwkVi9aR5j
        FyMXh5DAZUaJQ9cPsoAkhAROMElMuiAFYrMJ6Eos6mlmArFFBNQkJrYdYgFpYBb4wCjxq3MW
        O0hCWCBaYvrkS2DNLAKqEhc6PrGB2LwCURIHnj5hhtgmJ3Fp2xcwm1PAQqJx1zdGiGXmEp8m
        HmaewMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIgPHuYPy/TuYQ
        owAHoxIPb4RXXoQQa2JZcWXuIUZJDiYlUd4wx/wIIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
        doeAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd4/II2CRanpqRVp
        mTklCGkmDk6Q4TxAwwUPgwwvLkjMLc5Mh8ifYlSUEufdAtIsAJLIKM2D64UlgFeM4kCvCPP2
        gLTzAJMHXPcroMFMIIM9wQaXJCKkpBoYM1dEH7oX5ZXZ91fg0aaDHQulN7747VnvaL/QW3fF
        17ObuBc/3WUo8cjWt/Dssth+Du//L7Z52ppUPNAL+PlaUtl0P4PsuqcLpl7/WW/GHMXwdwLL
        uUlxkc/2TpPY7Rr/4smZ+IpMtb2MTQKJjRp68+7dVz1SYHTWbuEZJX3J82cTH6zvnNYtq8RS
        nJFoqMVcVJwIAKPVcBfbAgAA
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
index 27d4fd3..f723834 100644
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
@@ -2763,10 +2767,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 		}
 	}
 
-	if (logfd >= 0) {
+	if (*logfd >= 0)
 		adjust_shared_perm(logfile->buf);
-		close(logfd);
-	}
 
 	return 0;
 }
@@ -2777,11 +2779,14 @@ static int files_create_reflog(struct ref_store *ref_store,
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
@@ -2817,17 +2822,17 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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

