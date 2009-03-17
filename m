From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] MinGW: a hardlink implementation
Date: Tue, 17 Mar 2009 08:46:43 +0100
Message-ID: <49BF5563.2060500@kdbg.org>
References: <49BF53C2.6020707@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Kodl <petrkodl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjU2S-0006Gw-IZ
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbZCQHqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZCQHqt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:46:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42538 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbZCQHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:46:49 -0400
Received: from [192.168.1.98] (cm56-163-160.liwest.at [86.56.163.160])
	by bsmtp.bon.at (Postfix) with ESMTP id DBD3D10043;
	Tue, 17 Mar 2009 08:46:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49BF53C2.6020707@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113433>

From: Petr Kodl <petrkodl@gmail.com>
Date: Sat, 24 Jan 2009 15:04:39 +0100

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  This is the meat of Petr's original patch with the fixup that was
  discussed in the msysgit mailing list (WINAPI was added in the
  typedef).

  -- Hannes

  compat/mingw.c |   21 +++++++++++++++++++++
  compat/mingw.h |    3 +--
  2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f66ad56..171fa85 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1118,3 +1118,24 @@ void mingw_open_html(const char *unixpath)
  	printf("Launching default browser to display HTML ...\n");
  	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
  }
+
+int link(const char *oldpath, const char *newpath)
+{
+	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	static T create_hard_link = NULL;
+	if (!create_hard_link) {
+		create_hard_link = (T) GetProcAddress(
+			GetModuleHandle("kernel32.dll"), "CreateHardLinkA");
+		if (!create_hard_link)
+			create_hard_link = (T)-1;
+	}
+	if (create_hard_link == (T)-1) {
+		errno = ENOSYS;
+		return -1;
+	}
+	if (!create_hard_link(newpath, oldpath, NULL)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	return 0;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index f5da647..762eb14 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -67,8 +67,6 @@ static inline int readlink(const char *path, char *buf, size_t bufsiz)
  { errno = ENOSYS; return -1; }
  static inline int symlink(const char *oldpath, const char *newpath)
  { errno = ENOSYS; return -1; }
-static inline int link(const char *oldpath, const char *newpath)
-{ errno = ENOSYS; return -1; }
  static inline int fchmod(int fildes, mode_t mode)
  { errno = ENOSYS; return -1; }
  static inline int fork(void)
@@ -134,6 +132,7 @@ int getpagesize(void);	/* defined in MinGW's libgcc.a */
  struct passwd *getpwuid(int uid);
  int setitimer(int type, struct itimerval *in, struct itimerval *out);
  int sigaction(int sig, struct sigaction *in, struct sigaction *out);
+int link(const char *oldpath, const char *newpath);

  /*
   * replacements of existing functions
-- 
1.6.2.rc2.971.g14d5
