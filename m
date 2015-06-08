From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/14] gc: use tempfile module to handle gc.pid file
Date: Mon,  8 Jun 2015 11:07:43 +0200
Message-ID: <49aefb848eaeee535346a6f172e9aab1275e6db5.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2r-0002mi-5a
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbFHJI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:29 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46192 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752833AbbFHJIH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:07 -0400
X-AuditID: 12074414-f79ed6d000000cef-90-55755b76a8d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.DF.03311.67B55755; Mon,  8 Jun 2015 05:08:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897oja010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:05 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFsWXRpq8HKagEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74/HkKUwF
	v7kqXk7az9LA2MzZxcjJISFgIjHnfDM7hC0mceHeerYuRi4OIYHLjBKL331hgXBOMEns/TOL
	CaSKTUBXYlFPM5gtIuAoceLBdVYQm1nAQWLz50ZGEFtYwEXi8rp7QJM4OFgEVCUmTy4HCfMK
	REnseTWFDWKZnMT54z+ZQWxOAQuJX193MYGUCwmYS/yYyzqBkXcBI8MqRrnEnNJc3dzEzJzi
	1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJDgEdnBeOSk3CFGAQ5GJR7eA4tKQoVYE8uKK3MPMUpy
	MCmJ8n6MKA0V4kvKT6nMSCzOiC8qzUktPsQowcGsJMLLZAGU401JrKxKLcqHSUlzsCiJ835b
	rO4nJJCeWJKanZpakFoEk5Xh4FCS4N0cBdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRY
	WpIRD4qL+GJgZICkeID2NoC08xYXJOYCRSFaTzEqSonz5oEkBEASGaV5cGNhKeEVozjQl8K8
	jCBVPMB0Atf9CmgwE9Dg71+LQQaXJCKkpBoYXdeZ1n+I9Xt5nFe2fankom+h7r9rD4mXWvHI
	H7j76zK/Uf3a+2f3Xm/MXHjys8J2xuP8b79kMMbMrtz4WCTwh0yH3JxvlxZv7r9/Kt1yS+j/
	GwGT8joM+gN1iw28nE4ezd+VlHJGhTvRifHO3sW57h+OxNT802mbFnTUo/yjqlCd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271006>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/gc.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4dc21b2..a340e89 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,20 +43,7 @@ static struct argv_array prune = ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
-static char *pidfile;
-
-static void remove_pidfile(void)
-{
-	if (pidfile)
-		unlink(pidfile);
-}
-
-static void remove_pidfile_on_signal(int signo)
-{
-	remove_pidfile();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile pidfile;
 
 static void git_config_date_string(const char *key, const char **output)
 {
@@ -202,7 +189,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	int fd;
 	char *pidfile_path;
 
-	if (pidfile)
+	if (pidfile.active)
 		/* already locked */
 		return NULL;
 
@@ -249,11 +236,8 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
-
-	pidfile = pidfile_path;
-	sigchain_push_common(remove_pidfile_on_signal);
-	atexit(remove_pidfile);
-
+	register_tempfile(&pidfile, pidfile_path);
+	free(pidfile_path);
 	return NULL;
 }
 
-- 
2.1.4
