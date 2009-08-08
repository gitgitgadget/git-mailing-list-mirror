From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH js/run-command-updates] api-run-command.txt: describe error behavior of run_command functions
Date: Sat, 8 Aug 2009 22:44:20 +0200
Message-ID: <200908082244.20476.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 22:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZsmN-00070k-Ar
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZHHUoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbZHHUoY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 16:44:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17745 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZHHUoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 16:44:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DEDE52C4002;
	Sat,  8 Aug 2009 22:44:21 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9086642769;
	Sat,  8 Aug 2009 22:44:20 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125306>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/technical/api-run-command.txt |   31 ++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt 
b/Documentation/technical/api-run-command.txt
index 2efe7a4..b26c281 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -35,12 +35,32 @@ Functions
 	Convenience functions that encapsulate a sequence of
 	start_command() followed by finish_command(). The argument argv
 	specifies the program and its arguments. The argument opt is zero
-	or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`, or
-	`RUN_COMMAND_STDOUT_TO_STDERR` that correspond to the members
-	.no_stdin, .git_cmd, .stdout_to_stderr of `struct child_process`.
+	or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
+	`RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
+	that correspond to the members .no_stdin, .git_cmd,
+	.stdout_to_stderr, .silent_exec_failure of `struct child_process`.
 	The argument dir corresponds the member .dir. The argument env
 	corresponds to the member .env.
 
+The functions above do the following:
+
+. If a system call failed, errno is set and -1 is returned. A diagnostic
+  is printed.
+
+. If the program was not found, then -1 is returned and errno is set to
+  ENOENT; a diagnostic is printed only if .silent_exec_failure is 0.
+
+. Otherwise, the program is run. If it terminates regularly, its exit
+  code is returned. No diagnistic is printed, even if the exit code is
+  non-zero.
+
+. If the program terminated due to a signal, then the return value is the
+  signal number - 128, ie. it is negative and so indicates an unusual
+  condition; a diagnostic is printed. This return value can be passed to
+  exit(2), which will report the same code to the parent process that a
+  POSIX shell's $? would report for a program that died from the signal.
+
+
 `start_async`::
 
 	Run a function asynchronously. Takes a pointer to a `struct
@@ -143,6 +163,11 @@ string pointers (NULL terminated) in .env:
 To specify a new initial working directory for the sub-process,
 specify it in the .dir member.
 
+If the program cannot be found, the functions return -1 and set
+errno to ENOENT. Normally, an error message is printed, but if
+.silent_exec_failure is set to 1, no message is printed for this
+special error condition.
+
 
 * `struct async`
 
-- 
1.6.4.87.g9ec6e
