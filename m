From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/20] log_ref_setup(): improve robustness against races
Date: Thu, 25 Feb 2016 14:16:07 +0100
Message-ID: <2554cdb15206319537c694299f7c78238e7706b3.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvta-0008Bi-GO
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760685AbcBYNXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:47 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65170 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760665AbcBYNXq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:46 -0500
X-AuditID: 12074413-eefff7000000516b-25-56cefebbb995
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 60.F0.20843.BBEFEC65; Thu, 25 Feb 2016 08:16:43 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrm024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:41 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLv737kwgwunZCzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oymSRNYCy6JV3zfPpe5gXGlUBcjJ4eEgInE5PVr
	2boYuTiEBLYySiz6s4wVwjnBJDH31CF2kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCjxgluvZv
	ZwRJCAt4S+yZ+xTI5uBgEVCV6H9fABLmFYiS2NjbxgKxTU6i5cduVhCbU8BC4uLJ6cwgtpCA
	ucSqG3vYJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokREmLCOxh3
	nZQ7xCjAwajEwxvx+2yYEGtiWXFl7iFGSQ4mJVHePc/PhQnxJeWnVGYkFmfEF5XmpBYfYpTg
	YFYS4V3xFyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgZQbGkpBg
	UWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KAbii4FRAJLiAdqrCNLOW1yQmAsUhWg9
	xajLsWTXg7VMQix5+XmpUuK8y0GOEwApyijNg1sBSyivGMWBPhbm1QQZxQNMRnCTXgEtYQJa
	MnMD2JKSRISUVANjpsrBZayzok5975n82IR3mn7n1Rc2s5XY+mqfPbNlf2zbenhdjuW+eXfm
	3lVYJ+t783uDVgz/Ds6kLfZe8y668/Dmu9i8eXriRaT77+mlbP6rpiq/7H46ecGT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287384>

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
 refs/files-backend.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8fff1a8..2cc9489 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2582,6 +2582,14 @@ static int commit_ref(struct ref_lock *lock)
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
@@ -2593,36 +2601,24 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 	int logfd;
 
 	strbuf_git_path(logfile, "logs/%s", refname);
+
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (safe_create_leading_directories(logfile->buf) < 0) {
-			strbuf_addf(err, "unable to create directory for %s: "
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
-					strbuf_addf(err, "There are still logs under "
-						    "'%s'", logfile->buf);
-					return -1;
-				}
-				logfd = open(logfile->buf, O_APPEND | O_WRONLY | O_CREAT, 0666);
-			}
-
-			if (logfd < 0) {
+		if (raceproof_create_file(logfile->buf, open_or_create_logfile, &logfd) < 0) {
+			if (errno == ENOENT) {
+				strbuf_addf(err, "unable to create directory for %s: "
+					    "%s", logfile->buf, strerror(errno));
+			} else if (errno == EISDIR) {
+				strbuf_addf(err, "there are still logs under %s",
+					    logfile->buf);
+			} else {
 				strbuf_addf(err, "unable to append to %s: %s",
 					    logfile->buf, strerror(errno));
-				return -1;
 			}
+			return -1;
+		} else {
+			adjust_shared_perm(logfile->buf);
+			close(logfd);
 		}
-
-		adjust_shared_perm(logfile->buf);
-		close(logfd);
 	} else {
 		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
 		if (logfd < 0) {
-- 
2.7.0
