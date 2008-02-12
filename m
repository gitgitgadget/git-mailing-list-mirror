From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 09:20:29 +0100
Message-ID: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqO7-0002n4-24
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYBLIUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYBLIUf
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:20:35 -0500
Received: from mail.op5.se ([193.201.96.20]:57879 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbYBLIUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:20:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 067E91F08850;
	Tue, 12 Feb 2008 09:20:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.25
X-Spam-Level: 
X-Spam-Status: No, score=-2.25 tagged_above=-10 required=6.6 tests=[AWL=0.249,
	BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jk3tzEfYHubf; Tue, 12 Feb 2008 09:20:31 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 1B6CC1F0884E;
	Tue, 12 Feb 2008 09:20:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73637>

Packing objects can be done in parallell nowadays, but it's
only done if the config option pack.threads is set to a value
above 1. Because of that, the code-path used is often not the
most optimal one.

This patch adds a routine to detect the number of online CPU's
at runtime (online_cpus()). When pack.threads (or --threads=) is
given a value of 0, the number of threads is set to the number of
online CPU's. This feature is also documented.

As per Nicolas Pitre's recommendations, the default is still to
run pack-objects single-threaded unless explicitly activated,
either by configuration or by command line parameter.

The routine online_cpus() is a rework of "numcpus.c", written by
one Philip Willoughby <pgw99@doc.ic.ac.uk>. numcpus.c is in the
public domain and can presently be downloaded from
http://csgsoft.doc.ic.ac.uk/numcpus/

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

This patch was built on todays master as of 5 minutes ago
(40aab8119f38c622f58d8e612e7a632eb1f3ded2).
As far as I understood all of Nicolas' comments to my original
patch and the one sent in by Mr Casey, this implements all the
suggestions made to both sets.

 Documentation/config.txt           |    2 +
 Documentation/git-pack-objects.txt |    2 +
 Makefile                           |    2 +-
 builtin-pack-objects.c             |   13 ++++++-----
 thread-utils.c                     |   39 ++++++++++++++++++++++++++++++++++++
 thread-utils.h                     |   19 +++++++++++++++++
 6 files changed, 70 insertions(+), 7 deletions(-)
 create mode 100644 thread-utils.c
 create mode 100644 thread-utils.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f9bdb16..e9f26ed 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -756,6 +756,8 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
 
 pack.indexVersion::
 	Specify the default pack index version.  Valid values are 1 for
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8353be1..5c1bd3b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -177,6 +177,8 @@ base-name::
 	This is meant to reduce packing time on multiprocessor machines.
 	The required amount of memory for the delta search window is
 	however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
 
 --index-version=<version>[,<offset>]::
 	This is intended to be used by the test suite only. It allows
diff --git a/Makefile b/Makefile
index 92341c4..9ea378a 100644
--- a/Makefile
+++ b/Makefile
@@ -306,7 +306,7 @@ DIFF_OBJS = \
 
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
-	date.o diff-delta.o entry.o exec_cmd.o ident.o \
+	date.o diff-delta.o entry.o exec_cmd.o ident.o thread-utils.o \
 	pretty.o interpolate.o hash.o \
 	lockfile.o \
 	patch-ids.o \
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index acb0555..a7ffb53 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -14,10 +14,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "progress.h"
-
-#ifdef THREADED_DELTA_SEARCH
-#include <pthread.h>
-#endif
+#include "thread-utils.h"
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
@@ -1861,7 +1858,7 @@ static int git_pack_config(const char *k, const char *v)
 	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
-		if (delta_search_threads < 1)
+		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
 #ifndef THREADED_DELTA_SEARCH
@@ -2076,6 +2073,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
+	if (!delta_search_threads)	/* --threads=0 means autodetect */
+		delta_search_threads = online_cpus();
+
 	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -2130,7 +2130,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--threads=")) {
 			char *end;
 			delta_search_threads = strtoul(arg+10, &end, 0);
-			if (!arg[10] || *end || delta_search_threads < 1)
+
+			if (!arg[10] || *end || delta_search_threads < 0)
 				usage(pack_usage);
 #ifndef THREADED_DELTA_SEARCH
 			if (delta_search_threads > 1)
diff --git a/thread-utils.c b/thread-utils.c
new file mode 100644
index 0000000..b19243c
--- /dev/null
+++ b/thread-utils.c
@@ -0,0 +1,39 @@
+#include "thread-utils.h"
+
+/*
+ * By doing this in two steps we can at least get
+ * get the function to be somewhat coherent, even
+ * with this disgusting nest of #ifdefs.
+ */
+#ifndef _SC_NPROCESSORS_ONLN
+# ifdef _SC_NPROC_ONLN
+#  define _SC_NPROCESSORS_ONLN _SC_NPROC_ONLN
+# elif defined _SC_CRAY_NCPU
+#  define _SC_NPROCESSORS_ONLN _SC_CRAY_NCPU
+# endif
+#endif
+int online_cpus(void)
+{
+#ifdef THREADED_DELTA_SEARCH
+# ifdef _SC_NPROCESSORS_ONLN
+	long ncpus;
+
+	if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
+		return (int)ncpus;
+# else
+#  ifdef _WIN32
+	SYSTEM_INFO info;
+	GetSystemInfo(&info);
+
+	return (int)info.dwNumberOfProcessors;
+#  endif /* _WIN32 */
+#  if defined(hpux) || defined(__hpux) || defined(_hpux)
+	struct pst_dynamic psd;
+
+	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))
+		return (int)psd.psd_proc_cnt;
+#  endif /* hpux */
+# endif /* _SC_NPROCESSORS_ONLN */
+#endif /* THREADED_DELTA_SEARCH */
+	return 1;
+}
diff --git a/thread-utils.h b/thread-utils.h
new file mode 100644
index 0000000..53754b3
--- /dev/null
+++ b/thread-utils.h
@@ -0,0 +1,19 @@
+#ifndef THREAD_COMPAT_H
+#define THREAD_COMPAT_H
+
+#include "cache.h"
+
+#ifdef THREADED_DELTA_SEARCH
+#include <pthread.h>
+# ifdef _WIN32
+#  define WIN32_LEAN_AND_MEAN
+# include <windows.h>
+# endif
+# if defined(hpux) || defined(__hpux) || defined(_hpux)
+#  include <sys/pstat.h>
+# endif
+#endif
+
+extern int online_cpus(void);
+
+#endif /* THREAD_COMPAT_H */
-- 
1.5.4.rc5.11.g0eab8


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
