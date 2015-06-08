From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] fsck: report errors if reflog entries point at invalid objects
Date: Mon,  8 Jun 2015 15:40:05 +0200
Message-ID: <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1xI3-0002r1-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 15:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbbFHNk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 09:40:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62840 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbbFHNkW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 09:40:22 -0400
X-AuditID: 1207440f-f79236d000000c5e-37-55759b3bc6f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id ED.71.03166.B3B95755; Mon,  8 Jun 2015 09:40:11 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58De6ND022064
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 09:40:10 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433769878.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGs9uzTU4NRUC4uuK91MFg29V5gt
	+pd3sVncXjGf2eJHSw+zA6vH3/cfmDw+fIzzeNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M06fWsJY0MJX8XHfTLYGxk3cXYycHBICJhLPZv1hhbDFJC7cW88GYgsJXGaUuHchqIuR
	C8g+wSRx+eoesASbgK7Eop5mJhBbREBNYmLbIRaQImaB+YwSj1tfMYIkhAWCJR7uX8cMYrMI
	qEocXLwBrJlXIEpi+d2DTBDb5CTOH/8JVsMpYCFxtGkfI8Rmc4kJv/exTGDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJKT4dzB2rZc5xCjAwajEw3tgUUmoEGti
	WXFl7iFGSQ4mJVHe+r7SUCG+pPyUyozE4oz4otKc1OJDjBIczEoivMnTgXK8KYmVValF+TAp
	aQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQnehzOBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBsRFfDIwOkBQP0F7lWSB7iwsSc4GiEK2nGBWlxHk3gMwVAElklObBjYUl
	ileM4kBfCvOygLTzAJMMXPcroMFMQIO/fy0GGVySiJCSamDscn5mebHIT2D64WX8Rn2Nvt69
	/Qq2ee58/H3JZgFv+48caH73lO9FtHJuGPMTFs/Yf4uuL51uLb2nhZlLwJ25f/aXvKnJH7ra
	eC92r/3utqtyzXlfV07+D4oPFl1kfHSW4eaLGwkG0x+Fs92r+e709tmp2Ltswjsr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271031>

Previously, if a reflog entry's old or new SHA-1 was not resolvable to
an object, that SHA-1 was silently ignored. Instead, report such cases
as errors.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fsck.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b1b6c60..2679793 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -451,7 +451,7 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static void fsck_handle_reflog_sha1(unsigned char *sha1)
+static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1)
 {
 	struct object *obj;
 
@@ -460,6 +460,9 @@ static void fsck_handle_reflog_sha1(unsigned char *sha1)
 		if (obj) {
 			obj->used = 1;
 			mark_object_reachable(obj);
+		} else {
+			error("%s: invalid reflog entry %s", refname, sha1_to_hex(sha1));
+			errors_found |= ERROR_REACHABLE;
 		}
 	}
 }
@@ -468,19 +471,21 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
+	const char *refname = cb_data;
+
 	if (verbose)
 		fprintf(stderr, "Checking reflog %s->%s\n",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1));
 
-	fsck_handle_reflog_sha1(osha1);
-	fsck_handle_reflog_sha1(nsha1);
+	fsck_handle_reflog_sha1(refname, osha1);
+	fsck_handle_reflog_sha1(refname, nsha1);
 	return 0;
 }
 
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 			      int flag, void *cb_data)
 {
-	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
+	for_each_reflog_ent(logname, fsck_handle_reflog_ent, (void *)logname);
 	return 0;
 }
 
-- 
2.1.4
