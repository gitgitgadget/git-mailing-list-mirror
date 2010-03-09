From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 7/6] Enable threaded async procedures whenever pthreads is available
Date: Tue, 9 Mar 2010 21:00:36 +0100
Message-ID: <201003092100.36616.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <7vk4tpdx9x.fsf@alter.siamese.dyndns.org> <20100306215051.GE2529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 09 21:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np5dQ-0004Y6-MS
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 21:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab0CIUC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 15:02:28 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:45916 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752218Ab0CIUC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 15:02:27 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B7D1610017;
	Tue,  9 Mar 2010 21:02:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B263219F5AA;
	Tue,  9 Mar 2010 21:00:36 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100306215051.GE2529@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141845>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Samstag, 6. M=E4rz 2010, Shawn O. Pearce wrote:
> I'm in favor of that.  If we have threaded delta search enabled,
> we probably can also run these async procedures in a POSIX thread
> rather than forking off a child.

OK. The patch could look like this.

-- Hannes

 Documentation/technical/api-run-command.txt |    5 +++--
 Makefile                                    |    5 -----
 run-command.c                               |    6 +++---
 run-command.h                               |    4 ++--
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentatio=
n/technical/api-run-command.txt
index 44876fa..f18b4f4 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -231,8 +231,9 @@ The function pointer in .proc has the following sig=
nature:
=20
=20
 There are serious restrictions on what the asynchronous function can d=
o
-because this facility is implemented by a pipe to a forked process on
-UNIX, but by a thread in the same address space on Windows:
+because this facility is implemented by a thread in the same address
+space on most platforms (when pthreads is available), but by a pipe to
+a forked process otherwise:
=20
 . It cannot change the program's state (global variables, environment,
   etc.) in a way that the caller notices; in other words, .in and .out
diff --git a/Makefile b/Makefile
index 2fe52f8..52f2cc0 100644
--- a/Makefile
+++ b/Makefile
@@ -979,7 +979,6 @@ ifeq ($(uname_S),Windows)
 	NO_CURL =3D YesPlease
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
-	ASYNC_AS_THREAD =3D YesPlease
=20
 	CC =3D compat/vcbuild/scripts/clink.pl
 	AR =3D compat/vcbuild/scripts/lib.pl
@@ -1031,7 +1030,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX =3D YesPlease
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
-	ASYNC_AS_THREAD =3D YesPlease
 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnm=
atch -Icompat/win32
 	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
 	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winan=
si.o \
@@ -1344,9 +1342,6 @@ ifdef NO_PTHREADS
 else
 	EXTLIBS +=3D $(PTHREAD_LIBS)
 	LIB_OBJS +=3D thread-utils.o
-ifdef ASYNC_AS_THREAD
-	BASIC_CFLAGS +=3D -DASYNC_AS_THREAD
-endif
 endif
=20
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
diff --git a/run-command.c b/run-command.c
index 66cc4bf..053b28f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -447,7 +447,7 @@ int run_command_v_opt_cd_env(const char **argv, int=
 opt, const char *dir, const
 	return run_command(&cmd);
 }
=20
-#ifdef ASYNC_AS_THREAD
+#ifndef NO_PTHREADS
 static pthread_t main_thread;
 static int main_thread_set;
 static pthread_key_t async_key;
@@ -521,7 +521,7 @@ int start_async(struct async *async)
 	else
 		proc_out =3D -1;
=20
-#ifndef ASYNC_AS_THREAD
+#ifdef NO_PTHREADS
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
=20
@@ -590,7 +590,7 @@ error:
=20
 int finish_async(struct async *async)
 {
-#ifndef ASYNC_AS_THREAD
+#ifdef NO_PTHREADS
 	return wait_or_whine(async->pid, "child process", 0);
 #else
 	void *ret =3D (void *)(intptr_t)(-1);
diff --git a/run-command.h b/run-command.h
index 40db39c..56491b9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,7 +1,7 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
=20
-#ifdef ASYNC_AS_THREAD
+#ifndef NO_PTHREADS
 #include <pthread.h>
 #endif
=20
@@ -78,7 +78,7 @@ struct async {
 	void *data;
 	int in;		/* caller writes here and closes it */
 	int out;	/* caller reads from here and closes it */
-#ifndef ASYNC_AS_THREAD
+#ifdef NO_PTHREADS
 	pid_t pid;
 #else
 	pthread_t tid;
--=20
1.7.0.rc2.65.g7b13a
