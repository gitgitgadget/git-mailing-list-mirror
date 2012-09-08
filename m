From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v4] Support for setitimer() on platforms lacking it
Date: Sat, 8 Sep 2012 18:54:34 +0200
Message-ID: <001e01cd8de2$a07f3930$e17dab90$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 18:55:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAOJt-0007zf-Su
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 18:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2IHQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 12:55:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2IHQyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 12:54:47 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M0vAh-1TQ8J138eN-00v9xA; Sat, 08 Sep 2012 18:54:45 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2N2XjCBMpjIjpSTaS05IXAY4PSkg==
Content-Language: de
X-Provags-ID: V02:K0:72sHdlW5k4skdcsCUgGI0kJgdr/NKWAC2SPunprCOao
 kMClg+QLFk+ppPju7RNjYj0Gg/iPOi5j65RqC/Rs1GkuKuB/DF
 YsIIgiDsf46XvmjJ8Atf6SJRiIwlplHQDw4wmmdSnU7l3srny3
 1pIAQW7zn0xy68hXgnVW4reeZFZz4aGcJgJac786UaN6v5gge6
 dhmKijBm38gMQNgCOLBQ1f48W82t2vClWj6lGu9+m5hFN5uxNI
 UWXyr0+2o5RGsj30rwwB9UvRt/eQhYQYezALYWWJBstS+r/NYk
 VleOOlHjJE2M2bscgi0FcRhKxtfDCTcL/rbFVr8SAVVonO5/ZO
 bPZofklCBiTJHhNHByhQ5W8AHSLxxwPJzu7/pyi9dCOgDv3Fiw
 lyCFu1FfwQumg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205018>

HP NonStop (currently) doesn't have setitimer().
As setitimer() is only used in cases of perceived latency and it doesn't affect
correctness, it gets disabled entirely if NO_SETITIMER is set.
HP NonStop does provide struct itimerval, but other platforms may not, so this
is taken care of in this commit too, by setting NO_STRUCT_ITIMERVAL.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 Makefile          | 12 ++++++++++++
 git-compat-util.h | 11 +++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ac49320..7be555b 100644
--- a/Makefile
+++ b/Makefile
@@ -157,6 +157,11 @@ all::
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
+# Define NO_SETITIMER if you don't have setitimer()
+#
+# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
+# This also implies NO_SETITIMER
+#
 # Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
 # thread-safe. (e.g. compat/pread.c or cygwin)
 #
@@ -1647,6 +1652,13 @@
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
+ifdef NO_STRUCT_ITIMERVAL
+	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
+	NO_SETITIMER=YesPlease
+endif
+ifdef NO_SETITIMER
+	COMPAT_CFLAGS += -DNO_SETITIMER
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
diff --git a/git-compat-util.h b/git-compat-util.h
index 18089f0..4628d7a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,17 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
+#ifdef NO_STRUCT_ITIMERVAL
+struct itimerval {
+	struct timeval it_interval;
+	struct timeval it_value;
+}
+#endif
+
+#ifdef NO_SETITIMER
+#define setitimer(which,value,ovalue)
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-- 
1.7.12
