Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF831FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967316AbdAFQXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:16 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63379 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967270AbdAFQXK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:10 -0500
X-AuditID: 1207440e-7dfff700000009ec-c5-586fc46b92b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 83.D4.02540.B64CF685; Fri,  6 Jan 2017 11:23:09 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWx023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:06 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 09/23] rename_tmp_log(): use raceproof_create_file()
Date:   Fri,  6 Jan 2017 17:22:29 +0100
Message-Id: <b783c8055c36004c09361eddd14659d83633baad.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqJt7JD/CYE6fuEXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlPLn2gK3giVjF/A3v2BsYfwh2MXJySAiYSDz9tIqp
        i5GLQ0jgMqNE05VNLBDOCSaJ3b9/M4NUsQnoSizqaWYCsUUE1CQmth0CK2IW+MAo8atzFjtI
        QljAXeLz7vesXYwcHCwCqhLdXbEgYV6BKIkpsy8wQWyTk7i07QvYTE4BC4nGXd8YQWwhAXOJ
        TxMPM09g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyTA+HYwtq+X
        OcQowMGoxMPL4JEXIcSaWFZcmXuIUZKDSUmUN8wxP0KILyk/pTIjsTgjvqg0J7X4EKMEB7OS
        CK/dIaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9w9Io2BRanpq
        RVpmTglCmomDE2Q4D9BwwcMgw4sLEnOLM9Mh8qcYFaXEebeANAuAJDJK8+B6YQngFaM40CvC
        vD0g7TzA5AHX/QpoMBPIYE+wwSWJCCmpBkYxO8G/6jPU9r9M4fDtfVJ0sro1qMrocTjLOoPi
        sJOhtst35KxkSWWwYfjUxvI8Xc3sRePWi689V2udXP/MPFU3avPMTSZLp60KWn7klEqu5vp1
        KkGN34piqx4Y7jqdpzTb5cHq2YfeRJqdbZJfULmhkLdF2zNuv+RbboFbV94/f873eVngoy1K
        LMUZiYZazEXFiQCCZiEL2wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides shortening the code, this saves an unnecessary call to
safe_create_leading_directories_const() in almost all cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 73 +++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74de289..3f18a01 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2489,55 +2489,42 @@ static int files_delete_refs(struct ref_store *ref_store,
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_tmp_log_callback(const char *path, void *cb)
 {
-	int attempts_remaining = 4;
-	struct strbuf path = STRBUF_INIT;
-	int ret = -1;
+	int *true_errno = cb;
 
- retry:
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "logs/%s", newrefname);
-	switch (safe_create_leading_directories_const(path.buf)) {
-	case SCLD_OK:
-		break; /* success */
-	case SCLD_VANISHED:
-		if (--attempts_remaining > 0)
-			goto retry;
-		/* fall through */
-	default:
-		error("unable to create directory for %s", newrefname);
-		goto out;
+	if (rename(git_path(TMP_RENAMED_LOG), path)) {
+		/*
+		 * rename(a, b) when b is an existing directory ought
+		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
+		 * Sheesh. Record the true errno for error reporting,
+		 * but report EISDIR to raceproof_create_file() so
+		 * that it knows to retry.
+		 */
+		*true_errno = errno;
+		if (errno == ENOTDIR)
+			errno = EISDIR;
+		return -1;
+	} else {
+		return 0;
 	}
+}
 
-	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
-		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
-			/*
-			 * rename(a, b) when b is an existing
-			 * directory ought to result in ISDIR, but
-			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
-			 */
-			if (remove_empty_directories(&path)) {
-				error("Directory not empty: logs/%s", newrefname);
-				goto out;
-			}
-			goto retry;
-		} else if (errno == ENOENT && --attempts_remaining > 0) {
-			/*
-			 * Maybe another process just deleted one of
-			 * the directories in the path to newrefname.
-			 * Try again from the beginning.
-			 */
-			goto retry;
-		} else {
+static int rename_tmp_log(const char *newrefname)
+{
+	char *path = git_pathdup("logs/%s", newrefname);
+	int ret, true_errno;
+
+	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
+	if (ret) {
+		if (errno == EISDIR)
+			error("Directory not empty: %s", path);
+		else
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(errno));
-			goto out;
-		}
+				newrefname, strerror(true_errno));
 	}
-	ret = 0;
-out:
-	strbuf_release(&path);
+
+	free(path);
 	return ret;
 }
 
-- 
2.9.3

