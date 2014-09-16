From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 27/35] commit_lock_file(): use a strbuf to manage temporary space
Date: Tue, 16 Sep 2014 21:33:48 +0200
Message-ID: <1410896036-12750-28-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTye4-0003pZ-AV
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbaIPTmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:31 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50614 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755150AbaIPTmX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:23 -0400
X-AuditID: 12074412-f792e6d000005517-40-541890e1f1ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.45.21783.1E098145; Tue, 16 Sep 2014 15:34:57 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcV001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:55 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqPtwgkSIwaZ/3BZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cdse/uZ6aCo5wVq87pNjA+Zu9i5OSQEDCRuN39hxnC
	FpO4cG89WxcjF4eQwGVGiW2bHzNDOCeYJHYun84KUsUmoCuxqKeZCSQhItDGKLHr4mZWEIdZ
	oJtR4v2J00wgVcICIRJnrt4Cm8sioCoxfcJ5sG5eAVeJZY+nQ+2Tk9iw+z9jFyMHBydQ/Ou+
	AhBTSMBF4uBdvwmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihISd
	0A7G9SflDjEKcDAq8fB6PBIPEWJNLCuuzD3EKMnBpCTK+69bIkSILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCO8PX6Acb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IE781+
	oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7T3I0g7b3FBYi5Q
	FKL1FKMux7rOb/1MQix5+XmpUuK8NiBFAiBFGaV5cCtgSeYVozjQx8K870CqeIAJCm7SK6Al
	TEBLzvaIgSwpSURISTUwKl2a1eo1Ka01yKEq3fc3u9HqQrYtV46rOcw6mmNtF8GV/v3sicbr
	acuNUs7Hvfx445N7c+yuQokd11Ldgt1KK+YlSS/+mG74Uerr7MWyLNMFL4az9Cxd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257177>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a09b4a3..59c822d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -325,8 +325,9 @@ int reopen_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
 	int save_errno;
+	int err;
 
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
@@ -334,13 +335,13 @@ int commit_lock_file(struct lock_file *lk)
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
