Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA341FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967530AbdAFQYJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:24:09 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47452 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967366AbdAFQXY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:24 -0500
X-AuditID: 1207440d-8b7ff700000009ba-ee-586fc4700629
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 31.7A.02490.074CF685; Fri,  6 Jan 2017 11:23:13 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX2023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:11 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 12/23] log_ref_setup(): separate code for create vs non-create
Date:   Fri,  6 Jan 2017 17:22:32 +0100
Message-Id: <06ef507f76f8f894050d7524892de7cd417d1401.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqFt4JD/C4EEfh0XXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlXDz0hLGgWaJi9rVDzA2MrUJdjJwcEgImElNnv2ft
        YuTiEBK4zCjRfGIXE4Rzgkli8tKvzCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBT4wSvzqnMXe
        xcjBISwQKLFuuRhIDYuAqsTeCW3sIDavQJTEgYttTBDb5CQubfsCNpNTwEKicdc3RhBbSMBc
        4tPEw8wTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJMN4djP/X
        yRxiFOBgVOLhjfDKixBiTSwrrsw9xCjJwaQkyhvmmB8hxJeUn1KZkVicEV9UmpNafIhRgoNZ
        SYTX7hBQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfsHpFGwKDU9
        tSItM6cEIc3EwQkynAdouOBhkOHFBYm5xZnpEPlTjLocDTfWPWUSYsnLz0uVEufdAjJIAKQo
        ozQPbg4sMbxiFAd6S5i3B2QUDzCpwE16BbSECWSJJ9iSkkSElFQDYx5Hyfu79fcNXC24tL55
        lfZZrmOcEcD5tW/idzYehaNtZoaLDL7npEQKxq9okErcc3CC5dfa55ci3ZcnTTYvjpRwncEj
        vupKGIOWwDt20eDFuwxPvjK9fOqv+rqgK7LTNzXIvEq4Or/rx0e1eT81WkTU/S+YSug25c/m
        bCrO3dQwR+fV7UQuJZbijERDLeai4kQA6hQXX+cCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of this function (especially how it handles errors) is
quite different depending on whether we are willing to create the reflog
vs. whether we are only trying to open an existing reflog. So separate
the code paths.

This also simplifies the next steps.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 59 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fd8a751..c8f6d82 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2718,45 +2718,64 @@ static int commit_ref(struct ref_lock *lock)
  */
 static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
 {
-	int logfd, oflags = O_APPEND | O_WRONLY;
+	int logfd;
 
 	strbuf_git_path(logfile, "logs/%s", refname);
+
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile->buf) < 0) {
 			strbuf_addf(err, "unable to create directory for '%s': "
 				    "%s", logfile->buf, strerror(errno));
 			return -1;
 		}
-		oflags |= O_CREAT;
-	}
-
-	logfd = open(logfile->buf, oflags, 0666);
-	if (logfd < 0) {
-		if (!(oflags & O_CREAT) && (errno == ENOENT || errno == EISDIR))
-			return 0;
+		logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
+		if (logfd < 0) {
+			if (errno == EISDIR) {
+				/*
+				 * The directory that is in the way might be
+				 * empty. Try to remove it.
+				 */
+				if (remove_empty_directories(logfile)) {
+					strbuf_addf(err, "there are still logs under "
+						    "'%s'", logfile->buf);
+					return -1;
+				}
+				logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
+			}
 
-		if (errno == EISDIR) {
-			if (remove_empty_directories(logfile)) {
-				strbuf_addf(err, "there are still logs under "
-					    "'%s'", logfile->buf);
+			if (logfd < 0) {
+				strbuf_addf(err, "unable to append to '%s': %s",
+					    logfile->buf, strerror(errno));
 				return -1;
 			}
-			logfd = open(logfile->buf, oflags, 0666);
 		}
-
+	} else {
+		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
 		if (logfd < 0) {
-			strbuf_addf(err, "unable to append to '%s': %s",
-				    logfile->buf, strerror(errno));
-			return -1;
+			if (errno == ENOENT || errno == EISDIR) {
+				/*
+				 * The logfile doesn't already exist,
+				 * but that is not an error; it only
+				 * means that we won't write log
+				 * entries to it.
+				 */
+				;
+			} else {
+				strbuf_addf(err, "unable to append to '%s': %s",
+					    logfile->buf, strerror(errno));
+				return -1;
+			}
 		}
 	}
 
-	adjust_shared_perm(logfile->buf);
-	close(logfd);
+	if (logfd >= 0) {
+		adjust_shared_perm(logfile->buf);
+		close(logfd);
+	}
+
 	return 0;
 }
 
-
 static int files_create_reflog(struct ref_store *ref_store,
 			       const char *refname, int force_create,
 			       struct strbuf *err)
-- 
2.9.3

