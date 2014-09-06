From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 11/32] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Sat,  6 Sep 2014 09:50:25 +0200
Message-ID: <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAu8-00055l-DY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaIFH7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:24 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59874 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182AbaIFH7U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:20 -0400
X-AuditID: 1207440f-f79156d000006a5c-35-540abd2d885f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.1B.27228.D2DBA045; Sat,  6 Sep 2014 03:52:13 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHA006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:12 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqKu7lyvEYP8HeYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujFdLVzEXNHFWXPwu08A4nb2LkZNDQsBEYmbPRxYIW0ziwr31bF2M
	XBxCApcZJS7MO8wE4Rxjkrhw4TNYB5uArsSinmawhIhAG6PEroubWUESzAIpEh3PuxlBbGGB
	aIkPbyYwgdgsAqoSP7ZPA2rm4OAVcJX4sJgLYpucxIbd/8HKOYHC05s6wWwhAReJ9pP9TBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAkz/h2MXetlDjEKcDAq
	8fAWOHCFCLEmlhVX5h5ilORgUhLlzVsOFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC2zEZKMeb
	klhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuC9sRuoUbAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4UGfHFwNgASfEA7T0L0s5bXJCYCxSFaD3FqMuxrvNbP5MQ
	S15+XqqUOC/THqAiAZCijNI8uBWwpPKKURzoY2He+yCjeIAJCW7SK6AlTEBLzNM5QZaUJCKk
	pBoYV703dM2Z4L37+WlnG/V7nzlqvniyH/MR9py7ac208J/aNtouZm5zV57u/1Dy9WBLwraY
	BVJb+jftEdr4LtpW/8GVgzudDc6+tJjv1nzwsncza5doD+cGlpCY8Fij/pNuZ3Mm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256568>

It's bad manners.  Especially since, if unlink_or_warn() failed, the
memory wasn't restored to its original contents.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 828522d..8a63073 100644
--- a/refs.c
+++ b/refs.c
@@ -2545,12 +2545,15 @@ static int repack_without_ref(const char *refname)
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
