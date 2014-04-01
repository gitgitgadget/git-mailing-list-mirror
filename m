From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/22] lockfile: extract a function reset_lock_file()
Date: Tue,  1 Apr 2014 17:58:29 +0200
Message-ID: <1396367910-7299-22-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15s-0006X1-Il
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaDAP7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60167 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751948AbaDAP7J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:09 -0400
X-AuditID: 12074414-f79d96d000002d2b-44-533ae24ccd79
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 38.2D.11563.C42EA335; Tue,  1 Apr 2014 11:59:08 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbP027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:07 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOvzyCrYYMVBI4uuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ2x59sT1oIGwYqT958xNjC+5e1i5OSQEDCRaDy8hA3CFpO4cG89mC0kcJlR4tX11C5G
	LiD7GJPEvPZ+RpAEm4CuxKKeZiYQW0RATWJi2yEWEJtZIEXi1d9dYLawgKvErC8XwQaxCKhK
	rHt5BKyeV8BFYuKUBhaIZXISU34vYAexOYHilx7sYYVY7Cxx+s1i5gmMvAsYGVYxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISUyA7GIyflDjEKcDAq8fAePG8VLMSaWFZc
	mXuIUZKDSUmU98ddoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3lk3gXK8KYmVValF+TApaQ4W
	JXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK81x4ANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSDIiO+GBgbICkeoL2PQNp5iwsSc4GiEK2nGBWlxHlZQBICIImM0jy4sbBE8YpR
	HOhLYd73IFU8wCQD1/0KaDAT0GDudWCDSxIRUlINjDJf5gV9kz1m9fvOPLVPy/+LZ6n56oi/
	kf7M7lBbaJP3OfP0jK06oY/aXth+KNxWEsJ/OCT1q5la5zHzMkmxQ5nFVrWlTzalT9eYrnQh
	SCvbJJ1/TrOvm8LvO3b+u5QFOxOT22w2VOVFhixrvnP4nalyU9WzyN+H9pg3PfrW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245599>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 852d717..c06e134 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -85,6 +85,14 @@ static void remove_lock_file_on_signal(int signo)
 	raise(signo);
 }
 
+static void reset_lock_file(struct lock_file *lk)
+{
+	lk->fd = -1;
+	strbuf_setlen(&lk->filename, 0);
+	strbuf_setlen(&lk->staging_filename, 0);
+	lk->flags = LOCK_FLAGS_ON_LIST;
+}
+
 /*
  * path = absolute or relative path name
  *
@@ -185,8 +193,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 
 	lk->fd = open(lk->staging_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->staging_filename, 0);
+		reset_lock_file(lk);
 		return -1;
 	}
 	if (adjust_shared_perm(lk->staging_filename.buf)) {
@@ -273,17 +280,12 @@ int close_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	int err = 0;
-
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
-	if (rename(lk->staging_filename.buf, lk->filename.buf)) {
-		err = -1;
-	} else {
-		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->staging_filename, 0);
-	}
-	return err;
+	if (rename(lk->staging_filename.buf, lk->filename.buf))
+		return -1;
+	reset_lock_file(lk);
+	return 0;
 }
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
@@ -306,8 +308,8 @@ int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->staging_filename.buf, alternate_index_output))
 			return -1;
-		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->staging_filename, 0);
+
+		reset_lock_file(lk);
 		return 0;
 	} else {
 		return commit_lock_file(lk);
@@ -320,7 +322,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close_lock_file(lk);
 		unlink_or_warn(lk->staging_filename.buf);
-		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->staging_filename, 0);
+		reset_lock_file(lk);
 	}
 }
-- 
1.9.0
