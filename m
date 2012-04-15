From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v3] git-daemon wrapper to wait until daemon is ready
Date: Sun, 15 Apr 2012 13:53:22 +0200
Message-ID: <20120415115322.GA11786@ecki>
References: <20120414182907.GA3915@ecki>
 <4F89D1C6.8090705@kdbg.org>
 <20120414220606.GA18137@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJO2X-0000Xv-Jb
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2DOLyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:54:41 -0400
Received: from smtpout13.highway.telekom.at ([195.3.96.75]:61095 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752966Ab2DOLyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:54:40 -0400
Received: (qmail 18992 invoked from network); 15 Apr 2012 11:54:37 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL506.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub80.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <j6t@kdbg.org>; 15 Apr 2012 11:54:35 -0000
Content-Disposition: inline
In-Reply-To: <20120414220606.GA18137@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195562>

The shell script which is currently used to parse git daemon output does
not seem to work reliably. In order to work around such issues,
re-implement the same procedure in C and write the daemon pid to a file.

This means that we can no longer wait on the daemon process, since it is
no longer a direct child of the shell process.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Apr 15, 2012 at 12:06:06AM +0200, Clemens Buchacher wrote:
> On Sat, Apr 14, 2012 at 09:36:38PM +0200, Johannes Sixt wrote:
> > Am 14.04.2012 20:29, schrieb Clemens Buchacher:
> > > +	r = read_line(proc.err, buf, sizeof(buf));
> > 
> > We have strbuf_getwholeline_fd().
> 
> Thanks. Will fix.

Here's the re-roll for completeness. Still waiting on feedback from the
OP if this actually solves the problem, though.
 
 .gitignore          |    1 +
 Makefile            |    1 +
 t/lib-git-daemon.sh |   30 ++++---------------------
 test-git-daemon.c   |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 26 deletions(-)
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
index 0000000..f44fa6a
--- /dev/null
+++ b/test-git-daemon.c
@@ -0,0 +1,62 @@
+#include "git-compat-util.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+#include "strbuf.h"
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
+	struct strbuf line = STRBUF_INIT;
+	FILE *fp;
+	struct child_process proc, cat;
+	char *cat_argv[] = { "cat", NULL };
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
+	strbuf_getwholeline_fd(&line, proc.err, '\n');
+	fprintf(stderr, line.buf);
+
+	memset(&cat, 0, sizeof(cat));
+	cat.argv = (const char **)cat_argv;
+	cat.in = proc.err;
+	cat.out = 2;
+
+	if (start_command(&cat) < 0)
+		return 1;
+
+	if (parse_daemon_output(line.buf)) {
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
-- 
1.7.9.6
