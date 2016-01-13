From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/5] compat/mingw: support MSys2-based MinGW build
Date: Wed, 13 Jan 2016 14:31:09 +0100 (CET)
Message-ID: <5f66f66d4f3b693076bdf40cccfebd0ab032c779.1452691805.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:31:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLWF-0002Xz-7W
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760676AbcAMNbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:31:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:60855 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760653AbcAMNbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:31:15 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MZOan-1acGNH1YFh-00LH1L; Wed, 13 Jan 2016 14:31:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ZabUYx4Fev9TRWDV0boHIar89Qj2wpdYrHQSW5B2+pH3t8gxsFH
 7KgfUmIUkEA3XzD/1cEIzlsGAUWfX/8KN12MzGpp6wWW8ZsDW+e7GsgHmDhm/FC59t5QmSB
 ff0Cz116Onn5NLN7sLKJWa4+sGvoKpb/aDNqUaHO5Z7uJac7jWZQNDEfmCAi/Nfnh0Rr+3m
 k/nKhRWg1ac8SsjxqSmng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6axf/NLcds=:n853n7gVGJC+JtewklEcLb
 /Ip+OUR/RetohEr/lvf8EHHN5BVxiGuX3VhjwcvgbG9NVwpcx6QACHRhLQUj2s6JEFO5u2+l4
 9nJ8HP+3J2npKmGXR/T7my2gQbZNr5xFtK2TeGJ5fRbrCTGJ+O3rhlf7LiLsyABlwgmuij9RA
 PYgLtwln0ZZ+A/XMOfFG+cmwPqcMhSwMOcyKQ4SxO04Ckvv8CTpIge5F85xZJUGAwXNhu1n7M
 /aG/IjxfFwyM7rxr8v0hU2kXmb042szLoeA68qh3ReWJPvJe+KttGwsx6oiZIEt7DVMtF81q4
 h/NY+BpWCibVbyVrf+lINqtP2J8dq/cuDBUUPTcMlQnLNQX09heV5VDGctwtyu4ZUH8pqt1iX
 81GwLd0PixdFSMt4PTkOF3IoArhoO1fpAaF2gz62MewLxok3MtXIryRABGrunwfg31wp4+ipL
 cmo7DiT0OwNagtPpNAnb9mQkJ/uOUnGWosEN+sqYKInQKZA/S8yIvMy/ANQuuOPevdGO+vdkz
 txd0VQ5e7wfb1fHBsZyipwH6wJvEx27pB3DZl2bZXcJirjj401ffpKUZfrjseMtdqu0fAL4Ni
 sdmSCqFN6pR30eTetrlcPjNVnHg2BNjLknWuUwlAm6WRY7+p8vQcDtEG7V0xBigZ+xWjzUFHJ
 FMkrHrje0OidaKveFKooDx5riV7SrJUqWGPeO35xTFu4/NvLedlpVRAxQmptEeEgpzDCEtfOi
 bIqE5xxIZ2+DwKvAJ2DI5XVx3o6pRiLlwkXYI9y9iNfjmqxk3lRE559JPO9aLemDKgBytpbW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283916>

The excellent MSys2 project brings a substantially updated MinGW
environment including newer GCC versions and new headers. To support
compiling Git, let's special-case the new MinGW (tell-tale: the
_MINGW64_VERSION_MAJOR constant is defined).

Note: this commit only addresses compile failures, not compile warnings
(that task is left for a future patch).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index b3e5044..a2da783 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,14 +1,26 @@
+#ifdef __MINGW64_VERSION_MAJOR
+#include <stdint.h>
+#include <wchar.h>
+typedef _sigset_t sigset_t;
+#endif
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
+/* MinGW-w64 reports to have flockfile, but it does not actually have it. */
+#ifdef __MINGW64_VERSION_MAJOR
+#undef _POSIX_THREAD_SAFE_FUNCTIONS
+#endif
+
 /*
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
+#ifndef __MINGW64_VERSION_MAJOR
+typedef int pid_t;
 #define hstrerror strerror
+#endif
 
 #define S_IFLNK    0120000 /* Symbolic link */
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
@@ -100,8 +112,10 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
+#ifndef __MINGW64_VERSION_MAJOR
 static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
+#endif
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
@@ -176,8 +190,10 @@ int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
+#ifndef __MINGW64_VERSION_MAJOR
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
+#endif
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
 struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
@@ -301,8 +317,10 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 /*
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
+#ifndef __MINGW64_VERSION_MAJOR
 #define off_t off64_t
 #define lseek _lseeki64
+#endif
 
 /* use struct stat with 64 bit st_size */
 #ifdef stat
@@ -383,8 +401,12 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
+#ifndef __MINGW64_VERSION_MAJOR
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
+#else
+#include <inttypes.h>
+#endif
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
-- 
2.6.3.windows.1.300.g1c25e49
