From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 12/38] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Wed,  1 Oct 2014 12:28:16 +0200
Message-ID: <1412159322-2622-13-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9u-0002YE-F7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbaJAK3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:18 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62059 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552AbaJAK3Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:16 -0400
X-AuditID: 1207440f-f79156d000006a5c-ab-542bd7767c5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A5.EF.27228.677DB245; Wed,  1 Oct 2014 06:29:10 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6B026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:08 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1C27rh1isKZd2qLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oxnHU+YCv5xVnxtmszWwPibvYuR
	k0NCwESioWU/K4QtJnHh3nq2LkYuDiGBy4wSvZt2sUI4x5kkDrWcB+tgE9CVWNTTzARiiwio
	SUxsO8QCUsQssJhJYsKhTWwgCWGBaIkFXU/AbBYBVYn9nZOYQWxeAReJJYfaodbJSWzY/Z8R
	xOYEii+/3MwCYgsJOEvsuPOVaQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkl
	eqkppZsYIeHIv4Oxa73MIUYBDkYlHl6FBO0QIdbEsuLK3EOMkhxMSqK8iy4BhfiS8lMqMxKL
	M+KLSnNSiw8xSnAwK4nwZh8AyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRl
	ODiUJHinXANqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFR3wxMD5AUjxAe3eC
	tPMWFyTmAkUhWk8x6nKs6/zWzyTEkpeflyolzrsfpEgApCijNA9uBSz5vGIUB/pYmPcCSBUP
	MHHBTXoFtIQJaEnyGrAlJYkIKakGxmo91wbeMzauAoXOvcl1ATNm/izSzvvxXbdzdt+rJvWv
	5o4XHQpc60NvuDg2GVi+9ssQllo7e9+1At6APw77pp/qYn4Xlah7N/r9rPxrFbcW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257706>

It's bad manners. Especially since there could be a signal during the
call to unlink_or_warn(), in which case the signal handler will see
the wrong filename and delete the reference file, leaving the lockfile
behind.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 73d6bae..a415131 100644
--- a/refs.c
+++ b/refs.c
@@ -2602,12 +2602,15 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = LOCK_SUFFIX[0];
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(
+				lock->lk->filename,
+				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
+		int err = unlink_or_warn(loose_filename);
+		free(loose_filename);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
2.1.0
