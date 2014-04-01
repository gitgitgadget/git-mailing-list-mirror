From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/22] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Tue,  1 Apr 2014 17:58:20 +0200
Message-ID: <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16P-0001sB-2l
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbaDAP7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:00 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45718 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888AbaDAP6y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:54 -0400
X-AuditID: 1207440e-f79c76d000003e2c-50-533ae23e9560
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.1A.15916.E32EA335; Tue,  1 Apr 2014 11:58:54 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbG027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:53 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGv3yCrY4MZbWYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3Rcliq4CFHxe+7r1gbGL+zdTFyckgImEi8vbqWBcIWk7hwbz1QnItDSOAyo8T6ZTuZ
	IZxjTBKbLveAVbEJ6Eos6mlmArFFBNQkJrYdAoszC6RIvPq7C8wWFoiQONb3hLWLkYODRUBV
	4sh2P5Awr4CLxO+Nx6GWyUlM+b2AHcTmBIpferCHFcQWEnCWOP1mMfMERt4FjAyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUICim8HY/t6mUOMAhyMSjy8B85bBQuxJpYV
	V+YeYpTkYFIS5f1xFyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfGQ6Acb0piZVVqUT5MSpqD
	RUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9yhIo2BRanpqRVpmTglCmomDE2Q4l5RIcWpe
	SmpRYmlJRjwoLuKLgZEBkuIB2jsdbG9xQWIuUBSi9RSjopQ4bwhIQgAkkVGaBzcWliZeMYoD
	fSnMuxikigeYYuC6XwENZgIazL0ObHBJIkJKqoGxjLno+82HW5rcY7KWTtNaezRwrtGGpS+D
	pDVWvpHWm8sZwb48nKnJc9b0b5c31d5/w9PhmdLBUZWTkD5/+uTpjTHGt8w2rJB3OlOrd0es
	e6tK45Z3iyqvMIbMsQ/Jjy88c+7PNYWHehm9/r4vKpMKd5xYn6k4a0nncoN1C7Mm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245605>

It's bad manners.  Especially since, if unlink_or_warn() failed, the
memory wasn't restored to its original contents.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 28d5eca..11ad23e 100644
--- a/refs.c
+++ b/refs.c
@@ -2485,12 +2485,14 @@ static int repack_without_ref(const char *refname)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(lock->lk->filename,
+						strlen(lock->lk->filename) - 5);
+		int err = unlink_or_warn(loose_filename);
+		free(loose_filename);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
1.9.0
