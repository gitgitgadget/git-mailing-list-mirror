From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pager_in_use: make sure output is still going to pager
Date: Mon, 10 Aug 2015 01:23:54 -0400
Message-ID: <20150810052353.GB15441@sigill.intra.peff.net>
References: <20150810051901.GA9262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 07:24:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOfZ7-00086O-EC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 07:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbbHJFX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 01:23:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:42777 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbbHJFX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 01:23:59 -0400
Received: (qmail 15013 invoked by uid 102); 10 Aug 2015 05:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 00:23:59 -0500
Received: (qmail 2125 invoked by uid 107); 10 Aug 2015 05:24:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 01:24:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 01:23:54 -0400
Content-Disposition: inline
In-Reply-To: <20150810051901.GA9262@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275564>

When we start a pager, we set GIT_PAGER_IN_USE=1 in the
environment. This lets sub-processes know that even though
isatty(1) is not true, it is because it is connected to a
pager (and we should still turn on human-readable niceties
like auto-color).

Unfortunately, this is too inclusive for scripts which
invoke git sub-programs with their stdout going somewhere
else. For example, if you run "git -p pull rebase", git-pull
will invoke "git rebase", which invokes:

  git format-patch ... >rebased-patches

This format-patch process knows that its stdout is not a
tty, but because of GIT_PAGER_IN_USE it assumes this is
because stdout is going to a pager. As a result, it writes
colorized output, and the matching "git am" invocation
chokes on it, causing the rebase to fail.

We could work around this by passing "--no-color" to
format-patch, or by removing GIT_PAGER_IN_USE from the
environment. But we should not have to do so; format-patch
should be able to realize that even though GIT_PAGER_IN_USE
is set, its stdout is not actually going to that pager.

For this simple case, format-patch could see that its output
is not even a pipe. But that would not catch a case like:

  git format-patch | some-program >rebased-patches

where it cannot distinguish between the pipe to the pager
and the pipe to some-program.

This patch solves it by actually noting the inode of the
pipe to the pager in the environment, which readers of
GIT_PAGER_IN_USE can check against their stdout. This
technically makes GIT_PAGER_IN_USE redundant (we can just
check the new GIT_PAGER_PIPE_ID), but we keep using both
variables for compatibility with external scripts:

  - scripts which check GIT_PAGER_IN_USE can continue to do
    so, and will just ignore the new pipe-id variable.
    Meaning they may accidentally turn on colors if their
    output is redirected to a file, but that is the same as
    today and we cannot fix that. We do not actively break
    them from showing colors when their stdout _does_ go to
    the pager.

  - scripts which set GIT_PAGER_IN_USE but not
    GIT_PAGER_PIPE_ID will continue to turn on colorization
    for git sub-commands (again, they do not benefit from
    the new code, but we are not making anything worse).

The inode-retrieval code itself is abstracted into compat/,
as different platforms may represent the pipe id
differently. These ids do not need to be portable across
systems, only within processes on the same system.

Note that there is an existing test in t7006 which tests for
the exact _opposite_ of what we are trying to achieve
(namely, that GIT_PAGER_IN_USE does _not_ cause us to write
colors to a random file). This test comes from a battery of
tests added by 60b6e22 (tests: Add tests for automatic use
of pager, 2010-02-19), and I think is simply misguided, as
evidenced by the real "git pull" bug above. If you want to
ensure colors in a file, you do it with "--color", not by
pretending you have a pager.

Rather than delete the test, though, we simply re-title it
here. It actually makes a good check of the "scripts which
set PAGER_IN_USE but not PAGER_PIPE_ID" historical
compatibility mentioned above.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Jonathan, whose test I am calling misguided above. :)

I dug in the list and could not find anything interesting said about
this particular one. The motivation for adding the tests was a
regression in git-svn, and we added a bunch of tests in response. I
doubt that you remember it well 5 years later, but it does not hurt to
check.

 Makefile         |  1 +
 compat/pipe-id.c | 25 +++++++++++++++++++++++++
 compat/pipe-id.h | 27 +++++++++++++++++++++++++++
 pager.c          | 16 +++++++++++++++-
 t/t7006-pager.sh | 20 +++++++++++++++++++-
 5 files changed, 87 insertions(+), 2 deletions(-)
 create mode 100644 compat/pipe-id.c
 create mode 100644 compat/pipe-id.h

diff --git a/Makefile b/Makefile
index 7efedbe..72f7b56 100644
--- a/Makefile
+++ b/Makefile
@@ -679,6 +679,7 @@ LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
+LIB_OBJS += compat/pipe-id.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
diff --git a/compat/pipe-id.c b/compat/pipe-id.c
new file mode 100644
index 0000000..4764c5f
--- /dev/null
+++ b/compat/pipe-id.c
@@ -0,0 +1,25 @@
+#include "git-compat-util.h"
+#include "compat/pipe-id.h"
+#include "strbuf.h"
+
+const char *pipe_id_get(int fd)
+{
+	static struct strbuf id = STRBUF_INIT;
+	struct stat st;
+
+	if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode))
+		return NULL;
+
+	strbuf_reset(&id);
+	strbuf_addf(&id, "%lu", (unsigned long)st.st_ino);
+	return id.buf;
+}
+
+int pipe_id_match(int fd, const char *id)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode))
+		return 0;
+	return st.st_ino == strtoul(id, NULL, 10);
+}
diff --git a/compat/pipe-id.h b/compat/pipe-id.h
new file mode 100644
index 0000000..5ddff2c
--- /dev/null
+++ b/compat/pipe-id.h
@@ -0,0 +1,27 @@
+#ifndef PIPE_ID_H
+#define PIPE_ID_H
+
+/**
+ * This module allows callers to save a string pipe identifier, and later find
+ * out whether a file descriptor refers to the same pipe.
+ *
+ * The ids should be opaque to the callers, as their implementation may be
+ * system dependent. The generated ids can be used between processes on the
+ * same system, but are not portable between systems, or even between different
+ * versions of git.
+ */
+
+/**
+ * Returns a string representing the pipe-id of the file descriptor `fd`, or
+ * NULL if an error occurs. Note that the return value may be invalidated by
+ * subsequent calls to pipe_id_get.
+ */
+const char *pipe_id_get(int fd);
+
+/**
+ * Returns 1 if the pipe at `fd` matches the id `id`, or 0 otherwise (or if an
+ * error occurs).
+ */
+int pipe_id_match(int fd, const char *id);
+
+#endif /* PIPE_ID_H */
diff --git a/pager.c b/pager.c
index e3ad465..de00def 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/pipe-id.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -57,6 +58,7 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
+	const char *pipe_id;
 
 	if (!pager)
 		return;
@@ -88,6 +90,10 @@ void setup_pager(void)
 		dup2(pager_process.in, 2);
 	close(pager_process.in);
 
+	pipe_id = pipe_id_get(1);
+	if (pipe_id)
+		setenv("GIT_PAGER_PIPE_ID", pipe_id, 1);
+
 	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
 	atexit(wait_for_pager);
@@ -95,7 +101,15 @@ void setup_pager(void)
 
 int pager_in_use(void)
 {
-	return git_env_bool("GIT_PAGER_IN_USE", 0);
+	const char *pipe_id;
+
+	if (!git_env_bool("GIT_PAGER_IN_USE", 0))
+		return 0;
+
+	pipe_id = getenv("GIT_PAGER_PIPE_ID");
+	if (!pipe_id) /* historical compatibility */
+		return 1;
+	return pipe_id_match(1, pipe_id);
 }
 
 /*
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 947b690..2f77299 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -158,7 +158,7 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 	! colorful paginated.out
 '
 
-test_expect_success 'color when writing to a file intended for a pager' '
+test_expect_success 'color goes to files when GIT_PAGER_PIPE_ID is not used' '
 	rm -f colorful.log &&
 	test_config color.ui auto &&
 	(
@@ -177,6 +177,24 @@ test_expect_success TTY 'colors are sent to pager for external commands' '
 	colorful paginated.out
 '
 
+test_expect_success TTY 'no color when paged program writes to file' '
+	test_config alias.externallog "!git log >log.out" &&
+	test_config color.ui auto &&
+	test_terminal env TERM=vt100 git -p externallog &&
+	test_line_count = 0 paginated.out &&
+	test -s log.out &&
+	! colorful log.out
+'
+
+test_expect_success TTY 'no color when paged program writes to pipe' '
+	test_config alias.externallog "!git log | cat >log.out" &&
+	test_config color.ui auto &&
+	test_terminal env TERM=vt100 git -p externallog &&
+	test_line_count = 0 paginated.out &&
+	test -s log.out &&
+	! colorful log.out
+'
+
 # Use this helper to make it easy for the caller of your
 # terminal-using function to specify whether it should fail.
 # If you write
-- 
2.5.0.414.g670f2a4
