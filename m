From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Technical documentation of the run-command API
Date: Sun, 17 Feb 2008 21:39:43 +0100
Message-ID: <1203280783.47b89b8f11891@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: spearce@spearce.org, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 21:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQqJS-0008TN-T2
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYBQUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbYBQUjq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:39:46 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:50647 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYBQUjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 15:39:45 -0500
Received: from localhost (webmail01.srv.eunet.at [193.154.180.195])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 215AA13A9B9;
	Sun, 17 Feb 2008 21:39:43 +0100 (CET)
Received: from 77.117.103.133 ([77.117.103.133]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sun, 17 Feb 2008 21:39:43 +0100
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.103.133
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74179>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

This is the first time I post via my webmail client, so I can't
properly followup to our earlier discussion, and it'll probably be
whitespace damaged :( But it's meant to collect feedback.

Also, I'm asciidoc challenged...

-- Hannes

 Documentation/technical/api-run-command.txt |  159 ++++++++++++++++++++++++++-
 1 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt
b/Documentation/technical/api-run-command.txt
index 19d2f64..0ef50bf 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -1,10 +1,159 @@
 run-command API
 ===============

-Talk about <run-command.h>, and things like:
+The run-command API offers a versatile tool to run sub-processes with
+redirected input and output as well as with a modified environment
+and an alternate current directory.

-* Environment the command runs with (e.g. GIT_DIR);
-* File descriptors and pipes;
-* Exit status;
+A similar API offers the capability to run a function asynchronously,
+which is primarily used to capture the output that the function
+produces in the caller in order to process it.

-(Hannes, Dscho, Shawn)
+
+Functions
+---------
+
+`start_command`::
+
+	Start a sub-process. Takes a pointer to a `struct child_process`
+	that specifies the details and returns pipe FDs (if requested).
+	See below for details.
+
+`finish_command`::
+
+	Wait for the completion of a sub-process that was started with
+	start_command().
+
+`run_command`::
+
+	A convenience function that encapsulates a sequence of
+	start_command() followed by finish_command(). Takes a pointer
+	to a `struct child_process` that specifies the details.
+
+`run_command_v_opt`, `run_command_v_opt_dir`, `run_command_v_opt_cd_env`::
+
+	Convenience functions that encapsulate a sequence of
+	start_command() followed by finish_command(). The argument argv
+	specifies the program and its arguments. The argument opt is zero
+	or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`, or
+	`RUN_COMMAND_STDOUT_TO_STDERR` that correspond to the members
+	.no_stdin, .git_cmd, .stdout_to_stderr of `struct child_process`.
+	The argument dir corresponds the member .dir. The argument env
+	corresponds to the member .env.
+
+`start_async`::
+
+	Run a function asynchronously. Takes a pointer to a `struct
+	async` that specifies the details and returns a pipe FD
+	from which the caller reads. See below for details.
+
+`finish_async`::
+
+	Wait for the completeion of an asynchronous function that was
+	started with start_async().
+
+
+Data structures
+---------------
+
+* `struct child_process`
+
+This describes the arguments, redirections, and environment of a
+command to run in a sub-process.
+
+The caller allocates and clears (memset(&chld, '0', sizeof(chld));)
+a struct child_process variable, initializes the members, calls
+start_command(), processes the data, and calls finish_command().
+
+Its .argv member is set up as an array of string pointers (NULL
+terminated), of which .argv[0] is the program name to run (usually
+without a path). If the command to run is a git command, set argv[0] to
+the command name without the 'git-' prefix and set .git_cmd = 1.
+
+The members .in, .out, .err are used to redirect stdin, stdout,
+stderr as follows:
+
+. Specify 0 to inherit the channel from parent.
+
+. Specify -1 to have a pipe allocated; start_command() replaces -1
+  by the pipe FD in the following way:
+
+	.in: Returns the writable pipe end into which the caller writes;
+		the readable end of the pipe becomes the child's stdin.
+
+	.out, .err: Returns the readable pipe end from which the caller
+		reads; the writable end of the pipe end becomes child's
+		stdout/stderr.
+
+  The caller of start_command() must close the so returned FDs
+  after it has completed reading from/writing to it!
+
+. Specify a file descriptor > 0 to be used by the child:
+
+	.in: The FD must be readable; it becomes child's stdin.
+	.out: The FD must be writable; it becomes child's stdout.
+	.err > 0 is not supported.
+
+  The specified FD is closed by start_command(), even if it fails to
+  run the sub-process!
+
+. Special forms of redirection are available by setting these members
+  to 1:
+
+	.no_stdin, .no_stdout, .no_stderr: The respective channel is
+		redirected to /dev/null.
+
+	.stdout_to_stderr: stdout of the child is redirected to the
+		parent's stderr (i.e. *not* to what .err or
+		.no_stderr specify).
+
+To modify the environment of the sub-process, specify an array of
+string pointers (NULL terminated) in .env:
+
+. If the string is of the form "VAR=value", i.e. it contains '='
+  the variable is added to the child process's environment.
+
+. If the string does not contain '=', it names an environement
+  variable that will be removed from the child process's envionment.
+
+To specify a new initial working directory for the sub-process,
+specify it in the .dir member.
+
+
+* `struct async`
+
+This describes a function to run asynchronously, whose purpose is
+to produce output that the caller reads
+
+The caller:
+
+1. allocates and clears (memset(&asy, '0', sizeof(asy));) a
+   struct async variable;
+2. initializes .proc and .data;
+3. calls start_async();
+4. processes the data by reading from the fd in .out;
+5. closes .out;
+6. calls finish_async().
+
+The function has the following signature:
+
+	int proc(int fd, void *data);
+
+. fd specifies a writable file descriptor to which the function must
+  write the data that it produces. The function *must* close this
+  descriptor before it returns.
+
+. data is the value that the caller has specified in the .data member
+  of struct async.
+
+. The return value of the function is 0 on success and non-zero
+  on failure.
+
+
+There are serious restrictions on what the asynchronous function can do:
+
+. It cannot change the global state in a way that the caller notices;
+  in other words, .out is the only communication channel to the caller.
+
+. It must not modify global state that the caller of the facility also
+  accesses.
-- 
1.5.4.43.gbd39-dirty
