From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Fri, 25 Jan 2013 17:03:59 -0800
Message-ID: <20130126010359.GH3341@elie.Belkin>
References: <50EB8EB5.6080204@gmail.com>
 <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
 <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
 <50F303D8.20709@gmail.com>
 <50F5A435.5090408@ramsay1.demon.co.uk>
 <20130120101007.GD16339@elie.Belkin>
 <50FEDB08.6030901@ramsay1.demon.co.uk>
 <51031C43.5030307@gmail.com>
 <7v38xo3irh.fsf@alter.siamese.dyndns.org>
 <51032481.4030707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 02:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyuC5-0000nA-Su
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 02:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab3AZBEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 20:04:08 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35466 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3AZBEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 20:04:07 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so564348pad.27
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 17:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=awL4Yg3hOXUCMM472vObBDc0cM29/qW+HrnJZuaIzTw=;
        b=HHLqfvu1wk8qOq5jcr42vd8MsKwcZ1dLsrOkhDVBoY+VruvIU3vK9tgxa5WfomZp95
         rZGTw/D1/AY4y8sxiJmDsyRhbdxaxxMZj0fCWOiI6GSEcHkaCMUAmyIQmz/bhxMmDNK+
         dNxZCqVDDR2SoRFcZmEd/S9JAghC7e5wFlm3IfaNY3rPWIij41QiB3FWDF41Mz18cMfE
         4L9BJQTe2fezhMkPq6EwTwTtXLPJbCjnOJCDS64vKPFQXRTBOP0uki65dp4nuf7sBhg2
         xTPfhwFA51dZqYRL0bGTkP5FP0IGRldjqt+NsjzR1q0r2bNV2sDTPE7Vg/S+uio8Lj07
         R6/A==
X-Received: by 10.66.85.103 with SMTP id g7mr17663068paz.45.1359162245603;
        Fri, 25 Jan 2013 17:04:05 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id l5sm1821551pax.10.2013.01.25.17.04.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 17:04:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51032481.4030707@redhat.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214605>

Throughout git, it is assumed that the WIN32 preprocessor symbol is
defined on native Windows setups (mingw and msvc) and not on Cygwin.
On Cygwin, most of the time git can pretend this is just another Unix
machine, and Windows-specific magic is generally counterproductive.

Unfortunately Cygwin *does* define the WIN32 symbol in some headers.
Best to rely on a new git-specific symbol NATIVE_WINDOWS instead,
defined as follows:

	#if defined(WIN32) && !defined(__CYGWIN__)
	# define NATIVE_WINDOWS
	#endif

After this change, it should be possible to drop the
CYGWIN_V15_WIN32API setting without any negative effect.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eric Blake wrote:

> Which is why other projects, like gnulib, have
>
> # if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
>
> all over the place.

So, how about this?

Completely untested.

 abspath.c         |  2 +-
 compat/terminal.c |  4 ++--
 compat/win32.h    |  2 +-
 diff-no-index.c   |  2 +-
 git-compat-util.h |  3 ++-
 help.c            |  2 +-
 run-command.c     | 10 +++++-----
 test-chmtime.c    |  2 +-
 thread-utils.c    |  2 +-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/abspath.c b/abspath.c
index 40cdc462..c7d5458e 100644
--- a/abspath.c
+++ b/abspath.c
@@ -216,7 +216,7 @@ const char *absolute_path(const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
diff --git a/compat/terminal.c b/compat/terminal.c
index 9b5e3d1b..136e4a74 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -3,7 +3,7 @@
 #include "sigchain.h"
 #include "strbuf.h"
 
-#if defined(HAVE_DEV_TTY) || defined(WIN32)
+#if defined(HAVE_DEV_TTY) || defined(WINDOWS_NATIVE)
 
 static void restore_term(void);
 
@@ -53,7 +53,7 @@ error:
 	return -1;
 }
 
-#elif defined(WIN32)
+#elif defined(WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
 #define OUTPUT_PATH "CONOUT$"
diff --git a/compat/win32.h b/compat/win32.h
index 8ce91048..31dd30f7 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,7 +2,7 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
-#ifndef WIN32         /* Not defined by Cygwin */
+#ifndef WINDOWS_NATIVE	/* Not defined for Cygwin */
 #include <windows.h>
 #endif
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 74da6593..a0bc9c50 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -45,7 +45,7 @@ static int get_mode(const char *path, int *mode)
 
 	if (!path || !strcmp(path, "/dev/null"))
 		*mode = 0;
-#ifdef _WIN32
+#ifdef WINDOWS_NATIVE
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e5a4b745..ebbdff53 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,10 +85,11 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
+#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#define WINDOWS_NATIVE
 #endif
 
 #include <unistd.h>
diff --git a/help.c b/help.c
index 2a42ec6d..cc1e63f7 100644
--- a/help.c
+++ b/help.c
@@ -106,7 +106,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#if defined(WIN32) || defined(__CYGWIN__)
+#if defined(WINDOWS_NATIVE) || defined(__CYGWIN__)
 #if defined(__CYGWIN__)
 if ((st.st_mode & S_IXUSR) == 0)
 #endif
diff --git a/run-command.c b/run-command.c
index 04712191..04ac6181 100644
--- a/run-command.c
+++ b/run-command.c
@@ -72,7 +72,7 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
@@ -159,7 +159,7 @@ static const char **prepare_shell_cmd(const char **argv)
 		die("BUG: shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 		nargv[nargc++] = SHELL_PATH;
 #else
 		nargv[nargc++] = "sh";
@@ -182,7 +182,7 @@ static const char **prepare_shell_cmd(const char **argv)
 	return nargv;
 }
 
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
@@ -193,7 +193,7 @@ static int execv_shell_cmd(const char **argv)
 }
 #endif
 
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 static int child_err = 2;
 static int child_notifier = -1;
 
@@ -330,7 +330,7 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 	fflush(NULL);
 
-#ifndef WIN32
+#ifndef WINDOWS_NATIVE
 {
 	int notify_pipe[2];
 	if (pipe(notify_pipe))
diff --git a/test-chmtime.c b/test-chmtime.c
index 92713d16..803b6055 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -87,7 +87,7 @@ int main(int argc, const char *argv[])
 			return -1;
 		}
 
-#ifdef WIN32
+#ifdef WINDOWS_NATIVE
 		if (!(sb.st_mode & S_IWUSR) &&
 				chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
diff --git a/thread-utils.c b/thread-utils.c
index 7f4b76a9..4c4cf2fa 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -24,7 +24,7 @@ int online_cpus(void)
 	long ncpus;
 #endif
 
-#ifdef _WIN32
+#ifdef WINDOWS_NATIVE
 	SYSTEM_INFO info;
 	GetSystemInfo(&info);
 
-- 
1.8.1.1
