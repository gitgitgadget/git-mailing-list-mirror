From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/PATCH] read from 2 filedescriptors simultaneously into one
	strbuf
Date: Sun, 13 May 2012 16:47:34 +0200
Message-ID: <20120513144733.GA23408@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213093008.GD15585@t1405.greatnet.de> <7v7gzq9jg2.fsf@alter.siamese.dyndns.org> <4F3C3172.8030505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 13 16:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STa5n-0006xg-2b
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 16:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab2EMOrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 10:47:37 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40195 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751901Ab2EMOrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 10:47:36 -0400
Received: (qmail 32342 invoked from network); 13 May 2012 14:47:34 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 13 May 2012 14:47:34 -0000
Content-Disposition: inline
In-Reply-To: <4F3C3172.8030505@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197747>

Hi,

On Wed, Feb 15, 2012 at 11:28:02PM +0100, Jens Lehmann wrote:
> Am 14.02.2012 04:34, schrieb Junio C Hamano:
> > Hmm, this makes me wonder if we fire subprocesses and have them run in
> > parallel (to a reasonably limited parallelism), it might make the overall
> > user experience more pleasant, and if we did the same on the fetching
> > side, it would be even nicer.
> 
> Yeah, I had the same idea and did some experiments when working on
> fetch some time ago.
> 
> > We would need to keep track of children and after firing a handful of them
> > we would need to start waiting for some to finish and collect their exit
> > status before firing more, and at the end we would need to wait for the
> > remaining ones and find how each one of them did before returning from
> > push_unpushed_submodules().  If we were to do so, what are the missing
> > support we would need from the run_command() subsystem?
> 
> We would not only have to collect the exit status but also the output
> lines. You don't want to see the output of multiple fetches or pushes
> mixed together, so it makes sense to just defer that until the command
> exited and then print everything at once. The interesting part I couldn't
> come up with an easy solution for is to preserve the output order between
> the stdout and stdin lines, as they contain different parts of the
> progress which would look strange when shuffled around.

I had a go at a possible implementation for deferred output of parallel
subprocesses today. The idea is to use two concurrent threads
simultaneously reading from the two filedescriptors and writing the
result into one strbuf. Below is the diff for the current code I have[1].

One current limitation is that it only works with pthreads enabled. I
first tried to use the same pipe for the two threads to avoid the need
for locking and shared memory. I am not sure but it seems that
concurrents writes into the same pipe are not allowed.

What do you think of this approach? Is it the correct place or should it
go into another module? Also the function naming might need some polishing.

Cheers Heiko

P.S.: We can of course get rid of the second thread and just read in the
main thread for one of the filedescriptors but this was easier while
thinking about it.

[1]
diff --git a/run-command.c b/run-command.c
index 2a1041e..48c9e07 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec_cmd.h"
+#include "strbuf.h"
+#include <pthread.h>
 
 static inline void close_pair(int fd[2])
 {
@@ -407,6 +409,60 @@ fail_pipe:
 	return 0;
 }
 
+#ifndef NO_PTHREADS
+struct fd2fd_data {
+	pthread_mutex_t mutex;
+	struct strbuf *output;
+};
+
+static int fd2fd(int in, int out, void *data)
+{
+	struct fd2fd_data *me = data;
+	struct strbuf line;
+
+	FILE *fin = xfdopen(in, "r");
+
+	while (strbuf_getwholeline(&line, fin, '\n') != EOF) {
+		pthread_mutex_lock(&me->mutex);
+		strbuf_addbuf(me->output, &line);
+		pthread_mutex_unlock(&me->mutex);
+	}
+
+	strbuf_release(&line);
+	return 0;
+}
+
+void read_2_fds_into_strbuf(int fd1, int fd2, struct strbuf *output)
+{
+	struct async err_async;
+	struct async out_async;
+	struct fd2fd_data async_data;
+
+	pthread_mutex_init(&async_data.mutex, NULL);
+	async_data.output = output;
+
+	/* start two threads to read fd1 and fd2 simultaneously
+	 * into one strbuf */
+	memset(&out_async, 0, sizeof(out_async));
+	out_async.proc = fd2fd;
+	out_async.data = &async_data;
+	out_async.in = fd1;
+
+	memset(&err_async, 0, sizeof(err_async));
+	err_async.proc = fd2fd;
+	err_async.data = &async_data;
+	err_async.in = fd2;
+
+	start_async(&out_async);
+	start_async(&err_async);
+
+	finish_async(&out_async);
+	finish_async(&err_async);
+
+	pthread_mutex_destroy(&async_data.mutex);
+}
+#endif /* NO_PTHREADS */
+
 int finish_command(struct child_process *cmd)
 {
 	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure);
diff --git a/run-command.h b/run-command.h
index 56491b9..a65debb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -5,6 +5,8 @@
 #include <pthread.h>
 #endif
 
+struct strbuf;
+
 struct child_process {
 	const char **argv;
 	pid_t pid;
@@ -90,4 +92,8 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+#ifndef NO_PTHREADS
+void read_2_fds_into_strbuf(int fd1, int fd2, struct strbuf *output);
+#endif
+
 #endif
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 10b26e4..774807b 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -11,4 +11,10 @@ test_expect_success 'start_command reports ENOENT' '
 	test-run-command start-command-ENOENT ./does-not-exist
 '
 
+test_expect_success 'read_2_fds_into_strbuf basic behavior' '
+	test-run-command out2strbuf >actual &&
+	grep "^Hallo Stdout$" actual &&
+	grep "^Hallo Stderr$" actual
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 0612bfa..f59485d 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -10,26 +10,72 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
+#include "strbuf.h"
 #include <string.h>
 #include <errno.h>
 
+static int run_write_async(int in, int out, void *data)
+{
+	const char *msg = data;
+
+	FILE *fout = xfdopen(out, "w");
+	fprintf(fout, "%s\n", msg);
+
+	fclose(fout);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	struct child_process proc;
+	struct async write_out;
+	struct async write_err;
 
 	memset(&proc, 0, sizeof(proc));
 
-	if (argc < 3)
+	if (argc < 2)
 		return 1;
-	proc.argv = (const char **)argv+2;
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
+		if (argc < 3)
+			return 1;
+		proc.argv = (const char **)argv+2;
+
 		if (start_command(&proc) < 0 && errno == ENOENT)
 			return 0;
 		fprintf(stderr, "FAIL %s\n", argv[1]);
 		return 1;
 	}
 
+	if (!strcmp(argv[1], "out2strbuf")) {
+#ifndef NO_PTHREADS
+		struct strbuf output = STRBUF_INIT;
+
+		memset(&write_out, 0, sizeof(write_out));
+		write_out.data = "Hallo Stdout";
+		write_out.proc = run_write_async;
+		write_out.out = -1;
+
+		memset(&write_err, 0, sizeof(write_err));
+		write_err.data = "Hallo Stderr";
+		write_err.proc = run_write_async;
+		write_err.out = -1;
+
+		start_async(&write_out);
+		start_async(&write_err);
+
+		read_2_fds_into_strbuf(write_out.out, write_err.out, &output);
+
+		finish_async(&write_out);
+		finish_async(&write_err);
+
+		printf("%s", output.buf);
+		strbuf_release(&output);
+#endif /* NO_PTHREADS */
+
+		return 0;
+	}
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
