From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/16] lock_repo_for_gc(): compute the path to "gc.pid" only once
Date: Mon, 10 Aug 2015 11:47:48 +0200
Message-ID: <e34adde5b2cc3adbcd011ee06aeab93b3459a883.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh8-00021w-1X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbbHJJsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:21 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63301 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698AbbHJJsL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:11 -0400
X-AuditID: 1207440e-f79516d0000012b3-cf-55c8735af7a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.1B.04787.A5378C55; Mon, 10 Aug 2015 05:48:10 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx3021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:10 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtVfCLU4NQSS4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGStOHmQs
	mMpT8WAyWwPjI84uRk4OCQETiX0LpzJD2GISF+6tZ+ti5OIQErjMKDH/zFko5wSTxIZ7zYwg
	VWwCuhKLepqZQGwRATWJiW2HWEBsZoF0iRML2sFsYYEQiY6Lp9lBbBYBVYnL/avYQGxegSiJ
	BxtfAPVyAG2Tk1hwIR0kzClgIbG9cQMriC0kYC7xeN559gmMvAsYGVYxyiXmlObq5iZm5hSn
	JusWJyfm5aUW6Rrr5WaW6KWmlG5ihAQP3w7G9vUyhxgFOBiVeHhnbD4eKsSaWFZcmXuIUZKD
	SUmU1yL/RKgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd74DKAcb0piZVVqUT5MSpqDRUmcV22J
	up+QQHpiSWp2ampBahFMVoaDQ0mCV74IqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0
	JCMeFBfxxcDIAEnxAO21A2nnLS5IzAWKQrSeYlSUEuf9UwiUEABJZJTmwY2FpYRXjOJAXwrz
	NoK08wDTCVz3K6DBTCCDA8EGlyQipKQaGLUNCvQ+HFy6saqS4dtRZm/mo1XHMtf/+hErepHb
	KLv+/+u/62al9C2/tTakmPHCmStzivL6cr5O2lrIdfDRrH1KJr0TAqokJ1XcPn57Rtd8mZkz
	HrHNWKMtdeX35EOPuEIOcf7pVq1cmMZSGdFYVcp6aJ6AZU/J2u2fW/fyPPn3wnJC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275597>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/gc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 36fe333..c41354b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -199,6 +199,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	uintmax_t pid;
 	FILE *fp;
 	int fd;
+	char *pidfile_path;
 
 	if (pidfile)
 		/* already locked */
@@ -207,12 +208,13 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	if (gethostname(my_host, sizeof(my_host)))
 		strcpy(my_host, "unknown");
 
-	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
+	pidfile_path = git_pathdup("gc.pid");
+	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
 		static char locking_host[128];
 		int should_exit;
-		fp = fopen(git_path("gc.pid"), "r");
+		fp = fopen(pidfile_path, "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =
 			fp != NULL &&
@@ -236,6 +238,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			if (fd >= 0)
 				rollback_lock_file(&lock);
 			*ret_pid = pid;
+			free(pidfile_path);
 			return locking_host;
 		}
 	}
@@ -246,7 +249,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
 
-	pidfile = git_pathdup("gc.pid");
+	pidfile = pidfile_path;
 	sigchain_push_common(remove_pidfile_on_signal);
 	atexit(remove_pidfile);
 
-- 
2.5.0
