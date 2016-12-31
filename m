Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70DA2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbcLaDNa (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:30 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53310 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754635AbcLaDNZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:25 -0500
X-AuditID: 12074411-fa3ff700000009b7-55-5867225326ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B4.63.02487.35227685; Fri, 30 Dec 2016 22:13:24 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u5010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:22 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/23] log_ref_setup(): separate code for create vs non-create
Date:   Sat, 31 Dec 2016 04:12:51 +0100
Message-Id: <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqBuilB5hcHYni0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mo6euc5U8Fu8Ys/HxewNjM1CXYycHBICJhJzz55n6mLk4hASuMwoMfvEQlYI5ziTRNO/
        rUwgVWwCuhKLeprBbBEBNYmJbYdYQIqYBSYySkzbcgksISwQKLFo1wb2LkYODhYBVYkDM3JB
        wrwCURKn2r8yQWyTk7i07QsziM0pYCGx+FMfWFxIwFxi3c5LzBMYeRYwMqxilEvMKc3VzU3M
        zClOTdYtTk7My0st0jXVy80s0UtNKd3ECAkdwR2MM07KHWIU4GBU4uF9cCMtQog1say4MvcQ
        oyQHk5Ior6VlaoQQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6FcukRQrwpiZVVqUX5MClpDhYl
        cV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCV4FRaBGwaLU9NSKtMycEoQ0EwcnyHAeoOH+IDW8
        xQWJucWZ6RD5U4y6HA031j1lEmLJy89LlRLnXasAVCQAUpRRmgc3BxbzrxjFgd4S5t0FMooH
        mC7gJr0CWsIEtEQtJxlkSUkiQkqqgXHDcne+SN5vlkX1s3eaKGiL5GcZ2bHeF3TTf5Rz92zH
        r5n8VhufvXB61JVXpnRded4yg/0/H11RuG7ItrfgpOuOHfEzk5Z4hdaGsvFJrV0c8eZg7NEw
        0QvhpbNMNSd3bGtcsSm++e/7bYw3PlzUTV6wPzO8a2muevX2vb8OcsakMU+yTDt4wUaJpTgj
        0VCLuag4EQD9mdDD1AIAAA==
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
 refs/files-backend.c | 58 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fd8a751..47c7829 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2718,45 +2718,63 @@ static int commit_ref(struct ref_lock *lock)
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

