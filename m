Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78EB20C1D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbcLaDNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:24 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55417 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754540AbcLaDNU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:20 -0500
X-AuditID: 1207440d-8b7ff700000009ba-97-5867225030f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DD.21.02490.05227685; Fri, 30 Dec 2016 22:13:20 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u2010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:18 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/23] rename_tmp_log(): use raceproof_create_file()
Date:   Sat, 31 Dec 2016 04:12:48 +0100
Message-Id: <75f51a671ed56bff55906c6f9400d53dfe8199c9.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqBuglB5h0LaQ3aLrSjeTRUPvFWaL
        2yvmM1ssefia2eJHSw+zA6vH3/cfmDy62o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGU+uPWAreCJWMX/DO/YGxh+CXYycHBICJhI/7raxgthCApcZJW4/ju5i5AKyjzNJ9L7Y
        ywaSYBPQlVjU08wEYosIqElMbDvEAlLELDCRUWLalktgCWEBd4lV01+BNbAIqEpMP/sdzOYV
        iJL4fxhig4SAnMSlbV+YQWxOAQuJxZ/6mCA2m0us23mJeQIjzwJGhlWMcok5pbm6uYmZOcWp
        ybrFyYl5ealFukZ6uZkleqkppZsYIaHDu4Px/zqZQ4wCHIxKPLwPbqRFCLEmlhVX5h5ilORg
        UhLltbRMjRDiS8pPqcxILM6ILyrNSS0+xCjBwawkwrtQLj1CiDclsbIqtSgfJiXNwaIkzqu2
        RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbtQEahRsCg1PbUiLTOnBCHNxMEJMpwHaHgvSA1vcUFi
        bnFmOkT+FKOilDjvWgWghABIIqM0D64XFtuvGMWBXhHmrQVp5wGmBbjuV0CDmYAGq+Ukgwwu
        SURISTUw9vduf5iq8nHv93Dzl9KFpR/Djs84E3aQ99GKteKLrR9Y+uyuMIzWKl52YS+H6mLH
        Q1ePrvlkc1CK98fUjYfMNso4au8847PgTAvv98Q38b9cORo2zWp+GPb9tprMpeO5hjoXDesk
        ni4TUJLJ+5iwU7BpR/hz++0JQelvipXvdj4veMv/w4w1TImlOCPRUIu5qDgRAGU5iZ/IAgAA
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

