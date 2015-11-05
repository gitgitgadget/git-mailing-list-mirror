From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 5 Nov 2015 21:27:40 +0100
Message-ID: <563BBBBC.7070807@kdbg.org>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
 <1446747439-30349-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, tboegi@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:27:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuR8O-0007rc-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 21:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbbKEU1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 15:27:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50596 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbbKEU1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 15:27:44 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nsGcY0x39z5tlM;
	Thu,  5 Nov 2015 21:27:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8C8B6537D;
	Thu,  5 Nov 2015 21:27:40 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446747439-30349-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280937>

Am 05.11.2015 um 19:17 schrieb Stefan Beller:
> strbuf_read_once can also operate on blocking file descriptors if we are
> sure they are ready. The poll (2) command however makes sure this is the
> case.
> 
> Reading the manual for poll (2), there may be spurious returns indicating
> readiness but that is for network sockets only. Pipes should be unaffected.
> By having this patch, we rely on the correctness of poll to return
> only pipes ready to read.
> 
> This fixes compilation in Windows.

It certainly does (but I haven't tested, yet). But parallel processes
will not work because we do not have a sufficiently complete waitpid
emulation, yet. (waitpid(-1, ...) is not implemented.)

However, I think that the infrastructure can be simplified even further
to a level that we do not need additional emulation on Windows.

First let me say that I find it very questionable that the callbacks
receive a struct child_process. This is an implementation detail. It is
also an implementation detail that stderr of the children is read and
buffered, and that the child's stdout is redirected to stderr. It
should not be the task of the get_next_task callback to set the members
no_stdin, stdout_to_stderr, and err of struct child_process.

If you move that initialization to pp_start_one, you will notice rather
sooner than later that the readable end of the file descriptor is never
closed!

Which makes me think: Other users of start_command/finish_command work
such that they

1. request a pipe by setting .out = -1
2. start_command
3. read from .out until EOF
4. close .out
5. wait for the process with finish_command

But the parallel_process infrastructure does not follow this pattern.
It

1. requests a pipe by setting .err = -1
2. start_command
3. read from .err
4. wait for the process with waitpid

(and forgets to close .err). EOF is not in the picture (but that is
not essential).

I suggest to change this such that we read from the children until EOF,
mark them to be at their end of life, and then wait for them using
finish_command (assuming that a process that closes stdout and stderr
will die very soon if it is not already dead).

Here is a prototype patch. Feel free to pick it up. It marks a process
whose EOF we have found by setting .err to -1. It's probably better to
extend the meaning of the in_use indicator for this purpose. This seems
to work on Linux with test-run-command with sub-processes that produce
100k output each:

./test-run-command run-command-parallel 5 sh -c "printf \"%0100000d\n\" 999"

although error handling would require some polishing according to
t0061-run-command.

diff --git a/run-command.c b/run-command.c
index 51d078c..3e42299 100644
--- a/run-command.c
+++ b/run-command.c
@@ -977,7 +977,7 @@ static struct parallel_processes *pp_init(int n,
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
-		pp->pfd[i].events = POLLIN;
+		pp->pfd[i].events = POLLIN|POLLHUP;
 		pp->pfd[i].fd = -1;
 	}
 	sigchain_push_common(handle_children_on_signal);
@@ -1061,11 +1061,17 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	/* Buffer output from all pipes. */
 	for (i = 0; i < pp->max_processes; i++) {
 		if (pp->children[i].in_use &&
-		    pp->pfd[i].revents & POLLIN)
-			if (strbuf_read_once(&pp->children[i].err,
-					     pp->children[i].process.err, 0) < 0)
+		    pp->pfd[i].revents & (POLLIN|POLLHUP)) {
+			int n = strbuf_read_once(&pp->children[i].err,
+					     pp->children[i].process.err, 0);
+			if (n == 0) {
+				close(pp->children[i].process.err);
+				pp->children[i].process.err = -1;
+			} else if (n < 0) {
 				if (errno != EAGAIN)
 					die_errno("read");
+			}
+		}
 	}
 }
 
@@ -1082,59 +1088,20 @@ static void pp_output(struct parallel_processes *pp)
 static int pp_collect_finished(struct parallel_processes *pp)
 {
 	int i = 0;
-	pid_t pid;
-	int wait_status, code;
+	int code;
 	int n = pp->max_processes;
 	int result = 0;
 
 	while (pp->nr_processes > 0) {
-		pid = waitpid(-1, &wait_status, WNOHANG);
-		if (pid == 0)
-			break;
-
-		if (pid < 0)
-			die_errno("wait");
-
 		for (i = 0; i < pp->max_processes; i++)
 			if (pp->children[i].in_use &&
-			    pid == pp->children[i].process.pid)
+			    pp->children[i].process.err == -1)
 				break;
+
 		if (i == pp->max_processes)
-			die("BUG: found a child process we were not aware of");
-
-		if (strbuf_read(&pp->children[i].err,
-				pp->children[i].process.err, 0) < 0)
-			die_errno("strbuf_read");
-
-		if (WIFSIGNALED(wait_status)) {
-			code = WTERMSIG(wait_status);
-			if (!pp->shutdown &&
-			    code != SIGINT && code != SIGQUIT)
-				strbuf_addf(&pp->children[i].err,
-					    "%s died of signal %d",
-					    pp->children[i].process.argv[0],
-					    code);
-			/*
-			 * This return value is chosen so that code & 0xff
-			 * mimics the exit code that a POSIX shell would report for
-			 * a program that died from this signal.
-			 */
-			code += 128;
-		} else if (WIFEXITED(wait_status)) {
-			code = WEXITSTATUS(wait_status);
-			/*
-			 * Convert special exit code when execvp failed.
-			 */
-			if (code == 127) {
-				code = -1;
-				errno = ENOENT;
-			}
-		} else {
-			strbuf_addf(&pp->children[i].err,
-				    "waitpid is confused (%s)",
-				    pp->children[i].process.argv[0]);
-			code = -1;
-		}
+			break;
+
+		code = finish_command(&pp->children[i].process);
 
 		if (pp->task_finished(code, &pp->children[i].process,
 				      &pp->children[i].err, pp->data,
@@ -1144,7 +1111,6 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].in_use = 0;
 		pp->pfd[i].fd = -1;
-		child_process_clear(&pp->children[i].process);
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
