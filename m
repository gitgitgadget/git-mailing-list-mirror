From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] dump_marks(): reimplement using fdopen_lock_file()
Date: Wed,  1 Oct 2014 13:14:48 +0200
Message-ID: <1412162089-3233-3-git-send-email-mhagger@alum.mit.edu>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:15:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHsB-0005XU-OP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbaJALPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 07:15:00 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58431 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbaJALO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 07:14:59 -0400
X-AuditID: 1207440e-f79da6d0000002fc-f7-542be23293ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 66.DA.00764.232EB245; Wed,  1 Oct 2014 07:14:58 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91BEp6l028682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 07:14:56 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1DV6pB1i8P6AhEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BmPDl1hLrjKU3F63gXWBsZuri5G
	Tg4JAROJO31rmCBsMYkL99azdTFycQgJXGaUOPGrnwnCOc4kManlLlgVm4CuxKKeZjBbREBN
	YmLbIRaQImaBxUwSEw5tYgNJCAu4SzyY/YoRxGYRUJX429LNAmLzCjhLfJx3gBVinZzEht3/
	gWo4ODgFXCRmXeEECQsBleyY94lpAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5
	mSV6qSmlmxghwci3g7F9vcwhRgEORiUeXoUE7RAh1sSy4srcQ4ySHExKoryOD4BCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHizDwDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotg
	sjIcHEoSvLwPgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9Be
	IZB23uKCxFygKETrKUZdjnWd3/qZhFjy8vNSpcR5Q0AOFwApyijNg1sBSz2vGMWBPhbmVQMZ
	xQNMW3CTXgEtYQJakrwGbElJIkJKqoFx04ZQobq44znBCVVWidXmbwtqPSefatbZ7nb3YOY+
	be0mxqD61isCjIt3HeOf8sTrziHRytPPJq5eI9e/93j5lsb6hfdXx9QWsh8wjX5y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257741>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 fast-import.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index deadc33..fee7906 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1794,20 +1794,18 @@ static void dump_marks_helper(FILE *f,
 static void dump_marks(void)
 {
 	static struct lock_file mark_lock;
-	int mark_fd;
 	FILE *f;
 
 	if (!export_marks_file)
 		return;
 
-	mark_fd = hold_lock_file_for_update(&mark_lock, export_marks_file, 0);
-	if (mark_fd < 0) {
+	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
 		failure |= error("Unable to write marks file %s: %s",
 			export_marks_file, strerror(errno));
 		return;
 	}
 
-	f = fdopen(mark_fd, "w");
+	f = fdopen_lock_file(&mark_lock, "w");
 	if (!f) {
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
@@ -1816,22 +1814,7 @@ static void dump_marks(void)
 		return;
 	}
 
-	/*
-	 * Since the lock file was fdopen()'ed, it should not be close()'ed.
-	 * Assign -1 to the lock file descriptor so that commit_lock_file()
-	 * won't try to close() it.
-	 */
-	mark_lock.fd = -1;
-
 	dump_marks_helper(f, 0, marks);
-	if (ferror(f) || fclose(f)) {
-		int saved_errno = errno;
-		rollback_lock_file(&mark_lock);
-		failure |= error("Unable to write marks file %s: %s",
-			export_marks_file, strerror(saved_errno));
-		return;
-	}
-
 	if (commit_lock_file(&mark_lock)) {
 		failure |= error("Unable to commit marks file %s: %s",
 			export_marks_file, strerror(errno));
-- 
2.1.0
