From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/20] log_ref_setup(): improve robustness against races
Date: Tue, 16 Feb 2016 14:22:21 +0100
Message-ID: <9cee9cea6d284315f9a30e925dd0057bddc77c82.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjz-0004gj-FZ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbcBPNcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:32:17 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60861 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932359AbcBPNa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:27 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:30:26 EST
X-AuditID: 12074411-fe7ff700000071cf-c1-56c322b31541
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BD.14.29135.3B223C65; Tue, 16 Feb 2016 08:22:59 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOU028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:57 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLtZ6XCYwbl1QhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bNJTeYCi6JV+xYc5ylgXGlUBcjJ4eEgInEnsb9
	LF2MXBxCAlsZJS6eaodyTjBJLH59khmkik1AV2JRTzMTiC0ioCYxse0QWBGzwCNGia792xlB
	EsICHhLNj3eygtgsAqoSZz//ZQGxeQWiJE60nWSFWCcn0fJjN5jNKWAhcbKlF6xGSMBc4s6X
	PUwTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJMsEdjDNOyh1i
	FOBgVOLh5fQ4FCbEmlhWXJl7iFGSg0lJlJeH+3CYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	f6+AynlTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErziikBDBYtS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFREF8MjAOQFA/QXhsFoHbe4oLEXKAoROspRl2O
	JbserGUSYsnLz0uVEud1AdkhAFKUUZoHtwKWUl4xigN9LMzbDVLFA0xHcJNeAS1hAlqScwnk
	ueKSRISUVANjdiWP+bNK96MfJbh28MXG+tVdZr653P+0wnzeVXvZ+rPs4x3vPYtrFhFRL5dc
	pfIx5MGdHyfW8Sl2/Vl76myYoadQZ+i6uy5hFzuzS8TEKr0fy3EGcs7cdOowx53W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286402>

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
index f54d95b..0cfe1ce 100644
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
