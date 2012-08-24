From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v2] Prefer sysconf(_SC_OPEN_MAX) over getrlimit(RLIMIT_NOFILE,...)
Date: Fri, 24 Aug 2012 11:52:22 +0200
Message-ID: <002f01cd81de$28f43bf0$7adcb3d0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4qZE-0004xD-RF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629Ab2HXJwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:52:36 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58644 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2HXJwd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:52:33 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MRlnN-1TFWre2kFV-00Szws; Fri, 24 Aug 2012 11:52:31 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B3ig8YoKRc2k6TZmvMl7ipI+5cQ==
Content-Language: de
X-Provags-ID: V02:K0:yzQS0G8C6Sev6SRuY+oZCb/iRbfJdGzph5KJaHZWTpq
 M1n9bMS0jxJ1yTea6h9bTrU4FPazV8Le66unrVfjDK+R2YX1YJ
 LuC/FvwPw+fwEyL9nN9sI6al8F68R4N54nxu5nwRitE+YmjjQX
 2PoPTQUhC/PfBCxza+6BNHT89QP7U6pBwbBXuby5gskVA4ZAZb
 AihYR+PZml3BTXzTzg0WNe8p5GMiXUETBKTX3v4DSgi/M5PLdw
 A7/1kQ8QBYHApV7LMatS4zLyxE+TIdJ2nJItmXy0vd5/vKLNGn
 hQSjUFEAeiZVRG7AuoY+fHyfKoKe3TCgg8ivDNMmkPt4BflQHL
 tYkZNSTJ+aupWETfxsuxeEwCIbp5nHCZm4JUGnmflpdnP9p2IK
 QVYLcf7Dz7Syg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204198>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
As discussed now as a small helper function rather than #ifdef/#endif in the primary flow of the code.
And hopefully without having screwed up whitespace and line breaks

 sha1_file.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index af5cfbd..427f9e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -731,6 +731,20 @@ void free_pack_by_name(const char *pack_name)
 	}
 }
 
+static unsigned int get_max_fd_limit(void)
+{
+#ifdef _SC_OPEN_MAX
+	return sysconf(_SC_OPEN_MAX);
+#else
+	struct rlimit lim;
+
+	if (getrlimit(RLIMIT_NOFILE, &lim))
+		die_errno("cannot get RLIMIT_NOFILE");
+
+	return lim.rlim_cur;
+#endif
+}
+
 /*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
@@ -747,13 +761,7 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
-		struct rlimit lim;
-		unsigned int max_fds;
-
-		if (getrlimit(RLIMIT_NOFILE, &lim))
-			die_errno("cannot get RLIMIT_NOFILE");
-
-		max_fds = lim.rlim_cur;
+		unsigned int max_fds = get_max_fd_limit();
 
 		/* Save 3 for stdin/stdout/stderr, 22 for work */
 		if (25 < max_fds)
-- 
1.7.12
