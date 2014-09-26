From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 12/39] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Fri, 26 Sep 2014 12:08:12 +0200
Message-ID: <1411726119-31598-13-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSo-0003lB-0x
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbaIZKJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:17 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53323 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131AbaIZKJK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:10 -0400
X-AuditID: 1207440e-f79da6d0000002fc-32-54253b46baac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.49.00764.64B35245; Fri, 26 Sep 2014 06:09:10 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLv013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:09 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1HWzVg0xOHtCwqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7owTTe+YC/5xVvy8cYu5gfE3excj
	J4eEgInEwYYFLBC2mMSFe+vZuhi5OIQELjNKXDyzAMrZxCTxbt5vRpAqNgFdiUU9zUwgtoiA
	msTEtkMsIEXMAouZJCYc2sQGkhAWiJZ4eWUpWAOLgKpEy9YJYA28Aq4Sf743s0Ksk5PYsPs/
	WA0nULxx+zUwW0jARaJl/WSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbo
	paaUbmKEhCPfDsb29TKHGAU4GJV4eG+sUwkRYk0sK67MPcQoycGkJMr7xUI1RIgvKT+lMiOx
	OCO+qDQntfgQowQHs5II7x0joBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
	hoNDSYK3yAqoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UHfHFwPgASfEA7fUA
	aectLkjMBYpCtJ5i1OVY1/mtn0mIJS8/L1VKnPeIJVCRAEhRRmke3ApY8nnFKA70sTCvL8go
	HmDigpv0CmgJE9ASpSPKIEtKEhFSUg2MWS7tLc3/D2x48smESZ27TujtQdVe/8ap86eW7rSc
	PJ0h0WfvrF1icxrdDs1nODnd53DfvKaFjdNSPfKzvlhk+jRZ57LbTncX2rCod9Ox 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257509>

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
index 53cd4fb..11c76ec 100644
--- a/refs.c
+++ b/refs.c
@@ -2551,12 +2551,15 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
