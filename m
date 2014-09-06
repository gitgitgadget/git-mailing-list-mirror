From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 19/32] commit_lock_file(): rollback lock file on failure to rename
Date: Sat,  6 Sep 2014 09:50:33 +0200
Message-ID: <1409989846-22401-20-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuT-0005JL-Rg
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaIFH7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49033 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381AbaIFH7g (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:36 -0400
X-AuditID: 12074411-f79d86d000006a97-7f-540abd39d411
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A9.7D.27287.93DBA045; Sat,  6 Sep 2014 03:52:25 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHI006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:24 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqGu5lyvE4P1yfouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujHUXL7IWHOGqONO+i6mBcQtHFyMnh4SAiURnzzdGCFtM4sK99Wxd
	jFwcQgKXGSXWnTjCCuEcY5LYNOEFWBWbgK7Eop5mJpCEiEAbo8Sui5tZQRLMAikSHc+7gYo4
	OIQFQiXu/E0DMVkEVCXuLDEEqeAVcJU4/OwMO8QyOYkNu/+DjeQEik9v6gSzhQRcJNpP9jNN
	YORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkzAR3MM44KXeIUYCD
	UYmHt8CBK0SINbGsuDL3EKMkB5OSKG/ecqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6OyUA5
	3pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IEr8seoEbBotT01Iq0zJwS
	hDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7SXFaSdt7ggMRcoCtF6ilGXY13nt34m
	IZa8/LxUKXFeJpAiAZCijNI8uBWwpPKKURzoY2FeMZAqHmBCgpv0CmgJE9AS83ROkCUliQgp
	qQbGou4Aof0+AdLLOHMPP5tYtUI7izFqwYfkxIst37+uTNflqTw353l39gHxK9fT9qaaGe5+
	LBGqvcLlxZrSIrH5a3rP5fxa+fDIxbL9d98FHlyr5bvww6wwEb6WqIDsnIaJP87a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256574>

If rename() fails, call rollback_lock_file() to delete the lock file
(in case it is still present) and reset the filename field to the
empty string so that the lockfile object is left in a valid state.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 213783a..a7cdb64 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -306,25 +306,29 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
+	int save_errno;
 
 	if (!lk->filename[0])
 		die("BUG: attempt to commit unlocked object");
 
-	if (lk->fd >= 0 && close_lock_file(lk)) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
+	if (lk->fd >= 0 && close_lock_file(lk))
+		goto rollback;
 
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
 
 	if (rename(lk->filename, result_file))
-		return -1;
+		goto rollback;
+
 	lk->filename[0] = 0;
 	return 0;
+
+rollback:
+	save_errno = errno;
+	rollback_lock_file(lk);
+	errno = save_errno;
+	return -1;
 }
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
-- 
2.1.0
