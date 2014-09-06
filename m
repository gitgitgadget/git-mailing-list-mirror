From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 27/32] commit_lock_file(): use a strbuf to manage temporary space
Date: Sat,  6 Sep 2014 09:50:41 +0200
Message-ID: <1409989846-22401-28-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuS-0005JL-JK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbaIFH7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54040 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbaIFH7i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:38 -0400
X-AuditID: 1207440c-f79036d000005e77-72-540abd4486a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 74.C9.24183.44DBA045; Sat,  6 Sep 2014 03:52:36 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHQ006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:35 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqOuylyvE4OU/Q4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujP/Nz9gKjnJWzP6ygrmB8TF7FyMnh4SAicTvY2ugbDGJC/fWs3Ux
	cnEICVxmlNj85gsTSEJI4BiTxMk+MJtNQFdiUU8zE0iRiEAbo8Sui5tZQRLMAikSHc+7GUFs
	YYEQiTf334HZLAKqEl+anoDZvAKuEtNPXYXaJiexYfd/sDgnSLypkxFimYtE+8l+pgmMvAsY
	GVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQazw7Gb+tkDjEKcDAq8fAW
	OHCFCLEmlhVX5h5ilORgUhLlzVsOFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC2zEZKMebklhZ
	lVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuB12QPUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9rKCtPMWFyTmAkUhWk8x6nKs6/zWzyTEkpef
	lyolzssEUiQAUpRRmge3ApZWXjGKA30szCsGUsUDTElwk14BLWECWmKezgmypCQRISXVwFi7
	vzHZwM3li9VlvfsmHAw+Tm77VwrFFOvMyHk570FC6zOV5Lj8k3IyJ7WLVL+rMa7qfP1V25nB
	uVGl54+DSdmcW9eNAgo/9v+NKJygwrsqm6Eo9dXkX9vDqh9I/rxzrFc570iukkvD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256576>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f51f73f..f6b3866 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -318,8 +318,9 @@ int reopen_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
 	int save_errno;
+	int err;
 
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
@@ -327,13 +328,13 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		goto rollback;
 
-	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-
-	if (rename(lk->filename, result_file))
+	strbuf_add(&result_file, lk->filename,
+		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename, result_file.buf);
+	strbuf_reset(&result_file);
+	if (err)
 		goto rollback;
-
 	lk->active = 0;
 	lk->filename[0] = 0;
 	return 0;
-- 
2.1.0
