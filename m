From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sat, 14 Apr 2012 20:29:07 +0200
Message-ID: <20120414182907.GA3915@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7k0-0005BT-AN
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 20:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab2DNSa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 14:30:27 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:24891 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754634Ab2DNSa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 14:30:26 -0400
Received: (qmail 11010 invoked from network); 14 Apr 2012 18:30:23 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL505.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub78.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <zbyszek@in.waw.pl>; 14 Apr 2012 18:30:20 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195501>

The shell script which is currently used to parse git daemon output does
not seem to work unreliably. In order to work around such issues,
re-implement the same procedure in C and write the daemon pid to a file.

This means that we can no longer wait on the daemon process, since it is
no longer a direct child of the shell process.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Does this patch improve your situation?

Note that t5570 fails on current pu, because of the push.default
warnings. I am sending an independent patch for that.

Clemens

 .gitignore          |    1 +
 Makefile            |    1 +
 cache.h             |    1 +
 t/lib-git-daemon.sh |   30 +++-------------------
 test-git-daemon.c   |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 wrapper.c           |   21 +++++++++++++++
 6 files changed, 99 insertions(+), 26 deletions(-)
 create mode 100644 test-git-daemon.c

diff --git a/.gitignore b/.gitignore
index 87fcc5f..18a484c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /test-dump-cache-tree
 /test-scrap-cache-tree
 /test-genrandom
+/test-git-daemon
 /test-index-version
 /test-line-buffer
 /test-match-trees
diff --git a/Makefile b/Makefile
index be1957a..7317daa 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-git-daemon
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
diff --git a/cache.h b/cache.h
index e5e1aa4..6351c15 100644
--- a/cache.h
+++ b/cache.h
@@ -1176,6 +1176,7 @@ extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 extern void fsync_or_die(int fd, const char *);
 
+extern ssize_t read_line(int fd, void *buf, size_t count);
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 static inline ssize_t write_str_in_full(int fd, const char *str)
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index ef2d01f..9fefae1 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -23,27 +23,13 @@ start_git_daemon() {
 	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
 
 	say >&3 "Starting git daemon ..."
-	mkfifo git_daemon_output
-	git daemon --listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
+	test-git-daemon --listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
 		--reuseaddr --verbose \
 		--base-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
-		>&3 2>git_daemon_output &
-	GIT_DAEMON_PID=$!
-	{
-		read line
-		echo >&4 "$line"
-		cat >&4 &
-
-		# Check expected output
-		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
-		then
-			kill "$GIT_DAEMON_PID"
-			wait "$GIT_DAEMON_PID"
-			trap 'die' EXIT
-			error "git daemon failed to start"
-		fi
-	} <git_daemon_output
+		>&3 2>&4 ||
+		error "git daemon failed to start"
+	GIT_DAEMON_PID=$(cat git-daemon.pid)
 }
 
 stop_git_daemon() {
@@ -57,13 +43,5 @@ stop_git_daemon() {
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
-	# expect exit with status 143 = 128+15 for signal TERM=15
-	if test $ret -ne 143
-	then
-		error "git daemon exited with status: $ret"
-	fi
 	GIT_DAEMON_PID=
-	rm -f git_daemon_output
 }
diff --git a/test-git-daemon.c b/test-git-daemon.c
new file mode 100644
index 0000000..323bb65
--- /dev/null
+++ b/test-git-daemon.c
@@ -0,0 +1,71 @@
+#include "git-compat-util.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+#include "strbuf.h"
+#include "cache.h"
+#include <string.h>
+#include <errno.h>
+
+static int parse_daemon_output(char *s)
+{
+	if (*s++ != '[')
+		return 1;
+	s = strchr(s, ']');
+	if (!s)
+		return 1;
+	if (strcmp(s, "] Ready to rumble\n"))
+		return 1;
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	FILE *fp;
+	struct child_process proc, cat;
+	char *cat_argv[] = { "cat", NULL };
+	int parse_error;
+	char buf[PATH_MAX];
+	int r;
+
+	setup_path();
+
+	memset(&proc, 0, sizeof(proc));
+	argv[0] = "git-daemon";
+	proc.argv = (const char **)argv;
+	proc.no_stdin = 1;
+	proc.err = -1;
+
+	if (start_command(&proc) < 0)
+		return 1;
+
+	r = read_line(proc.err, buf, sizeof(buf));
+	if (r < 0) {
+		finish_command(&proc);
+		return 1;
+	}
+	fprintf(stderr, "%s", buf);
+
+	parse_error = parse_daemon_output(buf);
+
+	memset(&cat, 0, sizeof(cat));
+	cat.argv = (const char **)cat_argv;
+	cat.in = proc.err;
+	cat.out = 2;
+
+	if (start_command(&cat) < 0)
+		return 1;
+
+	if (parse_error) {
+		kill(proc.pid, SIGTERM);
+		finish_command(&proc);
+		finish_command(&cat);
+		return 1;
+	}
+
+	fp = fopen("git-daemon.pid", "w");
+	fprintf(fp, "%"PRIuMAX"\n", (uintmax_t)proc.pid);
+	fclose(fp);
+
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 85f09df..7bf6dda 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -141,6 +141,27 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+ssize_t read_line(int fd, void *buf, size_t count)
+{
+	char *p = buf;
+	ssize_t total = 0;
+
+	while (count > 0) {
+		ssize_t loaded = xread(fd, p, 1);
+		if (loaded < 0)
+			return -1;
+		if (loaded == 0)
+			return total;
+		count -= loaded;
+		total += loaded;
+		if (*p == '\n')
+			break;
+		p += loaded;
+	}
+
+	return total;
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-- 
1.7.9.6
