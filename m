From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 17/35] commit_lock_file(): die() if called for unlocked lockfile object
Date: Tue, 16 Sep 2014 21:33:38 +0200
Message-ID: <1410896036-12750-18-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWU-0000IF-HW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbaIPTem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53866 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051AbaIPTem (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:42 -0400
X-AuditID: 12074414-f79446d000001f1d-08-541890d1f83c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.EA.07965.1D098145; Tue, 16 Sep 2014 15:34:41 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcL001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:40 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHtxgkSIwZ0WBYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOOHO7g7XgPE/Fn4WRDYzzuLoYOTgkBEwk9s6U6WLk
	BDLFJC7cW8/WxcjFISRwmVHi9LQPUM4JJokpD26wg1SxCehKLOppZgJJiAi0MUrsuriZFcRh
	FuhmlHh/4jQTSJWwQJTEzI6ZYB0sAqoSM98tZQWxeQVcJa7//sEOsU9OYsPu/4wgZ3ACxb/u
	KwAxhQRcJA7e9ZvAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRkjQ
	iexgPHJS7hCjAAejEg+vxyPxECHWxLLiytxDjJIcTEqivP+6JUKE+JLyUyozEosz4otKc1KL
	DzFKcDArifD+8AXK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8M7r
	B2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VFfDEwMkBSPEB7N4O08xYXJOYC
	RSFaTzHqcqzr/NbPJMSSl5+XKiXOawNSJABSlFGaB7cClmJeMYoDfSzMuwWkigeYnuAmvQJa
	wgS05GyPGMiSkkSElFQDo3pcmkL3iSQrbl73ZsfZb8419vssaZrLGTX/1AsDgdToud937GGa
	MlU1ZuE5p8tnHmrPnXQh603Z/GJGFt1FpnmCecwuHfF711qKHIyrYJepkmlt7Npw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257150>

It was previously a bug to call commit_lock_file() with a lock_file
object that was not active (an illegal access would happen within the
function).  It was presumably never done, but this would be an easy
programming error to overlook.  So before continuing, do a consistency
check that the lock_file object really is locked.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 4 +++-
 lockfile.c                               | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index b53e300..9a94ead 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -68,7 +68,9 @@ commit_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and rename the lockfile to its
 	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	value on failure to close(2) or rename(2).  It is a bug to
+	call `commit_lock_file()` for a `lock_file` object that is not
+	currently locked.
 
 rollback_lock_file::
 
diff --git a/lockfile.c b/lockfile.c
index 9e1cdd2..6436111 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -312,6 +312,9 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 
+	if (!lk->filename[0])
+		die("BUG: attempt to commit unlocked object");
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
-- 
2.1.0
