From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/20] log_ref_setup(): separate code for create vs non-create
Date: Thu, 25 Feb 2016 14:16:06 +0100
Message-ID: <bc674e78b4d3f528d5e0bfe9d8dbff421b180538.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvtU-00086n-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbcBYNXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:45 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57423 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760665AbcBYNXo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:44 -0500
X-AuditID: 12074411-fe7ff700000071cf-49-56cefeb99f14
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CE.7D.29135.9BEFEC65; Thu, 25 Feb 2016 08:16:41 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrl024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:39 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvz37kwg923VS3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyHbY1MBXfEK+59/s3awPhHsIuRk0NCwESib2Iv
	cxcjF4eQwFZGiT+vHrNAOCeYJDa/XMQEUsUmoCuxqKcZzBYRUJOY2HYIrIhZ4BGjRNf+7Ywg
	CWGBQInuh1/BilgEVCWe/zoIFucViJI4cXMtK8Q6OYmWH7vBbE4BC4mLJ6czg9hCAuYSq27s
	YZ/AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkiQCe5gnHFS7hCj
	AAejEg9vxO+zYUKsiWXFlbmHGCU5mJREefc8PxcmxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3
	xV+gHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgpcZGE1CgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAoiC8GxgFIigdobwxIO29xQWIuUBSi9RSjLseS
	XQ/WMgmx5OXnpUqJ8y4HOU4ApCijNA9uBSylvGIUB/pYmNcMpIoHmI7gJr0CWsIEtGTmBrAl
	JYkIKakGxox+MUv1yxVHPV49Fvzvut9n25Q96hHiVwSZjib9OZwz8bEyv1PnR/mCZcbsT10e
	rOJme8lxSWN3Vc2GyZ9fTj8n9sl51cZNGjz735yZXCmr2X5OIW/2yt2Xo83c2lzN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287382>

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
index ed29b3b..8fff1a8 100644
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
