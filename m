From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] chain kill signals for cleanup functions
Date: Sun, 11 Jan 2009 06:32:12 -0500
Message-ID: <20090111113211.GB29791@coredump.intra.peff.net>
References: <20090111112222.GA29656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLyZY-0001cy-LT
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZAKLcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZAKLcQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:32:16 -0500
Received: from peff.net ([208.65.91.99]:50625 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZAKLcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:32:14 -0500
Received: (qmail 22737 invoked by uid 107); 11 Jan 2009 11:32:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jan 2009 06:32:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jan 2009 06:32:12 -0500
Content-Disposition: inline
In-Reply-To: <20090111112222.GA29656@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105168>

If a piece of code wanted to do some cleanup before exiting
(e.g., cleaing up a lockfile or a tempfile), our usual
strategy was to install a signal handler that did something
like this:

  do_cleanup(); /* actual work */
  signal(signo, SIG_DFL); /* restore previous behavior */
  raise(signo); /* deliver signal, killing ourselves */

For a single handler, this works fine. However, if we want
to clean up two _different_ things, we run into a problem.
The most recently installed handler will run, but when it
removes itself as a handler, it doesn't put back the first
handler.

This patch introduces sigchain, a tiny library for handling
a stack of signal handlers. You sigchain_push each handler,
and use sigchain_pop to restore whoever was before you in
the stack.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know if it is possible to trigger this issue with current git or
not. There are several instances that catch signals in different ways,
but I don't know if there are code paths that actually combine them. So
maybe it is fixing a bug, but it is definitely needed for 4/4, which
will install the wait_for_pager handler in most git runs.

I tried to neither over- nor under-engineer. On one hand, you could
actually accomplish the same thing by always keeping a "this was the
last handler" pointer at each callsite when installing the new handler.
But it's easy to mess up, so I think a little library helps keep the
code clean.

On the other hand, callsites still have to have separate clean_foo() and
clean_foo_on_signal() handlers, and manually pop() and raise() in the
latter. If the code just assumed you always wanted to chain to the next
handler immediately, then we could cut out even more client code.

The test script is probably overkill, but I wrote it to convince myself
I hadn't screwed up too badly (and because we probably wouldn't even
notice, as signals aren't well tested in our scripts). So I figured I
might as well share it.

 .gitignore            |    1 +
 Makefile              |    3 +++
 builtin-clone.c       |    5 +++--
 builtin-fetch--tool.c |    5 +++--
 builtin-fetch.c       |    5 +++--
 diff.c                |    5 +++--
 http-push.c           |   11 ++++++-----
 lockfile.c            |   13 +++++++------
 sigchain.c            |   43 +++++++++++++++++++++++++++++++++++++++++++
 sigchain.h            |    9 +++++++++
 t/t0005-signals.sh    |   18 ++++++++++++++++++
 test-sigchain.c       |   22 ++++++++++++++++++++++
 12 files changed, 121 insertions(+), 19 deletions(-)
 create mode 100644 sigchain.c
 create mode 100644 sigchain.h
 create mode 100755 t/t0005-signals.sh
 create mode 100644 test-sigchain.c

diff --git a/.gitignore b/.gitignore
index d9adce5..f28a54d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,6 +152,7 @@ test-match-trees
 test-parse-options
 test-path-utils
 test-sha1
+test-sigchain
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 2b873fa..fd02dec 100644
--- a/Makefile
+++ b/Makefile
@@ -388,6 +388,7 @@ LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
+LIB_H += sigchain.h
 LIB_H += strbuf.h
 LIB_H += tag.h
 LIB_H += transport.h
@@ -481,6 +482,7 @@ LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
+LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
@@ -1364,6 +1366,7 @@ TEST_PROGRAMS += test-match-trees$X
 TEST_PROGRAMS += test-parse-options$X
 TEST_PROGRAMS += test-path-utils$X
 TEST_PROGRAMS += test-sha1$X
+TEST_PROGRAMS += test-sigchain$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/builtin-clone.c b/builtin-clone.c
index f1a1a0c..18b9392 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -19,6 +19,7 @@
 #include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
+#include "sigchain.h"
 
 /*
  * Overall FIXMEs:
@@ -288,7 +289,7 @@ static void remove_junk(void)
 static void remove_junk_on_signal(int signo)
 {
 	remove_junk();
-	signal(SIGINT, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -438,7 +439,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	junk_git_dir = git_dir;
 	atexit(remove_junk);
-	signal(SIGINT, remove_junk_on_signal);
+	sigchain_push(SIGINT, remove_junk_on_signal);
 
 	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
 
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 469b07e..b1d7f8f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
+#include "sigchain.h"
 
 static char *get_stdin(void)
 {
@@ -186,7 +187,7 @@ static void remove_keep(void)
 static void remove_keep_on_signal(int signo)
 {
 	remove_keep();
-	signal(SIGINT, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -245,7 +246,7 @@ static int fetch_native_store(FILE *fp,
 	char buffer[1024];
 	int err = 0;
 
-	signal(SIGINT, remove_keep_on_signal);
+	sigchain_push(SIGINT, remove_keep_on_signal);
 	atexit(remove_keep);
 
 	while (fgets(buffer, sizeof(buffer), stdin)) {
diff --git a/builtin-fetch.c b/builtin-fetch.c
index de6f307..8c86974 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -10,6 +10,7 @@
 #include "transport.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "sigchain.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
@@ -58,7 +59,7 @@ static void unlock_pack(void)
 static void unlock_pack_on_signal(int signo)
 {
 	unlock_pack();
-	signal(SIGINT, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -672,7 +673,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		ref_nr = j;
 	}
 
-	signal(SIGINT, unlock_pack_on_signal);
+	sigchain_push(SIGINT, unlock_pack_on_signal);
 	atexit(unlock_pack);
 	exit_code = do_fetch(transport,
 			parse_fetch_refspec(ref_nr, refs), ref_nr);
diff --git a/diff.c b/diff.c
index d235482..5a74012 100644
--- a/diff.c
+++ b/diff.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "utf8.h"
 #include "userdiff.h"
+#include "sigchain.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1933,7 +1934,7 @@ static void remove_tempfile(void)
 static void remove_tempfile_on_signal(int signo)
 {
 	remove_tempfile();
-	signal(SIGINT, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -1968,7 +1969,7 @@ static void run_external_diff(const char *pgm,
 			atexit_asked = 1;
 			atexit(remove_tempfile);
 		}
-		signal(SIGINT, remove_tempfile_on_signal);
+		sigchain_push(SIGINT, remove_tempfile_on_signal);
 	}
 
 	if (one && two) {
diff --git a/http-push.c b/http-push.c
index a4b7d08..dec395d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -10,6 +10,7 @@
 #include "exec_cmd.h"
 #include "remote.h"
 #include "list-objects.h"
+#include "sigchain.h"
 
 #include <expat.h>
 
@@ -1363,7 +1364,7 @@ static void remove_locks(void)
 static void remove_locks_on_signal(int signo)
 {
 	remove_locks();
-	signal(signo, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -2261,10 +2262,10 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
-	signal(SIGINT, remove_locks_on_signal);
-	signal(SIGHUP, remove_locks_on_signal);
-	signal(SIGQUIT, remove_locks_on_signal);
-	signal(SIGTERM, remove_locks_on_signal);
+	sigchain_push(SIGINT, remove_locks_on_signal);
+	sigchain_push(SIGHUP, remove_locks_on_signal);
+	sigchain_push(SIGQUIT, remove_locks_on_signal);
+	sigchain_push(SIGTERM, remove_locks_on_signal);
 
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
diff --git a/lockfile.c b/lockfile.c
index 8589155..3cd57dc 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2005, Junio C Hamano
  */
 #include "cache.h"
+#include "sigchain.h"
 
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
@@ -24,7 +25,7 @@ static void remove_lock_file(void)
 static void remove_lock_file_on_signal(int signo)
 {
 	remove_lock_file();
-	signal(signo, SIG_DFL);
+	sigchain_pop(signo);
 	raise(signo);
 }
 
@@ -136,11 +137,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
-			signal(SIGINT, remove_lock_file_on_signal);
-			signal(SIGHUP, remove_lock_file_on_signal);
-			signal(SIGTERM, remove_lock_file_on_signal);
-			signal(SIGQUIT, remove_lock_file_on_signal);
-			signal(SIGPIPE, remove_lock_file_on_signal);
+			sigchain_push(SIGINT, remove_lock_file_on_signal);
+			sigchain_push(SIGHUP, remove_lock_file_on_signal);
+			sigchain_push(SIGTERM, remove_lock_file_on_signal);
+			sigchain_push(SIGQUIT, remove_lock_file_on_signal);
+			sigchain_push(SIGPIPE, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
diff --git a/sigchain.c b/sigchain.c
new file mode 100644
index 0000000..a18d505
--- /dev/null
+++ b/sigchain.c
@@ -0,0 +1,43 @@
+#include "sigchain.h"
+#include "cache.h"
+
+#define SIGCHAIN_MAX_SIGNALS 32
+
+struct sigchain_signal {
+	sigchain_fun *old;
+	int n;
+	int alloc;
+};
+static struct sigchain_signal signals[SIGCHAIN_MAX_SIGNALS];
+
+static void check_signum(int sig)
+{
+	if (sig < 1 || sig >= SIGCHAIN_MAX_SIGNALS)
+		die("BUG: signal out of range: %d", sig);
+}
+
+int sigchain_push(int sig, sigchain_fun f)
+{
+	struct sigchain_signal *s = signals + sig;
+	check_signum(sig);
+
+	ALLOC_GROW(s->old, s->n + 1, s->alloc);
+	s->old[s->n] = signal(sig, f);
+	if (s->old[s->n] == SIG_ERR)
+		return -1;
+	s->n++;
+	return 0;
+}
+
+int sigchain_pop(int sig)
+{
+	struct sigchain_signal *s = signals + sig;
+	check_signum(sig);
+	if (s->n < 1)
+		return 0;
+
+	if (signal(sig, s->old[s->n - 1]) == SIG_ERR)
+		return -1;
+	s->n--;
+	return 0;
+}
diff --git a/sigchain.h b/sigchain.h
new file mode 100644
index 0000000..254ebb0
--- /dev/null
+++ b/sigchain.h
@@ -0,0 +1,9 @@
+#ifndef SIGCHAIN_H
+#define SIGCHAIN_H
+
+typedef void (*sigchain_fun)(int);
+
+int sigchain_push(int sig, sigchain_fun f);
+int sigchain_pop(int sig);
+
+#endif /* SIGCHAIN_H */
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
new file mode 100755
index 0000000..d900df4
--- /dev/null
+++ b/t/t0005-signals.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='signals work as we expect'
+. ./test-lib.sh
+
+cat >expect <<EOF
+three
+two
+one
+EOF
+
+test_expect_success 'sigchain works' '
+  test-sigchain >actual
+  test "$?" = 130 &&
+  test_cmp expect actual
+'
+
+test_done
diff --git a/test-sigchain.c b/test-sigchain.c
new file mode 100644
index 0000000..8747dea
--- /dev/null
+++ b/test-sigchain.c
@@ -0,0 +1,22 @@
+#include "sigchain.h"
+#include "cache.h"
+
+#define X(f) \
+static void f(int sig) { \
+	puts(#f); \
+	fflush(stdout); \
+	sigchain_pop(sig); \
+	raise(sig); \
+}
+X(one)
+X(two)
+X(three)
+#undef X
+
+int main(int argc, char **argv) {
+	sigchain_push(SIGINT, one);
+	sigchain_push(SIGINT, two);
+	sigchain_push(SIGINT, three);
+	raise(SIGINT);
+	return 0;
+}
-- 
1.6.1.84.g8150
