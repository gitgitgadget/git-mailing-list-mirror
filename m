From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/20] log_ref_setup(): separate code for create vs non-create
Date: Tue, 16 Feb 2016 14:22:20 +0100
Message-ID: <927c04891a040b257ed319ad64b5fe123d992b1a.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiE-0003Ac-7s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbcBPNad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:33 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64171 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932179AbcBPNaa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:30 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:30:30 EST
X-AuditID: 1207440d-6a3ff7000000068f-1f-56c322b180a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 96.B2.01679.1B223C65; Tue, 16 Feb 2016 08:22:57 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOT028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:56 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqLtR6XCYwYc9mhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8a5q69ZC+6IV3x7/ImxgfGPYBcjJ4eEgInEsU/b
	2LoYuTiEBLYySvSufc0K4Zxgklj6YyorSBWbgK7Eop5mJhBbREBNYmLbIRaQImaBR4wSXfu3
	M3YxcnAIC/hJfN0qBlLDIqAqcW/FITaQMK9AlMS+zfoQy+QkWn7sBhvJKWAhcbKllwXEFhIw
	l7jzZQ/TBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCAox3B+P/
	dTKHGAU4GJV4eDk8DoUJsSaWFVfmHmKU5GBSEuXl4T4cJsSXlJ9SmZFYnBFfVJqTWnyIUYKD
	WUmE998roHLelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvhyLQUMGi
	1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQBMQXA2MAJMUDtDcNpJ23uCAxFygK0XqK
	UZdjya4Ha5mEWPLy81KlxHldQIoEQIoySvPgVsDSyStGcaCPhXmPg1TxAFMR3KRXQEuYgJbk
	XAJ5rrgkESEl1cAo9PP2Mz2OT0+MOoy5Z09/PN10WkAif0LmE82oOU1C2/6EWGyrjMrRqXH5
	ISj5etKB/n1vpQvKeCfFf1ibws57IeJ5cInP/IN59sIcpT2a4cmOXh0SnpfEnWxs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286377>

The behavior of this function (especially how it handles errors) is
quite different depending on whether we are willing to create the reflog
vs. whether we are only trying to open an existing reflog. So separate
the code paths.

This also simplifies the next steps.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 56 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4266da9..f54d95b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2590,7 +2590,7 @@ static int commit_ref(struct ref_lock *lock)
  */
 static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
 {
-	int logfd, oflags = O_APPEND | O_WRONLY;
+	int logfd;
 
 	strbuf_git_path(logfile, "logs/%s", refname);
 	if (force_create || should_autocreate_reflog(refname)) {
@@ -2599,36 +2599,54 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
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
+					strbuf_addf(err, "There are still logs under "
+						    "'%s'", logfile->buf);
+					return -1;
+				}
+				logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
+			}
 
-		if (errno == EISDIR) {
-			if (remove_empty_directories(logfile)) {
-				strbuf_addf(err, "There are still logs under "
-					    "'%s'", logfile->buf);
+			if (logfd < 0) {
+				strbuf_addf(err, "unable to append to %s: %s",
+					    logfile->buf, strerror(errno));
 				return -1;
 			}
-			logfd = open(logfile->buf, oflags, 0666);
 		}
 
+		adjust_shared_perm(logfile->buf);
+		close(logfd);
+	} else {
+		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
 		if (logfd < 0) {
-			strbuf_addf(err, "unable to append to %s: %s",
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
+				strbuf_addf(err, "unable to append to %s: %s",
+					    logfile->buf, strerror(errno));
+				return -1;
+			}
+		} else {
+			adjust_shared_perm(logfile->buf);
+			close(logfd);
 		}
 	}
 
-	adjust_shared_perm(logfile->buf);
-	close(logfd);
 	return 0;
 }
 
-
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
 {
 	int ret;
-- 
2.7.0
