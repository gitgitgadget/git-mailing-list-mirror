Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB801FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967438AbdAFQXb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:31 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63379 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965034AbdAFQXQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:16 -0500
X-AuditID: 1207440e-7dfff700000009ec-cf-586fc47292e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E4.D4.02540.274CF685; Fri,  6 Jan 2017 11:23:14 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX3023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:13 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 13/23] log_ref_setup(): improve robustness against races
Date:   Fri,  6 Jan 2017 17:22:33 +0100
Message-Id: <ad86aeda2873070eae142a0de32bd34ec9bcfe99.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqFt0JD/CYOYHa4uuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DK+Lr3J0vBIrGKXet2MTcwrhTsYuTkkBAwkZjdNpkZ
        xBYSuMwosXm9excjF5B9gkli+77zLCAJNgFdiUU9zUwgtoiAmsTEtkMsIEXMAh8YJX51zmIH
        SQgLeEu8O9HCBmKzCKhKnLy5jrWLkYODVyBKYvM1FYhlchKXtn0BW8YpYCHRuOsbI8Ric4lP
        Ew8zT2DkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJLz4djC2r5c5
        xCjAwajEw8vgkRchxJpYVlyZe4hRkoNJSZQ3zDE/QogvKT+lMiOxOCO+qDQntfgQowQHs5II
        r90hoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL3D0ijYFFqempF
        WmZOCUKaiYMTZDgP0HDBwyDDiwsSc4sz0yHypxh1ORpurHvKJMSSl5+XKiXOuwVkkABIUUZp
        HtwcWFp4xSgO9JYwbw/IKB5gSoGb9ApoCRPIEk+wJSWJCCmpBkaVvk75lvuRratjFjntyDht
        GFv5+9eJ9fyTsro0/yTs2npeySqF68JKW2+xgOCcZLtqq51BXQ6HZtzce6CxIqZhcbBNK9MM
        /56y5DMPK7bs+md9y/f9C8npJaW2ISZ3Lskf9/qYv9dET2Er64PpU7127bvKpiIxcWfk/ocu
        27jfLGw9udck6K4SS3FGoqEWc1FxIgC7vz/85gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change log_ref_setup() to use raceproof_create_file() to create the new
logfile. This makes it more robust against a race against another
process that might be trying to clean up empty directories while we are
trying to create a new logfile.

This also means that it will only call create_leading_directories() if
open() fails, which should be a net win. Even in the cases where we are
willing to create a new logfile, it will usually be the case that the
logfile already exists, or if not then that the directory containing the
logfile already exists. In such cases, we will save some work that was
previously done unconditionally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c8f6d82..27d4fd3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2710,6 +2710,14 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
+static int open_or_create_logfile(const char *path, void *cb)
+{
+	int *fd = cb;
+
+	*fd = open(path, O_APPEND | O_WRONLY | O_CREAT, 0666);
+	return (*fd < 0) ? -1 : 0;
+}
+
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
@@ -2723,31 +2731,18 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 	strbuf_git_path(logfile, "logs/%s", refname);
 
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (safe_create_leading_directories(logfile->buf) < 0) {
-			strbuf_addf(err, "unable to create directory for '%s': "
-				    "%s", logfile->buf, strerror(errno));
-			return -1;
-		}
-		logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
-		if (logfd < 0) {
-			if (errno == EISDIR) {
-				/*
-				 * The directory that is in the way might be
-				 * empty. Try to remove it.
-				 */
-				if (remove_empty_directories(logfile)) {
-					strbuf_addf(err, "there are still logs under "
-						    "'%s'", logfile->buf);
-					return -1;
-				}
-				logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
-			}
-
-			if (logfd < 0) {
+		if (raceproof_create_file(logfile->buf, open_or_create_logfile, &logfd)) {
+			if (errno == ENOENT)
+				strbuf_addf(err, "unable to create directory for '%s': "
+					    "%s", logfile->buf, strerror(errno));
+			else if (errno == EISDIR)
+				strbuf_addf(err, "there are still logs under '%s'",
+					    logfile->buf);
+			else
 				strbuf_addf(err, "unable to append to '%s': %s",
 					    logfile->buf, strerror(errno));
-				return -1;
-			}
+
+			return -1;
 		}
 	} else {
 		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
-- 
2.9.3

