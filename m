Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08A02070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbcLaDN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:29 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47943 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754643AbcLaDN0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:26 -0500
X-AuditID: 1207440e-7c7ff700000009ec-21-58672255b6ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 81.C9.02540.55227685; Fri, 30 Dec 2016 22:13:25 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u6010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:24 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/23] log_ref_setup(): improve robustness against races
Date:   Sat, 31 Dec 2016 04:12:52 +0100
Message-Id: <9ab4c213af5e342e0bfd6bc7a120c6fbd42d9538.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqBuqlB5hMOmUhEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mn537GIsWCRWcf/yC/YGxpWCXYycHBICJhIHlk5l72Lk4hASuMwo8W39QjYI5ziTxKaZ
        UxhBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQtMZJSYtuUSWEJYwFvi/bK9LCA2i4CqxKRfy5lB
        bF6BKIkzu/+xQayTk7i07QtYnFPAQmLxpz6wXiEBc4l1Oy8xT2DkWcDIsIpRLjGnNFc3NzEz
        pzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJHj4djC2r5c5xCjAwajEw9txLS1CiDWxrLgy9xCj
        JAeTkiivpWVqhBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3oVy6RFCvCmJlVWpRfkwKWkOFiVx
        XrUl6n5CAumJJanZqakFqUUwWRkODiUJ3oWKQI2CRanpqRVpmTklCGkmDk6Q4TxAw3tBaniL
        CxJzizPTIfKnGHU5Gm6se8okxJKXn5cqJc67VgGoSACkKKM0D24OLOpfMYoDvSXMuwtkFA8w
        YcBNegW0hAloiVpOMsiSkkSElFQDY+8smcgZ5zO0FnBM6TKeXHNmDfcz9aPLEq7v4paJepXR
        ZnX6+9kVHV3bHwVeqrC5sX7N4rvpEZlZFxmVXRatsFW+VXGgzGSHdcbGDccFA0583HA/vej6
        E5bYqs9NWm2Si/XuqE8wPvrg2o4nov23Vn11fa6tNO8Kk6sn+6uYHu/3hVYBFtJHBZVYijMS
        DbWYi4oTAU/NvgXVAgAA
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
index 47c7829..345f7c3 100644
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

