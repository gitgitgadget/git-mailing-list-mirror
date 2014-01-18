From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/17] lock_ref_sha1_basic(): if locking fails with ENOENT, retry
Date: Sat, 18 Jan 2014 23:48:55 +0100
Message-ID: <1390085341-2553-12-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiH-0005CE-4H
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaARWtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:51 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64026 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709AbaARWtm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:42 -0500
X-AuditID: 12074411-b7f426d000005455-fa-52db0505a693
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 40.EB.21589.5050BD25; Sat, 18 Jan 2014 17:49:41 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN94030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:41 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqMvKejvI4PckS4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M749uAac8FqroovnzazNDDO
	4ehi5OSQEDCRaFl1mA3CFpO4cG89kM3FISRwmVGi9dEfJgjnBJNE979DLCBVbAK6Eot6mplA
	bBEBNYmJbRBxZgEHic2fGxm7GDk4hAVCJBbf8QUJswioSvx+3cAIYvMKuEh8PNnDBlIiIaAg
	sfq6EEiYEyh8ZP4FsIlCAs4SN18/YZ/AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6p
	Xm5miV5qSukmRkigCO5gnHFS7hCjAAejEg/vAabbQUKsiWXFlbmHGCU5mJREeZVBQnxJ+SmV
	GYnFGfFFpTmpxYcYJTiYlUR4gzfcChLiTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnwerMADRUsSk1PrUjLzClBSDNxcIIILpANPCAbQAp5iwsSc4sz0yGKTjEqSonz
	hoMkBEASGaV5cANgMf2KURzoH2FeKZAqHmA6gOt+BTSYCWiwSOxNkMEliQgpqQZG+6WbFxtU
	zHpRd28tZ15K1vbWS0f2RysvMtVkn3eSw5B9xsEgRbvMrl+vLPhj5T6FGi/csZzzxsK0p0EW
	E5YubP2V49Os5iN2JOHHnqQKb40duiK3zhYcSzuzyoOv89H2dDb+HWIeie6dfu3v9yeEvsrk
	E2VhmblyUrLDEYFDZkus424KvbihxFKckWioxVxUnAgA5iVAi8QCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240662>

If hold_lock_file_for_update() fails with errno==ENOENT, it might be
because somebody else (for example, a pack-refs process) has just
deleted one of the lockfile's ancestor directories.  So if this
condition is detected, try again (up to 3 times).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9ae184d..4060ed1 100644
--- a/refs.c
+++ b/refs.c
@@ -2081,7 +2081,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lflags = LOCK_DIE_ON_ERROR;
+	lflags = 0;
 	if (flags & REF_NODEREF) {
 		refname = orig_refname;
 		lflags |= LOCK_NODEREF;
@@ -2109,6 +2109,17 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
+	if (lock->lock_fd < 0) {
+		if (errno == ENOENT && --attempts_remaining > 0)
+			/*
+			 * Maybe somebody just deleted one of the
+			 * directories leading to ref_file.  Try
+			 * again:
+			 */
+			goto retry;
+		else
+			unable_to_lock_index_die(ref_file, errno);
+	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
-- 
1.8.5.2
