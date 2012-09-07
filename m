From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3] Support for setitimer() on platforms lacking it
Date: Fri, 7 Sep 2012 11:55:29 +0200
Message-ID: <002201cd8cde$ea7cacc0$bf760640$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9vI2-0006Q7-GL
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 11:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760321Ab2IGJzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 05:55:47 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:56979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760304Ab2IGJzq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 05:55:46 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M51UE-1TVBky0cU2-00yjsx; Fri, 07 Sep 2012 11:55:38 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M3uYsNXj3/yNlToSgsL44k0ht9w==
Content-Language: de
X-Provags-ID: V02:K0:wQ0ScjTQppEIp5uCww7IcNkISbi3hLYcVS2lZZaeq7F
 9ep3HuWs/ESroC9t/x/4+Nt7pkMkDfbbOwbWo0MlJxlbWW/g+d
 mcn4ns8R2J9APfcbJp0JcCsDNQf7Qdy/k8CP6Z4SnPyF2xgXG5
 +xaFyOYwAKOS0DQguFYfBWxpe9xCcfMzUULAXcwPBQ0Wd+5uid
 G3c6xHWdUKgzs8nW/slx5nVQ559gpDkHxWA4/aYhoGBKWNErZO
 v012xSAQ1RdhBGyQrQnUelB1o7+1k9nJXe7WlwzB6kRk0iGfoZ
 mkjYexjgpNdBy3HPLI3ZbKgLP8ickRdAqkGpNadBqhVcxAa2P7
 E/M8sjej6E6HtoORQUbtx+jaaHDi1lo1eDZzvdIfuEEKjAoXjy
 haDw81akbZpQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204955>

HP NonStop (currently) doesn't have setitimer(). The previous attempt of an
emulation (reverted by this commit) was not a real substitute for a recurring
itimer (as here we also don't have SA_RESTART, so can't re-arm the timer).
As setitimer() is only used in cases of perceived latency and it doesn't affect
correctness, it now gets disabled entirely, if NO_SETITIMER is set.
HP NonStop does provide struct itimerval, but other platforms may not, so this
is taken care of in this commit too, by setting NO_STRUCT_ITIMERVAL.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 Makefile          |  5 +++++
 compat/itimer.c   | 50 --------------------------------------------------
 git-compat-util.h | 11 +++++++++--
 3 files changed, 14 insertions(+), 52 deletions(-)
 delete mode 100644 compat/itimer.c

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
diff --git a/compat/itimer.c b/compat/itimer.c
deleted file mode 100644
index 713f1ff..0000000
--- a/compat/itimer.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include "../git-compat-util.h"
-
-static int git_getitimer(int which, struct itimerval *value)
-{
-	int ret = 0;
-
-	switch (which) {
-		case ITIMER_REAL:
-			value->it_value.tv_usec = 0;
-			value->it_value.tv_sec = alarm(0);
-			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
-			break;
-		case ITIMER_VIRTUAL: /* FALLTHRU */
-		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
-		default: errno = EINVAL; ret = -1;
-	}
-	return ret;
-}
-
-int git_setitimer(int which, const struct itimerval *value,
-				struct itimerval *ovalue)
-{
-	int ret = 0;
-
-	if (!value
-		|| value->it_value.tv_usec < 0
-		|| value->it_value.tv_usec > 1000000
-		|| value->it_value.tv_sec < 0) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	else if (ovalue)
-		if (!git_getitimer(which, ovalue))
-			return -1; /* errno set in git_getitimer() */
-
-	else
-	switch (which) {
-		case ITIMER_REAL:
-			alarm(value->it_value.tv_sec +
-				(value->it_value.tv_usec > 0) ? 1 : 0);
-			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
-			break;
-		case ITIMER_VIRTUAL: /* FALLTHRU */
-		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
-		default: errno = EINVAL; ret = -1;
-	}
-
-	return ret;
-}
diff --git a/git-compat-util.h b/git-compat-util.h
index 18089f0..4628d7a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,9 +162,16 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
+#ifdef NO_STRUCT_ITIMERVAL
+struct itimerval {
+	struct timeval it_interval;
+	struct timeval it_value;
+}
+#define NO_SETITIMER
+#endif
+
 #ifdef NO_SETITIMER
-#define setitimer(a,b,c) git_setitimer((a),(b),(c))
-extern int git_setitimer(int, const struct itimerval *, struct itimerval *);
+#define setitimer(which,value,ovalue)
 #endif
 
 #ifdef MKDIR_WO_TRAILING_SLASH
-- 
1.7.12
