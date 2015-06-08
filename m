From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/14] lock_repo_for_gc(): compute the path to "gc.pid" only once
Date: Mon,  8 Jun 2015 11:07:42 +0200
Message-ID: <532e3a4e4beea4e94f22ac4b11aafa6095763e0b.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2j-0002f0-G7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbbFHJIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:24 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61444 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054AbbFHJIH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:07 -0400
X-AuditID: 1207440f-f79236d000000c5e-63-55755b7562c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 02.BA.03166.57B55755; Mon,  8 Jun 2015 05:08:05 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojZ010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:04 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFsaXRpqsGUDt0XXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y8qF2SwF
	U3kqtk+/wNTA+Iizi5GTQ0LARGL/jBlMELaYxIV769m6GLk4hAQuM0pMmnqEFcI5wSTxbsNb
	FpAqNgFdiUU9zWAdIgKOEiceXGcFsZkFHCQ2f25kBLGFBQIlOrZ8AKrh4GARUJXY+jQMJMwr
	ECUx+cNNVohlchLnj/9kBrE5BSwkfn3dBVYuJGAu8WMu6wRG3gWMDKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdE30cjNL9FJTSjcxQoKHfwdj13qZQ4wCHIxKPLwHFpWECrEmlhVX5h5ilORg
	UhLl/RhRGirEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJfJAijHm5JYWZValA+TkuZgURLnVV+i
	7ickkJ5YkpqdmlqQWgSTleHgUJLgNY8CahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwt
	yYgHxUV8MTAyQFI8QHu5Qdp5iwsSc4GiEK2nGBWlxHmNQBICIImM0jy4sbCU8IpRHOhLYd7N
	IFU8wHQC1/0KaDAT0ODvX4tBBpckIqSkGhjVfjeqf9P5u65sX/Yx5RlGAUfSAj4cr+xdeuru
	tRsSvU7HWa+1rG3bcqHu7NaUJB2bBZsedXsw1Cu+DRC9fufGvS2Sis/9nSc/FAlibFEsc19Q
	9fLSrLq+/W8Obmt2PdCi3vzHTiFs/p9TlxWPmvtd2/N8wbqbL9x/KXvGzAmpWvv6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271000>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/gc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6e18d35..4dc21b2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -200,6 +200,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	uintmax_t pid;
 	FILE *fp;
 	int fd;
+	char *pidfile_path;
 
 	if (pidfile)
 		/* already locked */
@@ -208,12 +209,13 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
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
@@ -237,6 +239,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			if (fd >= 0)
 				rollback_lock_file(&lock);
 			*ret_pid = pid;
+			free(pidfile_path);
 			return locking_host;
 		}
 	}
@@ -247,7 +250,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
 
-	pidfile = git_pathdup("gc.pid");
+	pidfile = pidfile_path;
 	sigchain_push_common(remove_pidfile_on_signal);
 	atexit(remove_pidfile);
 
-- 
2.1.4
